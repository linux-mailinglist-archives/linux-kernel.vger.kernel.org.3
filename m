Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA83A4FAFAE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbiDJTM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiDJTMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:12:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F7160CFE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:10:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c64so3705844edf.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N8ogQDlkv/YncYDLitO+ZzY4zCeqZnsOOoWX3crcddY=;
        b=biDtNxdPPd1Cssfs5BTWVtn4W5wFEfaXWB/8o7xryYj8kILF7pFw7xQ0n6ZVhH5Bii
         kONLXZKWGRDsDGcHsGlQ4eWMTukRMTS0qhk7iYYXJ/3kwvIGqXAxJ5QE7l9z1FjYwDHx
         97x8ywJ5NwpbQMDyodmOhk0LO92jRjRP8w6ClVeBD5vz7nftv4z37IUPzkW8mezlmbbG
         eTWnIKyf4/kXolW9rFHinul/xLFXHWnTlar006wUH8H3b56sqTx8WQeoxhpBUma7GnS6
         fVfylszT/LVBlHmIEx4RLCBffwBFtGII45r6DbmwLQXeZglpeRh2xKLjQKl7nX5uiHC4
         IP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N8ogQDlkv/YncYDLitO+ZzY4zCeqZnsOOoWX3crcddY=;
        b=aFuoT0bLhN4FZkadWYCiN/ZodIT0QZ06C1cFiTJl1lxpIS7NozWzKjxtVtPNuiTJR0
         OOK27H4na/n3kT6iDZj2TPAT4uLZNgZX92yPHkqCP5s93ekqjqEOISEFTtdLyK2NXVTj
         jmAnfMqEoh+lZaQn8xFeY0Vti6oYhYhxRKKGbgHtZIvv+yeObiZNfXjcU/0GF+vpyveL
         DEX0HYL/ZUl/LeERLQiYAQA2WiREtlYsKcbQuMYtsWgWahWEg0vvFbqC+Sb2rJkNDHvk
         jp+wXVFyFe31mQVGEUKTCFV4aNaQ6FUJNjdl/Guy/wOvEDDW7Vg90Zjfm2iqOvmd8rHT
         Kd2A==
X-Gm-Message-State: AOAM5335M4mkk+mfcQ1SiZQQE4wmdS/Ml3vUg9qBxadfTcWH0/BqxbXr
        aZy4qMZ/nAXmLPIkEbJC2dAn1w==
X-Google-Smtp-Source: ABdhPJwPYAjKWOeMBZg9+TfHTBh8t9CBvZTbit/20elRwUocnWp4J4XZic654M9df1XmEKYLZWL3mg==
X-Received: by 2002:aa7:d494:0:b0:41d:704f:7718 with SMTP id b20-20020aa7d494000000b0041d704f7718mr7120246edr.147.1649617840574;
        Sun, 10 Apr 2022 12:10:40 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906040200b006e84213fdffsm3706692eja.201.2022.04.10.12.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 12:10:40 -0700 (PDT)
Message-ID: <b480ec98-3538-43d7-0595-afe859d40a77@linaro.org>
Date:   Sun, 10 Apr 2022 21:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 5/6] ARM: dts: qcom: ipq8064: User generic node name
 for DMA
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-6-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220410175056.79330-6-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2022 19:50, Kuldeep Singh wrote:
> Qcom BAM DT spec expects generic DMA controller node name as
> "dma-controller" to enable validations.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
