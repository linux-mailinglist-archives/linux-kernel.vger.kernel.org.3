Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C104690E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbhLFHrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:47:52 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39879 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238503AbhLFHrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:47:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UzX-p6Q_1638776660;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UzX-p6Q_1638776660)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Dec 2021 15:44:21 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH RESEND MERGE REQUEST] mm/damon: move damon_rand()
 definition into damon.h
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211206062836.4497-1-sj@kernel.org>
Message-ID: <8d27d836-4d45-9d52-1407-04c54b7a3dff@linux.alibaba.com>
Date:   Mon, 6 Dec 2021 15:44:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206062836.4497-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/21 2:28 PM, SeongJae Park wrote:
> Hi Xin,
>
> On Mon, 6 Dec 2021 13:20:02 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> Hi park:
>>
>>       Are you fixing this potential bug? If not, I am willing to modify,
>> i will send a fixed patch ？
> I couldn't find a time slot for this yet.  It would be great if you could send
> a patch.
Ok, i will do, thanks!
>
>
> Thanks,
> SJ
>
>> -- 
>> Best Regards!
>> Xin Hao
>>
-- 
Best Regards!
Xin Hao

