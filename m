Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F0357325D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiGMJV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiGMJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:21:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46901F2E0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:21:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a5so14598290wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EuZkOhoO/lITrLjgkVjvwTGd6HeRto8WBI5Hh6eby/E=;
        b=lxpzLzJ2shualTR8sKZ9gN8OZks8zFo0iRo8BFAcwp2FMZRwgNsO18oikVjYyQKAgo
         rMuIfcGIahdIM7l57u7/mG2Gyfbio0+KR1Oz7FgpVdxwH1ipuYjoMqUEprcgbshmg9rv
         ELVKBizg2Y4CeidKhYIpjGaHNID9oH+ewrBMb593FOh+UJzGP1hL5cYBTi+mzIKN+sOT
         F9WCYfbuxv0iLvoi0ehIrM9WMzNkqKLSDIMeLxG6xGLvevHOPaEeuGHX3N4ajNUMwzi7
         jSAiaKaAwlIEyUsWxYZelMhXFi396sA+dTWjbi/W9Ex/hsM24+LrcVFxpicpVyV32ny2
         NnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EuZkOhoO/lITrLjgkVjvwTGd6HeRto8WBI5Hh6eby/E=;
        b=69Qcrl/ycmUuZGKEZs63Gp9ehtMtKP3ZbTaSt0R4PxieQuyDgTl72V4vMi9RVuFzND
         5GmQtiMSgwdqOqpNsI4AjIiu7Z0T12aNN/wJSLX101ulzMXZcSEDbnHZbbEAuJHDW99x
         yqolhL5Zv1OhF86VbwO93hKiVYWM/Ozm/3GqYIFg0fX4Cf7BFxfvd+BT8/Q/VXTx1Qo3
         KIhKUCde4S/Qlmcm5n79RflVILQxJIuCzBDa1vUpZ1C4DLdgez4HC78XoO4cOTIjfMCx
         nC01mzCLMKMbulhib42110DPzmsoXqESW8yuV7tEaAErwsNdsDFX44QdaHE6EJIBRN6Z
         CqkQ==
X-Gm-Message-State: AJIora91gst76FTs9l4Kur6CtgLe3dpvTgQ9dPM3qhbvU+DoYkkKfM2P
        BsLTEJWRYnvbqiRNTsnxE3NoAw==
X-Google-Smtp-Source: AGRyM1uJ6l9+mYRUMQdWMVEP6Jn6AiXmM/gA+u1wvU08eiSPFXbHEqDDa7FPwtSdpFEBibAvtahShg==
X-Received: by 2002:a5d:588b:0:b0:21d:a918:65a5 with SMTP id n11-20020a5d588b000000b0021da91865a5mr2285506wrf.210.1657704084868;
        Wed, 13 Jul 2022 02:21:24 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id j25-20020adfd219000000b0021d7122ab80sm10359669wrh.110.2022.07.13.02.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:21:24 -0700 (PDT)
Message-ID: <3a1eea1f-b598-58ad-60a6-c76b77cb08c4@sifive.com>
Date:   Wed, 13 Jul 2022 10:21:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-4-ben.dooks@sifive.com>
 <fdef31b4-9c27-ddda-f1e5-ee881812aa4e@linaro.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <fdef31b4-9c27-ddda-f1e5-ee881812aa4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 11:08, Krzysztof Kozlowski wrote:
> On 12/07/2022 12:01, Ben Dooks wrote:
>> The dwc pwm controller can be used in non-PCI systems, so allow
>> either platform or OF based probing.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-synposys.yaml | 40 ++++++++++++++
> 
> Bindings must be a separate patch. Preferably first in the series. Use
> proper subject prefix matching the subsystem.
> 
> Best regards,
> Krzysztof

Thanks, seems counter-intuitive that one change is split up like that.

-- 
Ben
