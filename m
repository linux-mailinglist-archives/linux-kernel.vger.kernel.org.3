Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D86A461A58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbhK2Ozv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238306AbhK2Oxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:53:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C89CC07E5C3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:16:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso16803749wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0E4fZVuvqOikcFLzjvJAIfmKIxDojH9AFXp6ET25+Bc=;
        b=fLfQ6tlxHG44dJsiockWybpP+XOqZy4RmScKii6/kKomjagt5ki5TuSx9Am7uS48JQ
         OJUAZ1CsFq7UPdF+W2o7z+GDKGV4R/6NTZFUKXG0GR5wMWUSMcWXcnJ4PecN3okNceA6
         6VSuqMGlf2/fCt5aIpp9A9Gp74RCjyYSxA0d7mzgd3cs2Arpt7DdnsQSbsJRfAS+EEyj
         uNALoZSjkgZpdZCmnbPUBZHpqKr53ishqCjttwI3KKRgnOZsYCbAfzyemQhxMna0q5el
         rvsuaGDFxp+4VomQazknympD2sKrx8/jyvBENgQhq/SIRQKCdp8sVuTi5d2NfNtc0P6B
         /FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0E4fZVuvqOikcFLzjvJAIfmKIxDojH9AFXp6ET25+Bc=;
        b=svx9G2scdpHi7Nxjpra5Fc9UZQ3mkX83mIf2A2uuFvA/iA138afuPDcvGrJG/Ttf72
         AKTh/MyvAS1XebIPPDouI7czT9o/Sk9k5w1z2RjdlRcPd18MxVey97U+uA8E+/Xf3/EU
         m2+O9JwEbe2W198IMvF/BiN/3VhrF9jt4PqvfIZgcJ0iqlNereb9j+qRW1L2OcwDCkv1
         kXGesNyajMn1o4cUQSXZa4G9ZiW+wJqZjAfS5KoowqzvLp+sXA1h2Ee3LDhT6O01MpQg
         NF2oPm8ntZ3S6t4nAmw6aJ/lUebhZGd1tqO2ghx7R0aHIUK9AHTup5IRF927NLG1SSJt
         Pzfg==
X-Gm-Message-State: AOAM530IzaTTm0S8LlwFOOADSnozhk4KJq4B9y+24Vh8bn3lBnyQE6vj
        +TtAcHm7wpoQkisPW5xo82OHjg==
X-Google-Smtp-Source: ABdhPJxQ98qCvaxlgCJ7tUcHkmFHkrHSq1X+nkV0tpFFhi10eCMnWBetnDGZrdKIJs6XWoYzDXcyKQ==
X-Received: by 2002:a05:600c:358a:: with SMTP id p10mr35615274wmq.180.1638191767208;
        Mon, 29 Nov 2021 05:16:07 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id w4sm14447200wrs.88.2021.11.29.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:16:06 -0800 (PST)
Date:   Mon, 29 Nov 2021 13:16:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: maxim,max77686: convert to
 dtschema
Message-ID: <YaTSlTCBL0dAFT3H@google.com>
References: <20211125074826.7947-1-krzysztof.kozlowski@canonical.com>
 <20211125074826.7947-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211125074826.7947-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021, Krzysztof Kozlowski wrote:

> Convert the MFD part of Maxim MAX77686 PMIC to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Rebased.
> 
> Changes since v1:
> 1. Add Rob's tag.
> 2. Correct title prefix.
> 3. Extend example with LDO22.
> ---
>  .../devicetree/bindings/mfd/max77686.txt      |  26 ----
>  .../bindings/mfd/maxim,max77686.yaml          | 132 ++++++++++++++++++
>  MAINTAINERS                                   |   1 -
>  3 files changed, 132 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77686.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77686.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
