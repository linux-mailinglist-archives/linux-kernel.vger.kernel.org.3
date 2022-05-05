Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B29C51B655
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiEEDOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiEEDOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:14:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F5720F66
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 20:10:58 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KtzCw6sFkzGpXb;
        Thu,  5 May 2022 11:08:12 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 11:10:56 +0800
Message-ID: <53e36000-ad70-9de7-74ad-16bd81dae530@huawei.com>
Date:   Thu, 5 May 2022 11:10:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH -next] vt: defkeymap.c_shipped remove unused variables
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220429014814.988829-1-chris.zjh@huawei.com>
 <YmuIEoOnJqYLy3CE@kroah.com>
From:   "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <YmuIEoOnJqYLy3CE@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/29 14:39, Greg KH 写道:
> On Fri, Apr 29, 2022 at 09:48:14AM +0800, Zhang Jianhua wrote:
>> The global variables 'funcbufptr' 'funcbufsize' and 'funcbufleft' have
>> been initialized but not used, they are redundant and remove them.
>>
>> --------
> Why this extra "------" line?

This line "------" means the end of commit message, if it is redundant, I will remove it in next version.

>> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
>> ---
>>   drivers/tty/vt/defkeymap.c_shipped | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/tty/vt/defkeymap.c_shipped b/drivers/tty/vt/defkeymap.c_shipped
>> index 094d95bf0005..80dee50bcb7a 100644
>> --- a/drivers/tty/vt/defkeymap.c_shipped
>> +++ b/drivers/tty/vt/defkeymap.c_shipped
>> @@ -185,10 +185,6 @@ char func_buf[] = {
>>   	'\033', '[', 'P', 0,
>>   };
>>   
>> -char *funcbufptr = func_buf;
>> -int funcbufsize = sizeof(func_buf);
>> -int funcbufleft = 0;          /* space left */
>> -
>>   char *func_table[MAX_NR_FUNC] = {
>>   	func_buf + 0,
>>   	func_buf + 5,
>> -- 
>> 2.31.0
>>
> Shouldn't you fix up the loadkeys tool instead?  As the top of this file
> says, it is auto-generated and is not something to be hand-edited at
> all.
>
> thanks,
>
> greg k-h
> .
Thanks, I will read the source code more carefully, and fix up the 
loadkeys tool if it is indeed a problem.
