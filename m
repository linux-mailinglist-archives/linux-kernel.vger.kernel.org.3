Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034F459C60E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiHVSY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbiHVSYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:24:24 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE6481D3;
        Mon, 22 Aug 2022 11:24:20 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id u14so13212917oie.2;
        Mon, 22 Aug 2022 11:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kHHAGkcdDwIUojsw/Qh9mTAcNHVZ/83Lhyn//UEbyGE=;
        b=KCM5lV6jh22OXLeWJuB2PF+QCC0TgTlKK3tnexJR1au8KWsichEDWaCgGAcFCNypyW
         kXjuQYUUYyJJAWRTUDHD8gMnbvjz7KAhtnVgYlwWblmovisc9lM5nYimMJh8aIRbALUk
         t78kFsAIAm/+ZYWUKzomcf9jBtjuppSb8eiNvjB459eBts2v2db+Wuzyn4ma/LNx5VbC
         Y7SuDm0G56V/4aVvzl0Mj7e2kWzzII5g7Nu4bBfJBkYZUJKmmKCciSDhqR/NpO4ZkwNu
         0qmnj1jmLNaPUKkk+hk0+pzZPUvJr9iP+Z8CohSlwgN2Xf64/Vcc4qdnA+ZpSeZeRJOa
         okBg==
X-Gm-Message-State: ACgBeo3SdrQGZWMmd2AzZBddFm+xglkb48wcrBNKXRCsnQZxun9D/u9y
        5lEvcevkRGpkbyyYAOYT5g==
X-Google-Smtp-Source: AA6agR4GcnCSOqfMPx7kKucGwdxFpONZqkYeDNNgwvLBMASnPewmx+dR5MZxR1QRtg6AOjnDW1mCwA==
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id n9-20020a05680803a900b003434b14cccemr11840129oie.41.1661192659071;
        Mon, 22 Aug 2022 11:24:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t20-20020a9d5914000000b0061cbd18bd18sm3145285oth.45.2022.08.22.11.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:24:18 -0700 (PDT)
Received: (nullmailer pid 109846 invoked by uid 1000);
        Mon, 22 Aug 2022 18:24:18 -0000
Date:   Mon, 22 Aug 2022 13:24:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFT PATCH v3 01/16] dt-bindings: mfd: qcom,tcsr: add several
 devices
Message-ID: <20220822182418.GA109764-robh@kernel.org>
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
 <20220819083209.50844-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819083209.50844-2-krzysztof.kozlowski@linaro.org>
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

On Fri, 19 Aug 2022 11:31:54 +0300, Krzysztof Kozlowski wrote:
> Document existing (MSM8996, SC7280) and new compatibles for TCSR syscon
> registers (QCS404, SC7180, SDM630, SDM845, SM8150, MSM8998).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Add more compatibles.
> 
> Changes since v1:
> 1. Correct order of compatibles.
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
