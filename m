Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3349847511E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbhLOC4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:56:36 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15736 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhLOC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:56:35 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JDKZ649mGzWtFT;
        Wed, 15 Dec 2021 10:53:34 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 10:56:33 +0800
Subject: Re: [PATCH -next] audit: use struct_size() helper in kmalloc()
To:     Paul Moore <paul@paul-moore.com>
CC:     <eparis@redhat.com>, <keescook@chromium.org>,
        <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>, <linux-hardening@vger.kernel.org>
References: <20211214114854.133328-1-xiujianfeng@huawei.com>
 <CAHC9VhRYZgDLsouVYkecHK1208dAHwLoGZ56sSTf1zBJ00R0ag@mail.gmail.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <d53e36ed-88a5-fc3e-8309-5528d35daa68@huawei.com>
Date:   Wed, 15 Dec 2021 10:56:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRYZgDLsouVYkecHK1208dAHwLoGZ56sSTf1zBJ00R0ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/12/15 6:47, Paul Moore 写道:
> On Tue, Dec 14, 2021 at 6:48 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>> Make use of struct_size() helper instead of an open-coded calucation.
>>
>> Link: https://github.com/KSPP/linux/issues/160
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   kernel/audit.c       | 2 +-
>>   kernel/audit_tree.c  | 2 +-
>>   kernel/auditfilter.c | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
> Merged into audit/next, thanks!
thank you, but I missed two places, do you mind if I send a v2 patch?
