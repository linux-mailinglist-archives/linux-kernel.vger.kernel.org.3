Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B33C4E1F56
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 04:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344319AbiCUDly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 23:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbiCUDls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:41:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC262574AF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:40:22 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KML1M4859zCqnH;
        Mon, 21 Mar 2022 11:38:15 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 11:40:20 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 11:40:20 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <lasse.collin@tukaani.org>
CC:     <akpm@linux-foundation.org>, <liaohua4@huawei.com>,
        <linux-kernel@vger.kernel.org>, <wangfangpeng1@huawei.com>,
        <zhongjubin@huawei.com>
Subject: Re: Re: [PATCH v2] kbuild: Enable armthumb BCJ filter for Thumb-2 kernel
Date:   Mon, 21 Mar 2022 11:40:17 +0800
Message-ID: <1647834017-23673-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <20211121233722.708131a8@kaneli>
References: <20211121233722.708131a8@kaneli>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 2021-11-20 Jubin Zhong wrote:
>> xz_wrap.sh use $SRCARCH to detect the BCJ filter. However, assigning 
>> arm BCJ filter to Thumb-2 kernel is not optimal. In my case, about 5% 
>> decrease of image size is observed with armthumb BCJ filter:
>> 
>> Test results:
>>   hardware:      QEMU emulator version 3.1.0
>>   config:        vexpress_defconfig with THUMB2_KERNEL & KERNEL_XZ on
>>   arm BCJ:       4029808
>>   armthumb BCJ:  3827280
>> 
>> Choose armthumb BCJ filter for Thumb-2 kernel to make smaller images.
>> 
>> Signed-off-by: Jubin Zhong <zhongjubin@huawei.com>

>I still didn't test it but it looks good to me.

Hi, this patch is not accepted into the kernel mainline yet.
Please let me know if there is any problem with the patch, thanks.

