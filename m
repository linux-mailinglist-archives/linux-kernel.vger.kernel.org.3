Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05584BB059
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiBRDns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:43:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBRDnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:43:45 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB0FEB2F;
        Thu, 17 Feb 2022 19:43:30 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 12so3183573pgd.0;
        Thu, 17 Feb 2022 19:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yN/a5yAp+A1O77SE+NBh+Z65AOWGwkPFtLthFGjHyhM=;
        b=FTygqvIwaOL/rLpE2cmSpdFbQhEgQdKxgBVWrX4R2HKFk0R99hqa9SxDm1KfnPrOJX
         OE22FBu4vtK5i131on7otz0rHM14HX1S4B5oh5ZLT5Pp20GZvLkS5WVfxiO/8z6AW7T0
         0Pv8O4tLa7fVJkk7Rae4nO9Ay8X+Mx7iyBzfcVMTicEDqyRMEcH7BwGQrm248zHuXLUB
         zsF6YXC+hxDmAYKOOSyjoK+zlJ5W44E8DSYdBL0/4jYbRE8aPjItxO4GWE9knk0sCb+t
         Tgz+lb+Bg9Rv76S7jHP/ILVjgSi7aXTV3EkUxJ19X4xtSei6wllFyBCjuFfAUD6ArZXX
         CEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yN/a5yAp+A1O77SE+NBh+Z65AOWGwkPFtLthFGjHyhM=;
        b=jpBCv0kSUi2JcI2yB8/3bj92YHM36CxcqTT7qLM0dH21xi2HuGiFmu05rmOPcqkPBO
         A4xRqaiDbAo/V3EWyhW/cPDEB4RSW+U9BUnFgf1uXTS/d5oMXjv7AXAjHECSQsS3kWau
         RTdyd94TZ+CsQiVUzj9ArSowRfRApecUWvF2MruQPiASE76+fnaTqGx1SNsz8tdnN69R
         nYgzd68MqfTDVSOCnCjcL+pc0U9lwiFZy7ULrSL/6ibjDYkBbBpNx6tcJrU+f0XziFB0
         vSXGZDP3jACkqHRDHHv/ARG1S6NvB6qD24uFq0aPvxO8QlZSkItNCYlQ8sEOa8gPXy5p
         HhKQ==
X-Gm-Message-State: AOAM532Y0Zi42oajH3J0r3T+UyF/mOQSh5LSNKeeqh2pFqubfQIQxLcq
        GdjJGR4Ae+B4nLiCvEavUPA=
X-Google-Smtp-Source: ABdhPJzUc65amfvPFHsZAKrUDxFG8bH7m5W5+7q0WCleU1U4l8120N8Paw368gj++SLLmsrHkV2b5g==
X-Received: by 2002:a63:8bc9:0:b0:34c:17:6174 with SMTP id j192-20020a638bc9000000b0034c00176174mr4848049pge.133.1645155809585;
        Thu, 17 Feb 2022 19:43:29 -0800 (PST)
Received: from [172.20.119.15] ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id d13sm956636pfj.205.2022.02.17.19.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 19:43:29 -0800 (PST)
Message-ID: <0c121357-8cea-ef1f-024c-da30f989d406@gmail.com>
Date:   Fri, 18 Feb 2022 11:43:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [RFC V4 4/6] blk-iocost: make iocost pluggable
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-5-jianchao.wan9@gmail.com>
 <Yg4M2+eG1EGY/+vV@infradead.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <Yg4M2+eG1EGY/+vV@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/17 4:52 下午, Christoph Hellwig wrote:
> On Thu, Feb 17, 2022 at 11:13:47AM +0800, Wang Jianchao (Kuaishou) wrote:
>> Make blk-iocost pluggable. Then we can close or open it through
>> /sys/block/xxx/queue/qos.
>>
>> Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
>> ---
>>  block/blk-iocost.c     | 52 ++++++++++++++++++++++++++----------------
>>  block/blk-mq-debugfs.c |  2 --
>>  block/blk-rq-qos.h     |  1 -
>>  3 files changed, 32 insertions(+), 23 deletions(-)
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 769b64394298..5a3a45985b49 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -660,9 +660,10 @@ static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
>>  	return container_of(rqos, struct ioc, rqos);
>>  }
>>  
>> +static struct rq_qos_ops ioc_rqos_ops;
>>  static struct ioc *q_to_ioc(struct request_queue *q)
>>  {
>> -	return rqos_to_ioc(rq_qos_id(q, RQ_QOS_COST));
>> +	return rqos_to_ioc(rq_qos_by_id(q, ioc_rqos_ops.id));
>>  }
> 
> This has a single caller, so just open code it.
> 
>> +static int blk_iocost_init(struct request_queue *q);
>> +
>>  static struct rq_qos_ops ioc_rqos_ops = {
>> +	.name = "blk-iocost",
>> +	.flags = RQOS_FLAG_CGRP_POL,
>>  	.throttle = ioc_rqos_throttle,
>>  	.merge = ioc_rqos_merge,
>>  	.done_bio = ioc_rqos_done_bio,
>>  	.done = ioc_rqos_done,
>>  	.queue_depth_changed = ioc_rqos_queue_depth_changed,
>>  	.exit = ioc_rqos_exit,
>> +	.init = blk_iocost_init,
>>  };
> 
> Again, move rq_qos_ops below the init function to avoid the forward
> declaration.

Got it

Thanks
Jianchao
