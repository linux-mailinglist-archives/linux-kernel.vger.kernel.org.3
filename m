Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E17F526784
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382627AbiEMQwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382552AbiEMQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81C4E54FAC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652460613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33oKxA4Na7t/dSRQE6iTTpYQb3oMGj6G5wXczQ6on5U=;
        b=HgzI0KNdDK+GaLqXXntnFdmsTtCrzBTsA1x4LoxshCzVb2GT7YfPciupJxRsyYvW6Sfav+
        W5XFtqCxtjDAppwGCFQcsfV2gKK0yhZOsc/J4NKpJDbCuIkHQbocYL3wX17jyHWnKAqxhK
        6RBtqwYE6CCNDhP2MF123EVttIFKxqc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-E_epyNm9N-Gqr5RiMsj8Zg-1; Fri, 13 May 2022 12:50:10 -0400
X-MC-Unique: E_epyNm9N-Gqr5RiMsj8Zg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCFA7294EDF4;
        Fri, 13 May 2022 16:50:09 +0000 (UTC)
Received: from [10.22.11.63] (unknown [10.22.11.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE6ED438BD9;
        Fri, 13 May 2022 16:50:09 +0000 (UTC)
Message-ID: <151959a6-e691-c905-fe05-c6fd3f616f25@redhat.com>
Date:   Fri, 13 May 2022 12:50:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] kselftest/cgroup: fix test_stress.sh to use OUTPUT dir
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Phil Auld <pauld@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20220512143439.26104-1-pauld@redhat.com>
 <f819f288-7f67-77d1-5d92-f0a5545c1c48@redhat.com>
 <CAOS58YNYoFQy9gv9qiUX-PDkhEJ0CAwKeNibUghrT68vSSckYQ@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAOS58YNYoFQy9gv9qiUX-PDkhEJ0CAwKeNibUghrT68vSSckYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 12:20, Tejun Heo wrote:
> Can you send a quick patch?

Will do.

Cheers,
Longman

>
> Thanks.
>
> On Fri, May 13, 2022 at 6:19 AM Waiman Long <longman@redhat.com> wrote:
>>
>> On 5/12/22 10:34, Phil Auld wrote:
>>> Running cgroup kselftest with O= fails to run the with_stress test due
>>> to hardcoded ./test_core. Find test_core binary using the OUTPUT directory.
>>>
>>> Fixes: 1a99fcc035fb ("selftests: cgroup: Run test_core under interfering stress")
>>> Signed-off-by: Phil Auld <pauld@redhat.com>
>>> ---
>>>    tools/testing/selftests/cgroup/test_stress.sh | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/cgroup/test_stress.sh b/tools/testing/selftests/cgroup/test_stress.sh
>>> index 15d9d5896394..109c044f715f 100755
>>> --- a/tools/testing/selftests/cgroup/test_stress.sh
>>> +++ b/tools/testing/selftests/cgroup/test_stress.sh
>>> @@ -1,4 +1,4 @@
>>>    #!/bin/bash
>>>    # SPDX-License-Identifier: GPL-2.0
>>>
>>> -./with_stress.sh -s subsys -s fork ./test_core
>>> +./with_stress.sh -s subsys -s fork ${OUTPUT}/test_core
>>
>> I would suggest using "${OUTPUT:-.}" as the variable OUTPUT may not be
>> defined if test_stress.sh is run interactively.
>>
>> Cheers,
>> Longman
>>
>

