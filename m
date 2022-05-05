Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A0551C23F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380530AbiEEOW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiEEOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:22:55 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A34A5A2F6;
        Thu,  5 May 2022 07:19:16 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id w194so3247916oie.9;
        Thu, 05 May 2022 07:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7YpYUilK7VdhZah+ZTNWbp1uIYfeJVKBdco83rssHIo=;
        b=hgscqlqz8SNyWXxbl3wsYeQmshKMkrV5vbIKG5RBqjeTpMaaOmQNkixXveIOBjTOJj
         m4dgBuuE+4DfSUNNPJpqT6IwFpZR0IGtAEJ38ZzsIwlh5mxKNow2lCv5TYOFDNLMgSae
         UbRNlNUBSFVIbFC4pjXbsjB0M+mlTwSIEp+vVmeOpqIFUzJbN4d1VQfuKXRB9NPWeVsd
         A3EksZq05Pu3yEQ8h/xBqLJf3egrSQnFsmHnhzNxpLF+Rsiw2bH2jGvxWfuGxedH2F8n
         3GH3gsxJvOMXsozWQdepCjch3R6po6H2uAV6JnK8EWURNUIVxbmQutuB0ytdx4vS7eNG
         lIiQ==
X-Gm-Message-State: AOAM530uNCZSYlChx1isAV9MGPsja07WQ9Z0JRxN/ebsAxYtcnGxPrKC
        l5V5bk6FQwPJw5YNI86SIA==
X-Google-Smtp-Source: ABdhPJz9g6PNoKy1GNiXgsPTNjyrkNfljTmstUY2TRuHCbsbvyAS8494S0N5o5R4ICttDtR8kNQqjQ==
X-Received: by 2002:a05:6808:19a5:b0:326:26b7:984a with SMTP id bj37-20020a05680819a500b0032626b7984amr2582239oib.12.1651760355291;
        Thu, 05 May 2022 07:19:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t25-20020a056870601900b000e686d1386fsm540802oaa.9.2022.05.05.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:19:14 -0700 (PDT)
Received: (nullmailer pid 3819550 invoked by uid 1000);
        Thu, 05 May 2022 14:19:13 -0000
Date:   Thu, 5 May 2022 09:19:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: interconnect: qcom,sdm845-cpu-bwmon:
 add BWMON device
Message-ID: <YnPc4eLI2nW5J2e3@robh.at.kernel.org>
References: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
 <20220504081735.26906-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504081735.26906-2-krzysztof.kozlowski@linaro.org>
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

On Wed, 04 May 2022 10:17:31 +0200, Krzysztof Kozlowski wrote:
> Add bindings for the Qualcomm Bandwidth Monitor device providing
> performance data on interconnects.  The bindings describe only BWMON
> version 4, e.g. the instance on SDM845 between CPU and Last Level Cache
> Controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../interconnect/qcom,sdm845-cpu-bwmon.yaml   | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
