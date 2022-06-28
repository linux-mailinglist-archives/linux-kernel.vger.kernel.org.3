Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BC655DAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbiF1H3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242141AbiF1H3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:29:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5ABE008;
        Tue, 28 Jun 2022 00:29:05 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXGQS0yM0zkWf2;
        Tue, 28 Jun 2022 15:27:44 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 15:29:02 +0800
Subject: Re: [PATCH -next] lsm_audit: Clean up redundant NULL pointer check
To:     Paul Moore <paul@paul-moore.com>
CC:     <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220614121030.115491-1-xiujianfeng@huawei.com>
 <CAHC9VhR8k-MDnHsMcdYb5SondWGem19CRPx5p23WtkcrHFaBnQ@mail.gmail.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <1f736550-b9ac-04f8-9056-6c3cd0f2d8fe@huawei.com>
Date:   Tue, 28 Jun 2022 15:29:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR8k-MDnHsMcdYb5SondWGem19CRPx5p23WtkcrHFaBnQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/6/15 10:07, Paul Moore 写道:
> On Tue, Jun 14, 2022 at 8:13 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>> The implements of {ip,tcp,udp,dccp,sctp,ipv6}_hdr(skb) guarantee that
>> they will never return NULL, and elsewhere user don't do the check
>> as well, so remove the check here.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   security/lsm_audit.c | 14 +-------------
>>   1 file changed, 1 insertion(+), 13 deletions(-)
> Reviewed-by: Paul Moore <paul@paul-moore.com>
Thanks for the review, and kindly ping here ...
