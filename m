Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9720859C2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiHVPkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiHVPkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:40:20 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539B1E006
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:40:18 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h8so1678800ili.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=hKfslifaQKjtXKGYCYA22ph+Gl/ofGy8Kdp1BhQIblc=;
        b=oXLBmNofJ4AUCzyeXRoPey1wZOTvHudO2aMmTbPKKFOH4nOvYi4j8/9mI900I89x9U
         erpNHRYuCMeRzQmugr19d+yFdVj/gg+BKrANNBsaVWsQciOtcCYe4NoVa6qeyNVMA3rs
         SIKjQTXnVBOF03WNmj55RuMWS3YlZIwquIa6Nrzy9fE53aEhgGqQ/on6EcvXkQtRIjAM
         tLxthyQCWxltl2V9TDDAF5vq2XQzQ7vYnVGZ4KB0bZuTqS+3MBbD1WJUmNaQKpjYOGvm
         ABsvEL9iL3Y8fcnHSr22LroIO2WkE7Zg9qC2awaR/4YpSpLYm4OjPFwjwNe2+ywSy12R
         NtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hKfslifaQKjtXKGYCYA22ph+Gl/ofGy8Kdp1BhQIblc=;
        b=YxHQsaR8bMYL5l5MU33nGLdwDLM1beEyzuwXa4WkQZ4PqkioKj4NcCnJc1rJqTAzNC
         JjZTNYsM/VTZ0lVThuPqebPxJyy6ffzz+kd60Ok3yjEWqQIaAtL9G4+l1ahPVUsXb8Sj
         LS7tJMAFW8JxMruyCreV1RTOtFsscBqcAJtvaT1Tlj96pC6W/jZVIqQTOoeiu/5EZjMH
         TNlq1hjLA+Gl7TNRlizl0k36UlSDxp5/i0zCW1FBlaem+89kB1hD6tUnB2SSxiy+Tu6u
         8GDkslnE7JA5HHCeqPROCaA7hB63gzfRdMeDGO3ECGHtSabymCv31nigM5cMo/mXDzWO
         78+Q==
X-Gm-Message-State: ACgBeo1OUkISRIFC0+WTMudAWgLadulC8/xEXMCpNk94pOmS6IljFjkd
        0H0Y2rSmb0XDn3RQpVq5gF8tHLQMJouZWg==
X-Google-Smtp-Source: AA6agR5dmKV0OR4o9n9g3iWgsuASoCq5JZxLBGeWzTR0e2frRmi8e0qeWqjT/Dz2QiLiJ+wNeLiNwA==
X-Received: by 2002:a92:d5cf:0:b0:2e9:4cb4:57e4 with SMTP id d15-20020a92d5cf000000b002e94cb457e4mr7013935ilq.224.1661182817641;
        Mon, 22 Aug 2022 08:40:17 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e96-20020a028669000000b00349c4b20185sm2737009jai.116.2022.08.22.08.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 08:40:17 -0700 (PDT)
Message-ID: <4a9d2d6f-2b07-7331-6507-e19cd8e4f2ff@kernel.dk>
Date:   Mon, 22 Aug 2022 09:40:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220822144613.6e6ce950@canb.auug.org.au>
 <911717ae-3955-08dd-ad53-a6488ef8127b@kernel.dk>
 <3848cd00-b4e8-17f6-32d6-011170f293da@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3848cd00-b4e8-17f6-32d6-011170f293da@acm.org>
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

On 8/22/22 9:34 AM, Bart Van Assche wrote:
> On 8/22/22 06:55, Jens Axboe wrote:
>> On 8/21/22 4:46 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> After merging the block tree, today's linux-next build (sparc defconfig)
>>> failed like this:
>>>
>>> drivers/scsi/qlogicpti.c: In function 'qpti_map_queues':
>>> drivers/scsi/qlogicpti.c:828:24: error: 'return' with a value, in function returning void [-Werror=return-type]
>>> ?? 828 |???????????????? return -1;
>>> ?????? |??????????????????????? ^
>>> drivers/scsi/qlogicpti.c:817:13: note: declared here
>>> ?? 817 | static void qpti_map_queues(struct qlogicpti *qpti)
>>> ?????? |???????????? ^~~~~~~~~~~~~~~
>>> drivers/scsi/qlogicpti.c:839:24: error: 'return' with a value, in function returning void [-Werror=return-type]
>>> ?? 839 |???????????????? return -1;
>>> ?????? |??????????????????????? ^
>>> drivers/scsi/qlogicpti.c:817:13: note: declared here
>>> ?? 817 | static void qpti_map_queues(struct qlogicpti *qpti)
>>> ?????? |???????????? ^~~~~~~~~~~~~~~
>>> drivers/scsi/qlogicpti.c: In function 'qpti_sbus_probe':
>>> drivers/scsi/qlogicpti.c:1394:1: warning: label 'fail_free_irq' defined but not used [-Wunused-label]
>>> ? 1394 | fail_free_irq:
>>> ?????? | ^~~~~~~~~~~~~
>>> cc1: some warnings being treated as errors
>>>
>>> Caused by commit
>>>
>>> ?? f19f2c966b2f ("block: Change the return type of blk_mq_map_queues() into void")
>>>
>>> I have applied the following fix up patch for today.
>>
>> Folded in, thanks Stephen.
> 
> Hi Jens,
> 
> Please drop Stephen's patch and fold in this patch instead:

Done - please check the end result, both yours and Stephen's had to be
manually applied.

-- 
Jens Axboe
