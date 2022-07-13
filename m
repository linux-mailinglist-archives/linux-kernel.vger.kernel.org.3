Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455E55732E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiGMJe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiGMJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:34:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79BBFB8CC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:32:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f2so14634922wrr.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vObXGH70a1Gg25oDZzb8Ojf+bWP/SQ2CR5CSaB0GfCQ=;
        b=UhlCtSEOxx3nG8eWaK2Ppa6xrk+qf777TFMCPxVlFUgKFBKVupeoUh9VgOqkkuep3I
         xH6bCHyw1cg+H+ilVAsO2hZXqHnMrlO5acxa1b3aJK+0lJD8Qpuf+65teQzFQ7d7hWUB
         3tTjGSngcJwWSuOxRREZ58M/jiJD1ATiTH43tMyygyagfe051KC+AH9Z6RhsKEQ4IltK
         pI1XuJV2T/PJ188gY0xo72MBCYloIqukNbVGFHDkyLYjJ2vZnJ+aOzELQryBps5Bw9NC
         hjg7cwBUFUpLWqbHV6piD9rXEuVD9ZHrJJCUVRX3sCiMe9aa7W0pTsA7kkecWkZ9Vnhq
         Xs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vObXGH70a1Gg25oDZzb8Ojf+bWP/SQ2CR5CSaB0GfCQ=;
        b=tKUMxc7+bYlFjeFzPkW5AsnWsESzh0UfA8lfgKU0PsWXQR01Go32+rhq70IlJUwRfE
         F/7f379JOWqcswDdHRHmXXo0CK2jqTj1z+nz7qLwXBmOysj/RySOc9X5tIqfuBUMosIy
         iQLbxl10pOZkHQMr12iRDqFQ7d1zBM/GFJT54wFkIPiXBZRrsbawww1CzMqNazQYg0We
         /Uvt1fOGt1kkOwOdZkKJuHvKSqMfgLp7ZZQPXVZdnAbY1pW730Sk9DDv+W0BlFVnJV+f
         zbnGVL2bU0bvJrEpI3plavDSYMc6vIKsSJ7sy+rxKzzqZyWJd2s5cvzsCCeDHpQR+ELb
         NF0g==
X-Gm-Message-State: AJIora9TemKc/FalEZU6p3JrAzUXDqmWIoNzLUqwQ9JfuztDu9JZx+N8
        E5vkV5d22MYHm1vLtZbH29tThw==
X-Google-Smtp-Source: AGRyM1sQP9HzmNytj5sUSLj+8Jg8pdPt5xWvb6tfDX7fN95pwfeyqDsT/g3GevG//e+I8soW1cwr/A==
X-Received: by 2002:adf:e28a:0:b0:210:b31:722 with SMTP id v10-20020adfe28a000000b002100b310722mr2265688wri.65.1657704713393;
        Wed, 13 Jul 2022 02:31:53 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0021d64a11727sm10395315wrr.49.2022.07.13.02.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:31:53 -0700 (PDT)
Message-ID: <cd37c8fa-225e-519b-52a2-a052c62dd198@sifive.com>
Date:   Wed, 13 Jul 2022 10:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 6/7] pwm: dwc: remove the CONFIG_OF in timer clock
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
 <20220712100113.569042-7-ben.dooks@sifive.com>
 <bcbd1b29-7c6d-1d1d-2c72-b8818e99c65c@linaro.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <bcbd1b29-7c6d-1d1d-2c72-b8818e99c65c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/07/2022 11:09, Krzysztof Kozlowski wrote:
> On 12/07/2022 12:01, Ben Dooks wrote:
>> We should probably change from the #ifdef added earlier in
>> 49a0f4692a8752c7b03cb26d54282bee5c8c71bb ("wm: dwc: add timer clock")
>> and just have it always in the dwc data so if we have a system with
>> both PCI and OF probing it should work
>>
>> -- consider merging with original patch
> 
> Missing SoB. Please run checkpatch.
> 
> Best regards,
> Krzysztof

Will be merging this with the previous patch now, thanks.
