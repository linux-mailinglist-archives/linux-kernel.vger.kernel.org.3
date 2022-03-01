Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306954C858E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiCAHxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiCAHx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:53:29 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A7C48306;
        Mon, 28 Feb 2022 23:52:48 -0800 (PST)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K78Zv1RX4z67kNj;
        Tue,  1 Mar 2022 15:51:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 08:52:46 +0100
Received: from [10.47.86.223] (10.47.86.223) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Tue, 1 Mar
 2022 07:52:45 +0000
Message-ID: <a1c25161-9e43-ddce-4131-cf73ad52917c@huawei.com>
Date:   Tue, 1 Mar 2022 07:52:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] docs: fix 'make htmldocs' warning in perf
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Qi Liu <liuqi115@huawei.com>, Will Deacon <will@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jiabing.wan@qq.com>
References: <20220228031700.1669086-1-wanjiabing@vivo.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220228031700.1669086-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.223]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 03:16, Wan Jiabing wrote:
> Fix following 'make htmldocs' warnings:
> ./Documentation/admin-guide/perf/hisi-pcie-pmu.rst: WARNING:
> document isn't included in any toctree
> 
> Fixes: c8602008e247 ("docs: perf: Add description for HiSilicon PCIe PMU driver")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Regardless of nit, below:

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   Documentation/admin-guide/perf/index.rst | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 5a8f2529a033..69b23f087c05 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -8,6 +8,7 @@ Performance monitor support
>      :maxdepth: 1
>   
>      hisi-pmu
> +   hisi-pcie-pmu

nit: we might prefer alphabetic ordering, but we don't have it fully ATM 
elsewhere

>      imx-ddr
>      qcom_l2_pmu
>      qcom_l3_pmu

