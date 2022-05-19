Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA6952E07B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbiESXW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245089AbiESXWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:22:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2811610655A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:22:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h13so66917pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iUAS+MiEYDQ4Hf8sgzaS5CdmvaJo09s7huIKYlwYiiU=;
        b=d25OvzWJOsz89NjPjUYX54d5vG5LER5JZD0Jyx99Mv5lp1kf83AhlUbHQ9kSA2KHKE
         4TQD9S2cyRtfd+EW38uv0KanuVQY0vLsx8QOPucTwbw1lWd/XbICK1Zw6/a1JuYN1xpN
         QuTKa2XSGULRHZuPbQPfMWDHVqgwodcyHdOchyI5MfM27OMiz/+9vM+F2ReqTx2a3qjJ
         Hs1erhzlab1pPsoITpTtHgQ7P34ddGd3cgP21D9HpL/VfJ56Z3jF18yllTwcmnODkdwb
         TJHHCwmMu+ZYQfrVwISxXtf+vq40rc65GwMe0jFvqGLnF+h/KiJcFTAR6n7ndUlS0emU
         xdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iUAS+MiEYDQ4Hf8sgzaS5CdmvaJo09s7huIKYlwYiiU=;
        b=vixvX5h8i96UNx/nTndJhKlLEicE9YhMh3sITyRbhNqGIrhPUbVaXnjnvXltWpj437
         t7CWQDHufqQQwMyDf9qd0PBPiNlKmYW7j/K5SVN8aP2m9+Zh+ngXhEuSXbZMiTRbeARF
         blowTMU03d2TXNUtejQIIGDN4EPmsh5Pry40pqbLrIQ/vHtPz9xBKkRijUwxUrQ314oN
         f97+L1Ps3BJixRr2MxjuNtvutnZ7fW1XJnrl7H71QJQx2aaAiPgJJiDr+ETkwKJcQo9l
         2lgNsXd9WThYYdnckoxTq7AvTmwwTPOvDVoi7GqYC5OgCzHHevnmQSN9sKMVnryp9c7S
         cxiQ==
X-Gm-Message-State: AOAM5328dk/rlcF6/wb28vRGJh0qfSj/DNGHRWQCQAPsHLJkcWZXu7un
        oMMS1GNv++xCa0YYz1KOjwDqEimi8fRLsw==
X-Google-Smtp-Source: ABdhPJygcGrPAwOz4LMNys9Wfd/2oxrWgjen9vszerPiJfgrxspheKzQjrnMRYdwUKqDw24inyWbbA==
X-Received: by 2002:a63:2303:0:b0:3da:eae2:583a with SMTP id j3-20020a632303000000b003daeae2583amr6022185pgj.123.1653002572617;
        Thu, 19 May 2022 16:22:52 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id cw25-20020a056a00451900b0050dc76281d3sm215608pfb.173.2022.05.19.16.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:22:52 -0700 (PDT)
Message-ID: <60b82026-9c46-16ea-d9fa-05eb96ae2218@kernel.dk>
Date:   Thu, 19 May 2022 17:22:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
References: <20220519193133.194138-1-axboe@kernel.dk>
 <YoajCafKmgUbbaY0@zx2c4.com> <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
 <8e6c98d4-03e9-3eb5-3d4e-b9a9faeb677a@kernel.dk> <YobPfgkzGrNPDDFI@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YobPfgkzGrNPDDFI@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 5:15 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 03:02:28PM -0600, Jens Axboe wrote:
>> Rebased patches attached, you can also find them here:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=random-splice
>>
>> Did some basic sanity checking (and with splice too), and seems fine
>> rebased as well.
> 
> Thanks. I left one comment about patch 1 in that subthread. The general
> idea of this patchset seems fine, but: what about write_iter? Can't we
> convert both of them? 1/3 - read_iter, 2/3 - write_iter, 3/3 - add the
> generic splice helpers. I ask because it seems weird to keep around the
> old thing (which sounds like is being gradually removed?) alongside the
> new thing.

I can certainly do the write side too. To fix this regression, I just
valued doing read_iter first and I'd hate to hold that up to do the
write side too. I'll do the write side later today, but let's keep them
separate.

In general, everyone using ->read and ->write should be converted so we
can kill these handlers. Would be great if someone would take that on...

-- 
Jens Axboe

