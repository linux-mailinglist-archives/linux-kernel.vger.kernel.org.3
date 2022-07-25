Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5062E580766
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiGYWco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiGYWcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:32:43 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523C72558C;
        Mon, 25 Jul 2022 15:32:40 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-f2a4c51c45so16593095fac.9;
        Mon, 25 Jul 2022 15:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vrFg/Wdr2fpmDmlkrGgKtDYpcQh0adoN9huZZNeAVOQ=;
        b=Tpsi4QB3GFKWUzPpssMRziiEEhUzcbZhFg7umD+Xyb4bCLgcB4v7C9dasSYUplLBr2
         CL6AB7dEfXGgi/cvEWwNaZyqJV4xDh6URdG74FYgh4xk36zu09LVk0em2N9g+0Ox23Vl
         q7DJyHohgGn6YemyqlfcGR7yb2/nkBzWCBOtkr04IOZosAP27gNxYZ8EZjswNa5oLkci
         jwWlDmJ8J/E/ofFqZcGxzIAqmgAxSkXDb4dLJ3q0LgKmzMN5mAIO3W/rVJe2RLDlouVn
         ie9AG5/rUA3KjtptVIhFzVSHTixMHMS+EeZd44KRJJvahntLvSc8fRTg0seB4arGsduz
         TE+g==
X-Gm-Message-State: AJIora/j1aed4SC1g01Rbp8C443SfvAGCrvbkPU1yw0ejoK2yN/IXXWa
        cEj5msUJjQUX1C2D17LNxg==
X-Google-Smtp-Source: AGRyM1t1bEV8DgQsWGAL0ndG+noYPz6WBjacLVXvISBkY4yCzv8I+OD2St3QKdRdkQDGzUvNBLwXNw==
X-Received: by 2002:a05:6870:15c9:b0:101:cdac:3887 with SMTP id k9-20020a05687015c900b00101cdac3887mr7255938oad.35.1658788359595;
        Mon, 25 Jul 2022 15:32:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f24-20020a9d6c18000000b0061c731fc92bsm5415876otq.64.2022.07.25.15.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:32:38 -0700 (PDT)
Received: (nullmailer pid 2865933 invoked by uid 1000);
        Mon, 25 Jul 2022 22:32:37 -0000
Date:   Mon, 25 Jul 2022 16:32:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH 01/10] dt-bindings: interconnect: qcom,msm8998-bwmon: add
 support for SDM845 LLCC BWMON
Message-ID: <20220725223237.GA2865899-robh@kernel.org>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720192807.130098-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 21:27:58 +0200, Krzysztof Kozlowski wrote:
> Add compatible for SDM845 Bandwidth Monitor instance measuring traffic
> between LLCC and memory.  It comes with different register layout:
> called v5.
> 
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
