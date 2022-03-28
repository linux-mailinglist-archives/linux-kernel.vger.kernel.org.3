Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50CE4E9C38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiC1QaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiC1QaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:30:01 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7631BE9D;
        Mon, 28 Mar 2022 09:28:19 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 850F8C80082;
        Mon, 28 Mar 2022 18:28:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hRZRmiZcs_tD; Mon, 28 Mar 2022 18:28:18 +0200 (CEST)
Received: from [192.168.178.30] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 61076C80080;
        Mon, 28 Mar 2022 18:28:17 +0200 (CEST)
Message-ID: <c8e0e071-7566-f958-f309-aefa2bd802ad@tuxedocomputers.com>
Date:   Mon, 28 Mar 2022 18:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 3/4] input/i8042: Add debug output for quirks
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        kernel test robot <lkp@intel.com>, dmitry.torokhov@gmail.com,
        tiwai@suse.de, mpdesouza@suse.com, arnd@arndb.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <20220322162125.59838-4-wse@tuxedocomputers.com>
 <202203230435.z5FH2fWa-lkp@intel.com>
 <c53b864a-912b-4569-251d-aea20be1bc5c@redhat.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <c53b864a-912b-4569-251d-aea20be1bc5c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 28.03.22 um 14:08 schrieb Hans de Goede:
> Hi,
>
> On 3/22/22 21:50, kernel test robot wrote:
>> Hi Werner,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on dtor-input/next]
>> [also build test ERROR on v5.17 next-20220322]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Werner-Sembach/input-i8042-Move-__initconst-to-fix-code-styling-warning/20220323-012205
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
>> config: ia64-defconfig (https://download.01.org/0day-ci/archive/20220323/202203230435.z5FH2fWa-lkp@intel.com/config)
>> compiler: ia64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://github.com/0day-ci/linux/commit/d92be72641d5753be3aa94fe5961e2dbe2b5bdc9
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Werner-Sembach/input-i8042-Move-__initconst-to-fix-code-styling-warning/20220323-012205
>>         git checkout d92be72641d5753be3aa94fe5961e2dbe2b5bdc9
>>         # save the config file to linux build tree
>>         mkdir build_dir
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
> i8042_dritek is only defined when building on x86, I would solve this
> by moving the new pr_debug to inside i8042_check_quirks();

Thanks I missed that. But moving the debug function in i8042_check_quirks would make the output x86 exclusive, while the
quirks in general are not (on non x86 they must be set via command line but still have effects on the code if i see that
correctly)

>
> The i8042_nopnp not being defined order is slightly tricker, you
> can more or less cleanly fix this by doing this at the end of
> i8042_check_quirks() and then put the new pr_debug after this:
>
> #ifdef CONFIG_PNP
>                 if (quirks & SERIO_QUIRK_NOPNP)
>                         i8042_nopnp = true;
> #else
> #define i8042_nopnp 0
> #endif

As an alternative i would suggest putting defines in the pr_debug call. Otherwise it might not be immediately that the
#define i8042_nopnp 0 is there specifically for this one statement only.

    pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
        i8042_nokbd ? " nokbd" : "",
        i8042_noaux ? " noaux" : "",
        i8042_nomux ? " nomux" : "",
        i8042_unlock ? " unlock" : "",
        i8042_probe_defer ? "probe_defer" : "",
        i8042_reset == I8042_RESET_DEFAULT ?
            "" : i8042_reset == I8042_RESET_ALWAYS ?
                " reset_always" : " reset_never",
        i8042_direct ? " direct" : "",
        i8042_dumbkbd ? " dumbkbd" : "",
        i8042_noloop ? " noloop" : "",
        i8042_notimeout ? " notimeout" : "",
        i8042_kbdreset ? " kbdreset" : "",
#ifdef CONFIG_X86
        i8042_dritek ? " dritek" : "",
#else
        "",
#endif
#ifdef CONFIG_PNP
        i8042_nopnp ? " nopnp" : "");
