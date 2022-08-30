Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9CE5A5F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiH3JTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiH3JTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:19:30 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35328D86EA;
        Tue, 30 Aug 2022 02:19:24 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3413ad0640dso102420537b3.13;
        Tue, 30 Aug 2022 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4LzcYMLA4n0/7gNYzbK/mkckLDWj4Hrt+zYpQebTjH4=;
        b=SO3qgOdHgFHXeHQcJlqYfbrWrZD8Iw0sHlWqtM/SViI75ecfevio/ANBS8vklEio/D
         OJ4WIL2E8RSLgQuJ4LWQ17wIV1ldFB8FGiKUFXjM/NfD3WO4c9SvLhbbWY0sxymF8e3X
         hHRsta6pn4uc/Wkq/47lGiXBJSuCypE5X1jNm7+OJAzUlDxaVDva9eAuV85WMIG1+E5I
         Qvo+EUEAcHdst3jlpPFPaDCOMRK5dvTe/rGnIqdEh1CEwylKa8ZMlGZOYQ+5BznRVlJj
         MY08cMyF8KlyjXhDSozG9ne+PjUGBrjuffcPpe+Vg317U5QtU1zTDcPi2dmKO33MnHHF
         OvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4LzcYMLA4n0/7gNYzbK/mkckLDWj4Hrt+zYpQebTjH4=;
        b=frs61rvGdvr+4kZaI2SbdSf/4oNwGkdJMQrFvilQgCTueETFSvHRO/bCsOu207AV6j
         qCPoEkDFxq8TioHlqKcBkHtojDLO7wQxwIfEIcAnadU8+LNJoq+1JAvM7NeUVZIC5dOU
         e4MLbtPoqGM4qGD9DrMIheFiG9svuB73upxXiqSgLayiq3YRTGyZ1YbfBgJM9WO/KR52
         GPg3Rf2BwhPSzogzOHE/xif8zPQqkxJddKL1gVLhQ7oN2dZoxxM6ndDCTRw+1fxZv5KA
         qULr7TA4u3z2wSUOCthfy/+4CgW5iHmtNQEUOxmLSMXnJ5O2oY3/zkU7aBSj/lQSZQdG
         jf6w==
X-Gm-Message-State: ACgBeo0aH/SMnqOpimlhjzhhFy/TP23aHgeZkVZGuwdZmWYLoIkz4chB
        oHMmA+RuLcuUgQrlnrJ1AvAZ07P7+lFL36lb080=
X-Google-Smtp-Source: AA6agR6wngvVcYUXvDSRVYgU7fd+FzO0hqISd0AH9TIazM2vBMpxMInlA0UjIOaSuYNpdfIIxOv7C9lgwFqkpoWh4hI=
X-Received: by 2002:a25:2502:0:b0:695:9024:4cfd with SMTP id
 l2-20020a252502000000b0069590244cfdmr11949686ybl.299.1661851164044; Tue, 30
 Aug 2022 02:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220829215816.6206-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <Yw1G69ny9tZrFWk4@pendragon.ideasonboard.com>
In-Reply-To: <Yw1G69ny9tZrFWk4@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 30 Aug 2022 10:18:57 +0100
Message-ID: <CA+V-a8sPRTBTFnH4W=qcKU3=WYU79oX3WxBONpCG2f4m9V2ncA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: bridge: renesas,dw-hdmi: Fix
 'unevaluatedProperties' warnings
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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

Hi Laurent,

On Tue, Aug 30, 2022 at 12:08 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Mon, Aug 29, 2022 at 10:58:16PM +0100, Lad Prabhakar wrote:
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
> Given that all the DT sources in the kernel specify the resets property,
> how about making it mandatory ?
>
Agreed, will do that and send a v2.

Cheers,
Prabhakar
