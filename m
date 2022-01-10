Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2105C489D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiAJQST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiAJQSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:18:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54866C06173F;
        Mon, 10 Jan 2022 08:18:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62522B81661;
        Mon, 10 Jan 2022 16:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E420C36AF6;
        Mon, 10 Jan 2022 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641831495;
        bh=rS4V/WO3etbLxGRygeuWlcXQr4ydR1z6tfJWlu1EtTE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d2mnaon2KYPN/QbKt30EQ243zPBjMmAIJ8VcqXYrjJ6ReupubGADw+v86TvDBoDCU
         InpXP3k2Vj0uBubhUDqClgoiBbDd2SOcmUFC2Uy+xoMI48PpqcqIVAxv8JCIEBPpzf
         AINBzxbMd3Y0jj8IaOsP5aQHkVMOazB5H63MjE5Zv+gbmIovnfvd7flys5uGVZoWkc
         C7bNiXOFUMlIG6ZXHauoU4yiGlB6vPv8vAebmpwTB9dYmajQOXTma5eG4hHC4hOsNe
         QMHM8vqJfjV3qMiRUTRqT0A/XElQr+9BS+XumDIWdilDv7aA5t+xOTezWvRxsFbNAO
         syjdwTdIbx4Xw==
Received: by mail-ed1-f51.google.com with SMTP id m4so14150904edb.10;
        Mon, 10 Jan 2022 08:18:15 -0800 (PST)
X-Gm-Message-State: AOAM531OXlqqBDeOWvFmuQ95YvHPPmfbiKrpaknvnvQwHT1FloalveWW
        aqLLf9ZCIgH4py69USBD7IEzPYfL1IVQXrI4Sw==
X-Google-Smtp-Source: ABdhPJxzI/V2iQ9Y/D5SfWoyQ05XpKPBwP6qYhOYyRpWpiYpvr4ivTJ/0gQCDjzplq09Hl8rg61Ix1TRefJ0/NcCXNM=
X-Received: by 2002:aa7:ce88:: with SMTP id y8mr357803edv.303.1641831493386;
 Mon, 10 Jan 2022 08:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20220110104214.25321-1-yu.tu@amlogic.com> <20220110104214.25321-2-yu.tu@amlogic.com>
In-Reply-To: <20220110104214.25321-2-yu.tu@amlogic.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jan 2022 10:18:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKFLnfc5eaUHeo6EkbS0kkpA94rh=Zuda9V9aCragdVxw@mail.gmail.com>
Message-ID: <CAL_JsqKFLnfc5eaUHeo6EkbS0kkpA94rh=Zuda9V9aCragdVxw@mail.gmail.com>
Subject: Re: [PATCH V5 1/5] dt-bindings: serial: meson: Drop legacy compatible.
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 4:42 AM Yu Tu <yu.tu@amlogic.com> wrote:
>
> Deprecated, don't use anymore because legacy amlogic,meson-gx-uart
> compatible. Don't differentiate between GXBB, GXL and G12A which
> have different revisions of the UART IP. So it's split into
> GXBB,GXL and G12A.

You are breaking compatibility. If your dts is updated to use the new
compatible, then a kernel without the change will not work anymore. It
worked before without understanding the changes you are making. It
should continue to. A compatible value like this would accomplish what
you want:

"amlogic,meson-gxbb-uart", "amlogic,meson-gx-uart", "amlogic,meson-ao-uart"

A new kernel will match on "amlogic,meson-gxbb-uart" or
"amlogic,meson-gx-uart" depending if the dtb is updated or not. An old
kernel will continue to match on "amlogic,meson-gx-uart".

If you are going to go breaking things, the power domain distinction
in the compatible is odd...


Rob
