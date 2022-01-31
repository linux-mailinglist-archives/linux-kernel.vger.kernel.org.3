Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2B4A4999
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbiAaOou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbiAaOoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:44:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0531C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:44:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f17so25903904wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fnJzOywNeH5zNZH+CkcZ4xrkTedgK+Dke7KHwtotdX8=;
        b=KovT1eD6vSjqr7qthhYEtXFah0CSX1aVvguEr8BxCiKsxkZ0Mo5OhAbbc2kedBTwZ0
         c23zYwN6LLTjUqN/qzl6OSwv805q4InExRuuqmOj7xTEm87HtUcLSwNI2IEJwg0NhxXT
         +S4kOUEhwa+VXr4v8Ck0FwWm/vYwQ5VK7gEP8ui29+rGR7YQdyQWu7RvS1qybBAdUNwl
         wFKqYkf0pADZf742aqddefOU7zTaOeRYl0e9c28OBMhQsY/mHehKPCqa2wxxVNd4x92A
         iErWJEvib/3IAymY1UnM4nRMfDx8v4GzOjInnf4UCVv9qnZlCrVwDGTQjRjTqxFgQ95m
         WFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fnJzOywNeH5zNZH+CkcZ4xrkTedgK+Dke7KHwtotdX8=;
        b=L7nsYhBVGvizbMwFFE+1TRXVOIlhVM2XbmrV5hkBJgo/HXYdi2hPT6J3tPCp7moG2t
         0ykZXvaMf0pJe6diBhjoJhV7m1bVxNtrv6CueUKH544shvWcGXJdYsrsYEvrGS3styr/
         TP6Up/FYMQDX4cmn+Dk2bK1rgoSgXrWtQ/2afhZ2ZX9gEVdAinvs5w/v1kr88VmgQmK9
         Wjxbe1zlecbSLngxD/AYJxzLWK639UeyyTWS05Xwuz6vn7jwppb9Qm3LEgR3uO4pGDlH
         780hPqfe21uc3nnFInX9NA2NHPC3XWnfQELISiA1FPui+sR7NVuE0TTAWDVIdwouZHAw
         sbVQ==
X-Gm-Message-State: AOAM532cgJDPCjDHoxF1l2YL3jP6qDoco9vqaw375Ov+Sxn4CKu0nQnL
        o8IhBGipw7Zbq5O6/KwYEor512ix4Sc=
X-Google-Smtp-Source: ABdhPJyNvoAVRURG+1qxDYgpLPdNiwKyFAfjAWiJKvaqGtfSp1Z7Jv/5ZUiOJcaJjnrb1H9g3M9Mfw==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr18578409wru.551.1643640284266;
        Mon, 31 Jan 2022 06:44:44 -0800 (PST)
Received: from [192.168.8.198] ([85.255.232.204])
        by smtp.gmail.com with ESMTPSA id n10sm14881335wrf.96.2022.01.31.06.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 06:44:43 -0800 (PST)
Message-ID: <a0dd7976-8b5f-784a-1126-302fb7eaa840@gmail.com>
Date:   Mon, 31 Jan 2022 14:42:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LKP] [io_uring] 811b398582:
 WARNING:possible_recursive_locking_detected
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20220131131122.GB16385@xsang-OptiPlex-9020>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20220131131122.GB16385@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 13:11, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with clang-14):
> 
> commit: 811b3985828e422a3759cf07a848fa75c17c1db4 ("io_uring: support for user allocated memory for rings/sqes")
> https://github.com/ammarfaizi2/linux-block axboe/linux-block/perf-wip

Would be great if for io_uring related reports it also CCs

io-uring@vger.kernel.org

-- 
Pavel Begunkov
