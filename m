Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F274D58C57B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiHHJVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242015AbiHHJVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:21:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDD213FA7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:21:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq11so11792070lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FccXBTNykxjVSFhKJvR6sgQg52SL6XIJ9Oc0djERUqw=;
        b=XR0I8TNP0FJq7M9R6lesad9vgRFZWfsgcdBiYdcKrJVyoWUymdBn3VzVf+tbhOVjyU
         16XtvRpfIAyV303x8dcAmtkDyC51hJJHVEWkfYbNWb8LuHUcwVvxEQnfJwG00azOigyg
         rXL3y1RJZIrfBaW0xhXpk0nqx/OHCCt1Nsb438WjaKKwj5biV2X8ax/9Jfc0CI0QQWUn
         zL4QugyOzQmkJDJveDxnVahY3motE8CZ5od9W+Br6NpKPve1cWmJauLDcOcAxk3+tJHu
         1X/ioocLEUhwk7gnAKqsnP79K6FjC73vtrn8QLiIf49Qwo56zrnz7pTMbb30zeSXmjHL
         L4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FccXBTNykxjVSFhKJvR6sgQg52SL6XIJ9Oc0djERUqw=;
        b=IiWpcUpdlppJSblTcAr5YLr2JUZzL8QedmuQ3OO9j1nSdQyevKSlqsIqf3ffU+lXK3
         HySqoi2JKD7GUSsycNkesX8EP+5UhElIe2rxtP0yoGTVB+ENUS9YTbKU00YF1GxLIOg4
         2kHmIFlsUJgmKO3WsDkT8NtFrdhCyx238cLuCrxPge4OZfUWntht0ebZMgkmrI0/c934
         VKcTimmhk4i32DfSwc+2pJ94N1d32Z6wNuxRusy7/vz74UvNgjQ2liCzZSxeYKtMDmkL
         EpNxIMY/XssN6ncS9Bi28J0wUZuEANe3/bq/N63vzEDz5gleKG9IQMtMuh4mW47vKAYO
         cZ0w==
X-Gm-Message-State: ACgBeo3/0JGQPkDt3zxhw/ctu4oIT6F4qbBfzBOG2/PB7iAS7OxRiUe/
        C24zu1ejteOg/Age//dP4h9Pog==
X-Google-Smtp-Source: AA6agR43ns/ayyEzaw9XITjxIh6rxgbPxery0gWFVIkbcFtX3ekcRkYMzHLww2EqZ1vh+mK1tRWSOw==
X-Received: by 2002:a05:6512:3b8e:b0:48b:23c6:9b0 with SMTP id g14-20020a0565123b8e00b0048b23c609b0mr6439516lfv.470.1659950499307;
        Mon, 08 Aug 2022 02:21:39 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id m2-20020a194342000000b0048af85f6581sm1352791lfj.154.2022.08.08.02.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:21:38 -0700 (PDT)
Message-ID: <cb74b5e0-2243-5afc-dd8e-7b024ca3e3da@linaro.org>
Date:   Mon, 8 Aug 2022 12:21:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] arm64: dts: marvell: Add DTSI to fix Xenon SDHCI 2G
 limitation on AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>
References: <20220806085818.9873-1-vadym.kochan@plvision.eu>
 <20220806085818.9873-4-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220806085818.9873-4-vadym.kochan@plvision.eu>
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

On 06/08/2022 11:58, Vadym Kochan wrote:
> +
> +	soc {
> +		sdhci: sdhci@805c0000 {
> +			compatible = "marvell,ac5-sdhci";
> +			reg = <0x0 0x805c0000 0x0 0x300>;
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cnm_clock>;
> +			clock-names = "core";
> +			marvell,ac5-sdhci-dma-bounce-pool = <&sdhci_dma_bounce_pool>;

Undocumented property.

Best regards,
Krzysztof
