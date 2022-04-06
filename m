Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D93A4F6B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiDFUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiDFUNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:13:55 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3131140A1;
        Wed,  6 Apr 2022 10:44:59 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso2205336otd.6;
        Wed, 06 Apr 2022 10:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQGAhVkoMVchgmtJMVhAtK7JRG3UaGk6gAi1FHksJok=;
        b=CxQ0tfR/V0mUHbcjblolrvkLrAtOuBoAnQSQ9ujIar9o8fprzjeQkvLC6lTvTlxSi3
         aH0gqT9y4k3T9r8rDk7LBi5FS6ImS1jEw7AO/Jfbl/23gFYCdNYYaY79Or+wZxKs1Ibd
         KjS12E7UQ5/3ZtUZK4wV0fwuKLhzpET28ovQ28EAXCLPkaM8YqtfUNMw724ic/Jqd+md
         mxzn9VBcicTAUW44xqPREQwA/WLcvOxpJP/DBADaqK7//GpMZlbnkFN1JEjiGpyTgh+L
         u4lt8ZhbFfegDDjNsysJ7k3g9VtwE/xkWpL1h2d4s0oiGXhpQi2Ms/cBZny5u5TqyRdp
         fvpg==
X-Gm-Message-State: AOAM530EAr7Xcj9g6P8BdZpRKKk7zk4Pybo5vE0vQSn/EpTJkQ3+3CJJ
        oyvKF2CdpEyaygGwjUB2zg==
X-Google-Smtp-Source: ABdhPJxmVkSyx43KIty/v1EZpatUCR4dvx3Ts6J5KNstYq0qO+8+CbAh29CaRQszr4r5SfRUiJs+4A==
X-Received: by 2002:a05:6830:82a:b0:5b2:36d5:1603 with SMTP id t10-20020a056830082a00b005b236d51603mr3472144ots.240.1649267098688;
        Wed, 06 Apr 2022 10:44:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e4-20020a056870920400b000e1bdf90ba5sm6236468oaf.22.2022.04.06.10.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:44:58 -0700 (PDT)
Received: (nullmailer pid 2481314 invoked by uid 1000);
        Wed, 06 Apr 2022 17:44:57 -0000
Date:   Wed, 6 Apr 2022 12:44:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to
 dtschema
Message-ID: <Yk3RmTJD5XHX1hIM@robh.at.kernel.org>
References: <20220404064017.68634-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404064017.68634-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 04 Apr 2022 08:40:16 +0200, Krzysztof Kozlowski wrote:
> Convert the GENI based Qualcomm Universal Peripheral (QUP) Serial
> Peripheral Interface (SPI) bindings to DT Schema.
> 
> The original bindings in TXT were not complete, so add during conversion
> properties already used in DTS and/or in the driver: dmas,
> interconnects, operating points and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Drop reg-names.
> 
> Changes since v1:
> 1. Correct $ref path and remove interconnect minItems (Kuldeep).
> 2. Remove child tpm device from example.
> 3. Pad reg hex addresses with 00.
> ---
>  .../bindings/spi/qcom,spi-geni-qcom.txt       |  39 ------
>  .../bindings/spi/qcom,spi-geni-qcom.yaml      | 116 ++++++++++++++++++
>  2 files changed, 116 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
