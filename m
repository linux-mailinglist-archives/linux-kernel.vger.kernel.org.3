Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525654D94B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbiCOGmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345261AbiCOGmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:42:44 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40E74A91A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:41:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V7FyDb8_1647326487;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V7FyDb8_1647326487)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Mar 2022 14:41:29 +0800
To:     james.morse@arm.com
Cc:     Babu.Moger@amd.com, bobo.shaobowang@huawei.com, bp@alien8.de,
        fenghua.yu@intel.com, hpa@zytor.com, jamie@nuviainc.com,
        lcherian@marvell.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, reinette.chatre@intel.com,
        scott@os.amperecomputing.com, shameerali.kolothum.thodi@huawei.com,
        tan.shaopeng@fujitsu.com, tglx@linutronix.de, x86@kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Erik Yuan <Erik.Yuan@arm.com>
References: <20220217182110.7176-1-james.morse@arm.com>
Subject: Re: [PATCH v3 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Reply-To: xhao@linux.alibaba.com
From:   Xin Hao <xhao@linux.alibaba.com>
Message-ID: <28638a5e-540c-c52e-bce3-67619dc59461@linux.alibaba.com>
Date:   Tue, 15 Mar 2022 14:41:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220217182110.7176-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi james,

I have done some verification on x86 machine(Intel(R) Xeon(R) Platinum 
8269CY), and "CAT, CMT, MBA, MBM"  have been tested,

They all work well.

So please add Tested-by: Xin Hao <xhao@linux.alibaba.com>

-- 
Best Regards!
Xin Hao

