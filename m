Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2571B5A20C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbiHZGUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244970AbiHZGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:19:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD211C3F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:19:58 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDV2v6s1Mz1N7LJ;
        Fri, 26 Aug 2022 14:16:23 +0800 (CST)
Received: from [10.67.110.83] (10.67.110.83) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 14:19:56 +0800
Subject: ping //Re: [PATCH v2 0/2] squashfs: Add the mount parameter
 "threads="
To:     <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>
CC:     <wangle6@huawei.com>, <yi.zhang@huawei.com>,
        <wangbing6@huawei.com>, <zhongjubin@huawei.com>,
        <chenjianguo3@huawei.com>
References: <20220815031100.75243-1-nixiaoming@huawei.com>
 <20220816010052.15764-1-nixiaoming@huawei.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <8d139f03-7845-9c96-fffc-74fdf8b5d78d@huawei.com>
Date:   Fri, 26 Aug 2022 14:19:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20220816010052.15764-1-nixiaoming@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping


On 2022/8/16 9:00, Xiaoming Ni wrote:
> Currently, Squashfs supports multiple decompressor parallel modes. However, this
> mode can be configured only during kernel building and does not support flexible
> selection during runtime.
> 
> In the current patch set, the mount parameter "threads=" is added to allow users
> to select the parallel decompressor mode and configure the number of decompressors
> when mounting a file system.
> 
> v2: fix warning: sparse: incorrect type in initializer (different address spaces)
>    Reported-by: kernel test robot <lkp@intel.com>
> 
> v1: https://lore.kernel.org/lkml/20220815031100.75243-1-nixiaoming@huawei.com/
> ----
> 
> Xiaoming Ni (2):
>    squashfs: add the mount parameter theads=<single|multi|percpu>
>    squashfs: Allows users to configure the number of decompression
>      threads.
> 
>   fs/squashfs/Kconfig                     | 24 ++++++++--
>   fs/squashfs/decompressor_multi.c        | 32 ++++++++------
>   fs/squashfs/decompressor_multi_percpu.c | 39 ++++++++++-------
>   fs/squashfs/decompressor_single.c       | 23 ++++++----
>   fs/squashfs/squashfs.h                  | 39 ++++++++++++++---
>   fs/squashfs/squashfs_fs_sb.h            |  4 +-
>   fs/squashfs/super.c                     | 77 ++++++++++++++++++++++++++++++++-
>   7 files changed, 192 insertions(+), 46 deletions(-)
> 

