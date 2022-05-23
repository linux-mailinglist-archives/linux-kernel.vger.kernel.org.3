Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1233F53106E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiEWMbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiEWMbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:31:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB202D1C9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:31:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 202so6557191pfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=drc5LnU//nothzoPqQ8d1G4VXl7oy7LH+bWASwffyS0=;
        b=cUjzWmvkn1g+Ctnqb9MUltJvIF5FuQsDRBOLVuQ/2DACJACoScCPORIK0YNVEvtYJW
         7mnjzKll6XZsFk9zw0VVRjk+GagEMU1q1FQvFN/qMWvY9SQ2+58l9+WcPpN5ix29NgGi
         u4Xo4WZXPKpkd5RcyH7ClkcGPRfSEYtuskl+1oSh6sezlpOlByJQ/Aypi7bUJO2mhgLv
         bYMaAOyvdXmmHNNgMOnY7f9Wi/bvXJZKBPJ3S6Xs/5mMvjwOF21UH7F6qGOHwpt2c9N1
         EK5FTv6xjaUIz9dNJRsle5vJmw3rwCWHp4zT2F48v9wMPTqHpoDaYiQseopL6Xq4PswJ
         ZqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=drc5LnU//nothzoPqQ8d1G4VXl7oy7LH+bWASwffyS0=;
        b=E2ao3soaOJNQ1s+7OKfV/KHC3c4syu1dyKJnQOGKIdzPRNf9ZEV+Wfjygpvwd50Cpi
         0RnSlBkBtWTWKalynfAYYXSym6xD5mwSqyUBs6Kf2nKoiKmpHip9hsi9dGfBomItiLpE
         8P12rdWx+py4jnVaSfnCZIhFAclERwxjt/gHS6dsqx1OZ1z8Es0pBxjE6cx95WkY5x5c
         JMembMOcRva4QkiVU1+ak5/cJqGe+xpwZp6wz9LaQwQ6f6dMPXOj1YT9SH0h/ZXLKfyW
         srSekfJ5qTzk1YVN4VOvhO0ALl9eaUbYbSMknbCs2zfofXLg5vkcIJ+50P8R7ZscqNPu
         S9aw==
X-Gm-Message-State: AOAM530cXtLiNHOv7h7wJeQA4zeGeihxYA+uv6q+chDMDA/5441jqiHN
        AxCLmZz7WTTwRIHd2h+kP32jkA==
X-Google-Smtp-Source: ABdhPJwgWclUcyvYUV+ZStu0nHJ4/FYeTiOk1bWWebykY/Rdx+WsX/KSJ4QAglqBV2Jfvlj9RLHc4Q==
X-Received: by 2002:a63:3194:0:b0:3f6:a28:77cf with SMTP id x142-20020a633194000000b003f60a2877cfmr19688940pgx.264.1653309089024;
        Mon, 23 May 2022 05:31:29 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902b61000b0015ec71f72d6sm4995468pls.253.2022.05.23.05.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 05:31:28 -0700 (PDT)
Message-ID: <b12eb111-ea5f-e396-d7b3-249bf1e45e9d@kernel.dk>
Date:   Mon, 23 May 2022 06:31:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To:     Coly Li <colyli@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220523124921.7d6bbf34@canb.auug.org.au>
 <df3ffbac-2f4e-df03-8b29-8e2e4bb69fac@kernel.dk>
 <f1a9c46e-59a6-7b68-fd17-6f2563e24e98@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f1a9c46e-59a6-7b68-fd17-6f2563e24e98@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 12:05 AM, Coly Li wrote:
> On 5/23/22 10:52 AM, Jens Axboe wrote:
>> On 5/22/22 8:49 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> After merging the block tree, today's linux-next build (x86_64
>>> allmodconfig) failed like this:
>>>
>>> drivers/md/bcache/btree.c: In function 'bch_btree_check':
>>> drivers/md/bcache/btree.c:2073:1: error: the frame size of 2184 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>>>   2073 | }
>>>        | ^
>>>
>>> Caused by commit
>>>
>>>    c766acd3d78e ("bcache: improve multithreaded bch_btree_check()")
>>>
>>> struct btree_check_state is very large to put on the stack :-(
>>>
>>> I have reverted that commit for today.
> 
> Hi Jens,
> 
>> Thanks, I'll drop it. It's not part of the initial request sent to
>> Linus, exactly because it arrived late.
>>
>> Coly, I'm dropping this series.
> 
> Yes please. Should I re-submit the fixed series to you in later -RC
> round, or wait for 5.20 merge window?

Just resubmit it when it's been fixed, then we'll figure it out at that
point. As mentioned in the original email, at the very least it needs a
linux-next soak for a weeks time. If the patches are simple enough and
don't cause odd build errors/warnings, then we can still make this
release if need be.

-- 
Jens Axboe

