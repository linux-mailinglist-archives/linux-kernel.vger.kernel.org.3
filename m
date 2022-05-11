Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B21523EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbiEKUgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiEKUgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:36:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643EC22BCB;
        Wed, 11 May 2022 13:36:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d19so5587338lfj.4;
        Wed, 11 May 2022 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6ojZI9/OD16y8IIbbbbr20+lgWh1L2wXNhWVUJLRxZA=;
        b=EXDJT9RrmxRequBVKMI7c6eOe90w7mVQaqq4QiDNmHUqbqJ8VnPNCzYocIDEiqf3/C
         Yf80YZ9W9hPqsX7fWgRmV7KwAunrRz/hz7YfIgERq2aM0h8I2TYShHCYOvVg6kcIlPrD
         KOmV9Pvobe353TII5xEo8Kbpk2gM6czUyRIyaXZor+6gavWJqF2G4sGSDyHJA4IQPZaS
         AsxhVWCeyLDokKPOj/XcpUF6w2SPhaO5UD1xLpsoIXjO43pU129wiSWKjA3ZncH0T9YX
         71yHCV6ff2DlMkfkMy3lUu+0FJ/RpBjYOMq9nYERvOF1V9sSlmmUtxVVICkxS1nkr8Xb
         /CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6ojZI9/OD16y8IIbbbbr20+lgWh1L2wXNhWVUJLRxZA=;
        b=ibByB/ro7HguvBPPGBhCLpaz8vXXWGzerzijZYb2Ka03wBDKoGNN5zuxWK2CiS8s26
         uBx/bRvxj/gR/4YN/qJPM24sNpeN31XNhtbiEN6lfMv2yYB0Xcd+8+Fpl4huBXbJVYM1
         h56AL8s39HpjoCY8H7jtqTzRrZkBfCNND9oIiSAvZWUuNK0Vec6T+QofWTXi+BW2zrUa
         b8y/RN8OjV/Yoy2rStYSRoOhLn3V+XjKsmmsPGBVagJ2Xy8CZ9h6xMKGU5jro/wsc/s+
         6s04qGSwE+UCgiCPcHl5S/Q+Fnbz+VWzmpoPs276ngUVbace+mbaTGIdSrTvoHR9AjvI
         1VPA==
X-Gm-Message-State: AOAM533ksTd9ky/KNEY5LT+H4aTJzvb6eXkncshyMLMVxuoGe0WRuGUO
        kTffmU/n5NB9RpVlXe0ms/6dysDWWHGaHA0r
X-Google-Smtp-Source: ABdhPJylh9Qce9//Ii3Y9f5x7e7hu+2iWH/wCpknzcJjYjhpdWbDHI2uHBQqfLXBAAteolHXjubtTw==
X-Received: by 2002:a19:7114:0:b0:473:e3f5:c7ba with SMTP id m20-20020a197114000000b00473e3f5c7bamr21761571lfc.9.1652301380651;
        Wed, 11 May 2022 13:36:20 -0700 (PDT)
Received: from [172.22.204.227] ([104.28.230.247])
        by smtp.gmail.com with ESMTPSA id k42-20020a0565123daa00b0047255d2116csm436333lfv.155.2022.05.11.13.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 13:36:20 -0700 (PDT)
Message-ID: <10ce5bf1-bf12-b028-49cb-a3f1999f9a07@gmail.com>
Date:   Wed, 11 May 2022 23:36:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mtd: parsers: add support for Sercomm partitions
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220329122016.4122899-1-csharper2005@gmail.com>
 <20220330100958.57dc4d61@xps13>
 <ede9e050-3b60-ba0e-c626-044f7825adb7@gmail.com>
 <20220511091643.064f9d13@xps13>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <20220511091643.064f9d13@xps13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2022 10:16 AM, Miquel Raynal wrote:

>>>> This is essentially the same code as proposed by NOGUCHI Hiroshi
>>>> <drvlabo@gmail.com> here:  
>>> I would credit Hiroshi with a Suggested-by at least  
>> I read submitting patches rules again and thought that Signed-off-by is
>> suitable for this case. Is this ok?
> Either you take his work almost like it is and he must be the author
> *and* the first signed-off-by line, or you take the authorship if you
> think you did enough modifications to the code and in this case you can
> either credit him with a suggested-by before your signed-off, or you
> can credit him with a co-developed-by + his signed-off and then yours.

Thank you for clarification! My modifications were quite small:
 - Remove redundant braces and logical NOT operator
 - Define pr_fmt
 - Replace kcalloc by kzalloc
 - Use of_get_child_count() and alloc big enough array before the
   for_each_child_of_node()

Therefore, I prefer to keep the authorship of the original author (NOGUCHI Hiroshi). 

Patch is really good and was successfully tested on the hundreds of Sercomm devices (5.4, 5.10, 5.15 Kernel). My motivation for upstreaming is work under official support for these devices in OpenWrt.

What are the next steps from my side in this case? Should I wait for review of this patch here (Link: https://lore.kernel.org/linux-mtd/20220510162655.21011-1-csharper2005@gmail.com/T/#u
) or do I need to do something additionally (for example, send updated set v5 with Acked-by from Krzysztof in the first patch)? 

And sorry for the many questions... I haven't fully mastered the Linux change management process and best practices yet.

> Thanks,
> Miquèl

-- 
Best regards,
Mikhail

