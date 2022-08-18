Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21963598B08
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbiHRSVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiHRSVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:21:31 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA715CE451;
        Thu, 18 Aug 2022 11:21:30 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-334dc616f86so63515177b3.8;
        Thu, 18 Aug 2022 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cz4aqrtGrX+pP5uaPE+3Nxxzh1rZqJ7+xHhzxGrUvU8=;
        b=N07iSmth21aYe0Ug2MVhr/I18VG3BG3N9GJm8JMxKXfKTwT7UY2lN6G8a+5yndiAr/
         e7g1JXUjnhuelsFLFgQlyid3CIddpKLQyFeVPBrOHf4hn0bUZ18t3OyyPfYKXhgqWQYB
         +azSBDHrs7PrupZeX4iD4WoftRPWLByOEjowiD1nm8/SPa3KtZSIaNBCrYvBZS76CmbQ
         rr4fcQU3Z3YytVkZW+J3x4SEBj4leZy6IsVa/QUCk19a/Q8O6XQGlS0k6ph9Nr1uvSGq
         LQCtKqhKZqKWCUG1D17OM3xTV9f4LakV3yDumJ++hNlRN993HxyLehQBHCiOoDEygRIw
         zTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cz4aqrtGrX+pP5uaPE+3Nxxzh1rZqJ7+xHhzxGrUvU8=;
        b=IUory5Ee92y+YpavXEEl/WxlyFNCKAmI6amZvjGqVvzTHzZDIMdkOD21PfT64FiMAP
         bKw3R15Nxwg4iH2pAsiJ8JJSv7k8r1LCRt2R1D7iRb8AvM71r2v5h1C5Iy9mGo9D8svJ
         ayFAXd7Re2FDI52zRBybtSkl792FzVu6ok5r8bziNm6TNk8M3TES1XLM22RveZmQA8hM
         5MGuSRh7vLFam60J958XtGpRf5Pe+PEi902JPbemCT379/RYepRuX3NIMiXbhqJ6osZV
         kTy3yIY+CD03pyWbbU1F24vWdSiOfvNrbupoJXTDbg59HkfAFRfHLtz6A+Tcu4MGLUEy
         +0tw==
X-Gm-Message-State: ACgBeo33j+cjCPRsos1H2ParQz8qkQTE0WE75hUODd4by9iumDnA1aC2
        VLwH3m5TF0oM4inAXLtVjBpiNgOWlonTMZqzB+M=
X-Google-Smtp-Source: AA6agR6gnz3Z3AdTSbd4ifE9AdXb9U3hfPUpCwSodkO/c1SWj8iYRpoFJPnWaj8WJoSk4MFWP1iE2QLpLSwHe52ce6M=
X-Received: by 2002:a25:dc12:0:b0:68f:b662:e85d with SMTP id
 y18-20020a25dc12000000b0068fb662e85dmr4172606ybe.279.1660846890039; Thu, 18
 Aug 2022 11:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220816083842.25925-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <cae2f59a-aeeb-e573-029f-7151ae29dd28@linaro.org>
In-Reply-To: <cae2f59a-aeeb-e573-029f-7151ae29dd28@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 18 Aug 2022 19:21:03 +0100
Message-ID: <CA+V-a8tWTNHbqyxkjrc=mQL0zkXkg7VO4Fd06HDLV5ZGZeA-jw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: renesas,sh-msiof: Fix
 'unevaluatedProperties' warnings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

On Tue, Aug 16, 2022 at 10:45 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/08/2022 11:38, Lad Prabhakar wrote:
> > With 'unevaluatedProperties' support implemented, there's a number of
> > warnings when running dtbs_check:
> >
> > arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb: spi@e6e90000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
> >       From schema: Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> >
> > The main problem is that SoC DTSI's include power-domains and resets
> > property, whereas the renesas,sh-msiof.yaml has 'unevaluatedProperties:
> > false'. So just add optional power-domains and resets properties.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> > index 5de710adfa63..7bd86cf876f1 100644
> > --- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> > +++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> > @@ -69,6 +69,10 @@ properties:
> >    clocks:
> >      maxItems: 1
> >
> > +  power-domains: true
> > +
> > +  resets: true
>
> No. For both you need maxItems (or describe the items).
>
Agreed, I will fix it and send a v2.

Cheers,
Prabhakar
