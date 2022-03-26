Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF03B4E7E45
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiCZBAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 21:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCZBAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:00:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C91C12D;
        Fri, 25 Mar 2022 17:59:00 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q5so12317927ljb.11;
        Fri, 25 Mar 2022 17:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BVtfYYgl1UiY9NrkHOYeYSomk3TpHw4O37jlKHosSiU=;
        b=Th9DNt97HzvoKHP8lH45GNLnuJWlG0caZKOIXgV3PiZr0pI5BTWn00IwtBcJZoHFVv
         D3josQ3GamCEloX40jBWStzTLse6JA9jkernLs/Pm0a5FQ16dvmn1lX62EPxgCVA5WvQ
         KQ6qAMogJY/qDEvsXxD4qXlqCyOiatjkDyN3+Dk1tzkh31FDn/pE4YOV8dF6XUl0jO8X
         ymEP1CAF2vkbLk3TWpQQix1UBtuEHlYKJK0TBrRQqPt6AbyLE685AkmhEBF5Wta+EOw0
         wsjZLxdctv0mk0s4BVlODtxqtPCZaxKF92OOKpIQKGzYIGx62SE73/uZ/lvJYj5rdoTN
         HbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BVtfYYgl1UiY9NrkHOYeYSomk3TpHw4O37jlKHosSiU=;
        b=k1PJV1pwdTPqNYe3Mlde2wAD/dK3+E3znyuvFJo55+K4YqChchT48uFSiFl9+zbUfy
         IEc7UlOiP0Lek/D/4Suru0xyIO2/5zBGEzs9HajbcJ/dkusSJcguv1WH3IRK8dF+GCse
         mQVRqurhBTHBZZjLvn8+/KDxRuOejLEuAm2DAKKS4aTXDGmPzrZL4BUpxij2DR8lZv6J
         CdfP0O32BnznJ1k8F33XuFmD45X723qRMf18ktVDAGiC0BjYVMv+TFr1M+BDtBdUgGa9
         9u7Ais2b2zYMsCMqTiNYuZNdPbQkWkD7546qEcBLJvAXbG4FFrKFOJZrCV/762msNWk8
         xreQ==
X-Gm-Message-State: AOAM5304SNhBCAz4R3FCejm67OGXVOI7gVNW7Lb2wzNVcuc3x7NtpDPf
        iTd2HUs1fb1Lm2B10RLZOJFau5jz3S4bLlrjva8=
X-Google-Smtp-Source: ABdhPJwW9UYq9zgWfSnh4zwUD8aTy+59ByBfInkR0bCYS67gQfGldlsfbRMYnds5gKIUKX9uhK3nhMWBwkPjtw3HM/w=
X-Received: by 2002:a05:651c:1192:b0:246:1d6b:d323 with SMTP id
 w18-20020a05651c119200b002461d6bd323mr10255003ljo.360.1648256338971; Fri, 25
 Mar 2022 17:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-3-git-send-email-u0084500@gmail.com> <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
 <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org> <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
 <03999953-77c5-0272-7477-ab8a069b3671@kernel.org> <CADiBU38zYM1Rw2inTJ_Pu2eWKKqp2Ybb-_+JUJfxfmLNu=kYvw@mail.gmail.com>
 <cf67f944-47a7-f3b5-9d83-f0f51dc4e954@kernel.org> <Yj3oXuijuZY1gG9X@sirena.org.uk>
 <d2f220ae-c62c-a7f7-23cc-c33956c2eeaf@kernel.org>
In-Reply-To: <d2f220ae-c62c-a7f7-23cc-c33956c2eeaf@kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 26 Mar 2022 08:58:47 +0800
Message-ID: <CADiBU3-3QLi5PVUymk_VCbF+-uVSqjoP9jLGL+R=PQ-S=Y=_AA@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8826=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:08=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 25/03/2022 17:05, Mark Brown wrote:
> > On Fri, Mar 25, 2022 at 04:55:25PM +0100, Krzysztof Kozlowski wrote:
> >
> >> You mention board, some of_device_get_match_data() so you talk about
> >> runtime. maybe_unused is not about runtime. It is about build time.
> >
> >> The code you sent cannot have this structure unused. If you think
> >> otherwise, please provide argument, but not about runtime (again). You
> >> can for example build it without OF and see...
> >
> > If you use of_match_ptr() in the struct device (which is good practice,
> > didn't check if this driver does it) then that causes the ID table to b=
e
> > unreferenced as of_match_ptr() compiles to NULL when !OF.
>
> Yep, then the case is obvious, but the driver does not use it.
>
> +static struct i2c_driver rt5759_driver =3D {
> +       .driver =3D {
> +               .name =3D "rt5759",
> +               .of_match_table =3D rt5759_device_table,
>
> Therefore the of_device_id cannot be unused, so __maybe_unused is not
> correct. This can be fixed in two different ways, which we did not
> discuss yet...
>
As my past experience, '__maybe_unused' must be added to fix W=3D1 build
warning when OF=3Dn
You can refer to the below link.
https://lore.kernel.org/lkml/1598234713-8532-1-git-send-email-u0084500@gmai=
l.com/

And it's based on 'of_match_ptr' is used.

I tried to remove only __maybe_unused and build with x86 config  that
CONFIG_OF=3Dn.
There's no warning or error message when compiling the rt5759 source code.

If so, I will remove only '__maybe_unused'.
May I ask whether 'of_match_ptr'  need to be added or not?

> Best regards,
> Krzysztof
