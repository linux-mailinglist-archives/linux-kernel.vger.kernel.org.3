Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4C58C21C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiHHDcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241537AbiHHDcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:32:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5DD11170
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 20:32:08 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M1MD35cJVz1HBXh;
        Mon,  8 Aug 2022 11:30:43 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 11:32:06 +0800
Message-ID: <e1ba2ab6-5cca-e350-587a-06caa61d8443@huawei.com>
Date:   Mon, 8 Aug 2022 11:32:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: arch/arm64/net/bpf_jit_comp.c:1683:16: sparse: sparse: incorrect
 type in assignment (different base types)
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>,
        kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <202208060800.EiP6qXW9-lkp@intel.com>
 <0f1d610a-e249-7cd7-4408-3f7457ec60b3@iogearbox.net>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <0f1d610a-e249-7cd7-4408-3f7457ec60b3@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/2022 4:55 PM, Daniel Borkmann wrote:
> On 8/6/22 2:46 AM, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   74cae210a335d159f2eb822e261adee905b6951a
>> commit: efc9909fdce00a827a37609628223cd45bf95d0b bpf, arm64: Add bpf trampoline for arm64
>> date:   4 weeks ago
>> config: arm64-randconfig-s051-20220805 
>> (https://download.01.org/0day-ci/archive/20220806/202208060800.EiP6qXW9-lkp@intel.com/config)
>> compiler: aarch64-linux-gcc (GCC) 12.1.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O 
>> ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.4-39-gce1a6720-dirty
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=efc9909fdce00a827a37609628223cd45bf95d0b 
>>
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout efc9909fdce00a827a37609628223cd45bf95d0b
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 
>> CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/net/
> 
> Xu, please take a look and send a fix, thanks!
> 

Sorry for the delay, I'll send a fix today.

>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>

