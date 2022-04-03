Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAC4F0AE4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352651AbiDCPsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359297AbiDCPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:48:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D73326FA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:46:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p15so15214619ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LYx9vbaJPUNdfXIS3EFqUowucY1MMBbJcAD7xxWwqJE=;
        b=GuOF2PiN5v6qm6pExziHFvW4NdmAjiny9z/M6GcZpXDZKd0K/Sheld7Y/npC8kwQzn
         WTOhn0orR6bhXrTXHHvrOFtFBKOa7ayOBrjz9wO+twHhfLGQOgUPH3jOw9A/rNCmEd7g
         qfHF2iCJuXZiBTohCS2oxZ0wlBDUC4x67B7v4U77st5XXJ6/g1AUTOJ7+Pp52Bxi1yo8
         VB6gCnpDBYIHonW7N1RoAv4ycf31c1orsDEs8VcmuouO8oUheOr7ewScqKfvQWavpWYP
         wy/bZ7kF9Mf4qLrKk7V4+ZY3zYh4vmKOCFduwJbWfF7ZOiXAuTaFfxymZbCCgfpUhtrE
         eeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LYx9vbaJPUNdfXIS3EFqUowucY1MMBbJcAD7xxWwqJE=;
        b=hVdaIS69NlbU+gQfGfiyoL7+afAY77pYJbue2LuAYDHG9+R1E4f4OWc1ON9WqgvXLk
         gNni6R6IQp3t1oR1jIl8VwbdRZCVF4zQdANPha8THhfb16ERwFcdnQ2QmffcOQFf3uU2
         rRBKr3Tzi0AOXZvFnaRYef/RdO38Kf/QC5a3h4+i0CCi/O4b9tV3t9hc7+e7OjqIh2G/
         ZYVARtaIUuYStgNgVH6Z956/Xqm+veXHu1D1X4xVaYOVOpclH7Hyb1mLbSghauUs90Mc
         Pi+Wqgwx8QMSLEm3tRwLklYm0l91beLEo83RYZRl0HRzL1b17sdRFtFEJXQiX+QG/79p
         aAiQ==
X-Gm-Message-State: AOAM531milA0I0ugT7eq3qkTbv+mJwnk8uPtFD0sw6M+ZdLsmEM8Y4gg
        agt428KuB/2Kj/EF2LzwEbXolLD5DdZjiszm
X-Google-Smtp-Source: ABdhPJzSrJadXrXyXG9O97k4Y19sD2+YhsQWeyluUAWQqPHBO7iuX4dgBHMyyAkRWvy9+4Ox+RRtEA==
X-Received: by 2002:a17:907:3f07:b0:6e0:2fa0:2482 with SMTP id hq7-20020a1709073f0700b006e02fa02482mr7423607ejc.766.1649000766507;
        Sun, 03 Apr 2022 08:46:06 -0700 (PDT)
Received: from [192.168.0.172] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id cr19-20020a170906d55300b006df6b316e29sm3325521ejc.208.2022.04.03.08.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 08:46:06 -0700 (PDT)
Message-ID: <50934ae0-0863-ee8a-0e7b-295be2286445@linaro.org>
Date:   Sun, 3 Apr 2022 17:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] regulator: dt-bindings: maxim,max8997: correct array
 of voltages
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220331211653.175200-1-krzysztof.kozlowski@linaro.org>
 <Ykm5IG2EUUSSotUF@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Ykm5IG2EUUSSotUF@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2022 17:11, Rob Herring wrote:
> On Thu, Mar 31, 2022 at 11:16:52PM +0200, Krzysztof Kozlowski wrote:
>> uint32-array with voltages should be within one bracket pair <>, not
>> each number in its own <>.  Also the number of elements in the array
>> should be defined within "items:".
> 
> Which encoding an array uses has been a source of pain.
> 
>>
>> This fixes DT schema warnings like:
>>
>>   maxim,max8997.example.dtb: pmic@66: max8997,pmic-buck1-dvs-voltage:
>>     [[1350000, 1300000, 1250000, 1200000, 1150000, 1100000, 1000000, 950000]] is too short
> 
> These exist due to the move from validating yaml files to DTBs and I 
> haven't come up with how to fix the warning. The schema was correct as 
> it was. The change leaks the encoding (everything is a matrix) into the 
> schema which we don't want to do.
> 
> The issue is in the if/then schema, the tools don't know if the type is 
> an array or matrix. It gets it wrong (or different from the top-level) 
> and thus the warning. I think the fix will be using the extracted type 
> information to do the right transformation. The code for all this is 
> pretty horrible and I've lost count of how many times I've re-written 
> it. I think a lot of it can be removed when/if support for yaml encoded 
> DT is removed which I think can happen in a kernel cycle or 2.
> 
> Perhaps in the short term the example can just be removed or commented 
> out though that doesn't help on dts files.

I think I already might be adding the same pattern to other bindings I
convert, so maybe I should add at least comments to such cases so we can
fix it later.


Best regards,
Krzysztof
