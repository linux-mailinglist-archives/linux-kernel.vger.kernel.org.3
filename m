Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12C84FAFAC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiDJTMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbiDJTM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:12:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7595C855
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:10:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c64so3704904edf.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ddlAouRQPorm1pzROwysoPR7lL51Rh7fmiTObb7P9lE=;
        b=h2x/dBCPYBi4ejU9G6ZBahDX6HG1fMsbUlruJMpqY007udMQrA5YMysRFTN0sAijpU
         7Hti7rZ09wHimCKthVMexCoF4gumRipaHt2uTfcjfs0Wq/+hhxV30qBzGj17cueOJ+ID
         RkGNWEJfotCbB/kv5Lf/Y7q2TYzHoOLtqxikhWJbLXdlsdEuvv3XK4dFwKMnOlkdi0CD
         n23zUIC6FppUva4QYWuDPuUAPOvsYcsuVJvU+7sNVWGMPIlzzrWlOtkE5rxNEVbJV2tP
         QL3+gLgAd1OKUKHvTWhHheMVWcfHDb1wlwvMaUrFfGcaIEMoTrmHKQYv9HY550e0NvEl
         qGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ddlAouRQPorm1pzROwysoPR7lL51Rh7fmiTObb7P9lE=;
        b=z6QnKTSHf6oyov5t5QaJ4pNOLPQGkrp4BwL4UHkDC2Wsn6pCY0H2h/wcHaW0pG1NCe
         EEUS3htBLsdCsE8kbUX8BarRD5YHr2FwolleSErdk9kOXzQiyttW53WRVBhwhCZFf3ce
         TNNdhqirEK7vKE793kzlnSDEWTH3OGBwK77lTKlD9uG4Io/OJTrtpWe9mIvWFI5hLZvh
         D1pz+vwnVy5sDRRxuGECwZgmu2QxWQQlhttsJGXvlD3Z/6gcOXTMfU5PM94ZoKYns4uX
         V565bRTVqbKjBVW0gLwGVje4r4CvTbPE4/vszwZ4W1yMrGYogrcah0LzPP2eYoWuAyon
         /pVQ==
X-Gm-Message-State: AOAM530PztkI+/c9jPtEvjAUyIZJuFJE5Vvy6UajE2CrdLLwyiU7oRzC
        +GvNid8ZX02HBq5in+JGP4ByoQ==
X-Google-Smtp-Source: ABdhPJwe/Nizy6VvIILFSWuWCcmerVBLjfNCV4S9gJHr8sZZ2U9X+0kRfrTqgtTC9IoeDQY9nI62wQ==
X-Received: by 2002:a05:6402:1e8a:b0:41a:4242:7de9 with SMTP id f10-20020a0564021e8a00b0041a42427de9mr29806873edf.284.1649617816388;
        Sun, 10 Apr 2022 12:10:16 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906c00c00b006e66eff7584sm9708203ejz.102.2022.04.10.12.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 12:10:15 -0700 (PDT)
Message-ID: <45c22de6-9a48-12d4-7c11-944861060aa8@linaro.org>
Date:   Sun, 10 Apr 2022 21:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/6] ARM: dts: qcom: ipq4019: User generic node name
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
 <20220410175056.79330-5-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220410175056.79330-5-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi   | 4 ++--
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts | 2 +-
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi   | 2 +-
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi   | 4 ++--
>  arch/arm/boot/dts/qcom-ipq4019.dtsi             | 6 +++---
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
