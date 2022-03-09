Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4BA4D27B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiCICeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiCICeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:34:08 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433932058
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:33:10 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g19so1009053pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 18:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tvi+CbjBZiaWt83v4DDYcOeSUIz7fvyu9NHoATP31MQ=;
        b=EHu3Vgl6G16UPOPzkJySlDlLsFfXzlh5uKmwP/vkUh55Tapii0hN3/FDBrGZSecMgH
         Ubq68jw4L9Kw5h5+9ZjEBI4azPkOAS61alAvOM/Y+tVJwb9C1/jWnuWICAlf80Npnokr
         7D7atmo5BBTY37TbExAkqA2RxthXeulom6/EwJiHqk+KWA8Omr9KWa6fNmTu22CIsWz0
         D+ftNx4mMWq2/x0/XmYW/CQ4mc8GgZXZ1hWSux7CYx4mcQq4f3/qNSdaJNKVKxpmKih9
         hZfOwKYVqERYhctPnn7hGSL8BYwqyRo9ATLwSR45S/XqLaZXijMjyxk5CyvEOQ9VEIsR
         EkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tvi+CbjBZiaWt83v4DDYcOeSUIz7fvyu9NHoATP31MQ=;
        b=MgyhbU2JpKXztmyAMdMCKkwDhoZC/Rt9Am8qiaxF4SyawOYrFqO8aj1W/YI/FR/sht
         iXi+L4lTaPGONzA3vmuDBqmBugIC2AtZ8PWJuDR2oGeTUuv3Ca15OtDgF0HqNWRLaOci
         A4hKfNPh8PzvBWjSRvSfu8InbH+0mjZG+FJyxgnyYkhA1fR4vJcHnWVGeC+G/oa38kS9
         m6jFFBhujS9oELwBsYM3hnIMNDSEtK3d6cQ08hv6USBWmf9nYsu3zv1TlRIsLTj9RpNw
         DFF2L124Dp9ufST0b1IP2HX4xHgLG6lxMg1TNt8tfULoiQV1Ff9Usy60x96UuEOVl3XK
         xiOA==
X-Gm-Message-State: AOAM530ND9Y2JGKaafpN/iah3nP9+PXX3rhg9dUAJOLl/1FtdKNsn74V
        3TMaZmOqRqRJYsdHLKblVIa58SjYiK7P3xE2
X-Google-Smtp-Source: ABdhPJx0UxqWu9BRtnm2GIMgJ2kxbnOX7bMhCwWVJJ5KuFPttt/KLmBTAfSEbY5yBquyE115vcpfaQ==
X-Received: by 2002:a05:6a00:190f:b0:4f3:a81d:c4c3 with SMTP id y15-20020a056a00190f00b004f3a81dc4c3mr21434773pfi.45.1646793190222;
        Tue, 08 Mar 2022 18:33:10 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f4-20020aa782c4000000b004f6f0334a51sm434924pfn.126.2022.03.08.18.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 18:33:09 -0800 (PST)
Message-ID: <fac2395b-9ad7-4c57-3d4a-ce6ba097ffb3@kernel.dk>
Date:   Tue, 8 Mar 2022 19:33:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220309131638.26600d10@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220309131638.26600d10@canb.auug.org.au>
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

On 3/8/22 7:16 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from block/blk-mq-debugfs-zoned.c:7:
> block/blk-mq-debugfs.h:24:42: error: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>    24 |                                   struct blk_mq_hw_ctx *hctx);
>       |                                          ^~~~~~~~~~~~~
> block/blk-mq-debugfs.h:25:44: error: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>    25 | void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
>       |                                            ^~~~~~~~~~~~~
> block/blk-mq-debugfs.h:32:47: error: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>    32 |                                        struct blk_mq_hw_ctx *hctx);
>       |                                               ^~~~~~~~~~~~~
> block/blk-mq-debugfs.h:33:50: error: 'struct blk_mq_hw_ctx' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>    33 | void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
>       |                                                  ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors

It just needs a forward declaration. I'll fix it up.

-- 
Jens Axboe

