Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF94D2710
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiCICn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiCICnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:43:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3E559E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:42:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so3919806pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 18:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Nq5oE57ceqvDWxpK4wSnF7NhZzcG0ii3WOnYPCtmIiE=;
        b=CNPHgBnxRO/Su5D1rwSEpCeJKBF/8Fxmi3tFXt1piWtM1cyMre2UFDm4pVUHO7Po5T
         5ZjjgKLIaEMhlpwAAcIfO4WzBLpBNwkzBHT+cdq99A02yqM7efp0c3BLeMSGk3EMCoDb
         4cJF5MD3orXBH/qfc6uNkcyMLL1xZsp5IXz+7v3IM5AUtOS4V1S05Q27Ha4u06GkL83C
         jQxYH38e30FN/jamRg5s1smFzCrSmTHmqsG4oB7uRwpz0EJ47MJ7NbZBOa/5s8bQ7Vdk
         hc2Jc3PM7qg9NQpTeBW7U/z3Zv/6gzElgVSFICvHjUnjcGrzWW3g2z6tO30QBHod7fQF
         ySxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Nq5oE57ceqvDWxpK4wSnF7NhZzcG0ii3WOnYPCtmIiE=;
        b=2iY+786pYXoRpcb4OHpcn0s96yhHBl/SSSymdqlydPqulmoEKCdpZPxTYRcJjY41CE
         +zzc9t2YEyXKDYiXMlJ7bjZiQwx2OZpDAabVqieWAaPhxb1hc6U0N+mHL7Rd+B8Q/TPy
         DusPoqvHh8nhJC2OqAeMXsqlt0eQhRSFVavyZJXfgtbbWQoHlRwlDmS3YcDK9n8d4pGh
         3RknPjfjuDmm0f5mU8ZEVdan9lr6xLvfOMWa07sPSj0nT+YL0onU+CcljkrHn5i6Ay6z
         fZ5xwULe1CShXEG1vIM7HFkgPBGsZfWqhthHlEni/OIwHFaFvhDwMeZ4zjUz4ZC5O1YD
         r1Ng==
X-Gm-Message-State: AOAM533ngUC2/S4XI9wu/9LL+ZUl8WroNwhF7MZA8A8vScEhHxVERWI7
        Ec6LbrAKbD8lUHiVhvddBk5GJcPpbYG5zyqR
X-Google-Smtp-Source: ABdhPJyaTCleWFwk3rJ0H3rrAq8MB+MdZpKF/eeKm8eSpSTUKIbuOQZGbaX8IrOEsf/H0mnZzQ0WKA==
X-Received: by 2002:a17:90a:4f0b:b0:1be:e320:3e62 with SMTP id p11-20020a17090a4f0b00b001bee3203e62mr8040905pjh.124.1646793745041;
        Tue, 08 Mar 2022 18:42:25 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o185-20020a6341c2000000b0036fb987b25fsm434188pga.38.2022.03.08.18.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 18:42:24 -0800 (PST)
Message-ID: <52b0a497-fa46-fadd-d6ea-a5d4d5ce90e8@kernel.dk>
Date:   Tue, 8 Mar 2022 19:42:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220309131638.26600d10@canb.auug.org.au>
 <fac2395b-9ad7-4c57-3d4a-ce6ba097ffb3@kernel.dk>
In-Reply-To: <fac2395b-9ad7-4c57-3d4a-ce6ba097ffb3@kernel.dk>
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

On 3/8/22 7:33 PM, Jens Axboe wrote:
> On 3/8/22 7:16 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the block tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> In file included from block/blk-mq-debugfs-zoned.c:7:
>> block/blk-mq-debugfs.h:24:42: error: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>    24 |                                   struct blk_mq_hw_ctx *hctx);
>>       |                                          ^~~~~~~~~~~~~
>> block/blk-mq-debugfs.h:25:44: error: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>    25 | void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
>>       |                                            ^~~~~~~~~~~~~
>> block/blk-mq-debugfs.h:32:47: error: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>    32 |                                        struct blk_mq_hw_ctx *hctx);
>>       |                                               ^~~~~~~~~~~~~
>> block/blk-mq-debugfs.h:33:50: error: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>    33 | void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
>>       |                                                  ^~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
> 
> It just needs a forward declaration. I'll fix it up.

Fixed and pushed out.

-- 
Jens Axboe

