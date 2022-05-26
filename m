Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02C05348A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiEZCOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiEZCOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:14:34 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B49F8BD0A;
        Wed, 25 May 2022 19:14:34 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id e189so675356oia.8;
        Wed, 25 May 2022 19:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lXxPYdn4qOgK4BprlzzAunNk3cKD97maHWkf6/9DJSg=;
        b=wTc09Agd3+VsYz2cC0Yz08ul//D+UZ2MKKuoeEKNCOKc5fqTUrJtsvQ+LnKwQsbAhC
         QQzGdxmMeO8b1hGgIeb3771T7MIg4fRqvH7QU8uxFY6HZVpJkwjQLSBWGOpNxoZgxYS3
         neCvHyBM+872F7RhlqwFGWAmy3N99JjJv8V74ClS0YuN9utWN4r7zQvq+dpcz5OQXQkB
         CT1992riDwbeX6172R/L9sHz+rQbpL+xi4PT4Urbs3FgNSrreiiERegK0eykIaAvCeKo
         w0we5WiI02likoJjDwH/xWYWIEbGzfyGjuPBTzgW85opPo1OHPU7HMnU/68cecMA5VJz
         F2tA==
X-Gm-Message-State: AOAM532ZsKdrhyAqqOVmlFoxEnDVVdpHR/xjYmq/EilRvJL3y0OE6RRy
        baxWJrhSobGgAfdLOTc68g==
X-Google-Smtp-Source: ABdhPJyF7P/cb/xoLtuv2ZlxCyA5nwcRib9hzf1YGh40Ijsszv+OU2oInZFkXbEziqd5Nh5QiQQoBQ==
X-Received: by 2002:a05:6808:1827:b0:32b:3398:1382 with SMTP id bh39-20020a056808182700b0032b33981382mr54487oib.106.1653531273385;
        Wed, 25 May 2022 19:14:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m14-20020a056820050e00b0040eb1d3f43dsm184818ooj.2.2022.05.25.19.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:14:32 -0700 (PDT)
Received: (nullmailer pid 2923845 invoked by uid 1000);
        Thu, 26 May 2022 02:14:31 -0000
Date:   Wed, 25 May 2022 21:14:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: arm: qcom: fix Alcatel OneTouch Idol 3
 compatibles
Message-ID: <20220526021431.GA2923811-robh@kernel.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 14:32:44 +0200, Krzysztof Kozlowski wrote:
> The MSM8916 Alcatel OneTouch Idol 3 does not use MTP fallbacks in
> compatibles:
> 
>   msm8916-alcatel-idol347.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['alcatel,idol347', 'qcom,msm8916'] is too short
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: e9dd2f7204ed ("dt-bindings: arm: qcom: Document alcatel,idol347 board")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
