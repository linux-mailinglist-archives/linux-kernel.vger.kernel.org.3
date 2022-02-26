Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD74C5767
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiBZSQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiBZSQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:16:49 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FFF16DAE2;
        Sat, 26 Feb 2022 10:16:12 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id u3so12282296ybh.5;
        Sat, 26 Feb 2022 10:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LrEwaB+kbTeaznkd+BNx8jVuqDzOoWE98mZBP/QrouE=;
        b=IX95pwb0o0c1hdOQhpuOhe3OCnJ2Gb7GVrSZ6X1I2PH9tjuaE86tQRG/xSsVZvYINv
         XiYp6Fa/W2Ctg4q5bq8P7CmKiU4zAjOb5lWtmw8e+aFNTGNK9T/DjNXpjjXFouQ6do2u
         6g4R+0MsSjO0gkHAFPSNWQNiT2VZTOJAimfBV4M1ibAXdeAHP8Xt5KzAMCOo//ReGTby
         Ef/acwmtbJdtd5CgnBFTcv8y0hNbkttqPcFRiYs7bIO1Y6BCjBAVnm1UtsVVIQ1f1207
         GhYSBN6wAYrtX/jNMU/lVB9NLpVR/hVv8ZiYT4yIRboutW58uEXkYtPQcJx8br2gnguI
         hVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LrEwaB+kbTeaznkd+BNx8jVuqDzOoWE98mZBP/QrouE=;
        b=gUfKaoV6ktq168lK20tRRr1ubOUKstsW5t+mvpd61HZ19focux3JYkYQcXGjfTe3Mr
         iao2Lpmk+jmN8aRnFIa2t5rK/vIb/3UcfE6If97jyEWXqH3Z3a+q1xvKjcxWeDw7uBT7
         +GcFilA3rCluHhIxRP+7g1P/vBQIdtEm63YUqNkm8sTFjyfJa7uz90hQePrrrmfaK8LJ
         NL7/mwUFRzNP4Y5KeKwAiCeoWIK09ie6UiY0QdXHxZKNRXA9gzaBZPGwndxyK0CvlKxg
         c1w2u7zqzf84CO9kE7ZpCkC6O3HiSI8JP6HOZDYcqNrdWU0k4x6Fw/nAYSvlZ/Fn+XeN
         nZJA==
X-Gm-Message-State: AOAM532migsp6oVClk8I5Se88nhsEvaNMTNCWE2U/Jf+7gqeZZq763Nw
        ewI7BlUDTynJSuLdK/44YY6CNIdF17SQbrHP6SwxGN5fczm6zw==
X-Google-Smtp-Source: ABdhPJx6p75lgdbg9+7oe/9Jb1gunfXQkp3m4E3iFa+ALW1LnJX8X5/l6U5lvNfO3suJC1cXRwg6JBfdicUwZAOWbcE=
X-Received: by 2002:a25:8490:0:b0:624:5f70:142a with SMTP id
 v16-20020a258490000000b006245f70142amr12382739ybk.173.1645899371404; Sat, 26
 Feb 2022 10:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20220226135724.61516-1-linux@fw-web.de> <2815432.3mA4caTK8C@diego>
In-Reply-To: <2815432.3mA4caTK8C@diego>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 26 Feb 2022 13:15:59 -0500
Message-ID: <CAMdYzYro7r2nELu2O4TuxxtZLxNSv1e3iU5yBzjd7AQgHP+FPw@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: rockchip: Add sata2 node to rk356x
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Frank Wunderlich <linux@fw-web.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 1:08 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Frank,
>
> Am Samstag, 26. Februar 2022, 14:57:24 CET schrieb Frank Wunderlich:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > RK356x supports up to 3 sata controllers which were compatible with the
> > existing snps,dwc-ahci binding.
> >
> > My board has only sata2 connected to combphy2 so only add this one.
>
> how far does the added node diverge from the vendor kernel?
>
> If it's pretty much similar between both, we can assume the other nodes
> should work pretty well as well and therefore should all of them at once
> and hope for the best?

There's essentially zero divergence (minus the change due to combophy
changing), and likely won't be until the ahci-platform.txt is
converted to yaml.

I have tested both SATA1 and SATA2 successfully on the rk3566.
I don't have any rk3568 boards that are operational yet to test SATA0.

>
> Thanks
> Heiko
>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot=
/dts/rockchip/rk356x.dtsi
> > index 7cdef800cb3c..7b6c8a0c8b84 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > @@ -230,6 +230,21 @@ scmi_shmem: sram@0 {
> >               };
> >       };
> >
> > +     sata2: sata@fc800000 {
> > +             compatible =3D "snps,dwc-ahci";
> > +             reg =3D <0 0xfc800000 0 0x1000>;
> > +             clocks =3D <&cru ACLK_SATA2>, <&cru CLK_SATA2_PMALIVE>,
> > +                      <&cru CLK_SATA2_RXOOB>;
> > +             clock-names =3D "sata", "pmalive", "rxoob";
> > +             interrupts =3D <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> > +             interrupt-names =3D "hostc";
> > +             phys =3D <&combphy2 PHY_TYPE_SATA>;
> > +             phy-names =3D "sata-phy";
> > +             ports-implemented =3D <0x1>;
> > +             power-domains =3D <&power RK3568_PD_PIPE>;
> > +             status =3D "disabled";
> > +     };
> > +
> >       gic: interrupt-controller@fd400000 {
> >               compatible =3D "arm,gic-v3";
> >               reg =3D <0x0 0xfd400000 0 0x10000>, /* GICD */
> >
>
>
>
>
