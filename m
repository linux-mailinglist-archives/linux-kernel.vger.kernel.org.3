Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BF35A3620
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiH0JCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiH0JCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:02:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF2D27FC8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:02:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m3so4803809lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=tSaAKzb5w2T65/FdcCDzvyichDzNAon3GE1pC83jdZw=;
        b=ZuHqxfOwCkZJccxT0l2+1PQB9D2ShACtEkwkvAlIMBiKEretjxfkSm23NhSBLPElSO
         B+rS8g7boSspb0ecSDz0Zmzh2G5ymNIxDtCLQ2+U0KWCQZr3aXRyvovfelhSb+5e0whg
         RSLSh6y5FVe4SM1fknKno8wTjeUXZoKKluwztePVJDdbwfSIBTsHsxexv7hCxt3qPhbm
         JKFjcaM7/4OEdpt4KjUjXuU4pm42B/FLD2GL/elgXmPHY12wAm3dYP/oP58rZY4basrX
         yrX3bog1/3kCD5IGmYOFNfW6Sufs2wWUKxh9IvPtP7TDPl2dZsmaZXMOigzIsjUOHmre
         guSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tSaAKzb5w2T65/FdcCDzvyichDzNAon3GE1pC83jdZw=;
        b=nf7ZlcdQWFkJiKhNqOJ3fgs8x4ClZSheXaD/TMstzSz3EoFiccu4IR8vVng4gVl4qi
         hfZFvm/yIpIVpu72dCk5IEl5dbRl81p2H1PjCiCLdoO+LAk61ddYpoxeXtMEyG40oz6u
         oJSzSlzXg8oUju2urWQYotm4mvUTOksqp8pLzuJZBjjAQnc8md56nJZKLICYaY/8b51j
         62EHebbG34X8oxAtbu1aLSky3UUAuTveCbYJfDfLcpIG7MDgGZbodrxJ6qwXwq6LnIze
         EcwRCUh8DHLIO1//rxrWlX8YY9q6DjkLJ7JpaYQdUvgFJ3SMzzcQMtZ/9ET9kcNksJWJ
         IzOg==
X-Gm-Message-State: ACgBeo3GMpxZARoUpe/XetO3B/v18MzlrKGq4JqLsZNFIJ59dKebluym
        pXqvnfXc3VLkO8QQSyyRDqjouA==
X-Google-Smtp-Source: AA6agR6avMqu4paaaH5+k+RySA/u2b4JKe9lR72DOYOCmGAfXBduDProOI0ZX5APHtMKUGMpWcAGYg==
X-Received: by 2002:a05:6512:909:b0:48b:954c:8e23 with SMTP id e9-20020a056512090900b0048b954c8e23mr4023915lft.670.1661590964241;
        Sat, 27 Aug 2022 02:02:44 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id z14-20020a0565120c0e00b00491ee1bf301sm618807lfu.39.2022.08.27.02.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:02:43 -0700 (PDT)
Message-ID: <a5266af6-af19-48f9-8bc6-94c171ba6d0c@linaro.org>
Date:   Sat, 27 Aug 2022 12:02:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ASoC: codecs: allow compile testing without MFD drivers
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220826093659.1059276-1-krzysztof.kozlowski@linaro.org>
 <YwkSi1IIRsW2Hc/u@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YwkSi1IIRsW2Hc/u@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
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

On 26/08/2022 21:35, Mark Brown wrote:
> On Fri, Aug 26, 2022 at 12:36:59PM +0300, Krzysztof Kozlowski wrote:
>> Motorola CPCAP, Lochnagar Sound, Rockchip RK817 and Qualcomm
>> WCD9340/WCD9341 do not depend on parent MFD driver in build time and can
>> be compile tested without respective MFD part for increased build
>> coverage.
> 
> Although generally it's easy enough to just turn on the MFDs
> themselves, it's not the same base platform issue as the firmware
> interfaces can be.

True, it's not the same build coverage need as subsystem/interface
dependencies, but still:
1. Drivers can be built independently, so why not?
2. There is no drawback in allowing to building them independently
(compile test).
3. The parent MFD device could also depend on something (RK817 and
MFD_LOCHNAGAR depends on I2C and OF; CPCAP on SPI), so it's not always
the case of just enabling parent. IOW, you can compile test codecs
without I2C and SPI which is valuable itself.

I find the last reason actually quite valid and applicable here. If you
wish I can add it to the commit msg.


Best regards,
Krzysztof
