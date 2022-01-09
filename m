Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B15488A2D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiAIP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 10:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiAIP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:27:30 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A3EC06173F;
        Sun,  9 Jan 2022 07:27:30 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q25so34913001edb.2;
        Sun, 09 Jan 2022 07:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FvGKVkbPoLk160s03cYFMqXeMrS4eC4Yo28LpR7wSZw=;
        b=LMRe01B2fNbEumBBtKwIIorsxK7i16MNKkIRaXNwdQN5piJeFnHt5MLsVCxOqK5Dmu
         ZYhBMMPXITQZzIyx4qhqpg5KKyZl63kE9tdj1nJRtuKwJu08DsIujwJGqdESIKDGXZoI
         0UCW+SbSuEtYq34Lr3/cVOUQhJ+n8xrqWOXHv38WMkMhLj5Wua59DypjHftzy/h5YF5i
         KXX5oLHiewt2v/r5+aiZ4w0paGjylcxXRztouKbCe0POHWiwltUe2kZydJs5KfXnd4mK
         34eWLUYDZ3jexU4Zms2d3T6iiicTZuCJxEWTre22KavqEWBbS7Q0GaQ9X/e/v6QEJ+O5
         ZRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FvGKVkbPoLk160s03cYFMqXeMrS4eC4Yo28LpR7wSZw=;
        b=AKLSeWgR0rs2jS/bwClUqGkW0+YyOG3jBNxu2pOnfBTI1EbpmSy8sBAvBwRkH8fwr1
         8xtz7r5X9/rAWd0C8WkvqVrfE8wYBntzsDDyE8HLgNHxpWW+G+hh2a4+MKjuc2+Ws+x1
         nWa385fsaoLVu4XoK9nwBh5nXejrXlTN/65hbhk5SgwWbn/vNUtEnTVcvnRhFxRCihlP
         ldeF6BZyfCrorSzCDHMm286weHfR1J+7LRkfoHPE2X973SNM2IlXR2ecbiUz41hTXc+g
         FXRpV3UIeRwrLnxmNO3PFZLtuHtrhr8Nmmg7B8+un558HpUhEQ/0HzlrG0UKRe0TP4Dw
         PtQQ==
X-Gm-Message-State: AOAM530UcSJWTs4vcRixEi+q0tQls/5ML0nPmh1K7B9cG/uO2qaKiEY7
        jEWTW4/GcSWZVNXVMrzLg0U=
X-Google-Smtp-Source: ABdhPJyzMm6ymM4prYuEf17YUomBN2JF7P4yBD4KFNg9QzadE1JGig2uY81GmWpJlxMLir2uCu/rYA==
X-Received: by 2002:a17:906:344d:: with SMTP id d13mr11133627ejb.375.1641742048935;
        Sun, 09 Jan 2022 07:27:28 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m12sm2157191edd.86.2022.01.09.07.27.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 07:27:28 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 1/4] dt-bindings: interrupt-controller: New binding for
 Meson-S4 SoCs
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20220108084218.31877-2-qianggui.song@amlogic.com>
Date:   Sun, 9 Jan 2022 19:27:25 +0400
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4441A27-7B49-4A9A-83FD-05144A63E705@gmail.com>
References: <20220108084218.31877-1-qianggui.song@amlogic.com>
 <20220108084218.31877-2-qianggui.song@amlogic.com>
To:     Qianggui Song <qianggui.song@amlogic.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 8 Jan 2022, at 12:42 pm, Qianggui Song <qianggui.song@amlogic.com> =
wrote:
>=20
> Update dt-binding document for GPIO interrupt controller of Meson-S4 =
SoCs
>=20
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
> ---
> .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt    | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git =
a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpi=
o-intc.txt =
b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpi=
o-intc.txt
> index 23b18b92c558..9300736bf1ed 100644
> --- =
a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpi=
o-intc.txt
> +++ =
b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpi=
o-intc.txt
> @@ -18,6 +18,7 @@ Required properties:
>     "amlogic,meson-g12a-gpio-intc" for G12A SoCs (S905D2, S905X2, =
S905Y2)
>     "amlogic,meson-sm1-gpio-intc" for SM1 SoCs (S905D3, S905X3, =
S905Y3)
>     "amlogic,meson-a1-gpio-intc" for A1 SoCs (A113L)
> +    "amlogic,meson-a1-gpio-intc" for S4 SoCs (S802X2, S905Y4, =
S805X2G, S905W2)

^ should be "amlogic,meson-s4-gpio-intc=E2=80=9D ?

Christian

> - reg : Specifies base physical address and size of the registers.
> - interrupt-controller : Identifies the node as an interrupt =
controller.
> - #interrupt-cells : Specifies the number of cells needed to encode an
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

