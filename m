Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12555A5CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiH3HVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiH3HVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:21:09 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D856E2D5;
        Tue, 30 Aug 2022 00:21:08 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id q8so8079611qvr.9;
        Tue, 30 Aug 2022 00:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QOMOADjxX3AxTQL00SsYd+7QYCr6eFHbzE6U4FiL748=;
        b=JX17LTtjcGH9EgCC/Sn8YM4CeGOUrSCV5kVO7zWqccyJAY6lqXFRbL1gev2nE7Uu30
         jBurRZVMktqo2MA7n9Noqurl4MsGLM5Y75yPpgB3hJ7Na26MDtKl+0yT1kJp2MNBvfyG
         tLYOkLmvKezm5RHXJAcpepWXH2cESaDTxqpOjxn1DOP/Kj7ZDbBRmepO3ltQREQlam3E
         Vz7NeZDMZDKBvVkJa/0aKdiZ7HvwClOCMbd6XM/XAMqZGD6dNH5/cFX+1aWw5Ec8fLvx
         laronjlFTJ1hoar2y6Ju98TnRL/ap/lvS8II48UGjkw5epPH/N6Gwi7NIKps2D00MaFl
         h65Q==
X-Gm-Message-State: ACgBeo2IAMk2i2zMJTWsmnh/AgfMOOMarzwVETgUDpl4luUkCuvFq65R
        huKg5CdmiTQjhRGHdrVrDIUXs93L76jrjQ==
X-Google-Smtp-Source: AA6agR6OqWL/6cQbJlnEWRAcb6Aic2oWVvHdEpw3gHSLtxqHZYYxa3w6efU6y3Cb3P+9rasnXbsvxQ==
X-Received: by 2002:a05:6214:4015:b0:496:be28:62f5 with SMTP id kd21-20020a056214401500b00496be2862f5mr13740056qvb.14.1661844067098;
        Tue, 30 Aug 2022 00:21:07 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id u12-20020a05622a17cc00b003422c7ccbc5sm6488715qtk.59.2022.08.30.00.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:21:06 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-33da3a391d8so252091137b3.2;
        Tue, 30 Aug 2022 00:21:06 -0700 (PDT)
X-Received: by 2002:a0d:d691:0:b0:340:f6e7:5654 with SMTP id
 y139-20020a0dd691000000b00340f6e75654mr7738635ywd.502.1661844066437; Tue, 30
 Aug 2022 00:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220829220334.6379-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220829220334.6379-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Aug 2022 09:20:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVpYcV1p2rb-D=pcRut2y3o_SB1rkM+COuxbD5aCy-77w@mail.gmail.com>
Message-ID: <CAMuHMdVpYcV1p2rb-D=pcRut2y3o_SB1rkM+COuxbD5aCy-77w@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: spi: renesas,sh-msiof: Fix
 'unevaluatedProperties' warnings
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:03 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> With 'unevaluatedProperties' support implemented, there's a number of
> warnings when running dtbs_check:
>
> arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb: spi@e6e90000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
>         From schema: Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
>
> The main problem is that SoC DTSI's include power-domains and resets
> property, whereas the renesas,sh-msiof.yaml has 'unevaluatedProperties:
> false'. So just add optional power-domains and resets properties.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Set maxItems to 1

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
