Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7A04DD9F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiCRMv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiCRMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:51:55 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5481ED063;
        Fri, 18 Mar 2022 05:50:36 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w27so13947724lfa.5;
        Fri, 18 Mar 2022 05:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OJu/+DhwQ4TG5+tIH51Zo9ItsMV5oal9aAoPrsbEoi8=;
        b=ivXnSLtpOGaIMauHdRM7eGDHaDKj4RnX9Y5YODQ/G2BpToJJ/iSCriA4Z73IjGOUFW
         CkaTD2E7qVV6Ws4S3b1s5UIoYQdp3D88wgpeUuoSQHSeby/wn3rX8mB5wnKlluOFL/Iy
         vQOECIiWHAGdNJVmiWaFxXaURFd4Mkfu6Sg4RRCH1n/RUlh47A4Gc+M8z3gCsRIBBr2B
         fPMEcMNv1504zycsJa/kRtGAIqU/9GSoVI2N9kILL8W+lQLkgh/3xe0LPCscU4QQCQNl
         lxnCC0ohEio6ttxL4LpB+uC4b/K3EGaD66qQoSbiyZyB7UT+DJ4mARz2LQgymBrnrOE8
         zelQ==
X-Gm-Message-State: AOAM533etmiwV4+u5ehRl8XNCzQ05+3NpZGaIFAdZpFm2miXeLRwcNFy
        CzzbQAZ7L2dyYuefQLXvl68=
X-Google-Smtp-Source: ABdhPJyBkRrx7Z0uNMyc5zszBSpP9QRiZv8MKDpJewRS/0i0lodNGcX5PhVl8kjtJW8JfRMm+lnuWg==
X-Received: by 2002:a05:6512:3981:b0:448:40e5:cf90 with SMTP id j1-20020a056512398100b0044840e5cf90mr5632455lfu.656.1647607834839;
        Fri, 18 Mar 2022 05:50:34 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id v21-20020a2e2f15000000b002456e6cdab2sm944860ljv.93.2022.03.18.05.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 05:50:34 -0700 (PDT)
Message-ID: <cd976ef0-767b-8cf0-8635-28aeaa6542a3@kernel.org>
Date:   Fri, 18 Mar 2022 13:50:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 1/2] dt-bindings: mmc: sdhci-msm: Add gcc resets
 strings
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com
References: <1647532165-6302-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1647532165-6302-2-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1647532165-6302-2-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 16:49, Shaik Sajida Bhanu wrote:
> Add gcc hardware reset supported strings for qcom-sdhci controller.
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 6216ed7..f180111 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -62,6 +62,10 @@ Required properties:
>  - qcom,dll-config: Chipset and Platform specific value. Use this field to
>  	specify the DLL_CONFIG register value as per Hardware Programming Guide.
>  
> +- resets: Phandle and reset specifier for the device's reset.
> +- reset-names: List of reset signal name strings sorted in the same order as
> +	       the resets property.

Please list the actual names used in reset-names.


Best regards,
Krzysztof
