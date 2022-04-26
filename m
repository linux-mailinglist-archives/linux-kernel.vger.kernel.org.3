Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CEC51066C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350629AbiDZSQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbiDZSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:16:32 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA266C95E;
        Tue, 26 Apr 2022 11:13:24 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id y63so1149935oia.7;
        Tue, 26 Apr 2022 11:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VeOI+T4LlfkI1svlOgwmVDfx/X7fHxkMtfZYUeWc108=;
        b=nTlGFvQgBajEDNYP/evMJ0oQhXSwnYuvQdmkuSRsJ/lvDd3rUme6tFxICVkYpTbtnk
         BeMMJmFrYMRJ1Sish+qvSe73N9xtr3ak9+XJOLvVvRFOrvf/qsanon8v5E/xBU16tGHx
         VVRCBxd7tUSLvF2kRh//dEzrcnTAsyplz6gOa4EdEJwVqBb59v9LTCGRknlaieVOw1CV
         U/Jc9lFaLc5cORBruMwWYanx3a9XVViQD1agAuAw6D/CM/hgL+mED195+7ioTMPWQ4LH
         JUwycZ+8/9GYT52hlXKmEFw+yRFjG/ZvooXZPog6iNHVsx+DOfRsKiQZYZwGydlgh21w
         ewrg==
X-Gm-Message-State: AOAM5325rq9PnECkjzlJQHEaVWivJ80zynbKT8k1OU1lkjmp40zPO4GF
        Cg+MssYLaNfcYIZxKG/6QA==
X-Google-Smtp-Source: ABdhPJwypUOS+rV0e1Szk1wWf5mxPhtwAHyo8a/1TgX2vUVKllnlwTiSsDgV6rGOZ+s1WHeJSE7C/Q==
X-Received: by 2002:a05:6808:140f:b0:323:1d0c:cbc4 with SMTP id w15-20020a056808140f00b003231d0ccbc4mr12241012oiv.51.1650996803596;
        Tue, 26 Apr 2022 11:13:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q7-20020a056870e60700b000e686d13878sm1067667oag.18.2022.04.26.11.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:13:23 -0700 (PDT)
Received: (nullmailer pid 2285878 invoked by uid 1000);
        Tue, 26 Apr 2022 18:13:22 -0000
Date:   Tue, 26 Apr 2022 13:13:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v3 3/3] regulator: dt-bindings: qcom,rpmh: document
 vdd-l7-bob-supply on PMR735A
Message-ID: <Ymg2QtEQQjnCmyXr@robh.at.kernel.org>
References: <20220426105501.73200-1-krzysztof.kozlowski@linaro.org>
 <20220426105501.73200-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426105501.73200-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 12:55:01 +0200, Krzysztof Kozlowski wrote:
> The PMR735A comes with vdd-l7-bob-supply supply which was previously not
> documented.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
