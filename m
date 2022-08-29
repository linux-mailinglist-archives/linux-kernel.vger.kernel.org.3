Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB05A54E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiH2Tz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiH2TzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:55:16 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373F3B1F3;
        Mon, 29 Aug 2022 12:54:59 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so6652598otu.3;
        Mon, 29 Aug 2022 12:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uYHm4mFPT2eGTYbw2h4xIgrYI9PeSYaUmhIePHdbJ94=;
        b=fa+ZMBaRzETqDrH8FJiCK/4DVgV+vCswetUqDCJPef0HBHifaTTRD7YWsodxQVql/G
         3Z2KDrZY0xajlvQW0DjosxtAAjphKSRruPWA1RILECVrI1e3nBfXa9aTjiZczFn/gNMo
         iCUndgAm7RaodNjSahHSaCm1DjaPxUrS7YqH3wzt2X5911qvn1ycS9xFbfonk4Z8xbS1
         D3zOXNQmiUTiKB37ruS3ChStLcsSlSob9QXCqu+NvxVnSUtadF4/89HSfFTvREP50Zhw
         pSGhy7emDppFMSA5GbOVpU1u6JmQpgyfLHUwCILAd/ga7UGDX+dJdx6lKi4i0VTZkM2k
         Wuow==
X-Gm-Message-State: ACgBeo3RYvotKVOHfc+ADKX+kw5pEHjCb9wD3Hk7bg1tqxmmRxE/HSn3
        1Ge4vSEBcA2jijiFib5KCg==
X-Google-Smtp-Source: AA6agR5PXD6ZLnNdERMvkQXAuagOjycXCZuBV3uENqxvvA0g41pDwkmlIS09vaTGOdDr0JrGdifWUQ==
X-Received: by 2002:a9d:2783:0:b0:639:5fcb:30bb with SMTP id c3-20020a9d2783000000b006395fcb30bbmr7293041otb.42.1661802898322;
        Mon, 29 Aug 2022 12:54:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d6745000000b00636ed80eab8sm6000708otm.4.2022.08.29.12.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:54:57 -0700 (PDT)
Received: (nullmailer pid 2309912 invoked by uid 1000);
        Mon, 29 Aug 2022 19:54:56 -0000
Date:   Mon, 29 Aug 2022 14:54:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] media: dt-bindings: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220829195456.GA2309877-robh@kernel.org>
References: <20220823145649.3118479-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-3-robh@kernel.org>
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

On Tue, 23 Aug 2022 09:56:34 -0500, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/media/microchip,csi2dc.yaml   | 2 ++
>  Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml | 1 +
>  Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml | 1 +
>  Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml  | 1 +
>  Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml  | 1 +
>  Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml  | 1 +
>  .../devicetree/bindings/media/qcom,sdm845-venus-v2.yaml         | 1 +
>  Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml  | 1 +
>  Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml  | 1 +
>  9 files changed, 10 insertions(+)
> 

Applied, thanks!
