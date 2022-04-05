Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2C4F483A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378778AbiDEVcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573408AbiDETIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:08:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF18DFFAA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=t/jIi5NMSsGNuqWW3SuqC3XVvuEfpO7XbqF5AkaA5/U=; b=LPMKtFqBIJkiHt5K/vxQqvOLCu
        mTtahlGt/q4Xpf4OXU3LL8wuiNduEjzWzNq55unSnMzDk7CYvfowt/vKjj6bjlwQgADze5JQ9Psjo
        zoI+TVMYGfEfL4P70Pe2PFL/JxdwFD2I4WP+DyRear6bSQKw2eCB5CfybzmgtTuN/LMtSQTqF2OfR
        ZPzyowE2VLduY70zxf3YLEz4HZ23/teHo3NsyN9eJJ7+txeZLiIBHgyiORbDW7nI1nMeYFRmNjw9f
        Q6GuLgBNJCpOjbQZRtb3BmZB9wR7iHknQ9vB8LaKHfyWS17w82ksHoUVL6oTdaV3zrqFlq0Ltqr83
        sN+Qa8aQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nboVq-006ykA-C2; Tue, 05 Apr 2022 19:06:46 +0000
Message-ID: <7d16caee-e605-d80b-6638-3ada4dbc4f67@infradead.org>
Date:   Tue, 5 Apr 2022 12:06:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/format_helper: fix a kernel-doc typo
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220403232902.1753-1-rdunlap@infradead.org>
 <ttcrpLw9HkdhAH5SkXylXDBi9SBf7LWgOeW09ZvTF4U4_zKJAOXBQZlFxfw6NKY0Hip6dXBFape6zkX09cstuOno72c-c00wmZ_VbNDg6xs=@emersion.fr>
 <b20bbd22-895c-9e74-e579-d2f3561a2fe1@infradead.org>
 <BzpH4s8ZYn84kTlJQ3BHVMQzZlESb2Fk6v-uO5KBaaeBNMvRvC98lpuBLUNLE3a5bdoYTb5JRvo6EU__5AGJ79LUirSppO39I1t1xlwx-fI=@emersion.fr>
 <fda186f7-2cf4-a69a-d68e-58073d35cbea@redhat.com>
 <c544d79e-90ec-7bbe-77ad-de96a700d711@infradead.org>
 <qjTlHAInyuxpFWsTWPGXoVeByVdVe-NF-kg-FUeLWQbKy9SovMzCcK-eDsijpDt1roaSubDr-8kBGKQSt_7CXFa4-BxQ6SrGSNeoZrdiq-s=@emersion.fr>
 <c336dd9d-dae2-f654-4849-669c9b9b568f@infradead.org>
 <zO0fTUWc0nKMy-cwUaONpM1AHlfPoNe77IooCuHLEYiowkM165XiiuM2JGASUQrOFcvNMVSGUwETeF7JAIf40r84dwNvh_Gl1MF_ZXYOHWE=@emersion.fr>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <zO0fTUWc0nKMy-cwUaONpM1AHlfPoNe77IooCuHLEYiowkM165XiiuM2JGASUQrOFcvNMVSGUwETeF7JAIf40r84dwNvh_Gl1MF_ZXYOHWE=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/22 11:47, Simon Ser wrote:
> On Tuesday, April 5th, 2022 at 19:58, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 4/5/22 08:05, Simon Ser wrote:
>>
>>> On Tuesday, April 5th, 2022 at 16:39, Randy Dunlap rdunlap@infradead.org wrote:
>>>
>>>> On 4/4/22 23:26, Javier Martinez Canillas wrote:
>>>>
>>>>> On 4/5/22 08:12, Simon Ser wrote:
>>>>>
>>>>>> On Monday, April 4th, 2022 at 23:35, Randy Dunlap rdunlap@infradead.org wrote:
>>>>>>
>>>>>>> On 4/4/22 09:04, Simon Ser wrote:
>>>>>>>
>>>>>>>> Both doc patches pushed, thanks. I had to manually edit them because they
>>>>>>>> wouldn't apply cleanly. Next time, please use git-send-email (see
>>>>>>>> https://git-send-email.io/ for setup instructions).
>>>>>>>
>>>>>>> That's odd. I did use 'git send-email' and I don't usually have any
>>>>>>> problems (AFAIK). I'll check those setup instructions.
>>>>>>
>>>>>> Hm, maybe the issue isn't git-send-email, but the way the patch was
>>>>>> generated? I had to manually edit these lines for the first patch to work:
>>>>>>
>>>>>> --- linux-next-20211217.orig/include/drm/drm_file.h
>>>>>> +++ linux-next-20211217/include/drm/drm_file.h
>>>>>>
>>>>>> I changed these to:
>>>>>>
>>>>>> --- a/include/drm/drm_file.h
>>>>>> +++ b/include/drm/drm_file.h
>>
>>
>> quilt (which I am using) can generate a/ b/ patches instead of linux.orig/ and
>> linux/ patches.
>>
>>>>>> This wasn't enough for the second patch, I had to re-do the changes by hand
>>>>>> from scratch.
>>
>>
>> I would like more information about this one if it's not too much trouble
>> for you.
> 
> IIRC it was the usual git-am error "fatal: sha1 information is lacking
> or useless". Maybe you wrote the patch for an old tree and drm-misc-next
> contained changes near the lines you changed? Maybe providing base-commit
> information in the patch would've helped? I'm not sure.

OK, thanks Simon.

-- 
~Randy
