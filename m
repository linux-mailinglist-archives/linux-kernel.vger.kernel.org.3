Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C864F1DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385146AbiDDVmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379165AbiDDQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:38:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30BD62AE2C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:36:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBCFFD6E;
        Mon,  4 Apr 2022 09:36:05 -0700 (PDT)
Received: from [10.57.24.6] (unknown [10.57.24.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA9793F882;
        Mon,  4 Apr 2022 09:36:02 -0700 (PDT)
Message-ID: <78478dfd-ea3a-b3b7-e4d4-79296a92c485@arm.com>
Date:   Mon, 4 Apr 2022 17:36:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Content-Language: en-US
To:     xhao@linux.alibaba.com
Cc:     Babu.Moger@amd.com, bobo.shaobowang@huawei.com, bp@alien8.de,
        fenghua.yu@intel.com, hpa@zytor.com, jamie@nuviainc.com,
        lcherian@marvell.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, reinette.chatre@intel.com,
        scott@os.amperecomputing.com, shameerali.kolothum.thodi@huawei.com,
        tan.shaopeng@fujitsu.com, tglx@linutronix.de, x86@kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Erik Yuan <Erik.Yuan@arm.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <28638a5e-540c-c52e-bce3-67619dc59461@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <28638a5e-540c-c52e-bce3-67619dc59461@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 3/15/22 06:41, Xin Hao wrote:
> I have done some verification on x86 machine(Intel(R) Xeon(R) Platinum 8269CY), and "CAT, CMT, MBA, MBM"  have been tested,
> 
> They all work well.
> 
> So please add Tested-by: Xin Hao <xhao@linux.alibaba.com>

Great, thanks!

James
  

