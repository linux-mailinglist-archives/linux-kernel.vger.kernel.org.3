Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0353C53DC2F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344878AbiFEOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344749AbiFEOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:11:21 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAD013FBF;
        Sun,  5 Jun 2022 07:11:20 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id r14-20020a056830418e00b0060b8da9ff75so9006250otu.11;
        Sun, 05 Jun 2022 07:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lRUkT7BBPd5Yv/h/LdvT5NyszL+3WGewd+yFszXzh9k=;
        b=PJTxjGkw5y8SWY3kld6eqwJim51JSGXBhN6a5+nclgB8d1BfasspxnzfPGmDLeMmW3
         Eo2SBXCrQlSIjOmMb0W4jLN5OPwbJ8XpbD1k07alI9PJl05BA2Edzfcai8kjinFKAEzy
         dxFSn4j3aRkAuwtSKwVdHIj8X5PTpxk8LkeCuIrMlLaxJ6FL+Q04VAfZU5JmEhMMZhXR
         x5/Uz5Z/shVkafxDfHMMCYeiYqTcX5HrfgJEW4sIq1EOhYuaN2gXs+7tC7Hwn3qdoVfN
         LAiSVKmsmtUfUU5EGwKiF1sy3VUH9KCIFmMwxuO+KzvQyjWXUiRDv06WKTHxazYcwPPb
         1D9g==
X-Gm-Message-State: AOAM532DshgEdhwtTyApzBi09SrfSl9mV2DYBAdx6gBTeX6VOrGTGv2K
        /J/PN8KymNLqDMoPQE7PRDRHJzB5PA==
X-Google-Smtp-Source: ABdhPJxDMU8i9Ium0iUSU/vLQ9CqODm5zQ+T3J+ZXKkezF+RKwzIdX+2nPuZ+8fXGd8RvFrrPwupbg==
X-Received: by 2002:a9d:665a:0:b0:60b:a921:e7f6 with SMTP id q26-20020a9d665a000000b0060ba921e7f6mr7928660otm.42.1654438280216;
        Sun, 05 Jun 2022 07:11:20 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.0])
        by smtp.gmail.com with ESMTPSA id x25-20020a9d4599000000b0060603221258sm6662176ote.40.2022.06.05.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:11:19 -0700 (PDT)
Received: (nullmailer pid 3425881 invoked by uid 1000);
        Sun, 05 Jun 2022 14:11:12 -0000
Date:   Sun, 5 Jun 2022 09:11:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org, vkoul@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, quic_jackp@quicinc.com,
        bjorn.andersson@linaro.org, linux-phy@lists.infradead.org,
        lgirdwood@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Update QCOM USB subsystem maintainer
 information
Message-ID: <20220605141112.GA3425470-robh@kernel.org>
References: <20220603021432.13365-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603021432.13365-1-quic_wcheng@quicinc.com>
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

On Thu, 02 Jun 2022 19:14:32 -0700, Wesley Cheng wrote:
> Update devicetree binding files with the proper maintainer, and updated
> contact email.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 2 +-
>  Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml       | 2 +-
>  .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml         | 2 +-
>  .../devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml  | 2 +-
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml            | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 

Applied, thanks!
