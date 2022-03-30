Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDF84EC6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbiC3Oh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346951AbiC3Ohy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:37:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C541FBA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:36:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dr20so41905207ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mZKE0EPCBwY/E3JJQqpe71EQkJdNuH5EijWeXNvdI8U=;
        b=mZCAGfvV+XQfRPSI/PMRRBEqKpC4OXoT10QKeGkmb3S7h5fuyr162N5YyJMXpGx/1w
         2w9YsQAF+L6O20U/n23T1aOGVtmGc37h7EWmMKQ4qo/rWqoVHieSL5ythR2kLVrxIK5f
         thayEWEbVPlDmAokSeCh3BhMOsUxFgAptEhrMfbvggkn1uOQATKokHdaY35px9YVg+fi
         og6wSdKx2/m+AxHplCPc1jH784Rk9vhEMvFYZPfdlcjYt+tazmh5lGpweI5emG7SR2RJ
         Eh41o8NRRcqJ5TlpAR46wUnAnSr0lHrz+gSoAZR3tCKF4Q7NQNYftRsvy/7uNzdihV62
         /U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mZKE0EPCBwY/E3JJQqpe71EQkJdNuH5EijWeXNvdI8U=;
        b=e2AATCP6gg5+g+/XPGeQfW6VpdeVYPJBzLwLQpr0RVSIjIXkop2OOQPKIH/qf2T7qb
         ChVfgXNtEGn4vXNyZJmyk8t/hRKasP9+HonMp3Gs9gifwNxrpZnr1O50mZcQd036qjpv
         smHzqiF903e5/KpN/7w38joKZAGz69bvBgtiaK4ODoHwC2e5flxf5tjPLo8yv325krE6
         nDhO+A+vwsj1DyrALv4AfE1lfLnyqsTy1aJMx2MCkGQIrZas82ajDDn7qhG349qVYnRX
         XEXxN7EgsUxeQGnCO551+c8T8pMgk8Yt1graKebO33H9GUs6c7x2orSievyVXaGdxf7W
         vMfw==
X-Gm-Message-State: AOAM531gbDEZr/qE4TM4GH/ZLxTghtmBGS703A72OhvRjdonabmuoMOg
        nytxi6UgaJjJVYWY9f0527eTJw==
X-Google-Smtp-Source: ABdhPJwdWG8sBJyr3JqFQBHPHzbJlGmU8Tf0ULSmR/KGw5gR8AYBM9fQ7HGHozDkp2SU4in4HQqDpA==
X-Received: by 2002:a17:907:6d2a:b0:6df:e513:5410 with SMTP id sa42-20020a1709076d2a00b006dfe5135410mr39194588ejc.544.1648650966162;
        Wed, 30 Mar 2022 07:36:06 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w2-20020a50d982000000b00410dc0889b9sm10006826edj.63.2022.03.30.07.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 07:36:05 -0700 (PDT)
Message-ID: <caed045b-4286-3663-0e71-8a0f5f7f0bc6@tessares.net>
Date:   Wed, 30 Mar 2022 16:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] perf tools: Stop depending on .git files for building
 PERF-VERSION-FILE
Content-Language: en-GB
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1648635774-14581-1-git-send-email-john.garry@huawei.com>
 <3a72702f-6cf9-2b6e-0f9c-bf6857ab7ed2@tessares.net>
 <YkRlZhaEgmJ5Q4k/@kernel.org>
 <634d9682-dc78-e09a-865c-9eed28aee667@tessares.net>
 <YkRo/PtIf9aOqpZV@kernel.org> <YkRpcW4PkVH59axm@kernel.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <YkRpcW4PkVH59axm@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 16:30, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 30, 2022 at 11:28:12AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Mar 30, 2022 at 04:22:35PM +0200, Matthieu Baerts escreveu:
>>> On 30/03/2022 16:12, Arnaldo Carvalho de Melo wrote:
>>>>> Thank you for your patch, I just tested it and it also fixes the issue I
>>>>> reported!
> 
>>>> I'm taking this as a:
> 
>>>> Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
>>>> Ok?
> 
>>> Yes, OK for me, thank you!
> 
>>> I never know what maintainers prefer when there is already a
>>> "Reported-by" tag so I didn't specify it but I will do next time.
> 
>> Right, I'll stick both R-by and T-by.
> 
>> There are cases where people just report and don't test, or just ack.
> 
> But when you actually provide the:
> 
> Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> It makes the lives of maintainers using b4 easier, as it'll collect
> those.

I agree it is clearer having both tags.
On my side, some people are often asking not to their name in multiple
tags but instead combining tags, e.g. Reported-and-tested-by. But
Patchwork doesn't like that and I have to add the tag manually when
applying the patch. I guess many tools don't like these combined tags!

Anyway, next time I add it and let the maintainer drop / modify it if
they prefer :)

> About b4: https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation

Excellent and very useful tool, I agree :-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
