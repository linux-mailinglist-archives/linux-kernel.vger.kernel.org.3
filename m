Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E58857AE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbiGTDB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbiGTDA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:00:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7BB2E690
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:00:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c6so13733690pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jFM/x3AzSC3PgvKKwpYQ5fvUEj2lu/Pa5Yx8hNdwSbs=;
        b=gur6v1nWcYdAOh1dJFghP1PwZQS2AfZWnBtUECVirLR74mQrmQBr4aBd3TrawR7XzY
         muEgcdKEMIcRG9CiMhEOd2PIU3tbKYqFRvTxTg6TwMCcL1iQ3VcQDNnrUFc39L4XZ2+S
         Aq82LMR/y/Z97aPris3cfakSgYU+l40nBMqNcbS6+ArEIqG8PVjkIpgCvgaBpK97qHgT
         IXhKvO1y6Yo9yZ3r5rHgYISGn9AVGbDvSN5ey7DKfWRSB3DPqboMKomh48W9XgIeTmgo
         7MDgXWUCG2JVLmBpIunIkbp2dd6W8aqfyIAQeq4msjXMF5igGm0x/HiLi5r+snWOeBll
         K3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jFM/x3AzSC3PgvKKwpYQ5fvUEj2lu/Pa5Yx8hNdwSbs=;
        b=6cmMtf8xgrq9BkdDh86bojf65NzbtmQGYFsYn94tZr4wBT6+q2AhsAgmJLlN097ywV
         ThJ9zF0zXGa6bU2DuBlF5n4n2h+YkoyRY3z/VrIs5aCbf7SUHqcOzWk4syzz3/2otmFR
         uimLUQYVfpEYoLMwCDK0/BnOBDru8gPO00nCVr+MZ1f3nJRrEBsqqJMTbZ2Ib4zYxTa+
         87xBwUTCPQ0Zessu8Wurr5Okss6pgwaytjxAY42g5vppsfWohmPLZZTU/JjOno+9rRUr
         flMRZezUhW/1uOlUy1kAZvBhx5oLQeJDbq1aLa/VNlGRorStg17Rmg1Wgr7nfvAYkBpx
         nJyw==
X-Gm-Message-State: AJIora/pKQbHgTUcjubNdMlIILoxDhBSllVPjgmuNAUAAkGQbqeRSggN
        xnjPvGiNdlpHSx7djxsMXMVEdYdr4T/uVQ==
X-Google-Smtp-Source: AGRyM1sjhpeIZfYwjVHFq+7neW/udQkJlVfa+M8UQnvePhN/Ted5js8fvvxUDo8MB2JfLUq6W2bLtQ==
X-Received: by 2002:a17:90b:4d05:b0:1e2:bf91:8af2 with SMTP id mw5-20020a17090b4d0500b001e2bf918af2mr2907811pjb.210.1658286053359;
        Tue, 19 Jul 2022 20:00:53 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t126-20020a628184000000b0050dc7628148sm12299590pfd.34.2022.07.19.20.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 20:00:52 -0700 (PDT)
Message-ID: <ae79052b-98e7-0e60-2361-051b742b7573@kernel.dk>
Date:   Tue, 19 Jul 2022 21:00:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220714120840.1e1f8c63@canb.auug.org.au>
 <0904ae71-972f-f183-f295-bce3b8518fcf@kernel.dk> <YtC6SUmyaCSKe2HX@ZenIV>
 <YtC9AgqezKXuUoy6@ZenIV> <20220718125932.1ab89122@canb.auug.org.au>
 <YtTofKIkWU4eXvoK@ZenIV> <a43c8f77-a15f-ab1b-579c-feeeb8bd8593@kernel.dk>
 <YtdsQIm2kbmEqFRC@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YtdsQIm2kbmEqFRC@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 8:45 PM, Al Viro wrote:
> On Tue, Jul 19, 2022 at 10:52:12AM -0600, Jens Axboe wrote:
>> On 7/17/22 10:58 PM, Al Viro wrote:
>>> On Mon, Jul 18, 2022 at 12:59:32PM +1000, Stephen Rothwell wrote:
>>>> Hi Al,
>>>>
>>>> On Fri, 15 Jul 2022 02:04:02 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>>>
>>>>> On Fri, Jul 15, 2022 at 01:52:25AM +0100, Al Viro wrote:
>>>>>
>>>>>> Ones from Keith's branch - #alignment-fixes-rebased in there.  Looks like
>>>>>> one of the commits in it got changed since then - the difference in
>>>>>> __bio_iov_iter_get_pages() (unsigned int i initialization).
>>>>>>
>>>>>> Sigh...  I'll rebase on top of that.  
>>>>>
>>>>> Rebased and pushed out (with copy_pipe_to_iter() fix folded in as well)
>>>>
>>>> BTW, these still cause a conflict.  As long as you are sharing patches
>>>> (and then adding changes to the same areas), there will be conflicts.
>>>> You need to share commits i.e. a shared branch.
>>>
>>> Sigh...  That was (and is) a branch form Keith's tree.  Commits in block
>>> tree are, AFAICS, cherry-picked from it, with lore links and Jens' s-o-b
>>> added.
>>>
>>> I'm fine with using that, just tell me how to refer to the branch in
>>> question.  Jens?
>>
>> Are you fine with rebasing that one again? Seems the better approach
>> since it's all in one spot. The git location is:
>>
>> git://git.kernel.dk/linux-block for-5.20/block-iter
>>
>> which has all of them, and is the same base as the previous one. Do you
>> want a signed tag, or is the branch fine?
> 
> Grabbed, rebased and force-pushed (identical tree object, so probably
> hadn't fucked it up...)

Great, thanks Al.

-- 
Jens Axboe

