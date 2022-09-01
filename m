Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83B55A92A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiIAJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiIAJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:02:05 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFDA13251F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:01:08 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p18so13849289ljc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=lvApeUv6jUwfacMiPMy6drXUvkSgbjHAmu5eomvQtUg=;
        b=Ri9ESbHOWXgociYV0UbAWbMD69F5qYu2GTFUaK7N7RkMdXhRPHQWeVyizYTgKgzUSa
         T7WKkbtwyvX6FUU3flFndk0cDcHz9u2BAJGQzcvqW4YP6/vPdwL+tAsAeVNd2sdwwUC8
         QKisN6hUzmoNaqrzX0kLmRzhsWrqr6RK50GPezjS3QDx6r07y8DShuISj4hBwpsVD1tQ
         j7EyQdxMGcyw9awrD7xUnTGqZl0bDCze3fgSSZ3r1bLGaJjFZab33S0dglD1B8WJaFoC
         Ni5tHoAW6UC4/fDC7P5UfneFXY9+oUiAoAHygt3YVAvZ2d88jlLdSIpvE37uaK2NpkTM
         5AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lvApeUv6jUwfacMiPMy6drXUvkSgbjHAmu5eomvQtUg=;
        b=yxUkKeD5AiA6qZ2PcqV01lcLlRWcKEZsCzJWnr0KNpeGRAhcrIoNbR9sM4W6WntbMs
         bNHWJzKS/PTcQ0/jAYJx9lVWTDFNQExoIdv4KTVrDVEUJRZhEtCqQePOPKhSM+ylbSnm
         CWjerMWkn6taRd69dP2AM/wOMstffcqaZbfbrWvK3MmD280EWvpZ3isKjGON4XwvGo/M
         oqOrGKv8vO+WFtMMvwDu/Bds4gR4Y1FFJ65khLTT/fU9bHYDexD7Xq/DyoBEK6UVYF3b
         vwSQl50JiXlLid5sUXWZhq/e8jeFDjcxmmxSmV7TfbmXJCmju9rELi87N/ndxmfgC2OR
         /ePQ==
X-Gm-Message-State: ACgBeo2A5bkO4vrakRFiE/r8iGcuttANRWgOSN5ZaAVmUuapMlJcU0Bf
        m87LlLB0CIPkXIpFElYFsqfy2g==
X-Google-Smtp-Source: AA6agR61DBH568I0mLDo+jVDSq+L7cQdeSjOlgxiVpcdO0IVNeNmDu19EOP4GTt8D7im5iqsL/bqPQ==
X-Received: by 2002:a2e:301a:0:b0:264:12f6:ead6 with SMTP id w26-20020a2e301a000000b0026412f6ead6mr6119875ljw.520.1662022866710;
        Thu, 01 Sep 2022 02:01:06 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id f16-20020a05651c161000b00261b175f9c4sm577257ljq.37.2022.09.01.02.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 02:01:06 -0700 (PDT)
Message-ID: <1e19ae05-3cc2-d913-dd2c-a1c4be222508@linaro.org>
Date:   Thu, 1 Sep 2022 12:01:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH RFT 2/3] arm64: dts: qcom: align RPM regulators node name
 with bindings
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220901085609.95624-1-krzysztof.kozlowski@linaro.org>
 <20220901085609.95624-2-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901085609.95624-2-krzysztof.kozlowski@linaro.org>
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

On 01/09/2022 11:56, Krzysztof Kozlowski wrote:
> Node names should be generic and new DT schema expects RPM regulators
> node to be just "regulators".  Rename them while keeping similar naming
> style within PMIC families on different boards, e.g.
> 	pm660l-regulators -> regulators-0
> 	pm660-regulators -> regulators-1
> which creates in few places big diff.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Not tested on hardware, but I do not expect functional impact.
> ---

Eh, crap, I found few more of nodes to fix. There will be a v2.


Best regards,
Krzysztof
