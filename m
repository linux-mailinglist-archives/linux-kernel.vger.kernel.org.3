Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85AF5A62F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiH3MMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiH3MMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:12:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2832EFBA72
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:11:59 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MH5gP2GvgzlVhb;
        Tue, 30 Aug 2022 20:08:33 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 20:11:56 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 20:11:56 +0800
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in
 amba_probe()
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
 <Yw3ddyxCpPH5U4kN@shell.armlinux.org.uk>
 <4236a152-c848-a8f9-45db-4b6b7b4b586a@huawei.com>
Message-ID: <48f0135b-2a41-a09a-b112-2a12335b37e2@huawei.com>
Date:   Tue, 30 Aug 2022 20:11:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4236a152-c848-a8f9-45db-4b6b7b4b586a@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/30 18:07, Leizhen (ThunderTown) wrote:
> 
> On 2022/8/30 17:50, Russell King (Oracle) wrote:
>> Please don't send the patch system patches that have not had any chance
>> of review. The patch system is supposed to be for patches that are to
>> be applied.
> Okay, I get it now.
> 
>> Sending patches that are yet to be reviewed makes extra work for me.
> I'm so sorry.
> 
Hi, Russell:
  Do you have time to look at these two patches?
  https://lkml.org/lkml/2022/8/3/140
  https://lkml.org/lkml/2022/8/11/1266


-- 
Regards,
  Zhen Lei
