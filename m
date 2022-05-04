Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD47451A2C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351582AbiEDPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351596AbiEDO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:59:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41212AE2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:56:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i5so2369039wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=84mYzsMTe/dyl52gDr1DSp/xU9OTt4BUEsYuo992Lqw=;
        b=nLOmQn4L7dWOvgrSiD6kw/szgIUo8AZyaJMMxDvDWeqN9ti8x5GNQOA5Blr+bvZySO
         hGLCs9otWcD8MhkCJBiXRndiicTCuki7PmnLF/9WOFF32oBbAQx/2Ch8mROOsx2Bsttp
         lOhqb1o9gJyLB99wyKK8Qatg0ZUb8uQ5Np/IOjwo6AUatb6J7/WFn8zlSI/j/Urg6flx
         UaJGBmk1bq07XHP0TQCMY6N9OiLbd9lQ9hyTLSG7o1bp63+PCwJghWFmaJ7rntHMJLst
         zFfkNwvClYpWY9Dtr4PwEE62h7fP2C77YmVwTzTdcQGd4Zpxp3xRcYS+Wijf7qYgMty3
         h/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=84mYzsMTe/dyl52gDr1DSp/xU9OTt4BUEsYuo992Lqw=;
        b=HJeMvfa432J9r7kHBurwcB6a9KMauKBMMK1OZHVr4GGi4alNKd12zLMVKETIxFR9uq
         wArAS4tO+YZ4AoxGgUukiXATrs6EhhVcEPtj7lfwCIHBeHeEeiJnZEDI5BE+g9fA7JTT
         u4qr9jkxDrtX3z3O0+40EEs8yh3qayWf3K8ANdXVlH15N7+xCzJopY0mv/Fzec3LqRez
         M08QKsWKC08hGYWiVyTEUmZR+xMRb1+yYLvkl3WGeSWVqmBOOGUjWuUt+5UDLvphwOeQ
         u48jdXMRQcHoKI8VgGxvSCymOrqvhWS9pfX0w9zwQ0EvCyu4j1hdDr0M3Xbforntxxqz
         UIfg==
X-Gm-Message-State: AOAM532OwXl1QgOoZOrLor4n5XAyM57J1IwrtbVpAHxRKlWx/yRFd6x7
        BUnlALSCDOpIEMnOHvX58Evwkg==
X-Google-Smtp-Source: ABdhPJw8azrV+VjcS5jEvxYkt565CDoVLK9t89YYEjBfRmKDCU7AJykQT6f1JeRviBPtrlytMwdGKg==
X-Received: by 2002:a5d:6d0b:0:b0:20c:4ec7:8e84 with SMTP id e11-20020a5d6d0b000000b0020c4ec78e84mr16735182wrq.281.1651676176338;
        Wed, 04 May 2022 07:56:16 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h29-20020adfaa9d000000b0020c5253d913sm11747357wrc.95.2022.05.04.07.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 07:56:15 -0700 (PDT)
Message-ID: <d9608f47-e70b-43bd-14a1-d03b2ca3b1a9@linaro.org>
Date:   Wed, 4 May 2022 16:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/3] arm64: dts: intel: add device tree for n6000
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, dinguyen@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
 <20220503194546.1287679-4-matthew.gerlach@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503194546.1287679-4-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 21:45, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a device tree for the n6000 instantiation of Agilex
> Hard Processor System (HPS).
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> +
> +&spi0 {
> +	status = "okay";
> +
> +	spidev: spidev@0 {
> +		status = "okay";
> +		compatible = "linux,spidev";
> +		spi-max-frequency = <25000000>;
> +		reg = <0>;

You should see big fat warnings - from checkpatch and when you boot your
device. This compatible is not accepted.

Please be sure you run checkpatch on your patches. Using reviewers time
instead of automated tool for the same job is discouraged...


Best regards,
Krzysztof
