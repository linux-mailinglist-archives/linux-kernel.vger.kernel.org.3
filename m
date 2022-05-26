Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952C35348B0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbiEZCPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiEZCPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:15:33 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9458BD1E;
        Wed, 25 May 2022 19:15:32 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id s4-20020a4ac804000000b0040e93a35508so84230ooq.8;
        Wed, 25 May 2022 19:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9l+OzJCj1AVOl/f+aLniiFw+ClCf54mFHrhKTNruLkE=;
        b=zO25SCbGpU/72MJUsqqSCDb6wOeXrTnlbwzq2kQAuwyXVo0CW/zhM7dqmRViO1BARC
         HsoYEnTQTBFQvlCKNPIB5YCWuA7754YnSVcvSkCjZa5HQ7z8h1yeZj77tAIV+f6mEuq/
         UkrSNfIYR7nq5gKAMWZJ9jadVeh3tkGMcOWxtyyzygMlkEcT6VXoW5xKYLvRdS2bkocE
         kY185wNcwTQLF/mP52abdQfGsLcn5vmKAiFlXczsTgTfXljzZVJis6LBAUN4PyKM8KA2
         f3otGTqiELz4/nxI7PRXBDHSVn1jHuw0bhV6GGnbFdOrv1TTDA+cY8bHZfq7kBfYzQrf
         P0WA==
X-Gm-Message-State: AOAM532bRfsVuD/IYfLJ4X1Q1ghddSoAggIxJ+LmldS/1+ynQ/i79V44
        FwPbkwCsBd1fYSMjdOADpeTKFsRs+g==
X-Google-Smtp-Source: ABdhPJzgwwMtU+ApLvyhLVBXlxsuzvmGjJA/JziESOt1xQpFwaz8mqfcmgCUXt83dLNbExnghNvYdA==
X-Received: by 2002:a4a:645:0:b0:35f:82e0:beab with SMTP id 66-20020a4a0645000000b0035f82e0beabmr14156801ooj.73.1653531331480;
        Wed, 25 May 2022 19:15:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t5-20020a05683019e500b0060b07fdeee0sm131349ott.60.2022.05.25.19.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:15:30 -0700 (PDT)
Received: (nullmailer pid 2925503 invoked by uid 1000);
        Thu, 26 May 2022 02:15:29 -0000
Date:   Wed, 25 May 2022 21:15:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] dt-bindings: arm: qcom: fix MSM8994 boards
 compatibles
Message-ID: <20220526021529.GA2925469-robh@kernel.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
 <20220520123252.365762-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 14:32:47 +0200, Krzysztof Kozlowski wrote:
> The compatibles for APQ8094/MSM8994 boards are different than specified
> in bindings.  None of them use fallback to other SoC variant.
> 
> Fixes: 9ad3c08f6f1b ("dt-bindings: arm: qcom: Document sony boards for apq8094")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
