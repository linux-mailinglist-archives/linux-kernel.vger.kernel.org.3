Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3983B5A6862
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiH3Q03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiH3Q0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:26:25 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EAFB5E6F;
        Tue, 30 Aug 2022 09:26:23 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11dca1c9c01so17977553fac.2;
        Tue, 30 Aug 2022 09:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2m446idst0vpwcTbOSDprdgg8ebJq5bA4d1QdJc6O1w=;
        b=To7eipZpMHP/B/2B/zd0/QlGXoXmFi5k9IeiOYe4DrQwKO3j0WN7vsjV5Ej0gbnlE3
         THlg6LO8d7AfybLfAEt2mkGq9p5JdBaTw9zpNcmGdef1TV2mDw+4lTGBYQxdk0H7AUyN
         NR6G9TIf/NBNtoUX2d2iSX4h3D6RyB1hwSFyfEgn1f9uZCiM+XiAuePxaePyN0AxeELR
         o92v1njXdl0jpksI+axLC/gSOgWNqL13tARY6hgNLZ+eKL4jkKRb5mTbaH54K/0XfFQJ
         jraysIBYOMP+5YIJLi3ykLF2QoVI2WwEbsoVlCKrE2WVMisg42p9ROu8E/v1r7S1oHvY
         6VgQ==
X-Gm-Message-State: ACgBeo0aZ2ZrNAkAbKaVIs/r0eIMTlJyS3WWwDRvWWM5U13lKXf02uGl
        qjmUbF3Yew3y1PQGEGqZRq1FA8k3pQ==
X-Google-Smtp-Source: AA6agR7nuKkwhH5lSZJObOJdHm9WitG9wgeF8g+Yn2t48aSnc7UYeEUjSQMFwFkW7Jfezo5SK2xbBQ==
X-Received: by 2002:a05:6870:40c3:b0:11d:7f61:fc50 with SMTP id l3-20020a05687040c300b0011d7f61fc50mr10233600oal.45.1661876783021;
        Tue, 30 Aug 2022 09:26:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t7-20020a05683014c700b00616e2d2204csm7710858otq.21.2022.08.30.09.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:26:22 -0700 (PDT)
Received: (nullmailer pid 1518878 invoked by uid 1000);
        Tue, 30 Aug 2022 16:26:21 -0000
Date:   Tue, 30 Aug 2022 11:26:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] dt-bindings: mfd: qcom,spmi-pmic: fix regulator
 node schema
Message-ID: <20220830162621.GA1518762-robh@kernel.org>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
 <20220828084341.112146-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828084341.112146-14-krzysztof.kozlowski@linaro.org>
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

On Sun, 28 Aug 2022 11:43:40 +0300, Krzysztof Kozlowski wrote:
> The regulators node of Qualcomm SPMI PMIC represents sub-device, so it
> has its own compatible, multiple regulators and uses dedicated bindings.
> 
> Fixes: 3f5117be9584 ("dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
