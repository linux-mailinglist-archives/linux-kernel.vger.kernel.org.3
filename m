Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D83C5670C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiGEORz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiGEORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:17:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D51B61
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:12:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so3201994lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=96uT2/xHI+gJvTeOzSVEvKEVuYL1WzZK+F5WRMOqgPU=;
        b=EgHA5JrPLft/X3CFmcSgTwtTvECDveakN/2eQwLizukZ1zwsResj9IHMN3FSmmNZqH
         5esk68KrdSVQGMTMFYDbvKW8hYaxKcvG0DBhIN+03JfXtTRd4Xb/Eg5EWC6cuHTq73rL
         jjTDdg0IDX4s+Y2Cr8LRrseVutTmDARy/lobgDKmKk9vQanpAxXEuEzAQU/HEG/tw+J5
         /6h5DDeXqawo434PwFTi9OcOBTEVHxswPjQEzOwB8CuCRE7eLhx9/NsJJ7d2maK9ekQ6
         CjVey19X3C1BavDYQ8HPLTDw2tVIOKNNklPMaqfkKplUCccgSYePn/a0/JFdi5eQJjsr
         Rjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=96uT2/xHI+gJvTeOzSVEvKEVuYL1WzZK+F5WRMOqgPU=;
        b=3h8b6puv/b9rSsRBvrXMZvnhpDYetSo7wTGQQRu/EMjR9flAcMOppWviOzY3Ur+pmm
         KYivOet5WQm4nDxT9AftVCX6rrE/mevnZSV22ToxdoYMIKhESL4VXVwFIYNZSv+5aLah
         dTFNazGaLghLW9OTTzQ8yq5/+kb16Vs00gXzVyXJiwjV7p74NfJEHIB8jb+Sl8ZTdSAO
         6XyE7SJ5m/oA8zzabNlzx59mAX6rRVzsfH1shtlgoARqJfjJhTmTn/9lNEl759FoTLad
         nc1kHftgctlVeVxh1ncIjZMt/c039GGkFq5yoR9alS1wZac/pBJVhyJKDNPArwo40MaF
         jf1Q==
X-Gm-Message-State: AJIora/6rSFy6pwm6DnkSUjvvV66jFbDC1AXTzW3rgx2kFHvPcAmhT2M
        lY0cRIoT9WuRcv4SdIhqhncm0Q==
X-Google-Smtp-Source: AGRyM1ucI0R96J38sx4KrEcjCZdRo4b5u4rRdvgJC2EhgCpkX68hj/jPkm7aCy/l7c0q04uk3jbg7g==
X-Received: by 2002:a05:6512:224d:b0:47f:7812:d135 with SMTP id i13-20020a056512224d00b0047f7812d135mr21506046lfu.29.1657030360658;
        Tue, 05 Jul 2022 07:12:40 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id v6-20020a056512348600b00478f2f2f043sm5719610lfr.147.2022.07.05.07.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 07:12:39 -0700 (PDT)
Message-ID: <be521f90-97ce-c61d-d7d6-8f2bde24d824@linaro.org>
Date:   Tue, 5 Jul 2022 16:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Han Xu <han.xu@nxp.com>
Cc:     Bough Chen <haibo.chen@nxp.com>, ashish.kumar@nxp.com,
        yogeshgaur.83@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, zhengxunli@mxic.com.tw
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
 <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
 <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
 <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <f33ad190-f5c7-d9fa-088b-5538ab1f4d59@linaro.org>
 <DU2PR04MB877492F346BAA10B2AA7428497819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <62f113a0cdb0d58bf04ab0b274912eb7@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <62f113a0cdb0d58bf04ab0b274912eb7@walle.cc>
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

On 05/07/2022 16:06, Michael Walle wrote:
> 
>>>
>>> I think you could use here clock cycles or clock phase, but then it 
>>> has to be obvious
>>> it is that unit.
>>
>> Hi Krzysztof,
>>
>> Let me clarify it, in the document a term "delay cell" was used to
>> descript this register bit. Each delay cell equals "1/32 clock phase",
>> so the unit of delay cell is clock phase. The value user need set in
>> DT just number to define how many delay cells needed.
> 
> Then should the unit be "-degrees" and the possible range 0-180?

Thanks. We don't have it documented currently, but the unit seems
reasonable.

Best regards,
Krzysztof
