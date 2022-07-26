Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B83580C03
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiGZG7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiGZG7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:59:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBEB2715E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:59:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z13so15115467ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uYNyGTqh43kdnBvGIItlfjBuqOczPcK4t5svoUE++Sk=;
        b=FfFsLA3qk43d5a5qjKaYryUjbhcodKmzeaS/64zv+PlvlACHk2cU7U5gNjgXVaJq21
         ozs0wzuICeMTbfMjAoMUq3OOLcpIkakc711DZDckxWDVUZgPZGDjQ2o56MKLXE+Rawsi
         h/z1mnlrEsLtwul05QNDC2cpPh9v0zUHrQDGkOrD0/9Wx44X2RTaTicJM4/nToBLisYP
         TCauqvodKluV4JKUJWaNZbchYVJ+TSaLGWUDPPOpIS0IiYzAFGXJMcK9gSjgg7NpDdzI
         lGB1/s0lb1Jukc0ERp4c8SlS6ejoI1CvdRcbbuR1wgAY+6Cv6tErRjE9H9QodX9zklSq
         pWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uYNyGTqh43kdnBvGIItlfjBuqOczPcK4t5svoUE++Sk=;
        b=tObuQX+Uli0VAZKkHJ69GEoPYr19VabX+7MYMfQoKBoxXBxBeBSMtjOKsnL8RltH7i
         MKRHjiB45dpS8K4yGwL3cLfFbI3qlWPWq95ppohidoLFh5914BMfxzgpe41upZH0q1Mg
         HFFw8X2mtJJCfTAsa2gbD0wIZflVTEUD39k7QE7CQXzSwvrp/Ei33+9wnJR8GTYxpZ5I
         7AMxppbwPm8msthxqEqzCeHYvRc/neGfEWMgIVOPWP6taJTb0ljVGRD2nSjfkQDIX+vB
         P/fkuIT9H8e1oKUSHrgNhjwltjDtyGCLZGF7oBrTH/fpLwoU8wk3iFthIYryeZe5HCT3
         IZ0A==
X-Gm-Message-State: AJIora9Yjj1aVAcWR6870u76Zyqbu45D8lWD0dvC4d/94MXQiaFHt5QA
        GVUOr84tUgtlDMpWC6R+QLPT+g==
X-Google-Smtp-Source: AGRyM1u8ak2tbwYve79n/McQbM8lAlJlWuSclfCpYDvx6NrH3khnSpB6imATgjsFjzlpYIaUsp7Qhg==
X-Received: by 2002:a05:651c:504:b0:25e:c01:47c1 with SMTP id o4-20020a05651c050400b0025e0c0147c1mr1971100ljp.65.1658818752327;
        Mon, 25 Jul 2022 23:59:12 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id g22-20020a2e9396000000b0025e0c352498sm687352ljh.129.2022.07.25.23.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 23:59:11 -0700 (PDT)
Message-ID: <8b69b813-d030-2666-37f1-a731b1d52f4e@linaro.org>
Date:   Tue, 26 Jul 2022 08:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/9] Samsung Trinity NPU device driver
Content-Language: en-US
To:     myungjoo.ham@samsung.com, Oded Gabbay <ogabbay@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Yelin Jeong <yelini.jeong@samsung.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
References: <CAFCwf13JA+5vuAKqvBSs3MkcF-gbE_8vd9nSvStQga55vW80VA@mail.gmail.com>
 <20220725065308.2457024-1-jiho.chu@samsung.com> <Yt5cFBgiTLwGXv17@kroah.com>
 <CGME20220725065308epcas1p2f6de3d74792854bb312cca4b310badac@epcms1p5>
 <20220726020952epcms1p59c06fabb55776e195dcbeac549c98ef7@epcms1p5>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726020952epcms1p59c06fabb55776e195dcbeac549c98ef7@epcms1p5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 04:09, MyungJoo Ham wrote:
>> Hi,
>> Why isn't this submitted to soc/ subsystem ?
>> Don't you think that would be more appropriate, given that this IP is
>> integrated into application processors ?
>>
>> Thanks,
>> Oded
> 
> This series (Trinity-V2.3, V2.4, A1, ..) is being integrated to multiple SoCs,
> not limited to Samsung-designed chips (e.g., Exynos).
> It's a bit weird to have them in /drivers/soc/samsung.
> 
> CC: Krzysztof and Alim (Samsung-SoC maintainers)

If it is not related to Samsung SoCs (or other designs by Samsung
Foundry), then it should not go to drivers/soc. Based on cover letter,
it looks this is the case.


Best regards,
Krzysztof
