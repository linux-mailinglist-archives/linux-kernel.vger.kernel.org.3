Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E17B490071
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 04:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiAQDAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 22:00:22 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51866
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234088AbiAQDAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 22:00:20 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 430013F19C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642388419;
        bh=tbFdbl3a6wyFWQoCr2QHMITY6WUY2RtOQOu/UXgg7ZI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fKAj44UmJp6l2yXiWHuECM13MhUxIVk8LMdOzIVD/pDhQPlJuR5y4d9wYiAirtR/M
         ePVfLMM0uA+3GIYJpObkzbOavwjzTpJ7hvUmY1DLz4UrNiIhYi17bYvrDZM/vKQ3mz
         BpzQJzdh5eqEu2arZRJG4xkIAG1tduzY9a5zEyMwnpn/x8J/wu5h3Jp169O4I5AQdZ
         t647fKNYxPxXCRmjS0HZ9Sl2WkaMUVcHCzLVJg5wusGQ8fBadaRGqLy4vXGuZh8qDk
         WKED2RQDQqgMmUONfxF1lT7IysdMDB2pLum3Gcb2aiEA3fzsSmjI9XuUCDwmKPvZOy
         AOkAYXYH1lBDg==
Received: by mail-oi1-f200.google.com with SMTP id g4-20020acab604000000b002c8b24c3964so10479184oif.22
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 19:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbFdbl3a6wyFWQoCr2QHMITY6WUY2RtOQOu/UXgg7ZI=;
        b=D8sGDdNIzfrGO8rY4dJWxAmeej129oEv788LrGYjpWWYURuNqgSmF1n0bvyKCgBvNS
         UYAzIOjevJRg6ZIggdRSErMAsECc0fk5P6rRykuf86o/4zh5DxTff+XX8+hegmUzoHET
         g8W1ARx6Y7H2L1VP3Ug5nUTQrrfLt8QLr6F65D9ZKm/N0AkS/2L9crPl7MkQuAzA+Q+d
         354EoVK2ZiR32U4TJaby3RJDMjf8VQG+NnGSHVENerVgzGNIIUhQs3JU+f4WmG9hA2vR
         ZO2sEYydpo7U8dJ7ACxdOtqGtLwF3unBcOMgx7MqAIFinQMlQtGTYlwSfIjjmO9FVMzy
         MtBQ==
X-Gm-Message-State: AOAM531fEV0w4J/uaK5lt/jlMhiAeTJcNcxOD6rS3nXHiMUr6/4U2RUh
        VPwJnojAZZiQcSTb3Gb7kpGUwRkpLgbOcvOsc5EvBDSOzZ4V2mrCxTJFKFIWLPkU1T1AbvPYWud
        uvev1rRMZ5zCvlXelbcBCrYy5JQ2TFmiU1rM3tPW134ibr7PZZZNFw2dfjQ==
X-Received: by 2002:a05:6830:1f3a:: with SMTP id e26mr14796109oth.233.1642388417993;
        Sun, 16 Jan 2022 19:00:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1QTZiASpuDes7BN+zVFAzK/CfctQWh69kH+opon159gi/rJ0OyWyyCiCx0ejSAwa1FVur/IxA+NmYd5yZkT4=
X-Received: by 2002:a05:6830:1f3a:: with SMTP id e26mr14796090oth.233.1642388417639;
 Sun, 16 Jan 2022 19:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20211230052811.650191-1-kai.heng.feng@canonical.com>
In-Reply-To: <20211230052811.650191-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 17 Jan 2022 11:00:05 +0800
Message-ID: <CAAd53p6ev+yQT+jf32UrTMWQXwDPYtmZSrW0zCQnKuUaBbtXUg@mail.gmail.com>
Subject: Re: [PATCH v3] usb: core: Bail out when port is stuck in reset loop
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Rajat Jain <rajatja@google.com>, Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 1:28 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Unplugging USB device may cause an incorrect warm reset loop and the
> port can no longer be used:
> [  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x4202c0
> [  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
> [  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
> [  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x4202c0, return 0x4102c0
> [  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x4002c0
> [  143.039096] usb usb2-port3: link state change
> [  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
> [  143.039101] usb usb2-port3: do warm reset
> [  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
> [  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
> [  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, link inactive
> [  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x2802a0
> [  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
> [  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2802a0, return 0x3002a0
> [  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms
>
> The port status is PP=1, CCS=0, PED=0, PLS=Inactive, which is Error
> state per "USB3 Root Hub Port State Machine". It's reasonable to perform
> warm reset several times, but if the port is still not enabled after
> many attempts, consider it's gone and treat it as disconnected.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
>  drivers/usb/core/hub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 00070a8a65079..f618d86d526d1 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2979,7 +2979,8 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
>                 }
>
>                 /* Check for disconnect or reset */
> -               if (status == 0 || status == -ENOTCONN || status == -ENODEV) {
> +               if (status == 0 || status == -ENOTCONN || status == -ENODEV ||
> +                   (status == -EBUSY && i == PORT_RESET_TRIES - 1)) {
>                         usb_clear_port_feature(hub->hdev, port1,
>                                         USB_PORT_FEAT_C_RESET);
>
> --
> 2.33.1
>
