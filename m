Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92014C8CFA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiCANyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiCANyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:54:22 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3AD457A4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:53:41 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t13so14965433lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 05:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpS3f8EZoX7R2KAuz/UX0/xqwonI23q4hXHZBWApjxE=;
        b=YFJelA+ENY4EZJiP/YLHJkzoR5u7rW4E0VfzaZ8Q0qZfr9TB0HgZJOE/d1MySMcgPx
         Jf+/ZYCNvUoklZvkkIO9N8lnHCWaTxSd8Q/pfuSrwkZ31qj3uG/pBlU9hdB+FzzO1Bqa
         lmSYkKdaVatqRi/v1os1vNgdcFtMMHkJrbetMD5nmxughc6Duj/ZLysburORm04pujaU
         KZ1c7AyHGaDdC2fiLVz2VW+6SuRKZ3aGBHWXCdBU4CixGrA1OgBDOh/0wyOh9VhPVWZH
         Alx8GWnHSK7hg1IbTKx8yzgr5et49ZSuE6bwTPoZU9wBDc7ko43DeEneBxLzc4NHCR6U
         DfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpS3f8EZoX7R2KAuz/UX0/xqwonI23q4hXHZBWApjxE=;
        b=TFIa/d2LebIdJ+JDv8llwbTEyIb1vb0G/zzZsdVSkdAwuVhIDaR2VtnA9mQJtsw0JP
         YyZ9bX9+ZVD69hbpBGmE8eoKgmfBMtr+AesnylS/SL4/QvtKgt+kd/yyvASqtAvJ5/ip
         QqC4ujWUfv1DIEjFwepiPkNsBMYdijZedXSHmpU/ghoQQtHmequFnA/FjXksGjr3Jp3J
         w1q+d1SvccydCXxgNlCG4sF7Xg7XAl+pcmESZZCWLCKxMi7g/76PfuZTbMRHTrOesXqU
         X0TQxfoJVtwL9zgUMYraQT3fXr2eGsY6Z1kQIg1nbc/OAxIDzuMCPJBPtTYXb3Qjc6G/
         BWaQ==
X-Gm-Message-State: AOAM5315cpJKFYmBPK0oaR0Soumz9IU8wW4meKi/e3k1UbvjHTkyLNbj
        baoZNvoVIKWA9UbKtViABdXMmAYWm3aicHY/k4LlzQ==
X-Google-Smtp-Source: ABdhPJx0SoaiuulrB+NSo+UFoD6svkfCdOGBHeUCADEpXekaO/ti4K9CDSati5FTR+FCN4cJpmdhK9sgH1YngXvfez4=
X-Received: by 2002:ac2:44c1:0:b0:444:18fc:8389 with SMTP id
 d1-20020ac244c1000000b0044418fc8389mr15500530lfm.167.1646142819499; Tue, 01
 Mar 2022 05:53:39 -0800 (PST)
MIME-Version: 1.0
References: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Mar 2022 14:53:03 +0100
Message-ID: <CAPDyKFpgG-P8Gtb+ww3YeO8jyjuNhKtjk=bePz=3qcf-37fsvA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 at 22:23, Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Document RZ/V2L SDHI bindings. RZ/V2L SDHI is almost identical to one
> found on the R-Car Gen3. No driver changes are required as generic
> compatible string "renesas,rcar-gen3-sdhi" will be used as a fallback.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
> DTSi changes have been posted [0].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220227203744.18355-2-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 9ce6e06c19db..3b191fb89cf1 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -58,6 +58,7 @@ properties:
>                - renesas,sdhi-r8a77995  # R-Car D3
>                - renesas,sdhi-r8a779a0  # R-Car V3U
>                - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
> +              - renesas,sdhi-r9a07g054 # RZ/V2L
>            - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
>
>    reg:
> @@ -107,7 +108,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,sdhi-r9a07g044
> +            enum:
> +              - renesas,sdhi-r9a07g044
> +              - renesas,sdhi-r9a07g054
>      then:
>        properties:
>          clocks:
> --
> 2.17.1
>
