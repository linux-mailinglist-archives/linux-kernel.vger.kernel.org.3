Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83395A9374
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiIAJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiIAJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:43:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921927DEC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:43:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m7so14675430lfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XEXQPbFYUmyLFpItRto0dJ/tByAUIKacMuPLqwHCo+s=;
        b=Gfpfg8Sf0jfSEIFCwMWjk3s/aMXgKh97v8gftg2tIeA0hFhfcr9sF82fGNdBg60CS8
         6QOTX1cQ0bOzLBNDeN0xpUCY/VfhGfKzFpUEC/anMa9dbPhSiKlNvCnaFCxks7sdT5v8
         mu+7BgT8JYpHUGRxUGpPMI/IpPmcrFmdGbmvEdNPySVhZEmZq3M1o65Xm+/1Q8KhJGPq
         gSpai+QkPC6f8g6yyRsfgH3oBouVnCSfHT3IBO/K1+1H2ytY7teisWFsxQH/6V6BC3Ns
         KeIyllpNim/cEtVMwepqRgJmRRGfFaOta1JxIPQp3zn1QG/05V5mBT1hQRJOQqnQCov6
         pkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XEXQPbFYUmyLFpItRto0dJ/tByAUIKacMuPLqwHCo+s=;
        b=CqKswYdOSm1biXIqnsedBqLG7++HM7Bm5+xFr4X/p4PsKaLL1TWWCOozj/SGX+etcP
         ldKd3PfgBQ2CU1JjUz8KsDCM4/D3VoqMmzr9Qnus/iyfltXqTXLoRndHtup1OiSVli28
         Y/9gZuTt117XiT/g978EHvjP0D1mLtV0k6yMxu6btZRBa1rc+0Xp06Vs5fc1HK7+IDjE
         jrikDiNp6TCiPvYctdV74BnNT1gLbzJZW8m8QiZrWJlGt54frd0SdqB1Mdbn/gqaa3eZ
         jEcmdZPTsjrIeJ1Xpc6LwiKd1IAmkQIB6GblC2rx3OBN+E4XBb7/6bigjiAZBTHgEZKn
         sm2w==
X-Gm-Message-State: ACgBeo11fntFM6Bv5e/s3ywsjxe2NT1f2zXrbf8JyWdlFtwKSTU6DiAt
        aa4cW0bjXMl5O+tk9O4VSesp6Q==
X-Google-Smtp-Source: AA6agR4UzJqQQVStYvJ8JDhqeBGqAZuikeg2f1LAfkytqNgMWk4O3K4J51+OxtTxriFWxC20JQQqcg==
X-Received: by 2002:a19:505b:0:b0:494:6549:ade7 with SMTP id z27-20020a19505b000000b004946549ade7mr6436821lfj.62.1662025413899;
        Thu, 01 Sep 2022 02:43:33 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id u1-20020a05651220c100b0048b4690c78esm1180497lfr.288.2022.09.01.02.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 02:43:32 -0700 (PDT)
Message-ID: <91ed22e5-41c3-8a09-101f-7d3b7555cd7b@linaro.org>
Date:   Thu, 1 Sep 2022 12:43:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
 <20220831124850.7748-3-johnson.wang@mediatek.com>
 <b1296c37-5283-81f7-1939-7ea20e1f4d0d@linaro.org>
 <1fae0c47-fff9-89e9-c849-536d167d741d@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1fae0c47-fff9-89e9-c849-536d167d741d@collabora.com>
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

On 01/09/2022 11:04, AngeloGioacchino Del Regno wrote:
> I know it's going to be a long read, but the entire conversation is on the list [1]
> 
> Cheers,
> Angelo
> 
> [1]: 
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220612135414.3003-3-johnson.wang@mediatek.com/

I see there hundreds of lines of quoted text without trimming to actual
parts, so no, no one is going to read it.

Best regards,
Krzysztof
