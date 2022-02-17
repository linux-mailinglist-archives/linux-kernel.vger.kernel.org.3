Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5C14BA9DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbiBQTd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:33:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiBQTdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:33:24 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C8F1598FF;
        Thu, 17 Feb 2022 11:33:08 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a19so10331836qvm.4;
        Thu, 17 Feb 2022 11:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=rBxmT3+5CTt9IdhylIa0a5TlmY8jTHgnD/JXk7m1eDE=;
        b=Do8oVw2kp2yEl4I8UGBfELOtUezWrLbMjFLltSg307aAXy5a21BwcnrRlAUNOwgrpp
         lUrxx06H40fwQBf/AE3F02b7I/sH+MmnTUQzbbR6gvlj5rHYV5fCDnVUv3FeRRJjVx6L
         8kRammeTn3TLN0gbUzBCnaP2ZlgRXHBCgfYiBxMFesT24QFN1DK83jirH+dk2OghHw0R
         1rt4H2SByGWOmb+HIrSudTg+JxOcKboecm68cGS3dfqPzd7m3Vj3mvfnbeoYQCtxOquB
         5ym/3iSV06R6sxy5R5vILvQZ8JnWDcBjRDqFDNFtcTtlv4bZF0y25XV5V5Ad6p4FYedW
         xDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=rBxmT3+5CTt9IdhylIa0a5TlmY8jTHgnD/JXk7m1eDE=;
        b=VicuAaZBww6Dlel/DW7mIqAb5xPs4YPgGCVWuqyoL4sy2f5gLG1H7Sd8V5sTUavovU
         XYqFezVwKRu07cG0wnIo132MvmsEuP7HGjYbmaupR3vcER1KYaYA1PO2t16QYLoDHOMo
         NN0J2th3YuTYhAwN6HRzw5MhEsamGa3wR6iiInDRTg4a94O6VvDPzANRJK0cN54rk8ix
         Guc4hox5zLfl5ZsOHMuPCVpWbi2qaIJluwu9sR0gDKR74r4EXLpR4CxbpagSiAjinlyW
         I8zrr2nz2Zd0VyfCIJaiZGx4PA0pL+LJwHc3CShEQrja1S35t/nC29wYwrNpgDH6ziC7
         dOsA==
X-Gm-Message-State: AOAM5302PfxlmxYJoBSHdyqHEBae2WTJzOo6hNLP5x3ITFPFI4k8Dhfq
        NVLI4xfrprDOeUQXYy8f2RBUwRsPUISgDw==
X-Google-Smtp-Source: ABdhPJzCwNOh0o4gHu5fbDAM9egA9v84qNxeFoF+LbuJQYWgydkUFjf+wf5ljJbSERkA55PYYM3a1A==
X-Received: by 2002:a05:6214:581:b0:42d:7ccf:220b with SMTP id bx1-20020a056214058100b0042d7ccf220bmr3222930qvb.9.1645126387949;
        Thu, 17 Feb 2022 11:33:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j14sm22031729qko.10.2022.02.17.11.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 11:33:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a8e9e6f1-e7a0-d40d-8065-b72f60c72a32@roeck-us.net>
Date:   Thu, 17 Feb 2022 11:33:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220217072340.2472987-1-eugene.shalygin@gmail.com>
 <bf18f96a-b9ee-43f0-8b53-fc7d4aa6cf39@roeck-us.net>
 <CAB95QASiF=mXcUoBsOwKvtZ8KmVYgNd1bP-5+e0WYifcEzK55w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) do not print from .probe()
In-Reply-To: <CAB95QASiF=mXcUoBsOwKvtZ8KmVYgNd1bP-5+e0WYifcEzK55w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 10:43, Eugene Shalygin wrote:
> On Thu, 17 Feb 2022 at 19:26, Guenter Roeck <linux@roeck-us.net> wrote:
>> Looks like you did not run checkpatch.
> 
> I did (0 errors/warnings/checks). What needs to be corrected?
> 

Interesting. It appears that the continuation line in the declaration
confuses it. Otherwise you would get:

WARNING: Missing a blank line after declarations

>> Either case, I think you should just drop this function In probe:
> 
> Yes, currently that function is tiny, but some tests with motherboards
> from other families are done by users and if I add other families, the
> information required for each board model will grow and in that case
> I'd switch from dmi_system_id array to a custom struct to define all
> the board-related data at at the same place, and to save some space in
> the module binary, as unused parts of the dmi_system_id array already
> take a quarter of the total binary size. So, the function will likely
> get some more code soon.
> 

Hmm, ok. Wouldn't you still need some kind of dmi match ?

Thanks,
Guenter

> Regards,
> Eugene

