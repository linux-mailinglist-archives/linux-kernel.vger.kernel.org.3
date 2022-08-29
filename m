Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310245A551C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiH2T5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiH2T5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:57:13 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F6890C57;
        Mon, 29 Aug 2022 12:57:04 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11c4d7d4683so11773455fac.8;
        Mon, 29 Aug 2022 12:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GLVAQhP67GqpGtvEpnaqWTR1PDtHdyGTARxFHlVUfXI=;
        b=CV4xkUkhwyj1oD0NDFefwOyG60S7pSr+FWzrpfy+QK8nSusJquLxgpx2aIALkONGmY
         Hg99aN/+saKmhbC2CIKauPGZrGcxzdPIzMwpZ0Cnc0r+aD2fpRhWAK7XhHH7JwmgzrfR
         890kgNeR0UTPWDWcdHeQ2R44T5EcW+DYuXounHbY/Oxc33+05IfpGZkrOUvO/ABhvldd
         FpGfKW3MVN4xkrNhFV1OU21t3nnhZTBbVXrZsWGoOnvfuC+T3uq0YzjG/iIvyGqsSYtv
         HfGs1dtycGoZAP54C+xeQxwworZos9JvjKMgb4krYeXaFydcxZDthPqHRzBVCn2bZ0vt
         HApg==
X-Gm-Message-State: ACgBeo3NpnHANjZR3YqOctIfsscA7WeJ+NzG53ORBdwT+lqW0P+EQu5U
        QGntuuvVwRIHzUvZfO/xRw==
X-Google-Smtp-Source: AA6agR6eBhT1zUHqrOJZ/uUEbZLGeR5414KMfQ2WDOIIjfxxzxd629WqjvbKt3zCzPNSGvrXcGtFKg==
X-Received: by 2002:a05:6808:99b:b0:345:d1f7:b42a with SMTP id a27-20020a056808099b00b00345d1f7b42amr4824869oic.79.1661803023011;
        Mon, 29 Aug 2022 12:57:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p10-20020a4aa24a000000b0044897475dd0sm5559769ool.43.2022.08.29.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:57:02 -0700 (PDT)
Received: (nullmailer pid 2314237 invoked by uid 1000);
        Mon, 29 Aug 2022 19:57:00 -0000
Date:   Mon, 29 Aug 2022 14:57:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Kiran Gunda <kgunda@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jingoo Han <jingoohan1@gmail.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND - dt 1/2] dt-bindings: nvmem: qfprom: add IPQ8064
 and SDM630 compatibles
Message-ID: <20220829195700.GA2314199-robh@kernel.org>
References: <20220825125410.232377-1-krzysztof.kozlowski@linaro.org>
 <20220825125410.232377-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825125410.232377-2-krzysztof.kozlowski@linaro.org>
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

On Thu, 25 Aug 2022 15:54:09 +0300, Krzysztof Kozlowski wrote:
> Document compatibles for QFPROM used on IPQ8064 and SDM630.  They are
> compatible with generic QFPROM fallback.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
