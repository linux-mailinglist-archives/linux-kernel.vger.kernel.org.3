Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE09655B5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiF0DM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiF0DMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:12:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 850AE388F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:12:53 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX9gqILlisZ9fAA--.5897S3;
        Mon, 27 Jun 2022 11:12:43 +0800 (CST)
Subject: Re:
 arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:510:5:
 warning: no previous prototype for function
 'LZ4_decompress_safe_forceExtDict'
To:     kernel test robot <lkp@intel.com>
References: <202206260948.akgsho1q-lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <5753fd35-9848-0481-3a77-6a9c02e2170d@loongson.cn>
Date:   Mon, 27 Jun 2022 11:12:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <202206260948.akgsho1q-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxX9gqILlisZ9fAA--.5897S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1fAF17Gw48try8ZF4xJFb_yoW5Aryfpa
        1jkws5Kr1rWF18J3y0gayFg3WxXrZ5J3sruw1UJr1DZF4YqFyvqrnakrZ5Xr47Krn5X3yq
        ya18W3Wjgw12yaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
        IFyTuYvjxUy8nYDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/26/2022 09:14 AM, kernel test robot wrote:
> Hi Tiezhu,
>
> First bad commit (maybe != root cause):

Yes, I think the first bad commit is not the root cause.

>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0840a7914caa14315a3191178a9f72c742477860
> commit: 7e4fd16b38923028b01d3dbadf4ca973d885c53e MIPS: RALINK: Define pci_remap_iospace under CONFIG_PCI_DRIVERS_GENERIC
> date:   4 weeks ago
> config: mips-randconfig-r035-20220626
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 42a7ddb428c999229491b0effbb1a4059149fba8)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mipsel-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e4fd16b38923028b01d3dbadf4ca973d885c53e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7e4fd16b38923028b01d3dbadf4ca973d885c53e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    arch/mips/boot/compressed/decompress.c:42:6: warning: no previous prototype for function 'error' [-Wmissing-prototypes]
>    void error(char *x)
>         ^
>    arch/mips/boot/compressed/decompress.c:42:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void error(char *x)
>    ^
>    static
>    In file included from arch/mips/boot/compressed/decompress.c:64:
>    In file included from arch/mips/boot/compressed/../../../../lib/decompress_unlz4.c:10:
>>> arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:510:5: warning: no previous prototype for function 'LZ4_decompress_safe_forceExtDict' [-Wmissing-prototypes]
>    int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
>        ^
>    arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:510:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
>    ^
[...]

I think the following patch can fix the above build warning:

[PATCH] lib: Make LZ4_decompress_safe_forceExtDict() static
https://lore.kernel.org/lkml/1656298965-8698-1-git-send-email-yangtiezhu@loongson.cn/T/#u

Thanks,
Tiezhu

