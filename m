Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2215B058D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIGNpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIGNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:44:38 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E75D7FE7E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:44:08 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q81so11469228iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pEJwEhDUqrZGIVT/biazrZcA5jAB9CrKf7HerUiub98=;
        b=tVOaJXOR4bPOvT5BiR2mU+qlXXKdUfOeUppxrE21nF2Nnr3SRBPOM9t/05v7Bxpd32
         5BwnONSnFLmP8lBnHsfhNF2EVfD+HJNKoh8ERyJIbG4H5qvCd3g9CYtAJyeBQ6UNm/So
         gwlNZydmrZY7AOzxrhTHkuAWc4CZCYQMdYNmlQjYM3vUtJKxqUFdHfwDJZFu5viOFil+
         nGry/gQpHKPiyuUO4Iepx2NgKGMBqDhV+oWh7ZZW3e+Sr6ve0OjiDRq+Bf2V1hFlKorf
         HksHRfxHyus5hX7M87iUOfKysFbpiZ9dPSw1mGYhK9P9BQ1z4rTjOhF6/jzGf1P01Xes
         iFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pEJwEhDUqrZGIVT/biazrZcA5jAB9CrKf7HerUiub98=;
        b=031quwJ9Tg5w9eSFhinJcLVWiWaRY54okV0wmhzLR+YLUVSEpo1Ppbc2j6QMSUn7aL
         FUk6GEXaHDICu8PARP8CABvFg2US39IuvWQZW+zo3acuVBBbSOnCSb6Qw7LiN2rvXjfB
         TmzmLyPO0yHIXRfUOho9llZWIbBuWDXr1Dq91z2q/IPgYzr6tzfOwYbJw9kRYr+wr0k9
         1G3/igIS8T6vG3p4ugW6YzFHGZBY+lB6g+RQ4MYARJMUGwfUq35PFRWxHhm0SG80SLyR
         WVXcQvZsyRgXoo+R62HJ2ywGH/guDb8Vzlp7/MaXwb/2XVrue56V/5Jbzughn+46TFbv
         UDBQ==
X-Gm-Message-State: ACgBeo2u5jx6+CeUc3wPlN6d3aFdDGZDeJ7jr8cjS3Y1Leyjy+NpWpSz
        C3dDoJ+vrRDOiFMLfdmYD8nvw4AumfMKFg==
X-Google-Smtp-Source: AA6agR6cexkYlnnefIh0wXCM/2opy8g7O4vzDDGvXnxbmq14U6Mvy1RA+WcaqghPVXDbitUyUNJhuQ==
X-Received: by 2002:a05:6602:2cc9:b0:689:8260:e118 with SMTP id j9-20020a0566022cc900b006898260e118mr1890602iow.45.1662558246979;
        Wed, 07 Sep 2022 06:44:06 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g15-20020a92dd8f000000b002eae3ef70e8sm6442078iln.81.2022.09.07.06.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 06:44:06 -0700 (PDT)
Message-ID: <2d4655d4-2510-eb1e-2e4d-9d910e823293@kernel.dk>
Date:   Wed, 7 Sep 2022 07:44:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] kernel: export task_work_add
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20220829040013.549212-1-ming.lei@redhat.com>
 <5a1b3716-bcf8-8c37-2bd5-44e885de1f48@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5a1b3716-bcf8-8c37-2bd5-44e885de1f48@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 7:08 AM, Bart Van Assche wrote:
> On 8/28/22 21:00, Ming Lei wrote:
>> Firstly task_work_add() is used in several drivers. In ublk driver's
>> usage, request batching submission can only be applied with task_work_add,
>> and usually get better IOPS.
>>
>> Secondly from this API's definition, the added work is always run in
>> the task context, and when task is exiting, either the work is rejected
>> to be added, or drained in do_exit(). In this way, not see obvious
>> disadvantage or potential issue by exporting it for module's usage.
>>
>> So export it, then ublk driver can get simplified, meantime with better
>> performance.
> 
> If task_work_add() is exported, shouldn't task_work_cancel() be exported
> too? Anyway:

Not if it isn't currently used...

On the patch itself, it definitely makes sense in the context of ublk.
My hesitation is mostly around not really wanting to export this to
generic modular users. It's OK for core interfaces, of which ublk is
on the way to becoming, but I really don't like the idea of random
modules using it. But that's not really something we can manage with
the export, it's either exported or it's not...

-- 
Jens Axboe


