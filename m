Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380E4FF35C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiDMJZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiDMJZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:25:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D802153736
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:23:09 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KdcWv2y99zFpsx;
        Wed, 13 Apr 2022 17:20:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 17:23:08 +0800
Received: from [10.67.111.195] (10.67.111.195) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 17:23:08 +0800
Subject: Re: [PATCH v2 -next] scripts: add compare-config utility
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220412083057.4101246-1-chenlifu@huawei.com>
 <1dd4c336-d281-6da3-ba37-d13bbf7c2537@infradead.org>
From:   chenlifu <chenlifu@huawei.com>
Message-ID: <ddb5b0f5-bdfd-9a8e-cc58-e4bb73813b80@huawei.com>
Date:   Wed, 13 Apr 2022 17:23:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1dd4c336-d281-6da3-ba37-d13bbf7c2537@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.195]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/13 0:51, Randy Dunlap 写道:
> Hi--
> 
> On 4/12/22 01:30, Chen Lifu wrote:
>> This is an alternative utility to compare two .config files. Unlike
>> existing utilities "diffconfig" in the kernel tree, it prints detailed
>> results in table style, and support config name prefix so that it can be
>> used elsewhere. It is useful sometimes, for example, to analyze .config files
>> through tables, or to compare Buildroot .config.
>>
>> With grep and awk, it can print similar results like "diffconfg" as well.
>>
>> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> 
> Is your goal to have this merged into the kernel source tree?
> If so, you should also send the patch the the kconfig maintainer and
> mailing list.
> 
> The output is quite verbose in its default mode (no options specified).
> To get something useful, I use -C -O -N.
> 
> For my uses and preferences, I would like to see a -D (e.g.) which
> is just a combination of -CON. And it would be nice if that was the
> default mode also. :)
> 
>> ---
>> Changes in v2:
>> - Add config name prefix support
>>
>>   scripts/compare-config | 201 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 201 insertions(+)
>>   create mode 100755 scripts/compare-config
> 
> thanks.
> 

Hi, Randy，
Thanks for your friendly comment, I will add -D option and set it as 
default mode.

Chen Lifu
