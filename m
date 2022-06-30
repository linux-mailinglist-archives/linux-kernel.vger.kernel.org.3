Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3914E56176B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiF3KPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiF3KPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:15:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2058A44A35
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:15:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mf9so38128547ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GfQOH0uA5xHHsswoX4aED7xJvqSVhn+riV8wmLbA/wU=;
        b=W/m+OiUoLB/gYrF8sevJdttv3vWPW0nBvK4z34ZNVrwEUzdBuD+6n9m4bkCJKoFs25
         iEXnCyeMzF4kbMndUI78XuDxFQOWtIEKVxG/TjMHrJybQCza4s7XpClC2FtAGuueJI7Q
         aCGfkrIIS6ZtH4FcmVjtFXPD95OLuC0pU+j7veKT7bB2y5qqBiM6upVPI59vJ1x/l6l8
         6nax1SavKsX1h+kYwROfh6Aayz04wTolYHJZ5lqAHH0XovxoFxaBSRAxPVhPqfTXh5J0
         Wf0zYTpQM2QFtcWnZGaF4nr3P1YxD44hTfYvyIkHXADdA59Out+Redb/KCnAutr+SHi7
         9UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GfQOH0uA5xHHsswoX4aED7xJvqSVhn+riV8wmLbA/wU=;
        b=eRt64ay7nGyAEQh9whxACFNc9rrzrVCGAVF3BlA1Qs24nqHEchEzZhzudmd/vaobOq
         icQq3m77EE7BJ4s+kAb8kBT+XYkBjway5WCO5tDgrNDi775TNlvGhPhsbql9wszGf7sc
         2pNT9wMgjszS8AcmbjkHPAjKaHHX5q4Wb5TUdx7mDRYW9NDWxNQUnnd2CnS5f1dLf2Ul
         F/rn5nurbyBsvT6f23G5DavY1MUMaO8MJ+8ScFbVQohDTez7+ZUNqxvykeAdWk31AMjN
         28GivNDeyeYnx6P7AdB54LHBzgHeQJ6+sSHxarjDIEZ4A3/Pjujfpr1JN5qT6lz/Wgxm
         bGjw==
X-Gm-Message-State: AJIora8aEVv69LD6pQQn2teZAtFzBWuXTbXfgsIThNxS7IovSwOGwT0I
        kzU3ehmiU3M6hqXvJIYx50ZS3Q==
X-Google-Smtp-Source: AGRyM1sg+0Nq3WOsALianvu9zM0G9RgzakYuPbrOBeVD65q7iyC+efLIJ7cWOLWYrAsk28K2+m8efA==
X-Received: by 2002:a17:907:3f28:b0:726:3149:8a99 with SMTP id hq40-20020a1709073f2800b0072631498a99mr8263797ejc.277.1656584115653;
        Thu, 30 Jun 2022 03:15:15 -0700 (PDT)
Received: from [192.168.0.189] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d15-20020a170906c20f00b006feb875503fsm8922528ejz.78.2022.06.30.03.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:15:15 -0700 (PDT)
Message-ID: <06c2d390-9444-49e5-fb21-4d4b6df0329f@linaro.org>
Date:   Thu, 30 Jun 2022 12:15:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Switch PSCI cpu idle states
 from PC to OSI
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220630101403.1888541-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630101403.1888541-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 12:14, Abel Vesa wrote:
> Switch from the flat PC idle states of sdm845 to OSI hierarchical idle
> states. The exceptions are the cheza plaftorms, which need to remain with
> PC idle states. So in order allow all the other platforms to switch,
> while cheza platforms to remain the same, replace the PC idle states with
> the OSI ones in the main SDM845 dtsi, and then override the inherited OSI
> states with PC ones, delete inherited psci cpus nodes, domain idle states
> and power domain properties.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v1:
>  * fixed the commit message as suggested by Krzysztof
>  * dropped blank line sdm845 dtsi
>  * renamed sdm845 dtsi psci subnodes to power domain cpus and cluster
>  * fixed indentation for idle states in cheza dtsi

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
