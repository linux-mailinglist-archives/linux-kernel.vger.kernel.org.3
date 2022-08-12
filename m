Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5922F590D78
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiHLIfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbiHLIfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:35:50 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A7F21E28;
        Fri, 12 Aug 2022 01:35:49 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 7so501307ybw.0;
        Fri, 12 Aug 2022 01:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SovHfY+WOd6wV95pI5E0wFYxVIB+4e2AIqH2msk4bQU=;
        b=m8m+KkpyQhfjjlbt/9QorndorC6Dn7zfM5iEjQm1n6pMtBfAXdQUd+fm9Cf+mtOrQo
         +Z/dGgJPhEgToSKw2ylIG3B5FujC3SikbnuCcjDeh+zieIJT8paRTCKEBUnbi97ZrXFs
         x1a0/mqsairShgTmJLal78eMRIsgXsCDWblCwgiB9sQQ9enIGpCtT9jMyFB28DKQrdRa
         ulSZea153bLiGvoQI5kojLWNsiMaC+Yb9KzGDAxpfEZHcD1951vBF1VanU1xweYkKMsd
         qDGmkqjFD3TFaVHlAHbVkwYDqx3TZhigU5RcUBnphhtMEQkX1JaQEs/SxPz3iKqlIb+A
         8mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SovHfY+WOd6wV95pI5E0wFYxVIB+4e2AIqH2msk4bQU=;
        b=dzydwJYOzAWBOTyPk5MaL6l8nBmEaiBAOjzYY53jNHFIqJtAnNhZZz94YstQ60nG73
         JLV1quT4Knn2imwX5Z1MeZHNy18PtK5SIkE14BMvNerOrz9RfP248o7XXKaQI5tJ2zul
         6HtXd6CSyKczEVaej0TAhyV64W+uNvTah2m+x/iho9hRVQAMGkNMpQ30RS5DVq2g2mm4
         08hN0US96xPK5LSzyBeKFLOflPeU7URVBDArSn/t+J23NHPxQq6hKLPHFCiL9S4tb2Tt
         +29odq/8lxHwQ4dgFsDqT5pVmA4A7DvXUF8wMXxyn/uMJodl3k5R+XstADJ9BxgQBpCg
         yDDQ==
X-Gm-Message-State: ACgBeo2jg4fAxO/o9bab/9DIFa+cPi83WrTsw5Qv6GMcFDBYQs8U9LmP
        3bqXpcndVKrvVRpLGgciGeg7RfMVSza3j2DQlX8=
X-Google-Smtp-Source: AA6agR44EfIl2BDBZfy8SiIwuYEDMRul1lr5bJ4MY/Pu6Dv/Drjgwat4JXoWNy56ba/guOBBOA5aTYjK+gl1ZyXvqRY=
X-Received: by 2002:a25:2245:0:b0:67b:7758:808b with SMTP id
 i66-20020a252245000000b0067b7758808bmr2630616ybi.279.1660293349101; Fri, 12
 Aug 2022 01:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220726175315.1147-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220727154016.GA2719108-robh@kernel.org>
In-Reply-To: <20220727154016.GA2719108-robh@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 12 Aug 2022 09:35:20 +0100
Message-ID: <CA+V-a8smt5Z+Ksa4u5-_EFo7jofneh8udFFLHNBV4Qp0C2vevw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas: Document RZ/Five SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the review.

On Wed, Jul 27, 2022 at 4:40 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 26, 2022 at 06:53:15PM +0100, Lad Prabhakar wrote:
> > RZ/Five SoC is pin compatible with RZ/G2UL (Type 1) SoC. This patch
> > updates the comment to include RZ/Five SoC so that we make it clear
> > "renesas,r9a07g043-pinctrl" compatible string will be used for RZ/Five
> > SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml      | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Same comments as here[1].
>
This block is identical on RZ/G2UL and RZ/Five SoC.

> Rob
>
> [1] https://lore.kernel.org/all/20220727153738.GA2696116-robh@kernel.org/

Cheers,
Prabhakar
