Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D24482092
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbhL3WWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhL3WWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:22:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE37C061574;
        Thu, 30 Dec 2021 14:22:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o6so102875972edc.4;
        Thu, 30 Dec 2021 14:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icsjDhIEKBv5PA4Cpy4V9FTUygiq2ZP93ta7HHiW2v4=;
        b=Gr15T/KmJfjujIQlleKTVn7ZjlbaQshoHQ1fBpigwcMnqQcWeWZVx/DnOggcG9tljL
         4ScXXjD7bR1sp6MR3qYz3W0pp6jQ7lVRTFJZCnBT6pqLdi5dfzrwvqy3xG8+i+n6jMaV
         2WJeBebbpyw4+WP0SabwtOADxNCUYs5MFCwiTOWbLkYp+RwL5Syx0tn2yRG5vgpEYXSR
         gePRubOL3TJkn5vvnuh4PrDkMnILbt6sXY3GfScrognSzglomLdQGZWtd9f4C/5JNy/Q
         42lOWGesauSumOOHgI16SLX6ba160OqJzQALmz4Zq04ipB5eBNzSoqJEbBSknzbt1SMy
         BMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icsjDhIEKBv5PA4Cpy4V9FTUygiq2ZP93ta7HHiW2v4=;
        b=t5vE+I5qHGCa5U58cS4I6rgYQqklGO72fBuMxyI/IGNW0opdeHVMT1Q7eOUiJu/0Mx
         wfq9JgL0m1ldxqmGoUQn4fJL7HtMUMkgHYOJKRyzTnx4g5/Fm5jf3yY2DbaUMe6H3Phf
         rGWZCETj9h13sIYqG7Ns5fh93FPf4JmeBo7rzJHl/FxpGAgt0hSTlrytyTi5hIHJvKdm
         R1+gR+MHOWi3GN+SUtIH7+joFkAWwa95rSOWljVaI38S/eJKCCpjBehjQwEUjLzLftFd
         kqZPrVl0t1fv0nrcZoen97QGUKVdRp9Nvo5y1U//5Yj/JDc4T2gkOmpKbOE3bgDOnBnP
         a0nQ==
X-Gm-Message-State: AOAM530K684RgxA11q+TlBLXLMa/vBtETz/xCniEq3vuU0aEL/kDaUJ5
        G+2cM0srgLnvBJxXDG2mJwdqnyiQP6STBgaQlds=
X-Google-Smtp-Source: ABdhPJxtKwpWjmgFoVKO9DStYPv1zfin8xWOEvaSCQcpNxTMa3nbTPKK7mmsoXmhxZjD3Jf8NVKoGKv4X2fLb/PZQBo=
X-Received: by 2002:a17:907:75dc:: with SMTP id jl28mr26104740ejc.13.1640902955841;
 Thu, 30 Dec 2021 14:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20211230102110.3861-1-yu.tu@amlogic.com> <20211230102110.3861-2-yu.tu@amlogic.com>
In-Reply-To: <20211230102110.3861-2-yu.tu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 30 Dec 2021 23:22:25 +0100
Message-ID: <CAFBinCCwjS36ss_4sU+o9m8gEprFsVZbqcxgpQxczTNohZqFdA@mail.gmail.com>
Subject: Re: [PATCH V3 1/6] tty: serial: meson: Drop the legacy compatible
 strings and clock code
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:21 AM Yu Tu <yu.tu@amlogic.com> wrote:
>
> All mainline .dts files have been using the stable UART since Linux
> 4.16. Drop the legacy compatible strings and related clock code.
>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
I have just realized that this cannot be dropped until my series "ARM:
dts: meson: fix UART device-tree schema validation" [0] is merged

[...]
> -/* Legacy bindings, should be removed when no more used */
> -OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
> -                   meson_serial_early_console_setup);
This part is still needed as long as above series is not merged yet.
If we remove this then earlycon will stop working on the 32-bit SoCs
unless [0] is merged.

All other code below - except the of_device_id entry - can still be
removed since meson8.dtsi and meson8b.dtsi are using the non-legacy
clocks already.

Sorry for only noticing this now.


Best regards,
Martin


[0] https://patchwork.kernel.org/project/linux-amlogic/cover/20211227180026.4068352-1-martin.blumenstingl@googlemail.com/
