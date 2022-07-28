Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2925836A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiG1CEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiG1CE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:04:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29ED50712;
        Wed, 27 Jul 2022 19:04:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q23so861445lfr.3;
        Wed, 27 Jul 2022 19:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSfuGobo36quNHWVipU/P1j+8s0MOGIFxkTWPlVuisg=;
        b=kVrA+CxmAhYaAyt2XbjfpNQhbXEJDxTm344h3jdITmfQZaozQia1vNlq+KfhEG+CIm
         wxOXiUA3JXNFPuo7JR0uZ5YRALUrbcHzv/QadH29YU/CsUVGZ9XnwlRhLlEuV0plA2Ub
         FuIg/vlgE8kr1x7nxK8F0DVb6o9dBkTyVSSSlGWB5FBhapYTH2zQKwUN99AhXS00GyK0
         s4tcQuN0qhnb2JKD6onV66e0vMMDZGx7TciEDAUjVoHJwrSNsiAqntM1sapEQ+jJJg1R
         I9FsiP5C/a4CvmC0LfQrnCN8733lP0Nc0Q2RwhUFmxCNg+It2wnqPwoLiBVycel7RMBB
         t4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSfuGobo36quNHWVipU/P1j+8s0MOGIFxkTWPlVuisg=;
        b=cC22YL2G9WGMbn/RexgwPR7K0HgFAdg3aRNV8x79SDkQTCtT+T3FZ1siUhPPhHkHXX
         mCpJpO3LjZaeAo96lYP7sHnyiRlwfj3gpiW//1TYZ+gFLL6CA01CIIUTptF+R4kxfjnE
         lL24o8WkuRNa3M4AH82fp43KZCt103BYGn1+ct3KvNYGOrTmof4xBIfyl9W0JyA5Xx1l
         RrcoYR0yqwy0z0mW5THauVSy+CA8rGE1wWRMoLV3vDQ0cpnUAIGnZEJJKDOhmRNnafsG
         ftGtAr9mULGKDQjXguJp0xZR13xoZA2fpuAxY+7l2+PTs9ELT3dwSP38z2isDHhfhDEZ
         WaQw==
X-Gm-Message-State: AJIora+Wdy0Jjq5n3uQR4V5vpJDeAgVWO8hTTMqdpo+Qm4EGtX0HqHwu
        wpCJhD7haCKMxEcdvV3WGp3gs3ZXUzxORIHRI7U=
X-Google-Smtp-Source: AGRyM1sXsKkEuQYa2xUqWXJTZ0dYadBV58iuh9/OXFdD7dfr5MGre6hSXIeMyedKRD6ZDi647biJttfPLhS5srGsn50=
X-Received: by 2002:ac2:5550:0:b0:48a:b15f:223f with SMTP id
 l16-20020ac25550000000b0048ab15f223fmr2435705lfk.181.1658973865994; Wed, 27
 Jul 2022 19:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220726101513.66988-1-mollysophia379@gmail.com>
 <20220726101513.66988-2-mollysophia379@gmail.com> <809e9c7d-7634-f690-675d-9eccac8c8de8@linaro.org>
In-Reply-To: <809e9c7d-7634-f690-675d-9eccac8c8de8@linaro.org>
From:   Molly Sophia <mollysophia379@gmail.com>
Date:   Thu, 28 Jul 2022 10:04:14 +0800
Message-ID: <CAK0UmJBkMBfGN8q-ap-zWAJWeD9-WsXErMWPtpvcDmNWiHSSvQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add Novatek NT35596S
 panel bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! I'll handle that and send the new patches later.

Best regards,
Molly

On Wed, Jul 27, 2022 at 6:24 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/07/2022 12:15, Molly Sophia wrote:
> > Add documentation for "novatek,nt35596s" panel.
> >
> > Changes in v3:
> > - Embed the documentation into existing one (novatek,nt36672a).
> >
> > Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
> > ---
> >  .../display/panel/novatek,nt36672a.yaml       | 20 ++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> > index 563766d283f6..560fb66d0e5a 100644
> > --- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> > @@ -20,14 +20,20 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - tianma,fhd-video
> > -      - const: novatek,nt36672a
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - tianma,fhd-video
> > +          - const: novatek,nt36672a
> > +
> > +      - items:
> > +          - enum:
> > +              - jdi,fhd-nt35596s
> > +          - const: novatek,nt35596s
>
> This entire entry should be rather before nt36672a judging by numbers:
>
> +    oneOf:
> +      - items:
> +          - enum:
> +              - jdi,fhd-nt35596s
> +          - const: novatek,nt35596s
> +
> +      - items:
> +          - enum:
> +              - tianma,fhd-video
> +          - const: novatek,nt36672a
>
>
> Best regards,
> Krzysztof
