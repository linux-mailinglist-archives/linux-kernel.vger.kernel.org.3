Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D2505FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiDRWPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiDRWPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:15:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE54427B3F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:12:49 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c23so13493425plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sWWX2GTsw+MtALKWmopT7j+jipc7W7igl5gIqNLQGM8=;
        b=BX5jTyHiYa5maCfpHH901AGhqCKQsy/+DQaDL94UEpRWnk8etBqCxBqNNWcBzGoXdJ
         gMu5lQWoN2whmbKR/G8jsoSV8FdAaM4RiGCicjbGBy9dG3DTr4wgtSsLU5NhLzQVDxzG
         xkgYtHmpEhu7uoJoFELzg55/FkwqXDAg//bJVZbFrmDXk7WHyM+/AIyoD8Wt6zPSphsZ
         whvY+xVbBx5g03mOidV1JRxzidfuKXWUAiupujdt0z87gJLAFV1LFl2BIeRgc6jmpifo
         9IZUyOcm+Nd/hd2iINbRWglyjgJvNgh53ykjVvrHA0ih2I06tZQiNh3f1ho0OydBe7VU
         9J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sWWX2GTsw+MtALKWmopT7j+jipc7W7igl5gIqNLQGM8=;
        b=NmqNVPm9R+W5d0PJouLjHlqt/dr4iDQTp1G2xIJQytnNq0OjyGNSzC5iF9TTQL5FTp
         ufGtBwnDAsp3DTeqQuno4WmtxiaUhBGZpFFEGLOTceef87e0Vci7BGJhAFC/cQeHrkMD
         oRbkd4G4Q3jC7U0kJX1/xIfe6ifbt7ttxWpZCwlqWEVzLhTTrJniQ14+nBG8RSyjO1yL
         lD0TpCrrZWyvCzG8Uovwwl99KtovoqCsN46flj53h8eVwPK5AYvfy21wMeuxS6VraVOj
         cQzIXGkSvVafXcioI5PXqcBZzI6ai6o5RxRRVVjDbaJ2xbZNYvtH3KSMH+8Wawl1GmHb
         W6lw==
X-Gm-Message-State: AOAM530o2VIUEpd2GnliqG9bCb5BR0LzJ0rpWQDxbebIMWuV0zdsf3kl
        Xi5oX/xHe1++X3ouLoxyvGcVcg==
X-Google-Smtp-Source: ABdhPJwIjo3q1aAqS/oJjejwoLjmMkb+36qpIvU50nyfibKCTlL44ams67cHZ/9lQPsl29vYf8DhUA==
X-Received: by 2002:a17:903:1210:b0:151:fa59:95ef with SMTP id l16-20020a170903121000b00151fa5995efmr12993125plh.57.1650319969360;
        Mon, 18 Apr 2022 15:12:49 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i2-20020a625402000000b004fdf66ab35fsm13731333pfb.21.2022.04.18.15.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 15:12:48 -0700 (PDT)
Message-ID: <df4853fb-0e10-4d50-75cd-ee9b06da5ab1@kernel.dk>
Date:   Mon, 18 Apr 2022 16:12:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2=5d_fs-writeback=3a_writeback=5fsb=5fino?=
 =?UTF-8?Q?des=ef=bc=9aRecalculate_=27wrote=27_according_skipped_pages?=
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
 <587c1849-f81b-13d6-fb1a-f22588d8cc2d@kernel.dk>
 <CAHk-=wjmFw1EBOVAN8vffPDHKJH84zZOtwZrLpE=Tn2MD6kEgQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjmFw1EBOVAN8vffPDHKJH84zZOtwZrLpE=Tn2MD6kEgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 4:01 PM, Linus Torvalds wrote:
> On Mon, Apr 18, 2022 at 2:16 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> So as far as I can tell, we really have two options:
>>
>> 1) Don't preempt a task that has a plug active
>> 2) Flush for any schedule out, not just going to sleep
>>
>> 1 may not be feasible if we're queueing lots of IO, which then leaves 2.
>> Linus, do you remember what your original patch here was motivated by?
>> I'm assuming it was an effiency thing, but do we really have a lot of
>> cases of IO submissions being preempted a lot and hence making the plug
>> less efficient than it should be at merging IO? Seems unlikely, but I
>> could be wrong.
> 
> No, it goes all the way back to 2011, my memory for those kinds of
> details doesn't go that far back.
> 
> That said, it clearly is about preemption, and I wonder if we had an
> actual bug there.
> 
> IOW, it might well not just in the "gather up more IO for bigger
> requests" thing, but about "the IO plug is per-thread and doesn't have
> locking because of that".
> 
> So doing plug flushing from a preemptible kernel context might race
> with it all being set up.

Hmm yes. But doesn't preemption imply a full barrier? As long as we
assign the plug at the end, we should be fine. And just now looking that
up, there's even already a comment to that effect in blk_start_plug().
So barring any weirdness with that, maybe that's the solution.

Your comment did jog my memory a bit though, and I do in fact think it
was something related to that that made is change it. I'll dig through
some old emails and see if I can find it.

> Explicit io_schedule() etc obviously doesn't have that issue.

Right

-- 
Jens Axboe

