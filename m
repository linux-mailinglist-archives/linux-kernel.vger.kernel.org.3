Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F32E461A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbhK2PBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:01:47 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16322 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbhK2O7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:59:45 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J2pLz1fcYz91Nk;
        Mon, 29 Nov 2021 22:55:55 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 22:56:26 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 22:56:25 +0800
Message-ID: <4d620e55-172b-d873-eb79-05bf66c8b5b2@huawei.com>
Date:   Mon, 29 Nov 2021 22:56:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH Resend 0/2] amba: irq cleanup
Content-Language: en-US
To:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <saravanak@google.com>, <robh+dt@kernel.org>
References: <20211115135148.171786-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20211115135148.171786-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell，same as the reply of kfence patch, kindly ping...

On 2021/11/15 21:51, Kefeng Wang wrote:
> As the v1 of "amba: Properly handle device probe without IRQ domain"
> is merged, some comments[1] from Rob and Saravana is not included,
> let's send them separately again.
>
> patch1 has been ACKed by Rob[2].
> patch2 is suggested by Saravana.
>
> Resend:
> - Rebase on v5.16-rc1
> - Fix patch2's build error
>
> [1] https://lore.kernel.org/lkml/20210816074619.177383-1-wangkefeng.wang@huawei.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20210827150600.78811-4-wangkefeng.wang@huawei.com/
>
> Resend:
> - fix mistakes about patch2
>
> Kefeng Wang (2):
>    amba: Kill sysfs attribute file of irq
>    amba: Move of_amba_device_decode_irq() into amba_probe()
>
>   drivers/amba/bus.c | 71 ++++++++++++++++++----------------------------
>   1 file changed, 28 insertions(+), 43 deletions(-)
>
