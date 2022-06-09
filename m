Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3654470D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbiFIJPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiFIJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:15:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8272D18B3C;
        Thu,  9 Jun 2022 02:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40D75B82C94;
        Thu,  9 Jun 2022 09:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7279C34114;
        Thu,  9 Jun 2022 09:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654766120;
        bh=lX78Npt98ey6/C0d5zscpNgpQhug1xdeRde7s5Ic9kY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=tyG7QlC1OnGqXvMPLcEu4g+pQiGZUkto+ogNWbw5iraEGvp0wutsDaP4EJ2AZLU14
         B9pxaEyddmkfIeZVO+Irs6joZZLTLVb3m844L71DkUBiCmj1fOQ0ogsIp5HGEx+J3r
         Uz5yNnEwAPLDmwIHUx9IJ36/ytCCNJ5X+TC4m+6ZH9YXJEZHbOwe7UQA6vuYoeH7k+
         HJWptw0zkxjKRNj8sfdBpBdDYczPjh+ICasQM6k7qpVm/gJjnth8DipZH7EALdATY5
         xklbw1UhVcd5rYRxmVVRQ1eZNcpy74dMVbjwhopWLKp928oag8PHCfIvGq25hWt4PB
         /jEDQkWvvDKXQ==
Date:   Thu, 9 Jun 2022 11:15:16 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] HID: magicmouse: Fix some kernel-doc comments
In-Reply-To: <20220602075821.49622-1-yang.lee@linux.alibaba.com>
Message-ID: <nycvar.YFH.7.76.2206091114420.14340@cbobk.fhfr.pm>
References: <20220602075821.49622-1-yang.lee@linux.alibaba.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022, Yang Li wrote:

> Remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> drivers/hid/hid-magicmouse.c:148: warning: Function parameter or member
> 'hdev' not described in 'magicmouse_sc'
> drivers/hid/hid-magicmouse.c:148: warning: Function parameter or member
> 'work' not described in 'magicmouse_sc'
> drivers/hid/hid-magicmouse.c:148: warning: Function parameter or member
> 'battery_timer' not described in 'magicmouse_sc'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/hid/hid-magicmouse.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 664a624a363d..a13e07397e5d 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -120,6 +120,9 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
>   * @scroll_jiffies: Time of last scroll motion.
>   * @touches: Most recent data for a touch, indexed by tracking ID.
>   * @tracking_ids: Mapping of current touch input data to @touches.
> + * @hdev: device report descriptor

This is not a correct desciption; struct hid_device is much more than 
report descriptor. Could you please fix that up and resend?

Thanks,

-- 
Jiri Kosina
SUSE Labs

