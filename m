Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB0532096
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiEXCCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiEXCCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:02:41 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBDA7CDE2;
        Mon, 23 May 2022 19:02:40 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id e189so19905156oia.8;
        Mon, 23 May 2022 19:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o9taqpAliByc4G8JwaSpTdZKBrUT+Ewd9V6cxw+JgoY=;
        b=dqBQ4Fko+i+SaKF1J6BcU8vQSLOUZl3q7Ey8fq/q6jzte3h3861F8O+0wsB6mvBpG3
         J68EMNYYCW52heNzNhvldxBMn7+aMJZZcj2GOsJvWitZ9Qxznt1JhSbhRDAQAgtmNghd
         5ElwR6LX8TWwOfEc5bWJdbMA6LM5XdpulJb7ZmaY9TwlbOxkQYC2NGxGwV6io+dGBlfF
         VLall5ofu3CY3Coy1QbN1Ue2IdQUmAPAm6e8Vd0A0t4/R+r+1JqwcQ3kE5Y6h3rrxQcK
         DdgWnveuB0mfk7gbpfOH1OX2jCxThOpfP87WCSHTltJPDRPVd0JTHtAwq3jFFJy5XvR5
         VbpA==
X-Gm-Message-State: AOAM532I+MqMLSfLmf9TCWFv3/PaZuXpmyanZQgFqi5hUCGD8610ObbI
        2OnqEk7VuRjr41eFRFawS/UUXzF1MQ==
X-Google-Smtp-Source: ABdhPJxtagg3LpbiLPIoOCA/HVENOargtTIPscOlWUMoTZTlmEx41M7sABlXuqm1FwYly63qf50idQ==
X-Received: by 2002:a05:6808:ec3:b0:2ef:3f6a:5a1e with SMTP id q3-20020a0568080ec300b002ef3f6a5a1emr1173235oiv.296.1653357759413;
        Mon, 23 May 2022 19:02:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ds6-20020a0568705b0600b000f1bad20cc9sm4458090oab.0.2022.05.23.19.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:02:38 -0700 (PDT)
Received: (nullmailer pid 2600016 invoked by uid 1000);
        Tue, 24 May 2022 02:02:37 -0000
Date:   Mon, 23 May 2022 21:02:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 06/12] dt-bindings: arm: qcom: add missing SDM636 board
 compatibles
Message-ID: <20220524020237.GA2599989-robh@kernel.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
 <20220521164550.91115-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164550.91115-6-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:44 +0200, Krzysztof Kozlowski wrote:
> Document board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
