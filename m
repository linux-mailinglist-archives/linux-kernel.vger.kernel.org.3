Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E36C54419F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbiFICtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiFICtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:49:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652061A0AC0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 19:49:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w20so14271685lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 19:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xAbZi9QDkiuV/tRVVMDCL6/4gqIWbhumm5dxt4PBAPs=;
        b=mkO6iieR9vohwp1xfYcTplFYTwrNTrfHLcZKf5R3REebDklh4RIYgDqdJZWa0QGSrP
         6tXCA6mR0XyW4YI4R8nc/oDsbahxe9NpdpYrOjv9ZkRqR+rigjTTPHtC0Ljslas1edyX
         T0xrMZSOO0q8Y5I1l0TU8odLEOoKae6tAxxP6wJtELRkMdkoWPE2hkLQSA2Y3KZTn/XS
         zehFdrrGOqViKQ5Ce0G/+WpU2viDbIADVkdbJ8ZjxB11hk5o3R/R9z7tPkJ2gNJTrTv9
         5wAZzPd1Pb9MkaKRPipYauD55cQEeR67bhBywedGMo3pBEt+jggI4Hez+DRU3UmUS+Bu
         qD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xAbZi9QDkiuV/tRVVMDCL6/4gqIWbhumm5dxt4PBAPs=;
        b=IAhiL2o/Op/bmxSOtw/aTtE1okZzj/y9nLuVx7VfBM1QHvgbzPbaFMBrB9zok98W7Y
         0POrq4iYtNkTmr9ZoyfOFAK+Q3nKD66WQkNft8UubMnn3FgnEJYTwp3Lp/pvWZ9AHJzk
         GwkBVwSZnMhOF93oq9KkeY1quFnxLuqp9RoSARYrR4UvLWiW+VKU5Z3w21tbmeyC5L0R
         wTo/SHjobn8jd7svG2I/4pm7qzoPkjtKck+8VAs7Ervt8fh+t+YBbRNeyDJoo/UpkpLs
         xhglxeo009YaHzQcMT0CsVormu/wI4KiP7mwpRV5NPqbrDoHaHL0MiVUVtEJDpT5WDpS
         oA1Q==
X-Gm-Message-State: AOAM533I87nEtChKyeeYG+61KdUvtHVyaxcKI5znNwbkq9iQQcSOqooe
        JMmKtzzSWvqDauxUiq5Md1ebhQ==
X-Google-Smtp-Source: ABdhPJynRptJNEYyuq3lMoyZ6zhAFMwwfmmh2PZrONJF64Gu0ggbbHlLz+APd6K22daaYz8evDzC7A==
X-Received: by 2002:a05:6512:110e:b0:479:506f:ee04 with SMTP id l14-20020a056512110e00b00479506fee04mr10901344lfg.304.1654742944523;
        Wed, 08 Jun 2022 19:49:04 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id y25-20020a0565123f1900b004786eb19049sm4011264lfa.24.2022.06.08.19.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 19:49:04 -0700 (PDT)
Message-ID: <2a4cc632-c936-1e42-4fdc-572334c58ee1@openvz.org>
Date:   Thu, 9 Jun 2022 05:49:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [next] arm64: boot failed - next-20220606
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Qian Cai <quic_qiancai@quicinc.com>
References: <CA+G9fYv7fESqpGoeKmHoJsst6wfRNMi2wQLGm+PsjbLDuDjdMQ@mail.gmail.com>
 <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
 <20220607162504.7fd5a92a@canb.auug.org.au>
 <CALvZod5XBjw7MZfYSNv-UnE7pHMKTquUNomqyC5T05Qu_ef6Zw@mail.gmail.com>
 <CALvZod4DhM00LXsPty=cnYyv3Ci5YS5otasu_tr9o7ujQekKLw@mail.gmail.com>
 <CA+G9fYve1faH7AmpEa-p_ySb_WCgc4DdjqyS6fSdiJYsaEi=rA@mail.gmail.com>
 <CALvZod72bp9ejY+KghaUGkoXDrOMMbs_ofsopGib=MY4jzhRkg@mail.gmail.com>
 <CA+G9fYu6mayYrrYK+0Rn1K7HOM6WbaOhnJSx-Wv6CaKBDpaT2g@mail.gmail.com>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <CA+G9fYu6mayYrrYK+0Rn1K7HOM6WbaOhnJSx-Wv6CaKBDpaT2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ARM developers,
could you please help me to find the reason of this problem?

On 6/7/22 18:29, Naresh Kamboju wrote:
> On Tue, 7 Jun 2022 at 19:47, Shakeel Butt <shakeelb@google.com> wrote:
>>
>> On Tue, Jun 7, 2022 at 3:28 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>
>>> Hi Shakeel,
>>>
>>>>>> Can you test v5.19-rc1, please?  If that does not fail, then you could
>>>>>> bisect between that and next-20220606 ...
>>>>>>
>>>>>
>>>>> This is already reported at
>>>>> https://lore.kernel.org/all/Yp4F6n2Ie32re7Ed@qian/ and I think we know
>>>>> the underlying issue (which is calling virt_to_page() on a vmalloc
>>>>> address).
>>>>
>>>> Sorry, I might be wrong. Just checked the stacktrace again and it
>>>> seems like the failure is happening in early boot in this report.
>>>> Though the error "Unable to handle kernel paging request at virtual
>>>> address" is happening in the function mem_cgroup_from_obj().
>>>>
>>>> Naresh, can you repro the issue if you revert the patch "net: set
>>>> proper memcg for net_init hooks allocations"?
>>>
>>> yes. You are right !
>>> 19ee3818b7c6 ("net: set proper memcg for net_init hooks allocations")
>>> After reverting this single commit I am able to boot arm64 successfully.
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>
>> Can you please run script/faddr2line on "mem_cgroup_from_obj+0x2c/0x120"?
> 
> ./scripts/faddr2line vmlinux  mem_cgroup_from_obj+0x2c/0x120
> mem_cgroup_from_obj+0x2c/0x120:
> mem_cgroup_from_obj at ??:?
> 
> Please find the following artifacts which are causing kernel crashes.
> 
> vmlinux: https://builds.tuxbuild.com/2ABl8X9kHAAU5MlL3E3xExHFrNy/vmlinux.xz
> System.map: https://builds.tuxbuild.com/2ABl8X9kHAAU5MlL3E3xExHFrNy/System.map

