Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2251C4DD2B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiCRCCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiCRCCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:02:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F417F3EC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:01:15 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KKRz51XbMzfYpx;
        Fri, 18 Mar 2022 09:59:45 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 10:01:13 +0800
Subject: Re: [PATCH -next] ubifs: rename_whiteout: correct old_dir size
 computing
To:     Richard Weinberger <richard@nod.at>
CC:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yukuai3 <yukuai3@huawei.com>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220215040736.2839939-1-libaokun1@huawei.com>
 <dc55e8b3-7d22-6024-374d-4ed126e18c42@huawei.com>
 <157336576.152785.1647468012272.JavaMail.zimbra@nod.at>
 <a4f8bfff-26ee-95f8-db3c-91ca860a32bd@huawei.com>
 <2008739324.156347.1647556500875.JavaMail.zimbra@nod.at>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <1535fba0-838d-848b-8906-f25929037af9@huawei.com>
Date:   Fri, 18 Mar 2022 10:01:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <2008739324.156347.1647556500875.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

在 2022/3/18 6:35, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "libaokun" <libaokun1@huawei.com>
>>>>> +
>>>>> +		/* Add the old_dentry size to the old_dir size. */
>>>>> +		old_sz -= CALC_DENT_SIZE(fname_len(&old_nm));
>>> So you basically reset old_sz back to 0?
>> Yes, reset old_sz to 0 here.
> Okay, makes sense. Patch applied.
>
> Thanks,
> //richard
> .

Thank you for your review!

-- 
With Best Regards,
Baokun Li

