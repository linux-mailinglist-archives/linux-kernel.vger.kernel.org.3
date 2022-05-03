Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D5518524
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiECNMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiECNMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:12:31 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997572B259;
        Tue,  3 May 2022 06:08:58 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l203so18152427oif.0;
        Tue, 03 May 2022 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K5L1V6+k4xNcdQ9TAb0X4k6sNdC8CWPzZSB0oyYsbZg=;
        b=VxBcwfGjnWLmTnRRGCQVsFW+v6sIC0+PMx7SQFV1jM1u0pMSgV+6CHwmAHEUFXHVG3
         PShRVdf1M/kmFdfDOr0X/624JOb1v3Mfv5dHMs9AGRT2QdoDbcSD7MkB84RqN7W+6L2k
         gz7p+rbz4m2xDD3xZAwg4L5gsyKcDurnNW9aYAWmyAt8fmPKfgsVzj0FaHdR6rdR7tgj
         vCFXo5uW+uO1fmmG0S4zfjbTwJyTAHwuVyO8EWiYt78fzgL5iuGaf0t+AesS6iD6ToIA
         wsP97oP0ruakFE2zvanrTGqU99HibW0mD1x1aqky0pntWaWFceCybjvlELsom47tDX2h
         nYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K5L1V6+k4xNcdQ9TAb0X4k6sNdC8CWPzZSB0oyYsbZg=;
        b=3Lm5lL4FuMlYeHDq0W0+9shxMLbP9MdPaBFHiS84DA5qUfLWZ3fZwT55TCwQHeCPDJ
         z1AKBstehPESIALQjxutYalD2ZRkqNK0qzSxGupimAsZINwCSjZ0wHksq8XPvO6pYwLU
         Q7lpotE+VX9wxlov2v27s5oxGpfrGyqVKnx1IJxFkK2X2CUk5SOz3wnukHRjGSLN23Jn
         ZppV/txcDVXyyq9CFW+WxonnCGxGeP1q9qzIXjl9qSnZ38zat5KsEakXTQEaf1SpXAkQ
         lwV1hkCKJf1t32ZZVqWatihVrZwM+79ME2PstWR3Ib+Zq3FhF1Th5Thm9m1PPSWJJuJq
         CHeg==
X-Gm-Message-State: AOAM5310IlTz3Uch/kYa8DK5eKDCbvBahGpzZ9LFHpYvra28ZtKoJvqm
        Y4lv0OrVltM7VqYULoK9Y3HhsGw1o6L9DQ==
X-Google-Smtp-Source: ABdhPJyp4O3dFqFSB3wJfnt9ZnNY0j8O8wDrc7ss7C9zsdoMjcdQSpfRu/V/1y4v0QTfOvoT1v/VoA==
X-Received: by 2002:a05:6808:1526:b0:323:1194:d3bf with SMTP id u38-20020a056808152600b003231194d3bfmr1716642oiw.120.1651583337923;
        Tue, 03 May 2022 06:08:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v15-20020a4ae6cf000000b0035eb4e5a6cdsm4841560oot.35.2022.05.03.06.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 06:08:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <997daccd-94e0-fa8a-83de-a97f53314989@roeck-us.net>
Date:   Tue, 3 May 2022 06:08:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220503172259.294a15a1@canb.auug.org.au>
 <02ca2b24427d1ad4a8cb84cbf131c64e@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <02ca2b24427d1ad4a8cb84cbf131c64e@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 00:34, Michael Walle wrote:
> Hi,
> 
> Am 2022-05-03 09:22, schrieb Stephen Rothwell:
>> After merging the hwmon-staging tree, today's linux-next build (htmldocs)
>> produced this warning:
>>
>> Documentation/hwmon/lan966x.rst: WARNING: document isn't included in any toctree
>>
>> Introduced by commit
>>
>>   14ed2cdb02e0 ("hwmon: add driver for the Microchip LAN966x SoC")
> 
> Ouch. Guenter, should I send a fix on top or will you fix it in
> your tree?
> 

I'll fix it up.

Guenter

