Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB7534432
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344220AbiEYT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbiEYT0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:26:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7921146E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:26:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so43576244ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Tutsg3cgw72wmrqbtZBQVz/JQ/jobeGiwbgCHZW5u7A=;
        b=YK0d8cE3KQzWL0uX7hSy9CKHWz+RqIIghl7QY5xscnB9xG3MUvp8o0YeGIjLk+7Onu
         y5BKfebA/m1AYl59W0E0ATiH0j+Uk1ZZ8fa25DqifL7w9OppsLRwtG1hnp1hYjx4yLST
         PCzvYXoNTok0UTCpsXKcPB4ELta+x0UAN1rgarIyRW/dqHJFCzuZPBPWQxaL+lh584Oj
         FnW22AJRyXmwiWejRBhRqtvor6+zZ5Pjwyu1nLYcDK96JmfDsAnxhhGU2FKjoe4EY3wh
         bIGspPWEfdJF6Q2YEq1Kzi/aO01zMEEnnmym968MPUA9+9sn/11sHI6EpowULfs9Qb/a
         uHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Tutsg3cgw72wmrqbtZBQVz/JQ/jobeGiwbgCHZW5u7A=;
        b=Olvbm2PLJc3h5KVG9e2LVROF/P4Zg+maB86lVMmJbVP1K5rq7hZyrYy91QaM+lsZ9e
         wGT7JfLKjevlk7N29lIsqhOPkLfzY2RNgllDLqKwsoisrQ8RSZ+zF7DehFC7DjaAyS9D
         lJ9sWN6/1HtaOs37dI6GV9kQCQS8X0RmPv8Am7IezCviUoQq5elkO4u4GDWks26BtKjt
         iY4ZKA0p8PfB0RW+mDLrp9G+rgkoqN6UNkoM1j90i7rL1lcHnjKEgecpoxlScgAt5k2g
         eTZ1dyiVmpXxoIp4z+HXig/sLo5ETEs3Q+TUrfAwQVs6QShZfZUVkyuwiwMiTQ+FyuSY
         bMmw==
X-Gm-Message-State: AOAM532LddE45bmM2ozgU0D/16y+EXBP7ITn6CZEaTkoEWtLBMrulsSU
        JeXUeVRlL0b/7KrkDcWEeHsH2g==
X-Google-Smtp-Source: ABdhPJyxwQsdpAjuUCIdAz4hw4+sKgiHXE+r0RxNq3kM6PB8A9dVKXCNJKKc4oDCQ7h65u/pUGEeJg==
X-Received: by 2002:a17:907:7f14:b0:6ff:2013:3e98 with SMTP id qf20-20020a1709077f1400b006ff20133e98mr700315ejc.73.1653506782691;
        Wed, 25 May 2022 12:26:22 -0700 (PDT)
Received: from ?IPV6:2003:d9:9706:da00:cfdc:6d78:4a00:8f2e? (p200300d99706da00cfdc6d784a008f2e.dip0.t-ipconnect.de. [2003:d9:9706:da00:cfdc:6d78:4a00:8f2e])
        by smtp.googlemail.com with ESMTPSA id 15-20020a170906004f00b006f3ef214dd9sm8037973ejg.63.2022.05.25.12.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 12:26:21 -0700 (PDT)
Message-ID: <5dc3eb9d-229c-b086-9d1a-f695e94f8752@colorfullife.com>
Date:   Wed, 25 May 2022 21:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ipc: Remove dead code in perform_atomic_semop()
Content-Language: en-US
To:     Gautam Menghani <gautammenghani201@gmail.com>,
        akpm@linux-foundation.org, shakeelb@google.com,
        vasily.averin@linux.dev, mhocko@suse.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20220524182244.42987-1-gautammenghani201@gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20220524182244.42987-1-gautammenghani201@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/22 20:22, Gautam Menghani wrote:
> Remove the line which is dead code. Fixes the clang scan warning:
> warning: Value stored to 'result' is never read [deadcode.DeadStores]
>                  result = curr->semval;
>
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
Reviewed-by: Manfred Spraul <manfred@colorfullife.com>
> ---
>   ipc/sem.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 0dbdb98fdf2d..156824bcda47 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -766,7 +766,6 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
>   	for (sop = sops; sop < sops + nsops; sop++) {
>   		curr = &sma->sems[sop->sem_num];
>   		sem_op = sop->sem_op;
> -		result = curr->semval;
>   

A copy/paste mistake: The 1st loop in perform_atomic_semop() needs 
result - because it must check for overflows.

The 2nd loop doesn't need it.

>   		if (sop->sem_flg & SEM_UNDO) {
>   			int undo = un->semadj[sop->sem_num] - sem_op;

--

     Manfred

