Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D47C57E1D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiGVNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiGVNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42DAF878;
        Fri, 22 Jul 2022 06:02:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 045FF61A44;
        Fri, 22 Jul 2022 13:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820BCC341C6;
        Fri, 22 Jul 2022 13:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658494976;
        bh=sXtHX633NXttQ52gjkH415MKam/LYec875q3sOrQkSI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=e4nbcdsQD14H/vyLafcrTolZZ5pzguIDjRmSzSa4iToQwJTn0NOSfHhkYNh7RSlAg
         Y3Bheovy6BWNZjie2kPUsAw/C2aK0eFuHPEqIbIKhnFRwMs4psaSlNOvxx2FZCj/Km
         SkwSAtpPPIBmFAAjsx2ryOPs7DGjYbkCghOf7x6NLmEjhaJRLfjnr3ACBBrxtEo5H0
         BKP7uOl+7YRA+d8GPkelxoWvbIflN8Kv2fAJOu+C8sQ8Z4bjsy80mGolNr1jXm66Uv
         T5SfuDjRfN14z7Lo4d++kIXu3Zb1waAW7XW6EtIWuZsZrfIunly4gcUT3Qpq7NzBh1
         Hx6Ju92d80JIw==
Date:   Fri, 22 Jul 2022 15:02:52 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Artem Borisov <dedsa2002@gmail.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: alps: Declare U1_UNICORN_LEGACY support
In-Reply-To: <20220719145324.8107-1-dedsa2002@gmail.com>
Message-ID: <nycvar.YFH.7.76.2207221502470.19850@cbobk.fhfr.pm>
References: <20220719145324.8107-1-dedsa2002@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022, Artem Borisov wrote:

> U1_UNICORN_LEGACY id was added to the driver, but was not declared
> in the device id table, making it impossible to use.
> 
> Fixes: 640e403 ("HID: alps: Add AUI1657 device ID")
> Signed-off-by: Artem Borisov <dedsa2002@gmail.com>
> ---
>  drivers/hid/hid-alps.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
> index 2b986d0dbde4..db146d0f7937 100644
> --- a/drivers/hid/hid-alps.c
> +++ b/drivers/hid/hid-alps.c
> @@ -830,6 +830,8 @@ static const struct hid_device_id alps_id[] = {
>  		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
>  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
>  		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1) },
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
> +		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_UNICORN_LEGACY) },
>  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
>  		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_BTNLESS) },
>  	{ }

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

