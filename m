Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A30586DA7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiHAPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiHAPU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:20:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0EC3C16E;
        Mon,  1 Aug 2022 08:20:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i13so14162326edj.11;
        Mon, 01 Aug 2022 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4CKtQxwPKS4j7fatFEAhn8LvR2NgwB5YlyPIU5XsHwk=;
        b=OGAIMw1UxjJ4QK77ceaSCBBiRgHyREGUxeIdYZZO4nn272S86QK1GHC9noVWD5Pqmy
         t3+9rNwWxlVaCZZgJogZKGFT+pIMssQkAMANKPrPxmMCDyJ2ekyuGpeFK/7XQY7aZkqF
         If/+XGghQVba7PzFll+PioVSSr0fquQG9y4dtVJb9Ff4CVD4EedmF+/xITVr+udin3RO
         LX0iFlfAjS52DXQqBcRNpvcnHlaFiftSB1TEmiJnSwHLMlCP5aAlv/S6X/S5IrjsU0f5
         oa8A2FGg71oodevcZyBo0zZN+s3R4MToZoqAxJuXPuTXNjLX6eEFq8V6QKdP31mAZH14
         hXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4CKtQxwPKS4j7fatFEAhn8LvR2NgwB5YlyPIU5XsHwk=;
        b=hDmhopghbXggarD2oIjBW52Og8mKqQBRMAxJ2+gGGhrQOdjjTXyy6ko1Axs7KQNwiQ
         XnLJmZk/QHARn5FkDJOGZl4z/stKynIaq4YXRUzIJbmR7v0Ml4efKBptQ03BZ/1DrZ/v
         EKXhAceIeIByNODhlzaCST1anw8yVr8gr/IkUHFmRA66D33Ykjl4QYYQzXqUb5KX6CZU
         DBMJ41AtwDmWz3ehXHAVQ48G3901lW6l4ywk/7ysz7LSSBXc4Si7bFSVXo3xFP9oWkdn
         q8tmIggBrImREUH5L+xhLNVATy/5zcHcRncnRwjYJZ29QWUsI7GElZ/fEXQBrUXbC6v1
         24Ug==
X-Gm-Message-State: AJIora/TZcG0UdWU0h1LrztwZreQP6o20ExuardLSU/d5B6fK+Au+KhO
        zC8e0BAfIZ/2DR/Uqr68c5izf/R/q4SKaC6mpcs=
X-Google-Smtp-Source: AGRyM1v3D0d7SNVFSXxBdUtxZX7Qnyex8InkzghlbHTNjoafVZhHUBVyhtYWDE8MfmDte5mcIOD/BG/QPYFnr8UhVP4=
X-Received: by 2002:aa7:db49:0:b0:43c:d1af:5c76 with SMTP id
 n9-20020aa7db49000000b0043cd1af5c76mr16531223edt.173.1659367252619; Mon, 01
 Aug 2022 08:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
 <CADiBU39x98iyO_OB2sYdAUGUOW9pV4dt+mEdfquhuJVm1HDRHA@mail.gmail.com>
 <ada44af6-2a5e-0b1c-8c46-3dbaae9b1a94@linaro.org> <CADiBU3-juJZoeGccjPGCsJJ=B7Sez=MhtiiFADCuCCGc7fLrxQ@mail.gmail.com>
 <YufmQXSQ093YkuiE@google.com>
In-Reply-To: <YufmQXSQ093YkuiE@google.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 1 Aug 2022 23:20:41 +0800
Message-ID: <CADiBU3_L=18cvJOvA+jsmjf_y=tGCRo5Ek3JTAiHx3xo5mw95w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add Richtek RT5120 PMIC support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A10:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 26 Jul 2022, ChiYuan Huang wrote:
>
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=
=B9=B47=E6=9C=8826=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:59=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > >
> > > On 26/07/2022 05:45, ChiYuan Huang wrote:
> > > > cy_huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:42=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > >>
> > > >> From: ChiYuan Huang <cy_huang@richtek.com>
> > > >>
> > > >> This patch series is to add Richtek RT5120 PMIC support.
> > > >> In RT5120, it integrates four channels of buck converter, one chan=
nel of LDO,
> > > >> and one external enable channel to control the external power sour=
ce.
> > > > ping ......
> > >
> > > Whom are you pinging? Everyone in To list?
> > >
> > Sorry, forget to specify the part.
> > I'm pining the 'mfd' patch and 'power key' patch.
>
> Don't ping any{thing,one}!  If you think your patch has fallen through
> the gaps (it hasn't), then submit a [RESEND].
>
> Your patch was submitted at the very end of the development cycle,
> which means that it is low priority and is unlikely to receive
> attention until after -rc1 is out.
>
Got it.
Because I'm not very clear about the linux development cycle.
Now I know. I'll just keep waiting for the reviewing.

Very apologized to ping it.
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
