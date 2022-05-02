Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914125169A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 05:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357328AbiEBDyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbiEBDyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:54:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944CAE0B4;
        Sun,  1 May 2022 20:51:03 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id a10so14180361oif.9;
        Sun, 01 May 2022 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/NF8pyfH57GKRD5Dzqj4pHx2MqZaclUASnEJQVXNbBc=;
        b=YSM4LRLQzqX0XqiTK7UAmvNyq3rJBHDyB4Zkm/j8u3WnIsCpTMxEmApJ63J25B6qEd
         VHKEqWu0yU1+ImQyTcS7FsDM0E2uiQdopJjTX5IGMkb70gnAko1n2GB3NKHChqMU5ULo
         G6qtYs5hliYJuSj3GAj5P3c/lfoa9bCsN9SpSNhMMNR1YzvSHJSxTnbu9mlO2FtURo63
         jre+V/4/vlbQhwLRQ0bSk88UgiomO/EKtcs8FFCyf/QJW7QrnpQXe2ZSYZDiBKLcgpOv
         X6cfYlcm8ZoakYngXSCwg+K5BW1hEAnMon7soXohdLyV71Khb+HuHQ7p9YB5u3Vyf1yR
         P7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/NF8pyfH57GKRD5Dzqj4pHx2MqZaclUASnEJQVXNbBc=;
        b=jpoz+iADIzFSh+pBO9S/MLk9c+7GY/KTJ0d1KiucvwkAyzD8wLQaLUsEc8THKPhWtJ
         lUDYjI4woW9K1avZRveiAkmedHk+ByGuJMNPo3ccV0xmGjLGFn8gYN13zcZqa2/2uVxW
         wM65heuX3uSQaDvTkiishMc6G+I1DitCyC5kbKN1XaaRyhL8DB3khn2xu/2CYBCuRg9t
         3L9J5Wg2a3bO5HGTCPx5vjAWr0ZjbocpsxbxOF9IM4lT2WIUDFv3pS8hWxXq8FnSOiqU
         0KQxzXYQMg7y50M8+UASqKqqAKKjgu2aqoWG5tzDJbz7GayYVBwwNhhPIVX2E5NY2Plp
         SQ/A==
X-Gm-Message-State: AOAM530kqiGKG1gtCXNuxpjsQl4FwKiUC5DGdC0c/NTGtRP7OR48Yoi6
        LYhkTbk0EGr5vthtL1vWB6M=
X-Google-Smtp-Source: ABdhPJw58pfDSTpUlB4DbUfaytxkAMXnofPffQKcZ1/THtvS/lQD+nwWCXdXbHjr94di5vRJ53A5jA==
X-Received: by 2002:aca:2807:0:b0:326:14c8:a19b with SMTP id 7-20020aca2807000000b0032614c8a19bmr157541oix.158.1651463462930;
        Sun, 01 May 2022 20:51:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 2-20020a9d0c02000000b0060603221246sm2465068otr.22.2022.05.01.20.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 20:51:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9632fee7-126c-2205-3a7b-4374dd9c2123@roeck-us.net>
Date:   Sun, 1 May 2022 20:50:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/7] hwmon: (nct6775) Convert to regmap, add i2c
 support
Content-Language: en-US
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Renze Nicolai <renze@rnplus.nl>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20220427010154.29749-1-zev@bewilderbeest.net>
 <bc46d60e-7c89-ad05-780c-9e9fd19f788e@roeck-us.net>
 <2508913.OsOuS879W0@natalenko.name>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2508913.OsOuS879W0@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/22 08:18, Oleksandr Natalenko wrote:
> Hello.
> 
> On středa 27. dubna 2022 15:37:07 CEST Guenter Roeck wrote:
>> On 4/26/22 18:01, Zev Weiss wrote:
>>> This is v4 of my effort to add i2c support to the nct6775 hwmon
>>> driver.
>>>
>>
>> Thanks a lot for your effort.
>>
>> I applied patches 2..6 to hwmon-next. The first and the last
>> patch of the series will have to wait for DT maintainer approval.
> 
> Zev, sorry I'm late. I've just tested what went into hwmon-next (patches 2..6), and it didn't affect `sensors` output for me, so I guess this confirms what you asked me to do ("I don't have access to any asuswmi hardware, so testing of the nct6775-platform driver on that to ensure it doesn't break there would be appreciated (Oleksandr, perhaps?).").
> 
> Guenter, if it's not too late, please consider this as Tested-by: from me on this part of the submission.
> 

You'll have to provide a formal Tested-by: tag.

Guenter
