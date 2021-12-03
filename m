Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0D646736E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379299AbhLCIrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:47:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351255AbhLCIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638521060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OwOgBsAqeM8nCc99h1P3E89qpglyfHpzTAJ8c3y42RU=;
        b=EptM6ht/wCAef7cRjcsDdn+sALLH3RktmTrmaYg9K1U1DI228nmQUXyOGNJcZEFQlrL2CM
        thEycqDxI4WfNO/yZUOAoqjOOup+GIQqzPgrVXpdgdLZsaVpp842WYCHfx6B62C/3do5E1
        rSzyhb1DWBykuE3UG9WrNeR7FdZghyQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-ZjU7mKG0PRqNi30TsLfCVg-1; Fri, 03 Dec 2021 03:44:19 -0500
X-MC-Unique: ZjU7mKG0PRqNi30TsLfCVg-1
Received: by mail-pf1-f199.google.com with SMTP id q2-20020a056a00084200b004a2582fcec1so1519026pfk.15
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 00:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwOgBsAqeM8nCc99h1P3E89qpglyfHpzTAJ8c3y42RU=;
        b=6AXugWnLAYhQPpX3Bn/5ZpVnRPcrZpohqUiUC4WS4CcrzmWjZ7DVF4FEJFNCGHUGg+
         R4O4BXMskfaOAMbe1+s5Lzf814Cido0cmEvksCZlMrO5xjgBwL1VTEgEFlujsm1KTaia
         mXd23vQ+DaA3I+QR5kT+b3wyX81L9wrhTAPFO8mQiokovrb2OFgyKZmTnXDcfjXyup5e
         TGFXFVzDitaJHWKpoFPQv/eqsxOllJH6/DVPBamxjgv1/rgZN0WykCBsydLafvOSauFw
         k1x3d6bjaODW52lmvN1UGbQUGDpaRJEPyJr8fwC8TTT/VWKRn4Y5gVuRMMJfhmH6xtNe
         kULQ==
X-Gm-Message-State: AOAM532zDgycUwqYVvQXJiqwxu90oLV5QIqI1ITMSHz/D8yQZ8/XsXLv
        os914i+g8RXQUq2DqsoxSz94/QPsxgmkTUmM3vXX3KZbYjOrccT8MvrJubitadfPQH3JdnrtLhV
        Z/VYMDRP1ot+i6cXZIFO9qU0J5KQntZEFipx0zNZh
X-Received: by 2002:a05:6a00:1741:b0:4a6:3de7:a816 with SMTP id j1-20020a056a00174100b004a63de7a816mr18228914pfc.29.1638521058371;
        Fri, 03 Dec 2021 00:44:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcFgiszaGcpNTDAyqOTnAd7lzOOq04bLVpu+i3J2p9LDN9SMN6RsYGzYHtQFhVPg/ujvYDj7XnUe8+M+7jQ5o=
X-Received: by 2002:a05:6a00:1741:b0:4a6:3de7:a816 with SMTP id
 j1-20020a056a00174100b004a63de7a816mr18228884pfc.29.1638521058050; Fri, 03
 Dec 2021 00:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20211203030119.28612-1-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20211203030119.28612-1-xiazhengqiao@huaqin.corp-partner.google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 3 Dec 2021 09:44:07 +0100
Message-ID: <CAO-hwJKA-+Vu44RnOAjkBB12QOWaq68sHngy=gX+dAgeFztiZA@mail.gmail.com>
Subject: Re: [PATCH] HID: google: add eel USB id
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, phoenixshen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 4:01 AM xiazhengqiao
<xiazhengqiao@huaqin.corp-partner.google.com> wrote:
>
> Add one additional hammer-like device.
>
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>

Applied to for-5.16/upstream-fixes in hid.git

thanks

Cheers,
Benjamin

> ---
>  drivers/hid/hid-google-hammer.c | 2 ++
>  drivers/hid/hid-ids.h           | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index 8123b871a3eb..0403beb3104b 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -585,6 +585,8 @@ static void hammer_remove(struct hid_device *hdev)
>  static const struct hid_device_id hammer_devices[] = {
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_DON) },
> +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 96a455921c67..b02d8b1d907a 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -501,6 +501,7 @@
>  #define USB_DEVICE_ID_GOOGLE_MAGNEMITE 0x503d
>  #define USB_DEVICE_ID_GOOGLE_MOONBALL  0x5044
>  #define USB_DEVICE_ID_GOOGLE_DON       0x5050
> +#define USB_DEVICE_ID_GOOGLE_EEL       0x5057
>
>  #define USB_VENDOR_ID_GOTOP            0x08f2
>  #define USB_DEVICE_ID_SUPER_Q2         0x007f
> --
> 2.17.1
>

