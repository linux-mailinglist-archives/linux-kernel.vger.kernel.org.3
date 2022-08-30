Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07C45A6042
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiH3KGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiH3KGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:06:00 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6BF1B59;
        Tue, 30 Aug 2022 03:03:14 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-33dba2693d0so259618567b3.12;
        Tue, 30 Aug 2022 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=I3uyFklCX86QnaO4FGwtK3r174JBbykuqGUsbUF86CM=;
        b=SvE6u95A8KIYBCs4xKxTiCYBbxBSN2iF5GZ9kH5C/9wkg0aMPTTH37wmp6hMOIWLtS
         kC/9M7nTr3ZMa29TCkbg8BVblGpxJtPFxhnW8FJqUavlqEUtwodde3Xio4iCYWBbiz+z
         hHvwesFhf9khHthd7cskM2WeM28No/t0xUfgmB4T+KGuP5CQTrgnZvlIHI7T9gdPywIU
         tdb0UkPXOLOJwSGT6n2VUf/sjEKB0/gcO6ewRhMieGfTGS2g1d0Tl8nqGkj44st+zkfF
         f3/s9my62nvIu2qVuPTxTwzHqj5p7ZazPXEyDGE/e08LSjCIVVwpX0hJFmgu9qKGUShC
         NX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=I3uyFklCX86QnaO4FGwtK3r174JBbykuqGUsbUF86CM=;
        b=5RSdjygaB7xHVzgbopVulnnX5DmxLEc7cdUjHwN2zTnkZfRW7EKiVXjZZLR0eh9SCi
         BmRclojWmrkTnRpbFrcHNKgWCAAR/hvE38XwgbxMpYsewja/OiRa9r6kNv8Z8YUxgfMS
         3JYtzkjWC7GlV8jGXrUG4I1EK4Cg0npUmqZymUaRiOybamuop677VyPhEsvZRmJQaE+G
         10nBych+G+11wpy6UjhIwxR7gg/PoTTIOIDS9dq/gEBGnVVQwpiWI+vTwwxjwD3qKapD
         gqxPaAvR+vJP99ssnEzMdTgnDJ0yar3C3O24FC8yD3HX489su45y9p9WlUS6g5BYekSW
         ssbA==
X-Gm-Message-State: ACgBeo1Xttp4BuIx7QEZm2MBYAg2uizqCeZe2TxvxKDy5P4MTIHnglS1
        c9apbUwTI3uM+bKmkQuDrp4+CiVDalY786gLJSI=
X-Google-Smtp-Source: AA6agR7cJuSH4etKCu9hKCZHGR2bD5vDU9CYpMir88OlfN8Q5rHi5hJI+n41bex3eVce9XadXKx3EOprlFLuWLXffl4=
X-Received: by 2002:a05:6902:1146:b0:699:ba1f:8934 with SMTP id
 p6-20020a056902114600b00699ba1f8934mr10959552ybu.354.1661853792903; Tue, 30
 Aug 2022 03:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220829215816.6206-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <e455ebd7-7949-47d6-5f9b-9869dfdd601d@linaro.org>
In-Reply-To: <e455ebd7-7949-47d6-5f9b-9869dfdd601d@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 30 Aug 2022 11:02:46 +0100
Message-ID: <CA+V-a8so2GYf5PZAPmCzyZayYXVqnVZ7LBLbb-WUqSeWvVX_vA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: bridge: renesas,dw-hdmi: Fix
 'unevaluatedProperties' warnings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

Hi Krzysztof,

Thank you for the review.

On Tue, Aug 30, 2022 at 10:23 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/08/2022 00:58, Lad Prabhakar wrote:
> > With 'unevaluatedProperties' support implemented, there's a number of
> > warnings when running dtbs_check:
> >
> > arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb: hdmi@fead0000: Unevaluated properties are not allowed ('resets' was unexpected)
> >       From schema: Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml
> >
> > The main problem is that SoC DTSI's are including resets property, whereas
> > the renesas,dw-hdmi.yaml has 'unevaluatedProperties: false'. So just add
> > optional resets property to the binding.
>
> This is not main problem. I already commented on two of your similar
> patches, so same applies here. Please describe real problem.
>
Sure will do that and send a v2 (and also for the reset of the patches).

Cheers,
Prabhakar
