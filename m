Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E8358F497
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiHJW5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiHJW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:57:06 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4697465810;
        Wed, 10 Aug 2022 15:57:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d20so15004471pfq.5;
        Wed, 10 Aug 2022 15:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xPdhc/0hHYmENeMDs6+MtCNPsr3iYA3ZSSH+vaWj1IM=;
        b=RPFiz8B1rVOie58ZBdBHmpFfHRmrhoZyqdFFaGlw8qr2+il/opCX909xv8cb52fzQT
         xuPMGTgnrNwoRvU0Ax9uGwQFFf7w4biqio0J15psnjzAAPW2Jr48Tl2BxG0By6ZoGuRg
         hy1xCp4fpZrXlO2D2ZpvuyDqI8FpWF4fLpNTNs3y2v9D/zYPDwH0vzx8O7L+GjeAegot
         k2LjqKAixz70q0OitDAiwtvHt9hlvnv6Yp+XsW8RL8ipwr/NKaX/BwpqEkqi49OUXUQG
         +up0YYuOImPN5EzsYEqyhL7XsjhIShLLcXc8iqgfaryLkYQ+aopIQ1uR2yVeSPWmHFzX
         Sd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xPdhc/0hHYmENeMDs6+MtCNPsr3iYA3ZSSH+vaWj1IM=;
        b=uI0EpgiXfDWXbZ501As4LXX92evtiVs2jqY2QvIge9TsC9epu/x6YEWgh5R1Q0Omfk
         sdXVRrdiELQK9UDODkG6ErE7u61MAJaQaQqcLulD1rkWOA2vY7rP0nUtyO57i3/IA/ZW
         EG9psH3UmLClKQHXbLU+9mYnJBpZT1tY4PanIYZDphg2BgL162m05YMjVL0F7GRZgH2M
         RLJDSjFkegHT+O+pS0yxKDV/4g56gG3XNPljP8BWQQDnMdXK6mO7hM3zyZS50YB+smRA
         7oSSScu0RLsAqIs6jNWs+JyaX5TSy2Ue1Af425zqZmW0BP+NtpwWQ0kFO3wD214mzGPF
         bGzQ==
X-Gm-Message-State: ACgBeo38sMu+XJWuyDxDwkpNyqk6ztYU43Ota8dAAH/Yp0XemV2ftCoX
        3JDPEDcaxKasEkFZFakrGPA=
X-Google-Smtp-Source: AA6agR6HLsceBFq6yTroejhdeRCo4HgSVRKlPFXjxrfQchp2WJKLeR06sqDosQDUvkh8bG0wfYFIrg==
X-Received: by 2002:a63:7a1a:0:b0:41d:2c8c:43bc with SMTP id v26-20020a637a1a000000b0041d2c8c43bcmr18937347pgc.97.1660172225717;
        Wed, 10 Aug 2022 15:57:05 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a3c8:d6b9:a5c2:1eca])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027e4400b0015e9f45c1f4sm13399301pln.186.2022.08.10.15.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 15:57:04 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:57:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: ariel-pwrbutton: use
 spi-peripheral-props.yaml
Message-ID: <YvQ3viBmbzuai+LC@google.com>
References: <20220727164230.385614-1-krzysztof.kozlowski@linaro.org>
 <20220728151942.GA903363-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728151942.GA903363-robh@kernel.org>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 09:19:42AM -0600, Rob Herring wrote:
> On Wed, 27 Jul 2022 18:42:30 +0200, Krzysztof Kozlowski wrote:
> > Instead of listing directly properties typical for SPI peripherals,
> > reference the spi-peripheral-props.yaml schema.  This allows using all
> > properties typical for SPI-connected devices, even these which device
> > bindings author did not tried yet.
> > 
> > Remove the spi-* properties which now come via spi-peripheral-props.yaml
> > schema, except for the cases when device schema adds some constraints
> > like maximum frequency.
> > 
> > While changing additionalProperties->unevaluatedProperties, put it in
> > typical place, just before example DTS.a
> > 
> > The binding references also input.yaml and lists explicitly allowed
> > properties, thus here reference only spi-peripheral-props.yaml for
> > purpose of documenting the SPI slave device and bringing
> > spi-max-frequency type validation.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > Technically, this depends on [1] merged to SPI tree, if we want to
> > preserve existing behavior of not allowing SPI CPHA and CPOL in each of
> > schemas in this patch.

Could we merge this through SPI tree as well?

> > 
> > If this patch comes independently via different tree, the SPI CPHA and
> > CPOL will be allowed for brief period of time, before [1] is merged.
> > This will not have negative impact, just DT schema checks will be
> > loosened for that period.
> > 
> > [1] https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski@linaro.org/
> > ---
> >  Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
