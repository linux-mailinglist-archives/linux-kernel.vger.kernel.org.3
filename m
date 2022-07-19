Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3561957A459
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiGSQwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiGSQwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:52:16 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E5150733
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:52:15 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 125so12296708iou.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LJGlrT8MzUedVP3AsnU5o6TUFTYJ64RH2Qt3BsXByJ0=;
        b=7zDPDQSFAQPuoONc0p84pfOLOUcYoEulAkPwK/ZbaiWjOuObqCIyKGxfb9ZMRgebzy
         sdO8gjFzovQiK2uGDRhU8jrBtrdScDqj/UXPzLoHoK8zUvxjXr0P/M03MBm5ZPZMkLtV
         7wtxZotc8wmff43nIQxYTcadqQqwv+pUQfyG5Ccvm+Zjm8654wgxYA1KJ6GM1KICkEpc
         eE78pc4SbjIFRrUiChfquyv1fWusbMVfD3ljilugJme/JCN1tGQIIQhDelyBu5Q8ww0F
         T4IzH9xMb9cBvBdPt6IGlUQo9o2kstEdr6+Xot96bdb6dS31TT/BSjoHUsd4bE33HOux
         Gd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LJGlrT8MzUedVP3AsnU5o6TUFTYJ64RH2Qt3BsXByJ0=;
        b=PRQIDe3T/181cQl9fHRoPxCtASCJ3tkIfYg6j8SYRf/q8Nh2JxH2XTc/Vr8FyqHjqb
         Jtj5FEJYFFfYFvsyVVBgIr11rMQZ7TLogi7q2LnlgrwZneT4GIBPFbksVlBT6jdaFje7
         jRgNar3Ul/2am/HuhyDDaYIeWZxDL3PL1ym6V1+BOs5/D/FQuwn02whnvLPp73UVpZAq
         r/qg0Krc/2CQ5uhyk8oOBhsTEptF4NvEz0TjA8ZbDPHsrSIURilrRUOlUVnxHK4UaBj3
         byG7HLg6TI196ZO7kuNJkS4uZG/TfHSkhwVmvsmxuUL2xIn7tkXt+ErwAVOWAuOdL/ZJ
         07kQ==
X-Gm-Message-State: AJIora8z8krmZSAAp23ZacE1XSTFON2YG+yBxnm7EszTJ8WI4L3oNNOT
        3Gh0B9rFMr/+H4VZGzICYQJfcu/4ywZ1mg==
X-Google-Smtp-Source: AGRyM1u8p0wpJigFLz0W9l1pCgeA47X5QVVHayUjdfwo2cSelVeWoCucsJMP3eGNSPyqXOGzf72Jrg==
X-Received: by 2002:a05:6638:270d:b0:33f:3f96:468c with SMTP id m13-20020a056638270d00b0033f3f96468cmr18491318jav.272.1658249534417;
        Tue, 19 Jul 2022 09:52:14 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t16-20020a056602141000b00675a83bc1e3sm7418931iov.13.2022.07.19.09.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 09:52:13 -0700 (PDT)
Message-ID: <a43c8f77-a15f-ab1b-579c-feeeb8bd8593@kernel.dk>
Date:   Tue, 19 Jul 2022 10:52:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220714120840.1e1f8c63@canb.auug.org.au>
 <0904ae71-972f-f183-f295-bce3b8518fcf@kernel.dk> <YtC6SUmyaCSKe2HX@ZenIV>
 <YtC9AgqezKXuUoy6@ZenIV> <20220718125932.1ab89122@canb.auug.org.au>
 <YtTofKIkWU4eXvoK@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YtTofKIkWU4eXvoK@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/22 10:58 PM, Al Viro wrote:
> On Mon, Jul 18, 2022 at 12:59:32PM +1000, Stephen Rothwell wrote:
>> Hi Al,
>>
>> On Fri, 15 Jul 2022 02:04:02 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>
>>> On Fri, Jul 15, 2022 at 01:52:25AM +0100, Al Viro wrote:
>>>
>>>> Ones from Keith's branch - #alignment-fixes-rebased in there.  Looks like
>>>> one of the commits in it got changed since then - the difference in
>>>> __bio_iov_iter_get_pages() (unsigned int i initialization).
>>>>
>>>> Sigh...  I'll rebase on top of that.  
>>>
>>> Rebased and pushed out (with copy_pipe_to_iter() fix folded in as well)
>>
>> BTW, these still cause a conflict.  As long as you are sharing patches
>> (and then adding changes to the same areas), there will be conflicts.
>> You need to share commits i.e. a shared branch.
> 
> Sigh...  That was (and is) a branch form Keith's tree.  Commits in block
> tree are, AFAICS, cherry-picked from it, with lore links and Jens' s-o-b
> added.
> 
> I'm fine with using that, just tell me how to refer to the branch in
> question.  Jens?

Are you fine with rebasing that one again? Seems the better approach
since it's all in one spot. The git location is:

git://git.kernel.dk/linux-block for-5.20/block-iter

which has all of them, and is the same base as the previous one. Do you
want a signed tag, or is the branch fine?

-- 
Jens Axboe

