Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079C548E6AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbiANIi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:38:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40420 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiANIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:38:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0415161998;
        Fri, 14 Jan 2022 08:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82238C36AEA;
        Fri, 14 Jan 2022 08:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642149507;
        bh=eZrXkNR6tZSOqnbZSgDUYGUa4OUgT1vmZJRjI6HEcWo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rgeQIwTi6xxD2/JDO4eHkieOHB1e/6jWY32qRKsWsrmda0EkSyt/6AVBcIAk0zhQA
         NDMvBB80uj6Z3mJaLnYvr8T4UWFhcS0xSUeYwo4MmSp14UIsAeh5dENpgdcSasEQjr
         tZjUwOZ9LkCihPzLmrA817Wzbw2ze0H1GKMgXz0BO0wdHCSIuQZZC1SC5MoGe8Iwgj
         pvvCHrpx6B/wTEwOXs8o+f/xx+8iXDiEY0rzEMWqNcJGyB2j88NI4mhW3pwNrMR0hJ
         hccHlWlqRzKJYd4gONXW4UYhiXepmyqkQA77ldQ5SD5ICULmXXLYiaz4kfMjeS3LNA
         /2VqvB/hWhFwQ==
Date:   Fri, 14 Jan 2022 09:38:23 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@google.com,
        Wei-Ning Huang <wnhuang@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Sean O'Brien <seobrien@chromium.org>
Subject: Re: [PATCH v2] HID: google: modify HID device groups of eel
In-Reply-To: <20220107091357.28960-1-xiazhengqiao@huaqin.corp-partner.google.com>
Message-ID: <nycvar.YFH.7.76.2201140935460.28059@cbobk.fhfr.pm>
References: <20220107091357.28960-1-xiazhengqiao@huaqin.corp-partner.google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022, Zhengqiao Xia wrote:

> If HID_GROUP of eel is set to HID_GROUP_GENERIC, Whiskers Tablet
> Mode Switch of eel hammer will not be detected by system. when it
> is set to HID_GROUP_VIVALDI, system will detect Whiskers Tablet
> Mode Switch successfully.
> 
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
> ---
>  drivers/hid/hid-google-hammer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index 0403beb3104b..e5acd15f4a55 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -585,7 +585,7 @@ static void hammer_remove(struct hid_device *hdev)
>  static const struct hid_device_id hammer_devices[] = {
>  	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>  		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_DON) },
> -	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_VIVALDI,
>  		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
>  	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,

Color me confused, but anything with HID_GROUP_VIVALDI should be matched 
by hid-vivaldi driver, so what is this about?

Adding some more CCs.

Thanks,

-- 
Jiri Kosina
SUSE Labs

