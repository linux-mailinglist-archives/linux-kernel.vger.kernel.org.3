Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7952AF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiERA6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiERA6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:58:10 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8310254005;
        Tue, 17 May 2022 17:58:09 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so788903fac.7;
        Tue, 17 May 2022 17:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LpjWkKEpSmy8t1ziW+4ueZtuwiEuGRNClIwNw3ymmbA=;
        b=ixhFF0jAu2jmqzRfRppoKc8sMrsoDVb8Txv0N+QPCKBLEFgcQAMZtomeflsTVzMyS9
         VoiAR/wZoOFTWFXU01H2KkaePSCEYpHuQjpQXJrYkrU/d4LR9Y36wx/M+mye7hvzLIW8
         ezE4udd712eHmwLnUWOwWTkySkeO0bRI0k//uRTIkrJcPfLANS61zGtXo5jlFHhTbRlh
         e3Ul3n1HsGewKevAkEv9BSi+bcwUFZDOwy1cXrxMxtLSNTCu1VrzK3fhP2NN8IOtZ1zW
         2MQq7TyYKJ7AlJxDbd1NgHub5w5KGLvKcsP0cLwuhJk9+r5eEVdZ04A2Inw9/ybIKo49
         sHSQ==
X-Gm-Message-State: AOAM532LQ01hFmkGng65NsSlB08h9WWat3C03+TsxzlLRIBngbR2/QLV
        bmhLx+KzfG6Vw1wbVocRXq35Cs9+1w==
X-Google-Smtp-Source: ABdhPJybRUqXrXZRLYWRrTJaeDgKsRamcrVFghqsQ+A5UgH70g8ze1DsEsaKM4dKkTXYzIbg94pnjQ==
X-Received: by 2002:a05:6870:b402:b0:d3:3712:efa7 with SMTP id x2-20020a056870b40200b000d33712efa7mr13412638oap.88.1652835487389;
        Tue, 17 May 2022 17:58:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r10-20020a4aea8a000000b0035eb4e5a6c8sm391210ooh.30.2022.05.17.17.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 17:58:06 -0700 (PDT)
Received: (nullmailer pid 1982761 invoked by uid 1000);
        Wed, 18 May 2022 00:58:05 -0000
Date:   Tue, 17 May 2022 19:58:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/12] dt-bindings: remoteproc: qcom,adsp: use GIC_SPI
 defines in example
Message-ID: <20220518005805.GA1982728-robh@kernel.org>
References: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
 <20220517070113.18023-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517070113.18023-7-krzysztof.kozlowski@linaro.org>
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

On Tue, 17 May 2022 09:01:07 +0200, Krzysztof Kozlowski wrote:
> Use GIC_SPI defines instead of raw value in the DTS example.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
