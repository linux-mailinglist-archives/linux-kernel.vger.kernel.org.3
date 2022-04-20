Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50C3509227
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382569AbiDTVk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382566AbiDTVky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:40:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D7A38183
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650490686; x=1682026686;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VXO6sf1+FT6LLE/MLCKuoAa/Dl0N2qHwY87iTXEjbKc=;
  b=gR1kyKHqMw/ziNOaEuFwUQ/IsER6/ljWmNwb56iTVB9hNH9mzJKa5j88
   xNc3lr187HJvJP8R0aTMpnHYUup9w8vdDJfdRjYQAp+NIIWD1XdAbBMuh
   d+IS/099YjUd7nJ+hOS2r4W32tnw1kP0ZWvcb1PwFL3NisojR3XwIKzsA
   qn7GsWHVOf1oCuYOSgsomuBgZIS5zMkBGKfBHMyxnCLCCCrWjt9/2x/Rq
   U2cZ7LwEko658uJMSI2xnUteuxce3pHx4gijS830xpzGSmjTVApMyiRPO
   MzHBhImlk+td7juxYsSe1t87U+WOPaHvTY2raZkZpqJaasJzN6yJ7DSEQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244093140"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="244093140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 14:38:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="669127015"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 14:38:05 -0700
Date:   Wed, 20 Apr 2022 14:37:59 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Russ Weight <russell.h.weight@intel.com>
cc:     mcgrof@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, basheer.ahmed.muddebihal@intel.com,
        tianfei.zhang@intel.com
Subject: Re: [PATCH v4 8/8] selftests: firmware: Add firmware upload
 selftests
In-Reply-To: <20220419231658.664388-9-russell.h.weight@intel.com>
Message-ID: <alpine.DEB.2.22.394.2204201436530.66128@rhweight-WRK1>
References: <20220419231658.664388-1-russell.h.weight@intel.com> <20220419231658.664388-9-russell.h.weight@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Apr 2022, Russ Weight wrote:

> Add selftests to verify the firmware upload mechanism. These test
> include simple firmware uploads as well as upload cancellation and
> error injection. The test creates three firmware devices and verifies
> that they all work correctly and independently.

Hi Russ,

I applied your patches and ran the selftests.  Everything looks good to 
me.

