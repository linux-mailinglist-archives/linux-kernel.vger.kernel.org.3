Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272F147DDA7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 03:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345756AbhLWCQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 21:16:17 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15967 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhLWCQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 21:16:16 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JKDHh6hNNzZdns;
        Thu, 23 Dec 2021 10:13:04 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 10:16:14 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 10:16:14 +0800
Subject: Re: [PATCH] crypto: hisilicon/qm - cleanup warning in qm_vf_read_qos
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20211222020811.26292-1-yekai13@huawei.com>
 <CAHp75VfoxrEjV+M3kSECo2gLReZsnkPcNsGdPNYHhaJCfQxqCg@mail.gmail.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <0915e7b7-05e7-6e96-60e8-2a3113cf337a@huawei.com>
Date:   Thu, 23 Dec 2021 10:16:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfoxrEjV+M3kSECo2gLReZsnkPcNsGdPNYHhaJCfQxqCg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/23 9:51, Andy Shevchenko wrote:
>
>
> On Wednesday, December 22, 2021, Kai Ye <yekai13@huawei.com
> <mailto:yekai13@huawei.com>> wrote:
>
>     The kernel test rebot report this warning: Uninitialized variable: ret.
>     Here is fix it.
>
>
> How do you know that 0 is the correct value?
>
>
>
>     Signed-off-by: Kai Ye <yekai13@huawei.com <mailto:yekai13@huawei.com>>
>     ---
>      drivers/crypto/hisilicon/qm.c | 3 +--
>      1 file changed, 1 insertion(+), 2 deletions(-)
>
>     diff --git a/drivers/crypto/hisilicon/qm.c
>     b/drivers/crypto/hisilicon/qm.c
>     index b1fe9c7b8cc8..c6e9ad2041c3 100644
>     --- a/drivers/crypto/hisilicon/qm.c
>     +++ b/drivers/crypto/hisilicon/qm.c
>     @@ -4279,8 +4279,7 @@ static void qm_vf_get_qos(struct hisi_qm *qm,
>     u32 fun_num)
>
>      static int qm_vf_read_qos(struct hisi_qm *qm)
>      {
>     -       int cnt = 0;
>     -       int ret;
>     +       int cnt = 0, ret = 0;
>
>             /* reset mailbox qos val */
>             qm->mb_qos = 0;
>     --
>     2.33.0
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
we set the 0 to success in kernel style.

thanks
Kai
