Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE3F57C00D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiGTW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:27:58 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E151402E1;
        Wed, 20 Jul 2022 15:27:57 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id p81so36166iod.2;
        Wed, 20 Jul 2022 15:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oo4Cj90tKpj3sAP647twLEXNDvmJGXtpqn4ssO5hFeQ=;
        b=gKLNAiZYZ1fRzov1Eflmyyo7T8YMukxcZTnXPI2tW9LkfujZsd3WUf/PD4BRjTFCWA
         a5bDEvHSvxTJ/1sUkOfGfo6JAuSy2pI7QiWHZHd437+QEJcBsyS3m2+nlhRUEYh7dnFe
         QRu7q3DqwSzcMEmL8euL4APKdzB0d6DOgXYyuT96R7Yod58sXQduc4iexki6g0xDloQN
         I/ycatMQzCWCZlfg81P7cuoxZY0+jqDiYI4bamwUHrPrGOdczSM1KbcVoMZXS/DixNia
         fnN8TeBvzYOvtBf4SFL1ArB/9pIT8rCl2CUF5QF5pLlKkDH83iyLGUT9pNVMkNs3YYJc
         /CqQ==
X-Gm-Message-State: AJIora/T5Ul1xZfA0+8Owu2J+5lVyVu0UED9FtS+UI6IPrITANpTl01e
        TFAZim8Q7yoJN67wMWVYLg==
X-Google-Smtp-Source: AGRyM1v3ELRkc3yuJVlJ65DTdK4+N7DtTYKXQDS4hqkslEfANtvY7M0ms2gHbvH6FtrGNWdUN8mwfw==
X-Received: by 2002:a6b:6105:0:b0:67b:e68f:c9ee with SMTP id v5-20020a6b6105000000b0067be68fc9eemr12830428iob.154.1658356076454;
        Wed, 20 Jul 2022 15:27:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j17-20020a92c211000000b002dc0ddef9cfsm84546ilo.73.2022.07.20.15.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:27:56 -0700 (PDT)
Received: (nullmailer pid 4094110 invoked by uid 1000);
        Wed, 20 Jul 2022 22:27:54 -0000
Date:   Wed, 20 Jul 2022 16:27:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        angelogioacchino.delregno@somainline.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: Add DT schema for SM6375 TLMM
Message-ID: <20220720222754.GA4094076-robh@kernel.org>
References: <20220716192900.454653-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716192900.454653-1-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 21:28:59 +0200, Konrad Dybcio wrote:
> Document the TLMM driver for SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../bindings/pinctrl/qcom,sm6375-tlmm.yaml    | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
