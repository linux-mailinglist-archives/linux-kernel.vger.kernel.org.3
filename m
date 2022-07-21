Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3A057D3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiGUTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiGUTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39DD785A3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 053A76205A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AD0C3411E;
        Thu, 21 Jul 2022 19:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658430978;
        bh=hvnKp07ed2oqwB5CF2hkzKW/T6aJTr6sEDf6YyhEyRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1PuL0rpWzryLD1P7NI5z/Nj1s/mf4lUnBu+V4Vetnc/IpYfw8+zWqm3ZIq3nzH1Q
         rj+fxzS8Z/ZepkWlH+qg72z4+muVrxhYvLPA4CALAJI6UCcWAH3UsBmM2mTKA1oOl3
         fsUv3ZQi6+SIj8mwSyxMXAQ/vewJON4hkPV7faxE=
Date:   Thu, 21 Jul 2022 21:16:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Zhou Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 3/3] documentation: misc: intel_sysid: Add the system
 id sysfs documentation for Altera(Intel) FPGA platform
Message-ID: <Ytml/4+F1DANw1Be@kroah.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
 <20220721123258.416802-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721123258.416802-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:32:59PM +0800, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> This sysfs documentation is created for Altera(Intel) FPGA platform
> System ID soft IP. The Altera(Intel) Sysid component is generally
> part of an FPGA design.
> The component can be hotplugged when the FPGA is reconfigured.
> 
> Based on an initial contribution from Ley Foon Tan at Altera
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> Reviewed-by: Zhou Furong <furong.zhou@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  .../testing/sysfs-devices-platform-soc-sysid  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-soc-sysid
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid b/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid
> new file mode 100644
> index 000000000000..9fa58fd88dc0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid
> @@ -0,0 +1,27 @@
> +What:		/sys/devices/platform/soc@X/soc:base_fpga_region/
> +soc:base_fpga_region:fpga_pr_region0/XXXXXXXX.sysid/
> +Date:		May 2022
> +KernelVersion:	v5.18

5.18 is long released.  And it's after May 2022 now :(


> +Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
> +Description:
> +		The soc@X/soc:base_fpga_region/soc:base_fpga_region:fpga_pr_region0/
> +		XXXXXXXX.sysid/ directory contains read-only attributes exposing
> +		information about an System ID soft IP device. The X values could vary,
> +		based on the FPGA platform System ID soft IP register address.
> +
> +What:		.../XXXXXXX.sysid/sysid
> +Date:		May 2022
> +KernelVersion:	v5.18
> +Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
> +Description:
> +		The .../XXXXXXX.sysid/sysid file contains the System ID for the FPGA
> +		platform which is unique for the platform type and can be used for
> +		checking the platform type for software download purposes.

What format is this data in?

> +
> +What:		.../XXXXXXX.sysid/buildtime
> +Date:		May 2022
> +KernelVersion:	v5.18
> +Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
> +Description:
> +		The .../XXXXXXX.sysid/buildtime file contains the buildtime for the
> +		FPGA board file generation.

What format is this data in?

Please be specific.

thanks,

greg k-h
