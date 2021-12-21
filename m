Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A4847BCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhLUJSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbhLUJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:18:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B96C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:18:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63EC8B81219
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39A7C36AE2;
        Tue, 21 Dec 2021 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640078294;
        bh=bTcHJfEyJ/T+V8bKHWOU6ML05FDG7R4DgMbt1M2kysg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsMMTmTDhA4MhPisMFjK46m3c3aPTVznKFtlKhmhs8P8+Fd8VWmPy6mU2Ir5x6QAs
         /rOwXMuu1Cy1Rvav6QQvNMpx8RS50an1F05ROWsbjB7jouz4DaSvvMyuriyLsrHhmK
         20/EgUtcT09nV6rTWz9DpZK98iw9tvBZykNDAmAU=
Date:   Tue, 21 Dec 2021 10:18:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronak Jain <ronak.jain@xilinx.com>
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        lakshmi.sai.krishna.potthuri@xilinx.com
Subject: Re: [PATCH v4 2/3] firmware: zynqmp: Add documentation for runtime
 feature config
Message-ID: <YcGb0989zTxf0RT6@kroah.com>
References: <20211206112101.24955-1-ronak.jain@xilinx.com>
 <20211206112101.24955-3-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206112101.24955-3-ronak.jain@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:21:00AM -0800, Ronak Jain wrote:
> Add documentation for sysfs entries like feature_config_id and
>  feature_config_value for runtime feature configuration. The support is
>  added for an over temperature and external watchdog features.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
> Changes in v4:
> - Add separate sysfs entries for runtime feature config
> - Update commit message
> 
> Changes in v3:
> - None
> 
> Changes in v2:
> - Update commit message
> ---
>  .../ABI/stable/sysfs-driver-firmware-zynqmp   | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> index f5724bb5b462..0978a766bd65 100644
> --- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> +++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> @@ -113,3 +113,144 @@ Description:
>  		    # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
>  
>  Users:		Xilinx
> +
> +What:		/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
> +Date:		Dec 2021
> +KernelVersion:	5.16

no, 5.16 will not have these files, sorry.

