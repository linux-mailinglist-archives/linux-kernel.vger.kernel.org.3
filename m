Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A992B4ACB85
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbiBGVpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiBGVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:45:08 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102E4C061355;
        Mon,  7 Feb 2022 13:45:08 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so11870286otq.5;
        Mon, 07 Feb 2022 13:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EucQ1HDPzTdjlFQmTZFP5fOCWRcSfTcvpkCUM8lpbHM=;
        b=KRnuWdDo+sx61UYckKuaLEaVf4Lh8+ZNAcI9Rd3C+ln5dTA4co0asDE4oOUdoy8yFR
         UuX/BhY2ZcY0o4Nruw9OqcxSUa3hLL627WB9CxIEkFY592AvgmMSv9dvfQ6906Zq2DVi
         WOdndZEqUxBkD4nj+y+bj/x3eJOCm7+MIT3UK/0J6WSOdub352cYX32WLN/GrrGUJYOf
         Yuof4pR96lGTey5R9PYUAIf7G9qYRvxuqRXa3KMZrEHXnzVlB6HdzVoiLlkGXWu8WnK0
         Dnf4UBc8p8VbUMRbPza6NAfXe6YXy4Dx1Qe5+/NoXG5PyaItc+PulbEWpbeKYSRSpnYd
         4dpQ==
X-Gm-Message-State: AOAM53298e8KVTKS9iCB+2bNyFYSaoNtqcrmW40mnCMubspeI2jqsBes
        mvDn8cxpb2OxKyjyWVYVFQ==
X-Google-Smtp-Source: ABdhPJzvL7RVEbrfjUFInk8fOjM3ePzlL4+uLEqKjZgJD/j8eVPpQosYwuo5PcbJuBopaboqZec3cg==
X-Received: by 2002:a05:6830:1284:: with SMTP id z4mr721865otp.338.1644270307330;
        Mon, 07 Feb 2022 13:45:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q18sm4393063otf.54.2022.02.07.13.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:45:06 -0800 (PST)
Received: (nullmailer pid 977329 invoked by uid 1000);
        Mon, 07 Feb 2022 21:45:05 -0000
Date:   Mon, 7 Feb 2022 15:45:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     David Collins <quic_collinsd@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Dai <daidavid1@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: spmi: Add qcom,bus-id
Message-ID: <YgGS4b+8c4xmy0H5@robh.at.kernel.org>
References: <20220201134108.2677578-1-vkoul@kernel.org>
 <20220201134108.2677578-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201134108.2677578-2-vkoul@kernel.org>
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

On Tue, 01 Feb 2022 19:11:07 +0530, Vinod Koul wrote:
> PMIC arbiter version 7 and beyond we need to define if we are using
> primary or secondary bus, so add a new property of qcom,bus-id
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml  | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
