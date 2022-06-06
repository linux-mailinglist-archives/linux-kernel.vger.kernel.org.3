Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5306B53E7AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiFFMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbiFFMie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:38:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8E7B642D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2799DB81929
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAEAC341C0;
        Mon,  6 Jun 2022 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654519110;
        bh=i1AQKA4HtlMyrYOHB4sVJmXfHi0KPoNVjyHoEYQypPE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WFjBHSQsJZCrS60VD5dYqx9OgJQJwgPjQ14cTJ35P+LBrxPS36b7Z70ay8As9mov8
         YFDQu0jxeoaQ0qWh83rKYS0EbbWBH1hWu7tAoX0HuP6qOi4AXrIPtDx2MhuC1CkXmV
         NJqxjDbi91UiY0wLQyI6gWdhoz4pAP3mvo6MT4HqGawDzb/NuJS2FxipS1E6Wy3vQx
         KdPPpoMzr4yNkOoVDOSMC3pqNZ2cT1Z13v9wtqUuSru2wWvLQ1+p8deY6Ta1r4l4Z/
         Y6fDK56KfsjjpksE4RmvmOktD/1EVehP5cRQrW4+eTQAQSu5W66PLueGbtUFULcCZN
         6gyvZKy7WOWbg==
Message-ID: <de70aae8-4b39-cfb1-54a3-2e6b2e3c920d@kernel.org>
Date:   Mon, 6 Jun 2022 20:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20220606021103.89211-1-jefflexu@linux.alibaba.com>
 <Yp1oIye4FM+uU0a+@B-P7TQMD6M-0146.local>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Yp1oIye4FM+uU0a+@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/6 10:36, Gao Xiang wrote:
> On Mon, Jun 06, 2022 at 10:11:03AM +0800, Jeffle Xu wrote:
>> Glad to contribute the fscache mode to erofs. Sincerely I recommend
>> myself as the reviewer to maintain these codes.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Thanks for taking time on EROFS and looking after this.
> Acked-by: Gao Xiang <xiang@kernel.org>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1309e1496c23..6cd8b3631cc0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7388,6 +7388,7 @@ EROFS FILE SYSTEM
>>   M:	Gao Xiang <xiang@kernel.org>
>>   M:	Chao Yu <chao@kernel.org>
>>   R:	Yue Hu <huyue2@coolpad.com>
>> +R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>>   L:	linux-erofs@lists.ozlabs.org
>>   S:	Maintained
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
>> -- 
>> 2.27.0
