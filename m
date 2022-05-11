Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEABE523518
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiEKOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiEKOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:11:26 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A732469B6D;
        Wed, 11 May 2022 07:11:25 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id l9-20020a056830268900b006054381dd35so534495otu.4;
        Wed, 11 May 2022 07:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z06cn7d/G69c0xSOTqxfuLMjJW9goLXOAMM1t5ljbEY=;
        b=sXRFys/Lp75204n8zPJTPjwU5BY1G8PgQE2fXeesgdwZ3WEvbBL1LQlyUuI+48+QiJ
         F57ICzyhBh7Yp8RuLI9N3ZCVxawCpkAj/yDZPZpw4d+TNf9nXtE6nt3965DyjNeKWyF0
         yGaFDljuuWhKSsay73AShl7gEt7h8maNRVlq8oF4twptKGDjtyBGriJELdytIJneZhYj
         mV1Pki89WS4Xk7SLn2bSQtVkqbe9xa2Tbba6b3K96IyuuxPpem0QQVombwE46oOpoLMs
         xZP1p8nXGP1bIJHGfeZ0kMlbKO2lpJhb+1QJwKMc0i7ZFPiJuBenOA/kqOKGdJNaFJ9L
         WO7Q==
X-Gm-Message-State: AOAM5302SGASvfUwi1tkydMo1POTgFr62fi8HIYTo5dQrtDTwqZWKfTM
        4c2QInM2/33LqxiraGdOXw==
X-Google-Smtp-Source: ABdhPJxlKR+OEInFUMX3Z041DuUSmqCUhy9narX4q7Nb6Cr6YXvbswUKh9xkuPRehGjQl3+dmFTXew==
X-Received: by 2002:a9d:195:0:b0:605:eb43:5b84 with SMTP id e21-20020a9d0195000000b00605eb435b84mr10001291ote.357.1652278284426;
        Wed, 11 May 2022 07:11:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c17-20020a056830315100b006060322126esm819796ots.62.2022.05.11.07.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:11:23 -0700 (PDT)
Received: (nullmailer pid 234685 invoked by uid 1000);
        Wed, 11 May 2022 14:11:22 -0000
Date:   Wed, 11 May 2022 09:11:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V11 2/9] dt-bindings: mfd: pm8008: Change the address
 cells
Message-ID: <20220511141122.GA226988-robh@kernel.org>
References: <1651742739-12338-1-git-send-email-quic_c_skakit@quicinc.com>
 <1651742739-12338-3-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651742739-12338-3-git-send-email-quic_c_skakit@quicinc.com>
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

On Thu, May 05, 2022 at 02:55:32PM +0530, Satya Priya wrote:
> Change the address cells as '2' so that the first cell
> describes the i2c address offset of the clients. 
> This helps us to define the child nodes of all
> clients under the same parent mfd node, instead of
> adding separate mfd DT nodes.
> 
> Change the gpios reg value accordingly.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> Changes in V11:
>  - New patch added from V11.
> 
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> index a89649c..a41618e 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> @@ -39,7 +39,7 @@ properties:
>    interrupt-controller: true
>  
>    "#address-cells":
> -    const: 1
> +    const: 2
>  
>    "#size-cells":
>      const: 0
> @@ -48,7 +48,7 @@ properties:
>      maxItems: 1
>  
>  patternProperties:
> -  "^gpio@[0-9a-f]+$":
> +  "^gpio@[0],[0-9a-f]+$":

^gpio@0,[0-9a-f]+$

>      type: object
>  
>      description: |
> @@ -61,7 +61,7 @@ patternProperties:
>            - const: qcom,spmi-gpio
>  
>        reg:
> -        description: Peripheral address of one of the two GPIO peripherals.
> +        description: Peripheral offset and address of one of the two GPIO peripherals.
>          maxItems: 1
>  
>        gpio-controller: true
> @@ -110,7 +110,7 @@ examples:
>        pm8008i@8 {
>          compatible = "qcom,pm8008";
>          reg = <0x8>;
> -        #address-cells = <1>;
> +        #address-cells = <2>;
>          #size-cells = <0>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
> @@ -120,9 +120,9 @@ examples:
>  
>          reset-gpios = <&pm8350c_gpios 4 GPIO_ACTIVE_LOW>;
>  
> -        pm8008_gpios: gpio@c000 {
> +        pm8008_gpios: gpio@0,c000 {
>            compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
> -          reg = <0xc000>;
> +          reg = <0x0 0xc000>;
>            gpio-controller;
>            gpio-ranges = <&pm8008_gpios 0 0 2>;
>            #gpio-cells = <2>;
> -- 
> 2.7.4
> 
> 
