Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842BF4F0436
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356719AbiDBOmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356714AbiDBOmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:42:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588F21A3BC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:40:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b24so6068223edu.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XNA7JZlHCOkUJgQubK0e6uaBuAfi7LHL/HwfQfGUJqY=;
        b=MZKmHtRdE/d/kZs2anM8GJZvVNaaX3G1SPUeftLFK9gW+DWkbyNRK6ulfS3D4T1yT8
         AhUorGjiS6roW4BOK9VkNnU/stRAID6EO28ez4dPDkQ2Dr1woOuFtCzaMtNHoJzn894w
         zqcvg2Oh9Z+tHf2qPo8qalIjZ7PQB3BXywkpLtDKLh7ffhsFu8mdqhn3sV1CivRjDJeV
         i7O4/HXkdyuvpqjVogaVaWKD7y3tJnm7XaNGHRQG/JdzzYoXUp2wpXVMK1OJHIwBnNkQ
         Y05V2/KmHuIWqREZL0sKDrw9VIL/vNDtgBWVxSkfIOYBpy7P+MKrjGaZeoZHPFvEXgGV
         ylZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XNA7JZlHCOkUJgQubK0e6uaBuAfi7LHL/HwfQfGUJqY=;
        b=JuG9UTiMFfvj7y8X3c9dVWTO6y/AdnPL5HXlqWrgE1m6WpaHhz4bQl6CFLRoAaRKSJ
         +is/XxQ+V0Ok4g+tMuWhH8Oq+PPDGwH/Bf7vtsUUqDrhmOg5Xl+hhARGGpSqiK1skpno
         vSBiM1isRXGYQUZKR1SGSQ5YKzOTSj6BgiBui8Iw41a0n3L9U3TvyshkkB7K5i9rxOVH
         Fi7iHfKoBL5oE1wcQJ9Pe958vl3cc8xvPNYRoxYyg9x3ymOaNbvRPkKSmdw7+1bZcRLJ
         LdLzo/cpmGkXEfSYtQHUFsYoj5gTQLzojO4ROJj6DPIZZWKhK1m3vpDUYTrBSUnd1inA
         yw4A==
X-Gm-Message-State: AOAM530cLd+wmc0Y4OrcXtmnE/aDabb0jH1XQYBFH9QyDxoReQ91n+38
        yTmFwnhDtQ3D+0dPpU7JTeYNPQ==
X-Google-Smtp-Source: ABdhPJwfB7bogzwm+XNxHgXGVvJMn3iHK2ZRqopei35YEBOlAIMBCKMkBPEF833A1qJMt/T+ntpH8w==
X-Received: by 2002:aa7:d6d8:0:b0:419:886:dede with SMTP id x24-20020aa7d6d8000000b004190886dedemr25491467edr.258.1648910427904;
        Sat, 02 Apr 2022 07:40:27 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id rh26-20020a17090720fa00b006e0da7ef847sm2176812ejb.13.2022.04.02.07.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 07:40:27 -0700 (PDT)
Message-ID: <ba93d501-56db-143c-164a-333ae573d9f0@linaro.org>
Date:   Sat, 2 Apr 2022 16:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/6] arm64: dts: qcom: pmi8998: add smb2 node
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
 <20220401202643.877609-3-caleb.connolly@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401202643.877609-3-caleb.connolly@linaro.org>
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

On 01/04/2022 22:26, Caleb Connolly wrote:
> Add a node for the smb2 charger hardware found on the pmi8998.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> index da10668c361d..b98dad166a0b 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> @@ -9,6 +9,21 @@ pmi8998_lsid0: pmic@2 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		pmi8998_smb2: smb2@1000 {

Generic node name please, so "charger". Have in mind that PMIC
(parent's) schema might require it.

If it exists (I did not check), it should reference also your charger's
schema.

Best regards,
Krzysztof
