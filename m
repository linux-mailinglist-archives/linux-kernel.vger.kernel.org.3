Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEAB4DBC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351000AbiCQBlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiCQBlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:41:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE4110FC3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:39:57 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJqXz3NkjzfYlq;
        Thu, 17 Mar 2022 09:38:27 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 09:39:55 +0800
Subject: Re: [PATCH -next v3 0/2] jffs2: fix two memory leak when mount jffs2
To:     Richard Weinberger <richard@nod.at>
CC:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yukuai3 <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20220114102854.3399585-1-libaokun1@huawei.com>
 <c0d05cca-2827-481c-f534-d4fb30b91533@huawei.com>
 <936195660.152787.1647468047915.JavaMail.zimbra@nod.at>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <38d3124c-ed5d-d00b-bf72-6ff80cf80cd0@huawei.com>
Date:   Thu, 17 Mar 2022 09:39:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <936195660.152787.1647468047915.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/3/17 6:00, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "libaokun" <libaokun1@huawei.com>
>> An: "richard" <richard@nod.at>, "David Woodhouse" <dwmw2@infradead.org>, "linux-mtd" <linux-mtd@lists.infradead.org>,
>> "linux-kernel" <linux-kernel@vger.kernel.org>
>> CC: "yukuai3" <yukuai3@huawei.com>, "libaokun" <libaokun1@huawei.com>
>> Gesendet: Donnerstag, 10. März 2022 09:34:35
>> Betreff: Re: [PATCH -next v3 0/2] jffs2: fix two memory leak when mount jffs2
>> A gentle ping, sorry for the noise.
> Patches applied.
> Thanks for fixing!
>
> Thanks,
> //richard
> .


Thank you for your review!

-- 
With Best Regards,
Baokun Li

