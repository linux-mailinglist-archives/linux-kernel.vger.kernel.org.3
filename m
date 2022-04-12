Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E94FD834
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359595AbiDLJ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356532AbiDLIKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:10:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E753D6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:42:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so1891042pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9p/MmKuuxvIv4B30UAt79Rd7Dhf0WljkYqYqqKzZidw=;
        b=Mwww8UeE3bRZDqRGxTl0tpXi7zSB8wG+cPSjJsKwX72aR2VUttTenmlhDSj0HVpIKr
         mvsMwcJFNkqdGZbYaHPM5uzeZoeFpecwrcIK8OEYAnVaW5o5TeYyRLpTeXRfqCv69bf5
         n6J1cRU66cR2BMH3H9aqYDV3lLKZB9Rw6np4bbofSkci3SRy9+KcFeuP7hYHjbffHk63
         yEyNWZv2HadoZOXZ5aqoTEwgNrSz1Kemr7BHJzOsiYlJnLQ3ZpbAfZ4OtzbnR9J3CYB0
         iunlNqCohohbg9zA4n+Q+FQUs1tScceI9uXcgFtChyUw7kqDfNck1YPB1bJ83RbsAI/6
         vKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9p/MmKuuxvIv4B30UAt79Rd7Dhf0WljkYqYqqKzZidw=;
        b=k50j/R4BwKvtwAxhXyiLc8Ul5vvWyx4ljPyQaBDDy09tn5h6AskxLSwEpc4X5acRJV
         RelT5FVwJfr9wDpMy1XBc2R2Rw98Tg8COCeOy4WUFERA+9V/fAWmhvYrF0wvXXejpQgi
         bGSjWnMGX10xDb+3nV0Ylmb67nkUAkDXLSlM3So/YFXXKwBaUh95nCsiQOqgLdGOyUds
         v7eWMYkCVytyNWPVn6QrXQmM6ZwTY/w8LP9dDzmh6QfJMqVlPGbp7QyhygozY8yf51S3
         1xkwuOjfJjtXi4cAMoV4ITEvH4isOb0lYigwT3fWLUp97dPc5JupPsL7rCG6Wu7XoQoK
         18vg==
X-Gm-Message-State: AOAM530hWq+RYyOuS2wJdZe0re/8W8/NJb66xsWRbNQZoqU44IHMlf7E
        FaE2omiVK08movHAx64W2d2FYxhxShVu/p3z1h8=
X-Google-Smtp-Source: ABdhPJzlcXA1KUAmGSh2MiKL0M75Av4U3+iAaRIGSYomSHDnFzsTSnDmh+ZVyjBGda/uRe8WPUECiQ==
X-Received: by 2002:a17:90a:6402:b0:1c9:9377:dd0e with SMTP id g2-20020a17090a640200b001c99377dd0emr3433787pjj.211.1649749327100;
        Tue, 12 Apr 2022 00:42:07 -0700 (PDT)
Received: from [192.168.1.101] ([159.226.95.33])
        by smtp.gmail.com with ESMTPSA id j6-20020a63b606000000b003808b0ea96fsm1814254pgf.66.2022.04.12.00.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:42:06 -0700 (PDT)
Message-ID: <61783400-4df2-47af-78a7-7acb715c3a71@gmail.com>
Date:   Tue, 12 Apr 2022 15:42:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] mtd: rawnand: Fix return value check of
 wait_for_completion_timeout
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bastian Hecht <hechtb@googlemail.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202204121253.NcZifMQi-lkp@intel.com>
 <20220412063703.8537-1-linmq006@gmail.com> <20220412090649.33bb3f8b@xps13>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220412090649.33bb3f8b@xps13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

Thanks for your reply.

On 2022/4/12 15:06, Miquel Raynal wrote:
> Hi Miaoqian,
>
> linmq006@gmail.com wrote on Tue, 12 Apr 2022 06:36:52 +0000:
>
>> wait_for_completion_timeout() returns unsigned long not int.
>> It returns 0 if timed out, and positive if completed.
>> The check for <= 0 is ambiguous and should be == 0 here
>> indicating timeout which is the only error case.
>>
>> Fixes: 83738d87e3a0 ("mtd: sh_flctl: Add DMA capabilty")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>> change in v2:
>> - initialize ret to 1.
>> ---
>>  drivers/mtd/nand/raw/sh_flctl.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
>> index b85b9c6fcc42..2373251f585b 100644
>> --- a/drivers/mtd/nand/raw/sh_flctl.c
>> +++ b/drivers/mtd/nand/raw/sh_flctl.c
>> @@ -384,7 +384,8 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
>>  	dma_addr_t dma_addr;
>>  	dma_cookie_t cookie;
>>  	uint32_t reg;
>> -	int ret;
>> +	int ret = 1;
> Does not look right. I know this function returns > 0 on positive
> outcomes but this does not make any sense in the first place.

Yes, I made a mistake, Now I realize that in v2, it will return 1 in error path

when DMA submit failed.

And for patch v1, it will return 0  if calls wait_for_completion_timeout succeeds.

> This function is static and only called twice, please turn it into
> something like:
>
> if (dma_fifo_transfer())
> 	error
> else
> 	ok

So I want to keep ret>0 means success.

Or could I set ret > 0 after in wait_for_completion_timeout() success path?

like:

    if(time_left == 0)

            ret = -ETIMEDOUT;

    else

            ret = 1;

What do you think?


Thanks,

>> +	unsigned long time_left;
>>  
>>  	if (dir == DMA_FROM_DEVICE) {
>>  		chan = flctl->chan_fifo0_rx;
>> @@ -425,13 +426,14 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
>>  		goto out;
>>  	}
>>  
>> -	ret =
>> +	time_left =
>>  	wait_for_completion_timeout(&flctl->dma_complete,
>>  				msecs_to_jiffies(3000));
>>  
>> -	if (ret <= 0) {
>> +	if (time_left == 0) {
>>  		dmaengine_terminate_all(chan);
>>  		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
>> +		ret = -ETIMEDOUT;
>>  	}
>>  
>>  out:
>
> Thanks,
> Miquèl
