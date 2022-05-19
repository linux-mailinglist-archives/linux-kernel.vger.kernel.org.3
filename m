Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4092852DDFD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbiESTze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiESTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:55:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B2757167
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:55:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so6151152pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=POpUVEN6oy4tO2eZnZDGT+FrInZPwGgApSmhk6JzbPE=;
        b=ffyjkO+by7F3Dq5NgZinDZ5my4tGUEy9ORW7OvCdZkBB2Uj/JmoMy3Xo2vHdjmgA7H
         wQKVjJIYf0aovAlo/vzP85H9Qr4q/BETeqeEvMZdtdzP+2gmDWBrWIAmf3slbPpyphRI
         PExamdSwVfyKS0GC+1EEl7PIS1IwrfaNvsrO0l1E7YZ1Mr/Z63stUjbeRWE2ctm6BpaY
         k62GvGVEPE8zU2FSZmWdwgOeyWkX4wZ19aGm0Hkp/uBkAatyfkZB+FtkycTb8aitzPdC
         VZ3Ep4pPh3QKilkt/c++6v5vVTKPEMrJIAqpPqnhwL8IsdbjNG3vh+SFXiTm9b0Es7jn
         RXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=POpUVEN6oy4tO2eZnZDGT+FrInZPwGgApSmhk6JzbPE=;
        b=s2rVQrkuZA1JyOcwKnqCBawh3igOTRX9sTTNK2ablekV8usIFwN8tTCUpaKpOPX5OC
         rVpYdFzjTxsnX9Oo+imp4tr7Z6dAnaXH3kZEn7NVYCskAYLqbyVVq36atUQS9hLQbK6g
         eVf00Due7l0uPU/hZp1m+yHAWdiX+VYNqfOY+eYbSciVG7Q/tJGuYONb7/wWAwgbHC4X
         NKzZLNK/v0oo3O+DhCmq7vl3SlgcB366HPLZY6icncVIrKp8UgYFrOP35+6+WmHO+IdC
         rNugAB6+Bk+W4c5q2wSI98IrtvgTqQHeC2JldpV2hwyuGeCwaxCoUlpvZMktMKWIKD8a
         xXlA==
X-Gm-Message-State: AOAM533tkiAoJLJBJEngTRyXb87/l88jh24xsDnsJvSqARfJ5e4+LvJE
        o8l/dxk0d/DhXo2AIDnKVNZFe45R3XCZ8w==
X-Google-Smtp-Source: ABdhPJwLrOt/8XuaRTcjZT1tPBJv1F87Z8sx0kWuK41HwvJnTW/VO89g5wzfZrzw+XKVLLZ6DFCG9A==
X-Received: by 2002:a17:902:690b:b0:159:65c:9044 with SMTP id j11-20020a170902690b00b00159065c9044mr6410152plk.47.1652990128598;
        Thu, 19 May 2022 12:55:28 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21cf::196b? ([2620:10d:c090:400::4:84c5])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090a5d8600b001dcc0cb262asm211122pji.17.2022.05.19.12.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 12:55:27 -0700 (PDT)
Message-ID: <83183894-155a-efe7-ea0d-a3d88ebeadb1@kernel.dk>
Date:   Thu, 19 May 2022 13:55:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     tytso@mit.edu, Jason@zx2c4.com, linux-kernel@vger.kernel.org
References: <20220519193133.194138-1-axboe@kernel.dk>
 <20220519194838.GA6361@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220519194838.GA6361@lst.de>
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

On 5/19/22 1:48 PM, Christoph Hellwig wrote:
> On Thu, May 19, 2022 at 01:31:31PM -0600, Jens Axboe wrote:
>> Hi,
>>
>> We recently had a failure on a kernel upgrade because splice no longer
>> works on random/urandom. This is due to:
>>
>> 6e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
>>
>> which already has more than two handful of Fixes registered to its
>> name...
> 
> Yes.  It was a hard break to get rid of set_fs and it's abuse.

I'm a bit torn on this one, because I _really_ want us to get rid of
read/write and make everything use read_iter/write_iter. Firstly because
it's really stupid to have two interfaces, and secondly because even
basic things like "can we block here" doesn't work in the older
interface without fiddling with file flags which is a non-starter for
certain things.

However, it's also problematic that we end up breaking real applications
because of this change. Arguably we should've converted existing
read/write first and avoid this grey zone we are in now (best solution),
or provided splice read/write helpers that work with the non-iter based
read/write handlers.

-- 
Jens Axboe

