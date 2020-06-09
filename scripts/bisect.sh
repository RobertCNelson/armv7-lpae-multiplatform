#!/bin/sh -e
#
# Copyright (c) 2012 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

DIR=$PWD

if [ ! -f "${DIR}/patches/bisect_defconfig" ] ; then
	cp "${DIR}/patches/defconfig" "${DIR}/patches/bisect_defconfig"
fi

cp -v "${DIR}/patches/bisect_defconfig" "${DIR}/patches/defconfig"

cd "${DIR}/KERNEL/" || exit
git bisect start
git bisect good v5.0
git bisect bad v5.1-rc1
git bisect bad e266ca36da7de45b64b05698e98e04b578a88888
git bisect bad 63bdf4284c38a48af21745ceb148a087b190cd21
git bisect bad b7b14ec1ebef35d22f3f4087816468f22c987f75
git bisect bad 77ff2c6b49843b01adef1f80abb091753e4c9c65
git bisect bad bb7c778b73ebf4a62408ed6deafc587aae79d3e2
git bisect good a5040a9059ed6b9ecb77514092eb62726708412c
git bisect bad d4fd0404c1c95b17880f254ebfee3485693fa8ba
git bisect bad ed175d9c6f0d4df0f83f22ff4c887c21b7d021cd
git bisect good d1b3fa861c62e21bb4dc598f0aee73b6ccf5d051
git bisect good 10b63e8543145d03de68735a3a2b6f3784dd4a33
git bisect good d6228b7cdd6e790e6c21a844b9b3ab35d01a1974
git bisect good 83c177aea4c37d1a2ef1e2488b25838f70cf6571
git bisect bad 5ecdd77c61c8fe1d75ded538701e5e854963c890

git describe
cd "${DIR}/" || exit
