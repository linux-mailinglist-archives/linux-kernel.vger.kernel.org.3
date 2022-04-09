Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D944FA7B7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241775AbiDIMkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiDIMku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:40:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40A713F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 05:38:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bh17so22132687ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RpLyscpqKBQEV+cmacPi/7pfMk8oHHCQkm4XjyfCevc=;
        b=RdCyKrtrX2Rcr0qXPucOkWoOPqrteWZ8e1231DTVEXDqieB9W/gDLDJKLBw4F+h+7e
         qblKAIqF5cpaPgjJEcsA6h/SNBLKYmq+lzQhbuc+haicD80IIFipzBgPmwyivFaM1k4K
         VuFLCB6lOCo5CYZEpk9gNVUfsCFzNgFgjzcJls3Uxn+JWf2ke6tJpSYg1TX1Th31QT9o
         gT8oEUou3QzvIGveuZEdafwbaZ/Vto+BDGH/U3AxtwLMJCsMvlsFvjdnPmIV+KOU8fH2
         rrpgPDDVZAUdLYVr2Mx5MvdIYEvT1kMhxuuKtLcH4bKHez1mrH8cF5xlHrBqIQVBk7ju
         Hf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RpLyscpqKBQEV+cmacPi/7pfMk8oHHCQkm4XjyfCevc=;
        b=5jrnRA0R2O9a86u/VE/FJ91Br3sq7JIPAacmfLSO876KDixNnNS7nYHAjL56AL0fTE
         OI2poKC7lzEnJ8ygmrIeTBxMpBd3JpXJdCXUQW15aDw7+NxoiojFhZf1Z2GoK41BFz50
         4Rpr5BkDllvaduKVMjVGlz5igMDIUc1o6FIdsQkTNMse3lxnJIrigLjjDYVone6sddcG
         e2ApgeXC5h8lw5SlA7stOkCJY1P52d2drzdjAv9G3gO8Z0Kqh6CDDqoaJTcg1PnhyOur
         ErjynLtT6uaWztQFZQ+lCZ6xw00yC61v/9J5zy75QqWtYB/kHs78sVl5U3SyA3mnPs/p
         MzlQ==
X-Gm-Message-State: AOAM532UnhmOpShWQLVy+3OvPWC8h+SpvGnpXxOi8fTcxIaYuFle0ZJp
        rzGOrNXcvmCQTZMtjjLnBHcZLA==
X-Google-Smtp-Source: ABdhPJzY77DKPWSpLOfOBDiyAdMZSgLaeO04wDaxNJN64pBlaiA5gtbKwhFYaFWLNIZOU2Xlrgr92A==
X-Received: by 2002:a17:906:6a15:b0:6e8:8b:bead with SMTP id qw21-20020a1709066a1500b006e8008bbeadmr23445325ejc.650.1649507921203;
        Sat, 09 Apr 2022 05:38:41 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id d1-20020a50fe81000000b004197f2ecdc2sm11671603edt.89.2022.04.09.05.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 05:38:40 -0700 (PDT)
Message-ID: <a99d947d-418c-3f70-6b1a-a90d300604eb@linaro.org>
Date:   Sat, 9 Apr 2022 14:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/18] MIPS: DTS: jz4780: fix tcu timer as reported by
 dtbscheck
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <c48277625f0ab5afc86d89deb1b87537e9c592f6.1649443080.git.hns@goldelico.com>
 <e5ea96d8-f8c9-b925-04ee-81e80e30a5d0@linaro.org>
 <1TN2AR.Q91IJNXMNNNA1@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1TN2AR.Q91IJNXMNNNA1@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 14:24, Paul Cercueil wrote:
> Hi Krzysztof,
> 
> Le sam., avril 9 2022 at 13:11:48 +0200, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> a écrit :
>> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>>  arch/mips/boot/dts/ingenic/ci20.dtb: timer@10002000: compatible: 
>>> 'oneOf' conditional failed, one must be fixed:
>>>  	['ingenic,jz4780-tcu', 'ingenic,jz4770-tcu', 'simple-mfd'] is too 
>>> long
>>>  	'ingenic,jz4780-tcu' is not one of ['ingenic,jz4740-tcu', 
>>> 'ingenic,jz4725b-tcu', 'ingenic,jz4760-tcu', 'ingenic,x1000-tcu']
>>>  	'simple-mfd' was expected
>>>  	'ingenic,jz4760-tcu' was expected
>>
>> Trim it a bit...
>>
>>>  	From schema: 
>>> Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>>
>> You need to explain this. You're changing the effective compatible of
>> the device and doing so based only on schema warning does not look
>> enough. Please write real reason instead of this fat warning, e.g. 
>> that
>> both devices are actually compatible and this has no real effect 
>> except
>> schema checks.
> 
> Well, if the schema says that it should use a particular fallback 
> string, then that's what the DTS should use, right?

Or the schema is wrong. :)

> If making the DTS schema-compliant causes breakages, then that means 
> the schema is wrong and should be fixed.

Exactly, so the commit needs a bit of explanation why one solution was
chosen over the other. BTW, I am not saying that schema or DTS is wrong,
just that commit is not explained enough.

Best regards,
Krzysztof
