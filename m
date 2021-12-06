Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5D4690E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbhLFHst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:48:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238534AbhLFHsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638776710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0dKb0kOkklPwAp+HaAd/9ZIxbT61a1WHxt78m0N/Py0=;
        b=RwgeZQzfeQZXfy2FFjTM+bElOHfJlV0pY1Gir7wDyMULCJkbXDECCN3m9FHrARZd9YoEOj
        A85FDGuA1xmwPnec2lW1LUBT/94YYnhatNVE9ierkoRO29qnG2lFAK05j+iYGyF5iNthCp
        4JKyQ/DIyZJP82/3hJmlDhK4BuMkXjg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-Do_tGNhLP-Ks1ofobqJsLA-1; Mon, 06 Dec 2021 02:45:09 -0500
X-MC-Unique: Do_tGNhLP-Ks1ofobqJsLA-1
Received: by mail-pj1-f72.google.com with SMTP id iq9-20020a17090afb4900b001a54412feb0so4217684pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 23:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dKb0kOkklPwAp+HaAd/9ZIxbT61a1WHxt78m0N/Py0=;
        b=mrb+78ViK9OYgrW5tEIolXIEYeo9XZ6tRSVlIHhybyvXUKHNvhwQvLmYUtV96nJctc
         nv/VJrB7BJNlu9NIVeEaO1Gik013k78CY5LS1IKhyyp6MRWKiXejd8wgkURvR0eD/O+F
         BCgvlQb2V/e42VnCXZ6myjQuoOl3J6dfTozoxBM5ZYox87hK59cd3RIZwSf31NZ/X3fT
         ljGEbNdm+HllmSqcvYWHR5d4dXf2JgCaNGj3HoWVtr9Z+vYEDwB5X2JRaA5xgVke32Dq
         CdUC6qP0k4qBWIL0xzT+WxpvZAybLLB/aahCPGVc3r2ioXKkksy4PdxPxvz4GAr+sCCc
         zn8w==
X-Gm-Message-State: AOAM5305Ly4hT3lrp+C7k2Zxpz4EF6WpFY7yHXx6VoMSGOh2JF8lpwQE
        cXxPKgDVpC/Dd55mS9hD7n71rrOrb5uuiLuYNjU1djma9khzy3yL0mdJKhZC+d1MG7CY6P/N+co
        /hw8zkrC2QWPFJM7LIwfy7NbjsPV3czc2mhN49bgE
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr34293727pjb.246.1638776707414;
        Sun, 05 Dec 2021 23:45:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJoSPn8ntMUaQBKWCcmnF08/27uwMa/Y6ogSQsJsFjqRB4wjHAvDr/qkY3QTQPlwpjTlXweyOmbZHTkhBa9dA=
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr34293706pjb.246.1638776707237;
 Sun, 05 Dec 2021 23:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20211203185928.821497-1-arnd@kernel.org>
In-Reply-To: <20211203185928.821497-1-arnd@kernel.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 6 Dec 2021 08:44:56 +0100
Message-ID: <CAO-hwJLsijqibqARiWP0tPnmSDnrPsxSXDsvkgTV0=R7kQ1oOQ@mail.gmail.com>
Subject: Re: [PATCH] HID: prodikeys: add USB_HID dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Dec 3, 2021 at 8:07 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Like with the other drivers that recently got fixed, this one
> fails to link if USB_HID is disabled or unreachable:
>
> ERROR: modpost: "usb_hid_driver" [drivers/hid/hid-prodikeys.ko] undefined!
>
> Fixes: f237d9028f84 ("HID: add USB_HID dependancy on some USB HID drivers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks like you already been beaten to it by Greg:
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-5.16/upstream-fixes&id=30cb3c2ad24b66fb7639a6d1f4390c74d6e68f94

But thanks!

Cheers,
Benjamin

>  drivers/hid/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 74ce789f8636..48d18559670f 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -246,7 +246,7 @@ config HID_MACALLY
>
>  config HID_PRODIKEYS
>         tristate "Prodikeys PC-MIDI Keyboard support"
> -       depends on HID && SND
> +       depends on USB_HID && SND
>         select SND_RAWMIDI
>         help
>         Support for Prodikeys PC-MIDI Keyboard device support.
> --
> 2.29.2
>