Tested-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>  - No changes from v1
> v3:
>  - Added Reviewed-by tag
> v4:
>  - Added Reviewed-by tag
> ---
> tools/testing/selftests/firmware/Makefile     |   2 +-
> tools/testing/selftests/firmware/config       |   1 +
> tools/testing/selftests/firmware/fw_lib.sh    |   7 +
> .../selftests/firmware/fw_run_tests.sh        |   4 +
> tools/testing/selftests/firmware/fw_upload.sh | 214 ++++++++++++++++++
> 5 files changed, 227 insertions(+), 1 deletion(-)
> create mode 100755 tools/testing/selftests/firmware/fw_upload.sh
>
> diff --git a/tools/testing/selftests/firmware/Makefile b/tools/testing/selftests/firmware/Makefile
> index 40211cd8f0e6..7992969deaa2 100644
> --- a/tools/testing/selftests/firmware/Makefile
> +++ b/tools/testing/selftests/firmware/Makefile
> @@ -4,7 +4,7 @@ CFLAGS = -Wall \
>          -O2
>
> TEST_PROGS := fw_run_tests.sh
> -TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_lib.sh
> +TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_upload.sh fw_lib.sh
> TEST_GEN_FILES := fw_namespace
>
> include ../lib.mk
> diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
> index bf634dda0720..6e402519b117 100644
> --- a/tools/testing/selftests/firmware/config
> +++ b/tools/testing/selftests/firmware/config
> @@ -3,3 +3,4 @@ CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> +CONFIG_FW_UPLOAD=y
> diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
> index 5b8c0fedee76..fe8d34dbe7ca 100755
> --- a/tools/testing/selftests/firmware/fw_lib.sh
> +++ b/tools/testing/selftests/firmware/fw_lib.sh
> @@ -63,6 +63,7 @@ check_setup()
> 	HAS_FW_LOADER_USER_HELPER="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)"
> 	HAS_FW_LOADER_USER_HELPER_FALLBACK="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)"
> 	HAS_FW_LOADER_COMPRESS="$(kconfig_has CONFIG_FW_LOADER_COMPRESS=y)"
> +	HAS_FW_UPLOAD="$(kconfig_has CONFIG_FW_UPLOAD=y)"
> 	PROC_FW_IGNORE_SYSFS_FALLBACK="0"
> 	PROC_FW_FORCE_SYSFS_FALLBACK="0"
>
> @@ -113,6 +114,12 @@ verify_reqs()
> 			exit 0
> 		fi
> 	fi
> +	if [ "$TEST_REQS_FW_UPLOAD" = "yes" ]; then
> +		if [ ! "$HAS_FW_UPLOAD" = "yes" ]; then
> +			echo "firmware upload disabled so ignoring test"
> +			exit 0
> +		fi
> +	fi
> }
>
> setup_tmp_file()
> diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
> index 777377078d5e..f6d95a2d5124 100755
> --- a/tools/testing/selftests/firmware/fw_run_tests.sh
> +++ b/tools/testing/selftests/firmware/fw_run_tests.sh
> @@ -22,6 +22,10 @@ run_tests()
> 	proc_set_force_sysfs_fallback $1
> 	proc_set_ignore_sysfs_fallback $2
> 	$TEST_DIR/fw_fallback.sh
> +
> +	proc_set_force_sysfs_fallback $1
> +	proc_set_ignore_sysfs_fallback $2
> +	$TEST_DIR/fw_upload.sh
> }
>
> run_test_config_0001()
> diff --git a/tools/testing/selftests/firmware/fw_upload.sh b/tools/testing/selftests/firmware/fw_upload.sh
> new file mode 100755
> index 000000000000..c7a6f06c9adb
> --- /dev/null
> +++ b/tools/testing/selftests/firmware/fw_upload.sh
> @@ -0,0 +1,214 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# This validates the user-initiated fw upload mechanism of the firmware
> +# loader. It verifies that one or more firmware devices can be created
> +# for a device driver. It also verifies the data transfer, the
> +# cancellation support, and the error flows.
> +set -e
> +
> +TEST_REQS_FW_UPLOAD="yes"
> +TEST_DIR=$(dirname $0)
> +
> +progress_states="preparing transferring  programming"
> +errors="hw-error
> +	timeout
> +	device-busy
> +	invalid-file-size
> +	read-write-error
> +	flash-wearout"
> +error_abort="user-abort"
> +fwname1=fw1
> +fwname2=fw2
> +fwname3=fw3
> +
> +source $TEST_DIR/fw_lib.sh
> +
> +check_mods
> +check_setup
> +verify_reqs
> +
> +trap "upload_finish" EXIT
> +
> +upload_finish() {
> +	local fwdevs="$fwname1 $fwname2 $fwname3"
> +
> +	for name in $fwdevs; do
> +		if [ -e "$DIR/$name" ]; then
> +			echo -n "$name" > "$DIR"/upload_unregister
> +		fi
> +	done
> +}
> +
> +upload_fw() {
> +	local name="$1"
> +	local file="$2"
> +
> +	echo 1 > "$DIR"/"$name"/loading
> +	cat "$file" > "$DIR"/"$name"/data
> +	echo 0 > "$DIR"/"$name"/loading
> +}
> +
> +verify_fw() {
> +	local name="$1"
> +	local file="$2"
> +
> +	echo -n "$name" > "$DIR"/config_upload_name
> +	if ! cmp "$file" "$DIR"/upload_read > /dev/null 2>&1; then
> +		echo "$0: firmware compare for $name did not match" >&2
> +		exit 1
> +	fi
> +
> +	echo "$0: firmware upload for $name works" >&2
> +	return 0
> +}
> +
> +inject_error() {
> +	local name="$1"
> +	local status="$2"
> +	local error="$3"
> +
> +	echo 1 > "$DIR"/"$name"/loading
> +	echo -n "inject":"$status":"$error" > "$DIR"/"$name"/data
> +	echo 0 > "$DIR"/"$name"/loading
> +}
> +
> +await_status() {
> +	local name="$1"
> +	local expected="$2"
> +	local status
> +	local i
> +
> +	let i=0
> +	while [ $i -lt 50 ]; do
> +		status=$(cat "$DIR"/"$name"/status)
> +		if [ "$status" = "$expected" ]; then
> +			return 0;
> +		fi
> +		sleep 1e-03
> +		let i=$i+1
> +	done
> +
> +	echo "$0: Invalid status: Expected $expected, Actual $status" >&2
> +	return 1;
> +}
> +
> +await_idle() {
> +	local name="$1"
> +
> +	await_status "$name" "idle"
> +	return $?
> +}
> +
> +expect_error() {
> +	local name="$1"
> +	local expected="$2"
> +	local error=$(cat "$DIR"/"$name"/error)
> +
> +	if [ "$error" != "$expected" ]; then
> +		echo "Invalid error: Expected $expected, Actual $error" >&2
> +		return 1
> +	fi
> +
> +	return 0
> +}
> +
> +random_firmware() {
> +	local bs="$1"
> +	local count="$2"
> +	local file=$(mktemp -p /tmp uploadfwXXX.bin)
> +
> +	dd if=/dev/urandom of="$file" bs="$bs" count="$count" > /dev/null 2>&1
> +	echo "$file"
> +}
> +
> +test_upload_cancel() {
> +	local name="$1"
> +	local status
> +
> +	for status in $progress_states; do
> +		inject_error $name $status $error_abort
> +		if ! await_status $name $status; then
> +			exit 1
> +		fi
> +
> +		echo 1 > "$DIR"/"$name"/cancel
> +
> +		if ! await_idle $name; then
> +			exit 1
> +		fi
> +
> +		if ! expect_error $name "$status":"$error_abort"; then
> +			exit 1
> +		fi
> +	done
> +
> +	echo "$0: firmware upload cancellation works"
> +	return 0
> +}
> +
> +test_error_handling() {
> +	local name=$1
> +	local status
> +	local error
> +
> +	for status in $progress_states; do
> +		for error in $errors; do
> +			inject_error $name $status $error
> +
> +			if ! await_idle $name; then
> +				exit 1
> +			fi
> +
> +			if ! expect_error $name "$status":"$error"; then
> +				exit 1
> +			fi
> +
> +		done
> +	done
> +	echo "$0: firmware upload error handling works"
> +}
> +
> +test_fw_too_big() {
> +	local name=$1
> +	local fw_too_big=`random_firmware 512 5`
> +	local expected="preparing:invalid-file-size"
> +
> +	upload_fw $name $fw_too_big
> +	rm -f $fw_too_big
> +
> +	if ! await_idle $name; then
> +		exit 1
> +	fi
> +
> +	if ! expect_error $name $expected; then
> +		exit 1
> +	fi
> +
> +	echo "$0: oversized firmware error handling works"
> +}
> +
> +echo -n "$fwname1" > "$DIR"/upload_register
> +echo -n "$fwname2" > "$DIR"/upload_register
> +echo -n "$fwname3" > "$DIR"/upload_register
> +
> +test_upload_cancel $fwname1
> +test_error_handling $fwname1
> +test_fw_too_big $fwname1
> +
> +fw_file1=`random_firmware 512 4`
> +fw_file2=`random_firmware 512 3`
> +fw_file3=`random_firmware 512 2`
> +
> +upload_fw $fwname1 $fw_file1
> +upload_fw $fwname2 $fw_file2
> +upload_fw $fwname3 $fw_file3
> +
> +verify_fw ${fwname1} ${fw_file1}
> +verify_fw ${fwname2} ${fw_file2}
> +verify_fw ${fwname3} ${fw_file3}
> +
> +echo -n "$fwname1" > "$DIR"/upload_unregister
> +echo -n "$fwname2" > "$DIR"/upload_unregister
> +echo -n "$fwname3" > "$DIR"/upload_unregister
> +
> +exit 0
> -- 
> 2.25.1
>
>
