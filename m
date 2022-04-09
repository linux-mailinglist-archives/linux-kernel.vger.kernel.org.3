Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EBA4FA8F1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiDIO33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiDIO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:29:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F4C49
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 07:27:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g20so13071953edw.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VnRqAxbBSJiOT0qnggIVf3Uo/0FEFMXAxgN78+BZAGA=;
        b=kwBSLc6wR8xpV8lonIJ07GU/O0s570O8AqLJ9/YhVJx3j0vrexLv1sPXKQUIu+YB5m
         Z/l1QRYCYKshHTLufUNZYr5SjhLhUas6xPBvR5nI9zWlr4u+q5Y00pUswmG8ce67QLjy
         8fY8d6JJDvuWvmm7tKcBbY5f/JZNvWXrWdv9cqn2QnOJwdm4aVn3yX0ePzJgBkCQDsaI
         cW7rVwZtD5fH8Bcmy5PHrRrrSr4+Vo9KcvOTBVEW2zI8qG/qQNotURH9lHdhuZ04VmPO
         go3KKcPU35O9/ZRly0kJBroHo9qI27wr0HzfmiLI4k4Vie+jSlwSbEeMDK/DK5KWiQ5u
         A2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VnRqAxbBSJiOT0qnggIVf3Uo/0FEFMXAxgN78+BZAGA=;
        b=yFVsZKmbFBkAke0mI7mn3jIYgHZowNn+UTDiv06favE6gRIHdI56n4SUIDn4q+fueh
         ED2L7vMsOQWEx4DKxKqzvb6T4o/BxCpb7U4uzJgkHuM/O8hQnFyjAYpX4xDgVF0Fkv9X
         cyUpfCfbhzrU2kmUfy5L4PmY9ulcsuyXR8P8GFp7fXQnU8zLIbCHz4DX+YZi+ooledIH
         o2kap35I5QpXpuEW5E6BijpA72Mu4E4DOXgi5v2KsV0EAdgKeb+WhTSfW5WkeAXXr9fm
         LB7Qe/eeK5qDDv6SlVvx0sIvflZStRwZX3T+EKJpQTHBbmUPNBw43TiIs8H0kCfxZ9wV
         dsow==
X-Gm-Message-State: AOAM533KGFxywnymLBeszGuDTIh5RDkFMw+ogQ/hg1tCun8eFlLOCOCl
        6H1JrZZBVDNg+q2J/L7wync=
X-Google-Smtp-Source: ABdhPJzTUgfQOGe92yo7zilHLXxu6T6oEquhi3ZjKO0CdO2hjB40oOgTPTVfjPB2CJk0W/EIuH/8Dw==
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id y13-20020a056402440d00b004129e8a5e51mr24747197eda.362.1649514438081;
        Sat, 09 Apr 2022 07:27:18 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:1f4f:2923:d7f1:41f2? ([2a02:908:1252:fb60:1f4f:2923:d7f1:41f2])
        by smtp.gmail.com with ESMTPSA id a12-20020a170906468c00b006e874be7420sm553215ejr.60.2022.04.09.07.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 07:27:17 -0700 (PDT)
Message-ID: <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com>
Date:   Sat, 9 Apr 2022 16:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     thomas.hellstrom@linux.intel.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>, Ken.Xue@amd.com
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
 <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
 <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.04.22 um 19:25 schrieb Mikhail Gavrilov:
> On Fri, 8 Apr 2022 at 19:27, Christian König <christian.koenig@amd.com> wrote:
>> Please test the attached patch, it just re-introduce the lock without
>> doing much else.
>>
>> And does your branch contain the following patch:
>>
>> commit d18b8eadd83e3d8d63a45f9479478640dbcfca02
>> Author: Christian König <christian.koenig@amd.com>
>> Date:   Wed Feb 23 14:35:31 2022 +0100
>>
>>       drm/amdgpu: install ctx entities with cmpxchg
>>
>>       Since we removed the context lock we need to make sure that not two
>> threads
>>       are trying to install an entity at the same time.
>>
>>       Signed-off-by: Christian König <christian.koenig@amd.com>
>>       Fixes: 461fa7b0ac565e ("drm/amdgpu: remove ctx->lock")
>>       Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>       Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> The all listed games are now working with an attached patch.
> Also flood messages "WARNING: CPU: 31 PID: 51848 at
> drivers/dma-buf/dma-fence-array.c:191
> dma_fence_array_create+0x101/0x120" has gone.

That's unfortunately not the end of the story.

This is fixing your problem, but reintroducing the original problem that 
we call the syncobj with a lock held which can crash badly as well.

Going to take a closer look on Monday. I hope you can test a few more 
patches to help narrow down what's actually going wrong here.

Thanks,
Christian.

>
> Thanks.
>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>

