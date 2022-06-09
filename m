Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB70544211
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiFIDoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFIDoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:44:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6726A237CA8;
        Wed,  8 Jun 2022 20:44:13 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJVHZ3v74zRhVr;
        Thu,  9 Jun 2022 11:40:58 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:44:11 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:44:10 +0800
Message-ID: <44530040-0384-796e-143f-b7293886753c@huawei.com>
Date:   Thu, 9 Jun 2022 11:44:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [next] arm64: boot failed - next-20220606
Content-Language: en-US
To:     Vasily Averin <vvs@openvz.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>, <lkft-triage@lists.linaro.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Ard Biesheuvel" <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        Qian Cai <quic_qiancai@quicinc.com>
References: <CA+G9fYv7fESqpGoeKmHoJsst6wfRNMi2wQLGm+PsjbLDuDjdMQ@mail.gmail.com>
 <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
 <20220607162504.7fd5a92a@canb.auug.org.au>
 <CALvZod5XBjw7MZfYSNv-UnE7pHMKTquUNomqyC5T05Qu_ef6Zw@mail.gmail.com>
 <CALvZod4DhM00LXsPty=cnYyv3Ci5YS5otasu_tr9o7ujQekKLw@mail.gmail.com>
 <CA+G9fYve1faH7AmpEa-p_ySb_WCgc4DdjqyS6fSdiJYsaEi=rA@mail.gmail.com>
 <CALvZod72bp9ejY+KghaUGkoXDrOMMbs_ofsopGib=MY4jzhRkg@mail.gmail.com>
 <CA+G9fYu6mayYrrYK+0Rn1K7HOM6WbaOhnJSx-Wv6CaKBDpaT2g@mail.gmail.com>
 <2a4cc632-c936-1e42-4fdc-572334c58ee1@openvz.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <2a4cc632-c936-1e42-4fdc-572334c58ee1@openvz.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/9 10:49, Vasily Averin wrote:
> Dear ARM developers,
> could you please help me to find the reason of this problem?
Hi,
> mem_cgroup_from_obj():
> ffff80000836cf40:       d503245f        bti     c
> ffff80000836cf44:       d503201f        nop
> ffff80000836cf48:       d503201f        nop
> ffff80000836cf4c:       d503233f        paciasp
> ffff80000836cf50:       d503201f        nop
> ffff80000836cf54:       d2e00021        mov     x1, #0x1000000000000            // #281474976710656
> ffff80000836cf58:       8b010001        add     x1, x0, x1
> ffff80000836cf5c:       b25657e4        mov     x4, #0xfffffc0000000000         // #-4398046511104
> ffff80000836cf60:       d34cfc21        lsr     x1, x1, #12
> ffff80000836cf64:       d37ae421        lsl     x1, x1, #6
> ffff80000836cf68:       8b040022        add     x2, x1, x4
> ffff80000836cf6c:       f9400443        ldr     x3, [x2, #8]
>
> x5 : ffff80000a96f000 x4 : fffffc0000000000 x3 : ffff80000ad5e680
> x2 : fffffe00002bc240 x1 : 00000200002bc240 x0 : ffff80000af09740
>
> x0 = 0xffff80000af09740 is an argument of mem_cgroup_from_obj()
> according to System.map it is init_net
>
> This issue is caused by calling virt_to_page() on address of static variable init_net.
> Arm64 consider that addresses of static variables are not valid virtual addresses.
> On x86_64 the same API works without any problem.
>
> Unfortunately I do not understand the cause of the problem.
> I do not see any bugs in my patch.
> I'm using an existing API, mem_cgroup_from_obj(), to find the memory cgroup used
> to account for the specified object.
> In particular, in the current case, I wanted to get the memory cgroup of the
> specified network namespace by the name taken from for_each_net().
> The first object in this list is the static structure unit_net

root@test:~# cat /proc/kallsyms |grep -w _data
ffff80000a110000 D _data
root@test:~# cat /proc/kallsyms |grep -w _end
ffff80000a500000 B _end
root@test:~# cat /proc/kallsyms |grep -w init_net
ffff80000a4eb980 B init_net

the init_net is located in data section, on arm64, it is allowed by 
vmalloc, see

     map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data, 
0, 0);

and the arm has same behavior.

We could let init_net be allocated dynamically, but I think it could 
change a lot.

Any better sugguestion, Catalin?