Dear Naresh,
thank you very much

mem_cgroup_from_obj():
ffff80000836cf40:       d503245f        bti     c
ffff80000836cf44:       d503201f        nop
ffff80000836cf48:       d503201f        nop
ffff80000836cf4c:       d503233f        paciasp
ffff80000836cf50:       d503201f        nop
ffff80000836cf54:       d2e00021        mov     x1, #0x1000000000000            // #281474976710656
ffff80000836cf58:       8b010001        add     x1, x0, x1
ffff80000836cf5c:       b25657e4        mov     x4, #0xfffffc0000000000         // #-4398046511104
ffff80000836cf60:       d34cfc21        lsr     x1, x1, #12
ffff80000836cf64:       d37ae421        lsl     x1, x1, #6
ffff80000836cf68:       8b040022        add     x2, x1, x4
ffff80000836cf6c:       f9400443        ldr     x3, [x2, #8]

x5 : ffff80000a96f000 x4 : fffffc0000000000 x3 : ffff80000ad5e680
x2 : fffffe00002bc240 x1 : 00000200002bc240 x0 : ffff80000af09740

x0 = 0xffff80000af09740 is an argument of mem_cgroup_from_obj()
according to System.map it is init_net

This issue is caused by calling virt_to_page() on address of static variable init_net.
Arm64 consider that addresses of static variables are not valid virtual addresses.
On x86_64 the same API works without any problem.

Unfortunately I do not understand the cause of the problem.
I do not see any bugs in my patch.
I'm using an existing API, mem_cgroup_from_obj(), to find the memory cgroup used
to account for the specified object.
In particular, in the current case, I wanted to get the memory cgroup of the
specified network namespace by the name taken from for_each_net(). 
The first object in this list is the static structure unit_net

On x86_64 I can translate its address to page:

crash> p &init_net
$1 = (struct net *) 0xffffffff90c7bdc0 <init_net>
crash> vtop 0xffffffff90c7bdc0
VIRTUAL           PHYSICAL        
ffffffff90c7bdc0  402c7bdc0       

PGD DIRECTORY: ffffffff8fe10000
PAGE DIRECTORY: 401e15067
   PUD: 401e15ff0 => 401e16063
   PMD: 401e16430 => 8000000402c000e3
  PAGE: 402c00000  (2MB)

      PTE         PHYSICAL   FLAGS
8000000402c000e3  402c00000  (PRESENT|RW|ACCESSED|DIRTY|PSE|NX)

      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
fffff227d00b1ec0 402c7b000                0        0  1 17ffffc0001000 reserved

However, as far as I understand this does not work for arm64.
Could you please help me to understand what is wrong here?

Below are:
 link to my patch:
https://lore.kernel.org/all/20220603182442.63750C385B8@smtp.kernel.org/
 and the quote of my investigation of similar report:
https://lore.kernel.org/all/Yp4F6n2Ie32re7Ed@qian/

> virt_to_phys used for non-linear address: ffffd8efe2d2fe00 (init_net)
>  WARNING: CPU: 87 PID: 3170 at arch/arm64/mm/physaddr.c:12 __virt_to_phys
...
>  Call trace:
>   __virt_to_phys
>   mem_cgroup_from_obj
>   __register_pernet_operations

@@ -1143,7 +1144,13 @@ static int __register_pernet_operations(struct list_head *list,
  		 * setup_net() and cleanup_net() are not possible.
		 */
		for_each_net(net) {
+			struct mem_cgroup *old, *memcg;
+
+			memcg = mem_cgroup_or_root(get_mem_cgroup_from_obj(net));   <<<<  Here
+			old = set_active_memcg(memcg);
 			error = ops_init(ops, net);
+			set_active_memcg(old);
+			mem_cgroup_put(memcg);
...
+static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	do {
+		memcg = mem_cgroup_from_obj(p); <<<<
+	} while (memcg && !css_tryget(&memcg->css));
...
struct mem_cgroup *mem_cgroup_from_obj(void *p)
{
        struct folio *folio;

        if (mem_cgroup_disabled())
                return NULL;

        folio = virt_to_folio(p); <<<< here
...
static inline struct folio *virt_to_folio(const void *x)
{
        struct page *page = virt_to_page(x); <<< here

... (arm64)
#define virt_to_page(x)         pfn_to_page(virt_to_pfn(x))  
...
#define virt_to_pfn(x)          __phys_to_pfn(__virt_to_phys((unsigned long)(x)))
...
phys_addr_t __virt_to_phys(unsigned long x)
{
        WARN(!__is_lm_address(__tag_reset(x)),
             "virt_to_phys used for non-linear address: %pK (%pS)\n",
...
virt_to_phys used for non-linear address: ffffd8efe2d2fe00 (init_net)

Thank you,
	Vasily Averin
