Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D738509547
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383890AbiDUDSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383888AbiDUDSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:18:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAF112633
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:15:44 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KkN2851SKz1J9wN;
        Thu, 21 Apr 2022 11:14:56 +0800 (CST)
Received: from [10.67.111.227] (10.67.111.227) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 11:15:41 +0800
From:   "lizhengyu (E)" <lizhengyu3@huawei.com>
Subject: Re: [PATCH v3 -next 0/6] riscv: kexec: add kexec_file_load() support
To:     <palmer@rivosinc.com>
CC:     <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, <bjorn.topel@gmail.com>,
        <ebiederm@xmission.com>, <guoren@linux.alibaba.com>,
        <jszhang@kernel.org>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <mick@ics.forth.gr>, <paul.walmsley@sifive.com>,
        <penberg@kernel.org>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>, <liaochang1@huawei.com>
References: <20220408100914.150110-1-lizhengyu3@huawei.com>
Message-ID: <6e1970d7-8eed-11c3-1d2b-cfc1d5832f62@huawei.com>
Date:   Thu, 21 Apr 2022 11:15:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220408100914.150110-1-lizhengyu3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

It is suitable for rc3 without changing. I hope it is good to you.


Thanks!

