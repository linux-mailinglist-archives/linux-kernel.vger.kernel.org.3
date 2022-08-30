Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCD5A5E12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiH3I2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiH3I2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:28:33 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FEF72FE7;
        Tue, 30 Aug 2022 01:28:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-340f82c77baso139612157b3.1;
        Tue, 30 Aug 2022 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+LwAl7PUkEepJ1lIaE4+OPBBMc7O0EAG6xNwpqZpZHg=;
        b=pIdNzjVbNqDCLu7th2NhL6YlLeZtusgcSiGIM10wkikXvkdU2UarJvv7cX4x9fnpnF
         RoHO7evoZVeXsYjzacL7iqHkciPpq0q3+W24PBSSHJRjVeA3rJs5sPfTU4rPyioDw4wB
         pYp2+JespgNH6DTzmNyJ4DBLebBGjWrjQS5iVv6R+VemKBip5lDcdcRV6TEyr05AcMid
         6Ajcjj/mdBTEB2tlSmMKSqd/I4ai9FNwoB1LqSeoQ8Z8Ifwb8VRcz2FZHjBpM0eWKb9u
         uubGSasiJyjw+fQQUMyel689DpGAjFkUQrF4PPXMnJ7P8/Kngt96kp2b9UX0kaBBNC9M
         aduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+LwAl7PUkEepJ1lIaE4+OPBBMc7O0EAG6xNwpqZpZHg=;
        b=p7tdTBCSkjKgn+QguOhjzb2RsS26DRRumOwvTXoN8NW4+qBRP2EMM0hBcwqorZBatb
         YocaUCDwp6yaW6DaukeAirLOpVSrM0Oy4nJWwunwpzno57MkMTVsCwKNZauXV5yuSEUK
         p87tpIZWJdsHE7dTTsi0i1ADc6sToW5/9AJoRMiaeiG4JghSpqKPw1483mEAaRc0ba6A
         B4qZw8GBKKSu8bRFswYbs87JgDFDfBdDO1XE+s65FM9BLMP4iXXAs3NS5CQ8En51aTgS
         ghGeyh9VJisT0tfxF03HvlI48KvSVZau0EKZWgzhdocOVmiZzDBf2/cskrw/P7fsUo6+
         tBlQ==
X-Gm-Message-State: ACgBeo3wb7jtR/kgfY3wXruVZZczzdf0pmERQ+b5wIE/QH4qF3RRzCKR
        zSjgQuX1L/4I7ELAq/4GKMvw6w1Q/SI1G8zTjBs=
X-Google-Smtp-Source: AA6agR7zI5uwUNMd7rMEnWYc6pU0UTrwwUW+ldgZCwHycenpKmKo3pCG2JmVmS5N2j7w3RikV0r6AKlINfnZRnHOYwM=
X-Received: by 2002:a25:8b8c:0:b0:67b:5c18:870 with SMTP id
 j12-20020a258b8c000000b0067b5c180870mr10814096ybl.244.1661848111642; Tue, 30
 Aug 2022 01:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220829214256.5583-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVV6eEtWBaeG4VESe_cyPKYcTo-xSfwJDPLYOYCG=ZHug@mail.gmail.com>
In-Reply-To: <CAMuHMdVV6eEtWBaeG4VESe_cyPKYcTo-xSfwJDPLYOYCG=ZHug@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 30 Aug 2022 09:28:05 +0100
Message-ID: <CA+V-a8vJpj-S177DTsKezT=f3T4Oup0763fQtK3+9Rsums0N9Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Add iommus property
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Hi Geert,

Thank you for the review.

On Tue, Aug 30, 2022 at 8:06 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Mon, Aug 29, 2022 at 11:43 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > The SDHI block on Renesas R-Car and RZ/G2 SoC's make use of IOMMU.
>
> blocks ... SoCs
>
> > This patch fixes the below dtbs_check warnings:
> > arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb: mmc@ee100000: Unevaluated properties are not allowed ('iommus' was unexpected)
> >         From schema: Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > @@ -77,6 +77,9 @@ properties:
> >
> >    clock-names: true
> >
> > +  iommus:
> > +    maxItems: 1
>
> I would insert iommus below dma-names, as iommus belongs to dmas,
> logically (yes I know dmas is not used on R-Car Gen3 and RZ/G2, as
> SDHI has its own DMA controller).
>
Ok, I will move it after dmas along with an updated commit message and
send a v2.

Cheers,
Prabhakar
