Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE285288A6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245265AbiEPPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245333AbiEPPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:22:13 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9960B3CA4A;
        Mon, 16 May 2022 08:21:59 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-f18e6ff0f6so6173943fac.11;
        Mon, 16 May 2022 08:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jsKMnezEMbho6g+egNL/sEXy2h+jZMTIg3S1gFn875E=;
        b=USxilxJxSaoRanorf7TaGg5TXFrZL1wdOonJfG5USRtIDz/u64YISGrFzlEbYt57s7
         +3s59tSmY0/XNI3+x0+Hl9I6PfqKMin1334FbJJPdG2awrV11ELDfqnCNO5VK+a0ZE4i
         LpWrkKrvU+NQu2O5p1FVu0sz1T9u+9wXGpUSG3BLzV21wGe9sCzGXWk61D2gUWEU1hxq
         qrZD9FFgjwvtBNSNvXaN/QnDIpWtR62Gt1hdLLEXVtlgjZOCBrwxoogjGf5ACCjXdazA
         RWMLoWEv0rqion4KN+n4kjbeP0dZ4XVLm9QeO35U6mHRhPOvAsRuiHuXin+2ZnPrxfTt
         Fn/A==
X-Gm-Message-State: AOAM533KZwlcfxL6jds9diVmjfbarwhQse1TVRHfnxOFZ0BqIsuCcMq3
        0VhtGEZC6WdVeEK4NrgLdw==
X-Google-Smtp-Source: ABdhPJx3X7B0yv8TQHMxDnxya1oWoIcogdZr1G3rPEyVRyEvG6N0y6xeUP+M+SgZ2RCurdEN9GW1KA==
X-Received: by 2002:a05:6871:92:b0:d9:abe2:936e with SMTP id u18-20020a056871009200b000d9abe2936emr9316516oaa.83.1652714518918;
        Mon, 16 May 2022 08:21:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a056870d68300b000e686d13897sm5569999oap.49.2022.05.16.08.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:21:58 -0700 (PDT)
Received: (nullmailer pid 2669311 invoked by uid 1000);
        Mon, 16 May 2022 15:21:57 -0000
Date:   Mon, 16 May 2022 10:21:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        linux-remoteproc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 02/12] dt-bindings: remoteproc: remove unneeded ref for
 names
Message-ID: <20220516152157.GA2669256-robh@kernel.org>
References: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
 <20220512100006.99695-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512100006.99695-3-krzysztof.kozlowski@linaro.org>
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

On Thu, 12 May 2022 11:59:56 +0200, Krzysztof Kozlowski wrote:
> The core schema already sets a 'ref' for properties ending with 'names'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml    | 1 -
>  .../devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml   | 1 -
>  .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml   | 3 +--
>  .../devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml   | 1 -
>  4 files changed, 1 insertion(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