#else
        "");
#endif

As a side effect: like this the code snipped also stays completely position independed.

>
> Regards,
>
> Hans
>
>
>
>> All errors (new ones prefixed by >>):
>>
>>    In file included from include/asm-generic/bug.h:22,
>>                     from arch/ia64/include/asm/bug.h:17,
>>                     from include/linux/bug.h:5,
>>                     from include/linux/thread_info.h:13,
>>                     from include/asm-generic/preempt.h:5,
>>                     from ./arch/ia64/include/generated/asm/preempt.h:1,
>>                     from include/linux/preempt.h:78,
>>                     from include/linux/rcupdate.h:27,
>>                     from include/linux/rculist.h:11,
>>                     from include/linux/pid.h:5,
>>                     from include/linux/sched.h:14,
>>                     from include/linux/delay.h:23,
>>                     from drivers/input/serio/i8042.c:12:
>>    drivers/input/serio/i8042-x86ia64io.h: In function 'i8042_platform_init':
>>>> drivers/input/serio/i8042-x86ia64io.h:1511:17: error: 'i8042_dritek' undeclared (first use in this function); did you mean 'i8042_direct'?
>>     1511 |                 i8042_dritek ? " dritek" : "",
>>          |                 ^~~~~~~~~~~~
>>    include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
>>      418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>>          |                                 ^~~~~~~~~~~
>>    include/linux/printk.h:132:17: note: in expansion of macro 'printk'
>>      132 |                 printk(fmt, ##__VA_ARGS__);             \
>>          |                 ^~~~~~
>>    include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
>>      576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>          |         ^~~~~~~~~
>>    drivers/input/serio/i8042-x86ia64io.h:1497:9: note: in expansion of macro 'pr_debug'
>>     1497 |         pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>>          |         ^~~~~~~~
>>    drivers/input/serio/i8042-x86ia64io.h:1511:17: note: each undeclared identifier is reported only once for each function it appears in
>>     1511 |                 i8042_dritek ? " dritek" : "",
>>          |                 ^~~~~~~~~~~~
>>    include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
>>      418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>>          |                                 ^~~~~~~~~~~
>>    include/linux/printk.h:132:17: note: in expansion of macro 'printk'
>>      132 |                 printk(fmt, ##__VA_ARGS__);             \
>>          |                 ^~~~~~
>>    include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
>>      576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>          |         ^~~~~~~~~
>>    drivers/input/serio/i8042-x86ia64io.h:1497:9: note: in expansion of macro 'pr_debug'
>>     1497 |         pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>>          |         ^~~~~~~~
>>
>>
>> vim +1511 drivers/input/serio/i8042-x86ia64io.h
>>
>>   1494	
>>   1495		i8042_check_quirks();
>>   1496	
>>   1497		pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>>   1498			i8042_nokbd ? " nokbd" : "",
>>   1499			i8042_noaux ? " noaux" : "",
>>   1500			i8042_nomux ? " nomux" : "",
>>   1501			i8042_unlock ? " unlock" : "",
>>   1502			i8042_probe_defer ? "probe_defer" : "",
>>   1503			i8042_reset == I8042_RESET_DEFAULT ?
>>   1504				"" : i8042_reset == I8042_RESET_ALWAYS ?
>>   1505					" reset_always" : " reset_never",
>>   1506			i8042_direct ? " direct" : "",
>>   1507			i8042_dumbkbd ? " dumbkbd" : "",
>>   1508			i8042_noloop ? " noloop" : "",
>>   1509			i8042_notimeout ? " notimeout" : "",
>>   1510			i8042_kbdreset ? " kbdreset" : "",
>>> 1511			i8042_dritek ? " dritek" : "",
>>   1512			i8042_nopnp ? " nopnp" : "");
>>   1513	
>>   1514		retval = i8042_pnp_init();
>>   1515		if (retval)
>>   1516			return retval;
>>   1517	
>>
