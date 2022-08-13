Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE46591B27
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbiHMOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 10:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiHMOwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:52:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02564BF77;
        Sat, 13 Aug 2022 07:52:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fy5so6490708ejc.3;
        Sat, 13 Aug 2022 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=WMmwkK4k5xPlUVcqJ30C1LHbz/Q/KZcpo7vE9zUN3TE=;
        b=nRKXeZ7L14mSyhcdUmyRgBqlsZ6lXxai61d/wQCo+vg4gsXvll6mhWyDXK671GhYEV
         nqGV5+OVXixFCrDwNldbGT6Vr/H/8GrZCeiDKMv1EOyPWWckJQetpsl2BQJNYxy/CJrE
         vYhPsYIe3rng1dG9cfgEbYtJ7YspLc4jNEYn2Xb48yLk1moz9AJUXv54UZud8iJFv721
         +WxG6SY1DvWQGSGSxvjnbs5w13Q4J1pnqQiqnkLzcVu0GRySLRhQWxFtqmrC0kSavLow
         JBmqGkp7Cl/qruzlKA/jg8T0Bt1VwR3Yom53S9RnyJHoTeZfsQiOO+2VWquT8z55peyO
         4kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=WMmwkK4k5xPlUVcqJ30C1LHbz/Q/KZcpo7vE9zUN3TE=;
        b=dblzCyiLeW+2ylVvUVUgMQ7rHjk7oacXxqQnv9CmbTr08I5jbJvY9D8un+Aj/qhMJI
         /FsiF1rquW5PZ58WQzvLVnumXvX1u3MNVx5rE+BdFCMLekPJ4jZBTDcE1AxDgHDIL0SL
         7iSnMxu271BNz8MEAdyYCBewc87u4cDxekAxxGGDoHFIULdoF1rxyuh3Sl4wHChxR2in
         QjpQWolJwb6dyKAzbZnQMauv/IcQsJUdjCNUvr46RSr0/gao6I7F0oMpLJolaZviQO3S
         gKhS9kGf3uKGHBSAf8ZvH/nSiDLcE1ajGw4jWNTnDYwIo3w1lZlrifQa8TbID1eIuM1O
         FOHw==
X-Gm-Message-State: ACgBeo1UvfVdbyEtwZdFKfG7zMeM8rNxNG9JpknoPN08EFO1drGrtN85
        nIlI1s50qnL+rlRtqQJNFXeQMa8rRteE6YeRM+XzZRJj
X-Google-Smtp-Source: AA6agR5fuk8Stg8kIwgCTgU+5Y0tz0E0mj6Ap6bzWqblG6xmzKl5Y6/VjZF0bD7C0EZkxkY0+XU3cxp7UJVeokeXKJM=
X-Received: by 2002:a17:906:9f2a:b0:730:bc30:da30 with SMTP id
 fy42-20020a1709069f2a00b00730bc30da30mr5747794ejc.763.1660402360218; Sat, 13
 Aug 2022 07:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
 <1660225318-4063-2-git-send-email-u0084500@gmail.com> <3cae9d60-4012-1dfd-abd9-4d0b9379e6bb@linaro.org>
 <CADiBU3_depGDZtiyizU3MB939A3oH1uTWzTMyruUy0z=u6BZkQ@mail.gmail.com>
 <40261b95-637a-1304-2e06-8c8ff7fc377b@linaro.org> <CADiBU38+9sR1r20=YWt-9s2+u7maHH+1VudCnV1-0+F4jYKdQQ@mail.gmail.com>
 <CADiBU3_Jt6n6tm=oVvjk5vsoEAneH7t-37S6skepA6v6bVVYUw@mail.gmail.com> <f2a664be-71e9-7a26-2f0c-5f654d9cb3cb@linaro.org>
In-Reply-To: <f2a664be-71e9-7a26-2f0c-5f654d9cb3cb@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 13 Aug 2022 22:52:29 +0800
Message-ID: <CADiBU3-bKGhW2Yy13svNUykqW+WN3VS6LftWMU0rMeCc+fMySg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9471
 battery charger
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        cy_huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B48=E6=9C=8813=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A82:53=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 12/08/2022 19:05, ChiYuan Huang wrote:
> >> It's the same usage like as TI charger.
> >>>>
> >>>> For charger driver, does it mean legacy IRQ handler is more preferre=
d?
> >>>
> >>> Who is the consumer of these interrupts? Can you show the DTS with th=
e
> >>> interrupt consumer?
> >>>
> > Sorry, I forget to reply this question.
> > Some battery driver may need to know the 'full', 'recharge' , 'ieoc' st=
atus.
> > The usage will  be like as below
> >
> > battery {
> >   interrupts-extended =3D <&rt9471_chg 2 0>, <&rt9471_chg 3 0>, &(rt947=
1_chg 5 0>;
> >   interrupt-names =3D "chg-done", "chg-recharge", "chg-ieoc";
> > };
> >
> > Some gauge HW needs this information to enhance the battery capacity ac=
curacy.
>
> Other supply stack pieces do it via supplies (supplied to/from in
> include/linux/power_supply.h) and reporting power_supply_changed().
>
> With such explanation, your device is an interrupt source, but it is not
> an interrupt controller. If your device is interrupt controller, it
> means someone routes the interrupt line to your device. Physical line.
>
Yap, sure. And so on, just use the SW power supply chain to do this
kind of event notification.
To remove it, it doesn't affect the internal interrupt request inside
the driver.
Just cannot be used for the outer driver to request the events directly.

If so, I think 'interrupt-controller' and even '#interrupt-cells' need
to be removed.
OK?
> Best regards,
> Krzysztof
