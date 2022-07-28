Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2825839D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiG1Hva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiG1Hv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:51:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC5661B14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97F93B8231B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E802DC433C1;
        Thu, 28 Jul 2022 07:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658994682;
        bh=wvHbgMtJ2feakhj7qlSMWWOMe7Ef+r9reQxllPGJaBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3VlCUUzRKF36/507T6JFTBfSgThCKRXs0g2EduwFK647Jji216mOKeJC7pXEE7L/
         TFEp9ovvWd8/yJZ8dWXy8Aw8858G15+yUEA3N/5e3oO1kM9vPlUgm6ZuzKyu/CX+BP
         q1JeW/DY8TgScU3OhoBAzMxBPse34HVssvT70S1A=
Date:   Thu, 28 Jul 2022 09:51:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Zhou Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 3/3] documentation: misc: intel_sysid: Add the system
 id sysfs documentation for Altera(Intel) FPGA platform
Message-ID: <YuI/9/YysHmxkOTE@kroah.com>
References: <20220721123258.416802-1-kah.jing.lee@intel.com>
 <20220725035940.649062-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725035940.649062-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:59:41AM +0800, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> This sysfs documentation is created for Altera(Intel) FPGA platform
> System ID soft IP. The Altera(Intel) Sysid component is generally
> part of an FPGA design.
> The component can be hotplugged when the FPGA is reconfigured.
> 
> Based on an initial contribution from Ley Foon Tan at Altera
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>

You always need a blank line before the signed-off-by, didn't checkpatch
complain about this?

> Reviewed-by: Zhou Furong <furong.zhou@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> ---
> v2->v3:
> - Updated kernel version & date
> - Added format for sysid & builtime output

Please resend patches as whole new series, not as odd responses to
responses like this as it is impossible to figure out this way.

Please take some time and review patches from others to see just how
this process works.

> ---
> ---
>  .../testing/sysfs-devices-platform-soc-sysid  | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-soc-sysid
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid b/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid
> new file mode 100644
> index 000000000000..6e40d154601f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid
> @@ -0,0 +1,41 @@
> +What:		/sys/devices/platform/soc@X/soc:base_fpga_region/
> +soc:base_fpga_region:fpga_pr_region0/XXXXXXXX.sysid/
> +Date:		July 2022

July is almost over.

> +KernelVersion:	v5.20
> +Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
> +Description:
> +		The soc@X/soc:base_fpga_region/soc:base_fpga_region:fpga_pr_region0/
> +		XXXXXXXX.sysid/ directory contains read-only attributes exposing
> +		information about an System ID soft IP device. The X values could vary,
> +		based on the FPGA platform System ID soft IP register address.
> +
> +What:		.../XXXXXXX.sysid/sysid
> +Date:		July 2022
> +KernelVersion:	v5.20
> +Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
> +Description:
> +		The .../XXXXXXX.sysid/sysid file contains the System ID for the FPGA
> +		platform which is unique for the platform type and can be used for
> +		checking the platform type for software download purposes. Sysid value
> +		reported is in numerical format, and can also be printed in hex format
> +		for human-readable string.
> +		E.g:
> +			root@agilex:~# cat /sys/bus/platform/drivers/altera_sysid/
> +				f9000900.sysid/sysid/id

Why the line wrapping?

> +			4207856382
> +			root@agilex:~# cat /sys/bus/platform/drivers/altera_sysid/
> +				f9000900.sysid/sysid/id | xargs printf "0x%08x\n"
> +			0xfacecafe

If userspace wants this in hex format, just have the sysfs file export a
hex format.  No need to provide a tutorial for how to convert bases in
userspace, right?

> +
> +What:		.../XXXXXXX.sysid/buildtime
> +Date:		July 2022
> +KernelVersion:	v5.20
> +Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
> +Description:
> +		The .../XXXXXXX.sysid/buildtime file contains the buildtime for the
> +		FPGA board file generation. Buildtime value reported in
> +		<Unix timestamp> (YYYY-mm-dd HH:MM:SS UTC) format.
> +		E.g:
> +			root@agilex:~# cat /sys/bus/platform/drivers/altera_sysid/
> +				f9000900.sysid/sysid/timestamp
> +			1637751409 (2021-11-24 10:56:49 UTC)

Why not use the proper RFC format for time here instead of making up a
new one?  And who will use this file, why does it have to be parsed like
this?

thanks,

greg k-h
