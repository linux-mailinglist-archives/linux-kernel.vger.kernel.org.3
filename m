Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D264D2783
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiCIBQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiCIBQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:16:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01047058
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:59:42 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so868279pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KpeRyglq/KKb6h+FPp2kPuLZPFCdso3DNN8oDwE8uJM=;
        b=sIS5e4ip/C/OQYpC1HbLN3p/gS7oZxzSenbpbk+Qu9qLfk3/4NcyDvpTulApQ/5YfY
         WEKzfrYxC89sfiwYPEegV84r0VtDAe2D7NhN4aWUuf6RBMjuPh933SqiiZCJyIHQNx/7
         4baLL4jVOMHMGwCj4xDzFSITORK6f4cvgrftMHEDfboidOgt9TEh6GsO0QETUDU9SD6w
         zqO3gJNJlqBoBIa56IB9qzZ9/S1Yq7VQ1mhODDkMXTleAXn0U6au23rOZMtlmM3dbOhC
         xkckm9zeJ0G8AQO1pOjy8WSt9SFZv4bMVALpP2eY0xCFNunsNQ/Ao3CdcdHtPmqKkJHo
         hWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KpeRyglq/KKb6h+FPp2kPuLZPFCdso3DNN8oDwE8uJM=;
        b=vlAItGI6+xwZkJDBemA3q5lMezHTocePjcQ8aId+TyYjOHTB1YnWc/rRhm8vtlres9
         z15IiFsLsREpAn+yHJ8UbSfikneOUZoy/hO1tJRabKNVDPuLFwfupY3euLUKxEsZAZ/y
         BK76SroFiGA1+WnkxAieDMfc1C4Q74LSxL9A5ILEmOiXtDFs4ca8OGGZiHfiQ0hSb+/H
         OAU4vpe5Q7ZZu7vBQpv271rHBhmiKIHe5lElX1pfbKL7bD5h7jQBEuSidw1S7hqaYSD/
         TtsYJmXhE20MtqUoMLEqb8aJzummNaqHk1pGnWxUjPWMrxMoc5wu0FV+nrrk0VBmvUoc
         4sNg==
X-Gm-Message-State: AOAM531lNpxtOp8zMxUHQ0L7Oxg7tKiybdzba9aP9uskJdYRTdeVXT8p
        79aGjj6a9E0We23k3EyZXfb5EKLMeAsoRm8X
X-Google-Smtp-Source: ABdhPJw509jIgleFtjR4YJQ7shm6aXQ4P7p1SQgvGOXtMNxP2WiXmawU2fT5sxJzQFM599gtPxX+yA==
X-Received: by 2002:a17:90b:e08:b0:1bc:2b0c:65aa with SMTP id ge8-20020a17090b0e0800b001bc2b0c65aamr7527206pjb.102.1646787581515;
        Tue, 08 Mar 2022 16:59:41 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id om17-20020a17090b3a9100b001bf0fffee9bsm4519603pjb.52.2022.03.08.16.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 16:59:41 -0800 (PST)
Message-ID: <779bf1fe-7f58-51ed-27e8-1152375780ff@kernel.dk>
Date:   Tue, 8 Mar 2022 17:59:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] f2fs: pass the bio operation to bio_alloc_bioset
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220228124123.856027-1-hch@lst.de>
 <20220228124123.856027-3-hch@lst.de>
 <782226e0-5e7a-aec8-b9aa-e7fd7b3110a7@kernel.org>
 <20220308060624.GA23629@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220308060624.GA23629@lst.de>
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

On 3/7/22 11:06 PM, Christoph Hellwig wrote:
> On Tue, Mar 01, 2022 at 10:49:06AM +0800, Chao Yu wrote:
>> On 2022/2/28 20:41, Christoph Hellwig wrote:
>>> Refactor block I/O code so that the bio operation and known flags are set
>>> at bio allocation time.  Only the later updated flags are updated on the
>>> fly.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Is it okay for Jens to pick these two patches up in the
> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.18/alloc-cleanups
> branch?

I have tentatively done so, let me know you prefer doing it differently.

-- 
Jens Axboe

