Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C6E543BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiFHSmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiFHSmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:42:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C815735
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vE0ETWGH3wlbjHTBw41ZaNV8j6P02xowYJ+7I+tAJoM=; b=Rb1aNNTzjkR7H3PDqu5W3ktBQj
        xRJjCTqzAK85Tfmv3tqiMwty/u1ohqeQnMecG+Y7RkyHr/zbH/BbjaoBRYUEHeQmvDPpfibYbHn3a
        7OXfFWk6qJfh5o773yPlH+DJoI1QA4ak6gXTfOW8J+vdEKa8CxmTiObWXy5sp6bL06WXHVBcOEwts
        uOR32Nk+5Et9nyvyQ02ydNKeQuhsGTXkrDu9BJ76KmQ+1GLIdKr2fLABG87IgiJbq1k0ODd00nf4Z
        pw6DLibJlPya5Aq69t3+MyCLCuObvHFJyWnJw7X6PPFTtlaOEccde1mwfZqIxBfPMIsssybkS2+k4
        Syvf24TQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz0cm-006ARH-8H; Wed, 08 Jun 2022 18:41:48 +0000
Message-ID: <a9b45aec-cbc8-97c2-6425-780211891403@infradead.org>
Date:   Wed, 8 Jun 2022 11:41:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sched/pelt: Fix bracket typo
Content-Language: en-US
To:     =?UTF-8?B?6b6N5biG6LuS?= <1030steven@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220608150008.57629-1-1030steven@gmail.com>
 <3193fcc9-c672-19d9-a2e2-ad67809dd20b@infradead.org>
 <F0C192DB-6043-4629-A009-DCB4BA33A9A9@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <F0C192DB-6043-4629-A009-DCB4BA33A9A9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/8/22 09:30, 龍帆軒 wrote:
> 
>> Randy Dunlap <rdunlap@infradead.org <mailto:rdunlap@infradead.org>> 於 2022年6月8日 下午11:33 寫道：
>>
>>
>>
>> On 6/8/22 08:00, Steven Lung wrote:
>>> The second bracket describing the range is inverted, this patch
>>> will fix it.
>>>
>>> Signed-off-by: Steven Lung <1030steven@gmail.com <mailto:1030steven@gmail.com>>
>>> ---
>>> kernel/sched/pelt.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>>> index 0f3107682..ed82cfba9 100644
>>> --- a/kernel/sched/pelt.c
>>> +++ b/kernel/sched/pelt.c
>>> @@ -233,7 +233,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
>>>  * When syncing *_avg with *_sum, we must take into account the current
>>>  * position in the PELT segment otherwise the remaining part of the segment
>>>  * will be considered as idle time whereas it's not yet elapsed and this will
>>> - * generate unwanted oscillation in the range [1002..1024[.
>>
>> Is the above the same as                   range [1002..1024).
>> ?  I.e. 1002-1023 inclusive (or 1024 excluded)?
>>
>>> + * generate unwanted oscillation in the range [1002..1024].
>>>  *
>>>  * The max value of *_sum varies with the position in the time segment and is
>>>  * equals to :
>>
>> -- 
>> ~Randy
> 
> In the patch that the author submitted[1] for this comment, he mentioned that the value 1024 can be obtained. 
> So I think we should use brackets instead of parenthesis.
> 
> [1]: https://lore.kernel.org/all/20200506155301.14288-1-vincent.guittot@linaro.org/T/#u <https://lore.kernel.org/all/20200506155301.14288-1-vincent.guittot@linaro.org/T/#u>

OK, thanks for the link.

-- 
~Randy
