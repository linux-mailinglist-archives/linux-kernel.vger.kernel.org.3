Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77BD5307D2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353203AbiEWCwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345712AbiEWCwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:52:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F2C1EC48
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:52:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so12390361pjf.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rvYIyk1yb20798ouuDUQxf3Rwf5JHSIlW3fsEoAcKMg=;
        b=Zc5IjWlWFQ7egKRL58nFYhMlVqHAp88MafypBjzxVXnl1Z+jU3XSfrsqFlmDm6out9
         NZpOyahDej5a1393DubgBMSzwNDWOe7gP17vAqkUvAls6FOd3AiizK7ec0jSxs2Rj+Zv
         16NMD/B9srrP4cejxXORlceBPaSD7nYE0tM7D3HrkkgFvj84p6e5gDFWC8OrUD+BbI3A
         AfwBpxj/SqyIuTYQyq1YVC/iPljmTDVQpBZAvatV8X3kwTtKHC+Vt/xLrDTOm8aFJp+r
         NNG5KVb7rfvypQr96amiuxqbkRxiu36L2AqCZEdThq5J0SpPI3MctaCeUA1djDnfk43V
         O87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rvYIyk1yb20798ouuDUQxf3Rwf5JHSIlW3fsEoAcKMg=;
        b=IKj8MnXixCgSOm/b5J3+8IL4D1ufJxjwRUiyoJ0nzJNwBTD2zYOylVJLVFP44N7rOl
         fbAMDBGLtB+NV7yXL1mFjZgHdqHjl6cWXujGo1jfJvRSyOtynPsGljMKFFVTcEPxHwJr
         zxLOqt5Zn26zUt+AlFjPP8n3XDyXP3vOOJMacIedi/PiQa03zoYR84ijFiOcCG7ugHWm
         tpsZWq1/EHWaOUzwU+iA7K6gv1savaAOBKfEVilbXhsFugOWmju3kiZ0dqg3tessP79h
         4a+svOf33ps9j3cr7zkd4YoDl69CsoQ/6sFG9RC8fI5xxlWTPaNmTp4X34+UXKEjplLC
         K9JA==
X-Gm-Message-State: AOAM530Jt9t4yzGwX14LxYJuYA8Bpmyot10x4V9MWbCLLtll4NlCjZtr
        lbEhe/A0ETKRkpNpAgig+0kWZw==
X-Google-Smtp-Source: ABdhPJyaBjpk+NdPSFZh+kl+4SogHky0a9Ra0JCghE4MT6zExngfwomvnpjPNjO7cKgxh1Hpn7e8Ng==
X-Received: by 2002:a17:90b:4b52:b0:1df:c1ef:2cd1 with SMTP id mi18-20020a17090b4b5200b001dfc1ef2cd1mr24154304pjb.130.1653274329849;
        Sun, 22 May 2022 19:52:09 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c10100b0015e8d4eb228sm3809450pli.114.2022.05.22.19.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 19:52:09 -0700 (PDT)
Message-ID: <df3ffbac-2f4e-df03-8b29-8e2e4bb69fac@kernel.dk>
Date:   Sun, 22 May 2022 20:52:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Coly Li <colyli@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220523124921.7d6bbf34@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220523124921.7d6bbf34@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/22 8:49 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/md/bcache/btree.c: In function 'bch_btree_check':
> drivers/md/bcache/btree.c:2073:1: error: the frame size of 2184 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>  2073 | }
>       | ^
> 
> Caused by commit
> 
>   c766acd3d78e ("bcache: improve multithreaded bch_btree_check()")
> 
> struct btree_check_state is very large to put on the stack :-(
> 
> I have reverted that commit for today.

Thanks, I'll drop it. It's not part of the initial request sent to
Linus, exactly because it arrived late.

Coly, I'm dropping this series.

-- 
Jens Axboe

