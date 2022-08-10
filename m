Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D7858EAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiHJLAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiHJLAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:00:08 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA30E60535;
        Wed, 10 Aug 2022 04:00:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so14050297pgs.3;
        Wed, 10 Aug 2022 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=kiZ0GjFPDluN3W8aPPsegpk1Obyz0Y2e2nbcQbNMIKk=;
        b=WBo1j09+pUgd4BLk8uzp0Baa/VzIULafaH0Vqsbzo546R7Hen63C1BKlvodtNFhqiz
         QYCEKcntPwLU7vds7E4kOr1ynSP/U4ds6q7ybM8PqCmSBaR1q1nIaRDeIx2SkGJvJsJ/
         Z8wUburidhIWJWSpDxj7u5qPhu4ib+IMIAzLLNefE3aNQ3kHRDbmHiMtdIAbkt5wJCzw
         V5leEpU3f56Ga1ouQHPUYZpyeytC0W5++xzRpRq+SuzC5PXYGzdrX7GyH4nypBR+XF9R
         b87z+aXm5FEMxos3xJEDYC1cYhY1Us+BUbztdnjUq8iQbTkhZpWZfFEBTk27xKqO3Tg9
         iYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kiZ0GjFPDluN3W8aPPsegpk1Obyz0Y2e2nbcQbNMIKk=;
        b=g+I3Jqo7cWOU02U675aMgpCnBGTLnwxbY18LS46Fn3OpN6UzpQBPTqbkTwLHBgusZe
         AfWK+N65b8RuKt9BQDLDekHZD6bOLEvp3MUiuYltopnVr8x6Zv1bWY96LsCl60Ci9ERq
         OlHcfKoC0sEcbXPT7uLt1IAE2/aY7iwvKyPi1qfXdKzPWqfyvwbdlJzXp6mI+f3rkyAu
         lydx5OCxC5GMUfrG9tmO3QKku7i2zdWYjqxyTc21qYkmnvIMOqVZKUJX5t5NaMCNoZYA
         NI3VMnpplFYze8/NlHNnMCVD/SYQxUqGn4YJiiEYMUYKnqkt72ztBkfg+dRj6XI9vNRh
         dpYw==
X-Gm-Message-State: ACgBeo0nEqatQ2GTDBMMWuUIFLNyf3zGFd6GDBqdOgCT+Ec6NRNV/bmc
        DhJ0/9qGYNQz6n8Xxs1ABB4=
X-Google-Smtp-Source: AA6agR611g62PBer1d6V3DJjIyh8ixWzC0h3DHoPl+KpCYhB99O/QkBdcNpBmy0YN4O0issm10FKKg==
X-Received: by 2002:a05:6a00:140d:b0:52a:d561:d991 with SMTP id l13-20020a056a00140d00b0052ad561d991mr27058495pfu.46.1660129206096;
        Wed, 10 Aug 2022 04:00:06 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b0016db6bd77f4sm12891114plh.117.2022.08.10.04.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 04:00:05 -0700 (PDT)
Message-ID: <e5775cbb-bd2a-decf-ad81-a861d796e3fe@gmail.com>
Date:   Wed, 10 Aug 2022 19:00:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V2 1/1] loop: introduce LO_FLAGS_NO_DEALLOC
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20220806153022.83748-1-zhangboyang.id@gmail.com>
 <20220806153022.83748-2-zhangboyang.id@gmail.com> <YvLdc8GtbZ968qF6@magnolia>
From:   Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <YvLdc8GtbZ968qF6@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/8/10 06:19, Darrick J. Wong wrote:
> 
> Considering that discard isn't required to do anything, why not
> echo 0 | sudo tee /sys/block/loopX/queue/discard_max_bytes ?
> 

Thanks for reviewing! This will disable discard completely (>=5.19), 
thus the filesystem of backing file has no knowledge about what can be 
freed. In contrast, my patch convert REQ_OP_DISCARD to 
FALLOC_FL_ZERO_RANGE, the discarded parts of backing file is flagged 
zeroed. So there is possibility for the filesystem of backing file to 
discard (trim) the zeroed range, improving the write performance on, for 
example, SSDs.

However, it seems only XFS with realtime discard enabled can do trim on 
FALLOC_FL_ZERO_RANGE. All other filesystems (and XFS without realtime 
discard) can't do trim on extents flagged zeroed. Batch discard like 
FITRIM (used by `fstirm' tool) also can't help here, because no 
filesystem track `allocated but flagged zeroed' extents at filesystem 
level. I will probably write another patch to add the ability to trim 
zeroed extents in single file to FITRIM. (Currently, FITRIM work on 
filesystem level, not file level)

Best Regards,
Zhang Boyang
