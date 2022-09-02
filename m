Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647925AAA7D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiIBIrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiIBIqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:46:34 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDAD1E0;
        Fri,  2 Sep 2022 01:46:19 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id x5so946831qtv.9;
        Fri, 02 Sep 2022 01:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+efSmKPMaUF86xAxusmh16dSBB12tESjJF0BtlEmxmw=;
        b=jPzqRRuor7SJ7HMvNwdj3I+k1mi2CwIxHu+GyMnLqU2SUopDKdMdeR3eZukJfkvlP/
         ibwxGeX2ZuaQAGhxiFaMVW5sGllSbsmy+0fRz9DcdcCevizh/QNoqmZfvtzDfP6srvV+
         6E2qNnWIzwPKs5TCfSzMmA1uh25AqsJu20IYO1+t05DcGuPFmATud0fWUOGbgVxccxzA
         0ygeWfYjwzy1VjadbpB9nDTjC+a2SHXGP1GtelFzVFuwL1iQfGl06VZX5XDZf0vGgktA
         8b6dU5htMtqgK7LIIeElE+3V5+5Ez7ksj1lRzMdJJ+EurFz/lPaTUozsXVBh3ZD270yw
         AKow==
X-Gm-Message-State: ACgBeo2k7FAWXwHusG3zJlOSNHtjtOTj8ruzRb6e2i+TDUPAnmhVUdFF
        1L4ge6HQDiC6ALzusvIqpDOqG46JYM3x7g==
X-Google-Smtp-Source: AA6agR7Qvn/DQB3kq2qlQU2CbMq3/chM20GUAOdh/1wLHBdLYyHsm0xTcDcbLWGdA8HRsVasKS3Z3Q==
X-Received: by 2002:a05:622a:1ba9:b0:343:786c:3bb1 with SMTP id bp41-20020a05622a1ba900b00343786c3bb1mr26766823qtb.125.1662108378489;
        Fri, 02 Sep 2022 01:46:18 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a0c4400b006bc1512986esm994628qki.97.2022.09.02.01.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 01:46:18 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-33dc345ad78so10211467b3.3;
        Fri, 02 Sep 2022 01:46:17 -0700 (PDT)
X-Received: by 2002:a81:83c8:0:b0:341:4b7b:3d9e with SMTP id
 t191-20020a8183c8000000b003414b7b3d9emr18102137ywf.47.1662108377701; Fri, 02
 Sep 2022 01:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220829215128.5983-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <963693d9-6016-f279-a543-22e9be802d87@linaro.org>
In-Reply-To: <963693d9-6016-f279-a543-22e9be802d87@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 2 Sep 2022 10:46:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX2a3uR-Hq9S3DkfrTir_9nPmw56QovxLN1fMgJ+1yxEg@mail.gmail.com>
Message-ID: <CAMuHMdX2a3uR-Hq9S3DkfrTir_9nPmw56QovxLN1fMgJ+1yxEg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: Drop clock-names property from RPC node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

Hi Krzysztof,

On Tue, Aug 30, 2022 at 11:19 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 30/08/2022 00:51, Lad Prabhakar wrote:
> > With 'unevaluatedProperties' support implemented, there's a number of
> > warnings when running dtbs_check:
> >
> > arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb: spi@ee200000: Unevaluated properties are not allowed ('clock-names' was unexpected)
> >       From schema: Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> >
> > The main problem is that SoC DTSI's are including clock-names, whereas the
> > renesas,rpc-if.yaml has 'unevaluatedProperties: false'. So just drop
> > clock-names property from the SoC DTSI's.
>
> This is not the main problem. The main problem is that bindings do not
> allow clock-names. Commit msg should reflect that.

Thank you, I'm amending the commit message.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
