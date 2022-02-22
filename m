Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17504BF2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiBVH2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:28:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiBVH2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:28:30 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B1493981;
        Mon, 21 Feb 2022 23:28:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jnwang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V5BrXYP_1645514881;
Received: from 30.240.114.128(mailfrom:jnwang@linux.alibaba.com fp:SMTPD_---0V5BrXYP_1645514881)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Feb 2022 15:28:02 +0800
Message-ID: <8dc8eb43-b98c-c535-7f9e-a310ccad2a54@linux.alibaba.com>
Date:   Tue, 22 Feb 2022 15:28:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2] [hpsa] Fix the wrong chars in comment section
To:     Bart Van Assche <bvanassche@acm.org>, don.brace@microsemi.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <974edf4d-37fa-b25a-d0ac-33ac502381d8@acm.org>
 <1644889961-61470-1-git-send-email-jnwang@linux.alibaba.com>
 <739e4ca0-ec2d-d39a-4c80-2b2e16435f49@acm.org>
From:   James Wang <jnwang@linux.alibaba.com>
In-Reply-To: <739e4ca0-ec2d-d39a-4c80-2b2e16435f49@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/2/16 上午1:37, Bart Van Assche 写道:
> On 2/14/22 17:52, James Wang wrote:
>> These '+' should be redundant.
>>
>> Signed-off-by: James Wang <jnwang@linux.alibaba.com>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
> Please do NOT add a Reviewed-by tag if a reviewer has not posted that 
> tag himself.
>
> I have the following additional comments on this patch:
> - I am not convinced that this patch is useful since it does not help
>   users of the hpsa driver.

Maybe the patch helps the coding style. ;-)

James.W isn't a expert in storage system,  James.B should be;

but I have to post the issue what I see as a kernel hacker(junior).


> - The comment still does not conform to the Linux kernel coding style.
>   From coding-style.rst:
>
OK; I have run the script to check the code style this patch;

I like to imporve this patch again, without reviewed-by;


James


> The preferred style for long (multi-line) comments is:
>
> .. code-block:: c
>
>     /*
>      * This is the preferred style for multi-line
>      * comments in the Linux kernel source code.
>      * Please use it consistently.
>      *
>      * Description:  A column of asterisks on the left side,
>      * with beginning and ending almost-blank lines.
>      */
>
> Bart.
