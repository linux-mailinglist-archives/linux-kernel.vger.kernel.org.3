Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A960534872
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243518AbiEZB4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiEZB4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:56:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525A121251
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:56:44 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L7rbz0xYmzgYNr;
        Thu, 26 May 2022 09:55:11 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 09:56:42 +0800
Message-ID: <45daf51c-c9ec-d4d9-1aee-27fe4bb4b1da@huawei.com>
Date:   Thu, 26 May 2022 09:56:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next] jffs2: fix memory leak in jffs2_do_fill_super
To:     Richard Weinberger <richard@nod.at>
CC:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yukuai3 <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20220412093816.2280678-1-libaokun1@huawei.com>
 <c2f49973-e5be-475a-1b92-77fc6e86ba37@huawei.com>
 <1917663619.89751.1653338200219.JavaMail.zimbra@nod.at>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <1917663619.89751.1653338200219.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/5/24 4:36, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "libaokun" <libaokun1@huawei.com>
>> An: "richard" <richard@nod.at>, "David Woodhouse" <dwmw2@infradead.org>, "linux-mtd" <linux-mtd@lists.infradead.org>,
>> "linux-kernel" <linux-kernel@vger.kernel.org>
>> CC: "yukuai3" <yukuai3@huawei.com>, "libaokun" <libaokun1@huawei.com>
>> Gesendet: Montag, 23. Mai 2022 08:00:21
>> Betreff: Re: [PATCH -next] jffs2: fix memory leak in jffs2_do_fill_super
>> ping
> Thanks for your time. You patch will be part of the upcoming merge window.
> I'm preparing right now my queue.
>
> Thanks,
> //richard
> .

Thank you for your review!

-- 
With Best Regards,
Baokun Li

