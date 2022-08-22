Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D77F59C3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiHVQHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiHVQH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:07:27 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7D732040
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:07:26 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id t6so2709929ilf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mu4GdUlV+WQe3SYqD8p4Ychr4IxygsX0pgrZ5aKEYrc=;
        b=xEQErVzJm3zlyAIKaQObJgyJvM1/IfPFH4lJphGGU/mMk4iXOOMmOkVvCQRrv0G8xQ
         iScFlp7nd95L3k1XV00fO0a8HRoaQolZZwkm+gBKbfW3Wm30CmlX0l0j+l2LHgaxBesn
         H28fnQp9sFbLsR1UEOxi6U8P3zDqQ5wYDDqnb/t2Rb86MWPq+GsCBLYtyYPsE9g4O1HL
         +998kMsFyef3asaVe40/T800OMHU+VcUtIZYCPUun8f1KOrMeTE/BlAzBJ/CRBPGTgW9
         qhR3XSukpBFv8nk03VU8+C/H4p3duoCmL8yhH1RozOYKB8QulhgNfB62+PoHHQupobwL
         vqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mu4GdUlV+WQe3SYqD8p4Ychr4IxygsX0pgrZ5aKEYrc=;
        b=hn/xGZOPmw81HP3i+GyctVJteJ4jS5v0Mjq393ksiDIXb4zTOSLIXuPlbE3CjzVuPP
         65Fqe/bE7r0DGNxPBOg/Uk8EMj06U5Khp/sDpZergD/UCbEV39oG+nV64Qrk7A6qiNZX
         GaVDEFI1xBQ53Gb8+F8x3ENuOOV/zzhpxi9TqgQnaQx5g3UVhY/7IDBrw1zYd4FsMa4r
         PPsRGCecrYeydZctwxeLsZhFcE4oNd6zDQIO76WrZHMbJ7HIzHfu+DmGyBpVwsAd3gQA
         eRxYz3JPtrIqnzBQmDhdbQooC5zLH7+mSJxzthtURy3Qoyfy9hGrGtGCJjHqybX8l66y
         iuqg==
X-Gm-Message-State: ACgBeo3Hmn5fgxn98096+g9W+3nIFBej577TVyRqoPr+ao97hqE49AT+
        Ci9E0o17WnGBb6OkdAveTp/ZXQPZoGoJRQ==
X-Google-Smtp-Source: AA6agR6JWd8v85pRNtwiGo+7ah75D+0zAkZyQnmJ53oFS75A9pjxRz+3UIV1Cw4PllRLTrmvZaKS6Q==
X-Received: by 2002:a05:6e02:2162:b0:2e5:d70a:3af5 with SMTP id s2-20020a056e02216200b002e5d70a3af5mr10138250ilv.3.1661184445953;
        Mon, 22 Aug 2022 09:07:25 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e21-20020a0566380cd500b00349ed059d12sm256855jak.75.2022.08.22.09.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 09:07:25 -0700 (PDT)
Message-ID: <2d8b47ac-c343-2310-141a-88b54109dbdf@kernel.dk>
Date:   Mon, 22 Aug 2022 10:07:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220822144613.6e6ce950@canb.auug.org.au>
 <911717ae-3955-08dd-ad53-a6488ef8127b@kernel.dk>
 <3848cd00-b4e8-17f6-32d6-011170f293da@acm.org>
 <4a9d2d6f-2b07-7331-6507-e19cd8e4f2ff@kernel.dk>
 <5b659baa-8451-b4a1-2ad4-0423faac4642@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5b659baa-8451-b4a1-2ad4-0423faac4642@acm.org>
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

On 8/22/22 10:06 AM, Bart Van Assche wrote:
> On 8/22/22 08:40, Jens Axboe wrote:
>> Done - please check the end result, both yours and Stephen's had to be
>> manually applied.
> 
> Hi Jens,
> 
> There is a difference between the qlogicpti source code in your tree and in
> the master branch. Is this change intentional?

I did notice that, we can just make them identical. Won't really matter,
but might as well keep them consistent.

-- 
Jens Axboe
