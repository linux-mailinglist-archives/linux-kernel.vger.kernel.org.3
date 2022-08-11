Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B47590668
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiHKSU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiHKSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:20:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D4192;
        Thu, 11 Aug 2022 11:20:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x10so17614964plb.3;
        Thu, 11 Aug 2022 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FpI8YDT9XUTrgzXW1iia7ZfG1laXPlpeHaemReIIN70=;
        b=gUE17ymq2xcxrLr+YljATLtxpJ/YF8hKGNVLz1hqpsZ8jcUOdUcgZ9CF6b6FXjZAcF
         6i28ERwl20oLbre3LFFKvtSdWHHhQfyZCF0m7fz2xNzo/+lNGElUihzT9r8+FNsvx1ka
         yIy4jnJByTOVpNLZHhX59ikscYId8GK8yYb50L6FHg0w+zaQ95DULvVqcXc5ofbYl/aT
         9IsSIbTMc0R0V4wqUNTd7jItDpMzXlAuI1Sd+vUTfBPQ1+ulHrZjUPEV/HW9Ip3oBoV/
         s+g6t/qtI1moijAU4IdUSuDt9fFJI6WF5n/ycNTJOhpgDLyWtP/ift4Vtk5zOPtOdkHb
         8DeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FpI8YDT9XUTrgzXW1iia7ZfG1laXPlpeHaemReIIN70=;
        b=KDPr9hlzUpLFbwgMNGGAgA01YPZV6yaPJ6D8wFs2JCbYlTlDj80Uwg0Zwxa//XB4Ra
         r51sFD3NJA1cvWnzTXCT5lDR/tUREoJAwfH/FZTnvkjmIz8cTe75ilGq8UJ4C5XEF3TI
         JHGpAcAK38ihSOHVtz21/Ti+e5nS6dxytredoDCrmHnMCSUzR+aTI6UWZpBVNDxF20qh
         p/E2DN5r9gOwNvxJ1T+Xpw2embzWDhurci1LCjmxfo4W9lyAZw56ZdEX5OpzSxJskMcq
         W12//EJYgqz7SHF/0qJfSuaAouEeJct7tEswVrQPsh3Fez3RgkcjmXFMFpvYKLU0KIoF
         +qDg==
X-Gm-Message-State: ACgBeo3+ImjKBcE/bTa0C4HEEFG4PWzksKDypfmtuV4g1VrIfQ3ERaSH
        I8XRV6c8l4YZsu7pbLLrazQ=
X-Google-Smtp-Source: AA6agR7C5UlsbDWUXMwNgJzzqzyyhLATto0xUMmJRK37NarXgenY7qeVSTsTHxN57Mty94+hf+xgTA==
X-Received: by 2002:a17:902:b704:b0:16e:f05d:411e with SMTP id d4-20020a170902b70400b0016ef05d411emr389092pls.38.1660242017198;
        Thu, 11 Aug 2022 11:20:17 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c348:229d:7b9:f9dd])
        by smtp.gmail.com with ESMTPSA id c7-20020a170903234700b0016a7b9558f7sm15311784plh.136.2022.08.11.11.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:20:16 -0700 (PDT)
Date:   Thu, 11 Aug 2022 11:20:13 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: ariel-pwrbutton: use
 spi-peripheral-props.yaml
Message-ID: <YvVIXdXEwIq7aKZh@google.com>
References: <20220727164230.385614-1-krzysztof.kozlowski@linaro.org>
 <20220728151942.GA903363-robh@kernel.org>
 <YvQ3viBmbzuai+LC@google.com>
 <219a875c-f46c-fde9-4370-4168d440e614@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219a875c-f46c-fde9-4370-4168d440e614@linaro.org>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 09:21:35AM +0300, Krzysztof Kozlowski wrote:
> On 11/08/2022 01:57, Dmitry Torokhov wrote:
> > On Thu, Jul 28, 2022 at 09:19:42AM -0600, Rob Herring wrote:
> >> On Wed, 27 Jul 2022 18:42:30 +0200, Krzysztof Kozlowski wrote:
> >>> Instead of listing directly properties typical for SPI peripherals,
> >>> reference the spi-peripheral-props.yaml schema.  This allows using all
> >>> properties typical for SPI-connected devices, even these which device
> >>> bindings author did not tried yet.
> >>>
> >>> Remove the spi-* properties which now come via spi-peripheral-props.yaml
> >>> schema, except for the cases when device schema adds some constraints
> >>> like maximum frequency.
> >>>
> >>> While changing additionalProperties->unevaluatedProperties, put it in
> >>> typical place, just before example DTS.a
> >>>
> >>> The binding references also input.yaml and lists explicitly allowed
> >>> properties, thus here reference only spi-peripheral-props.yaml for
> >>> purpose of documenting the SPI slave device and bringing
> >>> spi-max-frequency type validation.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>
> >>> ---
> >>>
> >>> Technically, this depends on [1] merged to SPI tree, if we want to
> >>> preserve existing behavior of not allowing SPI CPHA and CPOL in each of
> >>> schemas in this patch.
> > 
> > Could we merge this through SPI tree as well?
> > 
> >>>
> >>> If this patch comes independently via different tree, the SPI CPHA and
> >>> CPOL will be allowed for brief period of time, before [1] is merged.
> >>> This will not have negative impact, just DT schema checks will be
> >>> loosened for that period.
> >>>
> >>> [1] https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski@linaro.org/
> >>> ---
> >>>  Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>
> >> Acked-by: Rob Herring <robh@kernel.org>
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> 
> There is no dependency anymore (and actually that time it was not really
> dependency), so you can take it freely for next cycle.

Hm, it turns out I already applied it and even included in pull request
for Linus. But for some reason my "applied" email was not bcc-ed to me
and so I got terribly confused.

-- 
Dmitry
