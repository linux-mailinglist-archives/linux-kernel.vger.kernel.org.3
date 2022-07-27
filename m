Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB57582948
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiG0PGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiG0PGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:06:49 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29CA2E6A8;
        Wed, 27 Jul 2022 08:06:48 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id e69so13772522iof.5;
        Wed, 27 Jul 2022 08:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I+Wo8Z2vtq8v8ZDTFu137lzidph+nIAzDw0CaJdsoA4=;
        b=BwgCXS/Z20M3Sai3Xa8XYQIcIeHtgIaGC4Cz7SsfsDdNY8hzdFATTWEKZ190qxsOsB
         nZI2QyUZulKpR7fq8H+U6rQL0Bbp/gRRj+WOha6wf5q6C+joGQZL8WgL2iDQJ1Hrho+D
         CMSe/jDgJmYVHFptyIZ3yJNlvh4y2j0G7MglHM6gwcgwufBDXPT0a9WaJ1nuD2lSAqj5
         /BnyaiAza6hsyAU7+WwUsjqN7fdPTat1kjzRM/BPWj5bLrlnMFXRIbTYBA8rdwe2g/JK
         FzjlJOakKZZd5VGfsrbSDXrVyo4dv7mgpjCBYHh0gOgt8PlK8HdQZeJqE2BFKT22Tem1
         Bl8Q==
X-Gm-Message-State: AJIora80qvoSigWnaGjZMt0L1XM1+JSNK7uwiUNEFHKjunjH24Qf82vv
        UGBqrbvAZPL0IpjkwcX4LQ==
X-Google-Smtp-Source: AGRyM1tT0ZB91E444DVbZyN4xdFJRhnMvmRyvzvn1Ms1ySxN4bPGQ4iKn+fe4JHaG1BwcLDV7jVtsw==
X-Received: by 2002:a05:6638:379b:b0:33f:6a8f:cd22 with SMTP id w27-20020a056638379b00b0033f6a8fcd22mr9008229jal.102.1658934408031;
        Wed, 27 Jul 2022 08:06:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s66-20020a025145000000b00339e669df91sm7979892jaa.153.2022.07.27.08.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:06:47 -0700 (PDT)
Received: (nullmailer pid 2668204 invoked by uid 1000);
        Wed, 27 Jul 2022 15:06:45 -0000
Date:   Wed, 27 Jul 2022 09:06:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8226
 constraints
Message-ID: <20220727150645.GA2668145-robh@kernel.org>
References: <20220726115202.99108-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726115202.99108-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 13:52:02 +0200, Krzysztof Kozlowski wrote:
> Document the constraints (number of GPIOs) for PM8226 variant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
