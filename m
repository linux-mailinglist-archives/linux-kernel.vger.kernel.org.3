Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C75AEED1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbiIFP3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiIFP3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:29:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0EDC0B52
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:40:36 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MMSCM2JjzzmV8n;
        Tue,  6 Sep 2022 22:17:51 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 22:21:25 +0800
Subject: Re: [PATCH -next] rv/reactor: add __init/__exit annotations to module
 init/exit funcs
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>
References: <20220906111846.58738-1-xiujianfeng@huawei.com>
 <3f8c0e42-07dc-4349-5021-bcb75e640094@kernel.org>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <65bb173d-1a36-283e-4e20-4bbbcac616c6@huawei.com>
Date:   Tue, 6 Sep 2022 22:21:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <3f8c0e42-07dc-4349-5021-bcb75e640094@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/9/6 21:43, Daniel Bristot de Oliveira 写道:
> 
> Hi Xiu
> On 9/6/22 13:18, Xiu Jianfeng wrote:
>> Add missing __init/__exit annotations to module init/exit funcs.
> 
> Regarding the Subject, this patch is not -next. I would suggest only using -next
> when you are fixing something in the linux-next (which is not the case here).
> 
> You can also fix this for the printk reactor. Do you mind re-sending this patch
> with including the printk reactor?

No problem, V2 already sent.

> 
> If you found it using an automatic tool, please add information to the patch.
> Also, try to figure out why it pointed to the panic reactor but did not point to
> printk.

Thanks, I found it by review not tools.

> 
> Add to v2:
> 
> Fixes: 135b881ea885 ("rv/reactor: Add the printk reactor")
> Fixes: e88043c0ac16 ("rv/reactor: Add the panic reactor")
> 
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Thanks
> -- Daniel
> .
> 
