Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3094853C0C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbiFBWTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiFBWTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:19:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2D734679;
        Thu,  2 Jun 2022 15:19:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c2so7978570edf.5;
        Thu, 02 Jun 2022 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=tbowqamXYYuuGAdFBr0ycte2n7isELmCXUpS72DXPYA=;
        b=Cfn9ZrjJiuyTgQEDoNcqfvdJSLpGNZk3ZIvxheCNDuJKdAZ7/R0LfKUCb6JqSD3l9V
         5r25+e3QoN3avlvliguJWFaximEHBbqMDW1vNP+yD4lCQPNmTqNiIxrvS0QZcMjXPXlX
         7XZlixPHgxssR2wJVbkZSSEYV5nwEsamgxA2dnD9UfYWMS4aAlDpm7rxRStHQoHUKE3c
         3XFgBIVrydZcp9sMwUro+iFBQqvdn8exH66hJiL0Is3zfcqToU58YLVPDLSYpiGr2YDw
         SxJDGBsf67UaIc46xeZo0fuUSHobZ8y0Ti46WMplznIqvpUkVHnHFAAaCQjodhoAq7Di
         hX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=tbowqamXYYuuGAdFBr0ycte2n7isELmCXUpS72DXPYA=;
        b=uexjQL9NqnPtZWq4DzAtOL6S15ZnCNapSfHDMjEDH0DDh3O7VeVXyBjo83wBmx99Ni
         CD07pqLGkLk8UIIlKSHLT9QXzlYrWvcysxcPl4p1K1WAt3xZoGGkbH63ACATsIBCd26i
         m0Q0lVndwMcFOD9TdvahpfWu+lHA63PxCDqGW9gsSwfjvG1cCqr4SzJ0ze4w4SL7TYAI
         GU1vPqg+aDsQibt+z5PQxq0qxFJ8EyGuA2p0KsEsNEgRCCQbaryVtTPeXU3fnL/Vp2nd
         n9HDC5dnqU1k9BmehJnu7BCKncS7b4/Z7uy6uxssuJcA/OhtalyF/+HUhshW4D5zYGlD
         D70A==
X-Gm-Message-State: AOAM532LXJBT342r88mydN+V3lg/1vPak2PgN9zMPfHa9k6CAGjy4CG1
        vtzWh7zTZMssbhHfLYlVFDrcgavZ64dcMCl8q+g=
X-Google-Smtp-Source: ABdhPJz1a65SOU6C73Ybt3zJBBGpUK5rx1jMp6pFTiIUucWL/ne9gp0OsWFNXQFD/Zwp0ttUaDtOpA==
X-Received: by 2002:a05:6402:1f0e:b0:42d:e38a:51f7 with SMTP id b14-20020a0564021f0e00b0042de38a51f7mr7825293edb.68.1654208358484;
        Thu, 02 Jun 2022 15:19:18 -0700 (PDT)
Received: from ?IPv6:2a02:ab88:368f:2080:eab:126a:947d:3008? ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.gmail.com with ESMTPSA id fg16-20020a1709069c5000b006fe8d8c54a7sm2150850ejc.87.2022.06.02.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 15:19:17 -0700 (PDT)
Message-ID: <f40aca00a4418c889395d2dab65f85d24e8662c6.camel@gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: exynos: Add internal eMMC support to
 jackpotlte
From:   David Virag <virag.david003@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     phone-devel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Jun 2022 00:18:51 +0200
In-Reply-To: <b3681990-e358-8e1d-93fe-b72c099902e3@linaro.org>
References: <20220601233743.56317-1-virag.david003@gmail.com>
         <20220601233743.56317-6-virag.david003@gmail.com>
         <b3681990-e358-8e1d-93fe-b72c099902e3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 14:01 +0200, Krzysztof Kozlowski wrote:
> On 02/06/2022 01:37, David Virag wrote:
> > Add the nodes relevant to provide clocks for Exynos7885 eMMC and to
> > support eMMC. eMMC is the internal storage used in the Samsung
> > Galaxy A8
> > (2018) (jackpotlte), and all other known devices using the
> > Exynos7885
> > SoC.
> >=20
> > Signed-off-by: David Virag <virag.david003@gmail.com>
> > ---
> > =C2=A0.../boot/dts/exynos/exynos7885-jackpotlte.dts | 20 ++++++++++++
> > =C2=A0arch/arm64/boot/dts/exynos/exynos7885.dtsi=C2=A0=C2=A0=C2=A0 | 32
> > +++++++++++++++++++
> > =C2=A02 files changed, 52 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> > b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> > index 4cf9aa25f618..5db9a81ac7bb 100644
> > --- a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> > +++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> > @@ -60,6 +60,26 @@ power-key {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > =C2=A0};
> > =C2=A0
> > +&mmc_0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mmc-hs200-1_8v;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mmc-hs400-1_8v;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cap-mmc-highspeed;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0non-removable;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mmc-hs400-enhanced-strobe;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0card-detect-delay =3D <200>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clock-frequency =3D <8000000=
00>;
>=20
> Is this real property for MMC? Neither mmc nor DW MSHC bindings
> mention it.

It is, but I don't remember trying without it. Seems like it is not
documented then. It is used in dw_mmc.c in the following places:

https://github.com/torvalds/linux/blob/master/drivers/mmc/host/dw_mmc.c#L32=
42-L3243

https://github.com/torvalds/linux/blob/master/drivers/mmc/host/dw_mmc.c#L33=
06-L3325

The Exynos850 device tree has the same property in it's mmc node.=20

>=20
> Best regards,
> Krzysztof

Best regards,
David
