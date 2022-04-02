Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE044F003C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354208AbiDBJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbiDBJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:54:41 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6D198EDF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:52:50 -0700 (PDT)
Received: from [192.168.165.80] (unknown [182.2.36.61])
        by gnuweeb.org (Postfix) with ESMTPSA id 232C57E2EE;
        Sat,  2 Apr 2022 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648893169;
        bh=8tCRa13ZZsZGboLXAqosF0lcTrImP1d0N9Iedzf/FKM=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=sQ/Eg7Ugag8rSe2h0j6rD7H6xRrxmuMYqGA+P5VU5LnWLGIvYyu5YU25eup1lGa68
         lsFMi2+8ae4Q+T+2FA6hp5hxjG6MmBU1z4HrBr92gMdO4x2/Zz1AkggLW+m2teO41F
         LLjzaKQ+2lkX4C2BEB/cQe+uY9DNIHfnqVRoYaQLBBo6Ae36+Nm8TMAlZjCMHd4LJt
         pQuN8SUHj80w/hMX4Kwg01EYD6UXmybs0M9yh+A1nwK9Gv46v8FzVu9tOWr/cWwXt8
         ThShw+EgvEB/wTagd+LFSvgDObSdrQ+9qASDX4FxKqDTYqRs8Hn2tvTegNVpyrfsRT
         nxFi5Lz8EmEMA==
Message-ID: <9fa2454e-aef5-c879-eb0d-2eb23e603b55@gnuweeb.org>
Date:   Sat, 2 Apr 2022 16:52:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <willdeacon@google.com>
References: <202204021112.ErKMELRr-lkp@intel.com>
 <87r16fbzaq.wl-maz@kernel.org>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re:
 [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-03
 199/9999] arch/arm64/kvm/perf.c:58:36: error: implicit declaration of
 function 'perf_num_counters'
In-Reply-To: <87r16fbzaq.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 4/2/22 4:38 PM, Marc Zyngier wrote:
> Hi Robot,
> 
> On Sat, 02 Apr 2022 04:47:04 +0100,
> kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Marc,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2022-03
> 
> Oh look, a random Android tree based on ... 5.10.
> 
>> head:   64099431c232d4a95f621411747a3972cc1c8061
>> commit: 13dbdc0759fd4b89417f64d399ffa6a86fdc7caf [199/9999] FROMGIT: KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static key
>> config: arm64-randconfig-r024-20220331 (https://download.01.org/0day-ci/archive/20220402/202204021112.ErKMELRr-lkp@intel.com/config)
>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project cc2e2b80a1f36a28fa7c96c38c2674b10868f09f)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install arm64 cross compiling tool for clang build
>>          # apt-get install binutils-aarch64-linux-gnu
>>          # https://github.com/ammarfaizi2/linux-block/commit/13dbdc0759fd4b89417f64d399ffa6a86fdc7caf
>>          git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>>          git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2022-03
>>          git checkout 13dbdc0759fd4b89417f64d399ffa6a86fdc7caf
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> arch/arm64/kvm/perf.c:58:36: error: implicit declaration of function 'perf_num_counters' [-Werror,-Wimplicit-function-declaration]
>>             if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
>>                                               ^
>>     1 error generated.
> 
> $ ls -l arch/arm64/kvm/perf.c
> ls: cannot access 'arch/arm64/kvm/perf.c': No such file or directory
> 
> What is the point of testing trees that have no resemblance with
> upstream?

It's my tree. Didn't realize it yields many irrelevant errors like this.
I will stop pushing Android stuff to this tree.

Sorry for bothering you.

-- 
Ammar Faizi
