Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341BC4FB0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 01:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiDJXqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 19:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiDJXq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 19:46:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27CA13DD0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bLPnIonM5faf/em8rQAPmTTs2bKRGk+3dmj20c0S2PI=; b=SPXMvZtJ6D5Sxmn+TKQhwFvPZU
        7aPnYnEst4LmkbMNaJt3JUlBcP0HGXi4yxcmjcfKAF0oh2TUHjdvNmlrIyrIVQo4fGlqLSndUVWC+
        VVkSqozLSy5Wiboot2v8xrCTtB7gMFZOvoWf5yEm3pA0E1SA/w/+jDQBou+eFowCUOqkE5WHyNK2S
        dCJyPdfdGbWS6wZEcReWs+sUN4nFhvduN3JpZi67ayovt/UrWXD+CEsUiukOEGPRkIp3H2zBo5FwD
        c+X+2n2hOkybtjkxJ4e9lo+iOUJY577QZOJd1zk6V5rahIa60ePCiN75/0V71I1FoI4w+hRtIRcvW
        CcL9PLmA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndhDw-003mjk-D4; Sun, 10 Apr 2022 23:44:05 +0000
Message-ID: <70b6fc13-a1a1-e1b2-2fa9-4cbf0766da0e@infradead.org>
Date:   Sun, 10 Apr 2022 16:43:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: or1k-linux-ld: drivers/net/dsa/realtek/realtek-smi.o:undefined
 reference to `rtl8366rb_variant'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <202204110757.XIafvVnj-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202204110757.XIafvVnj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/10/22 16:24, kernel test robot wrote:
> Hi Luiz,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4ea3c6425269d33da53c79d539ce9554117cf4d4
> commit: 765c39a4fafe6f7ea0d370aa5f30c811579cf8eb net: dsa: realtek: convert subdrivers into modules
> date:   2 months ago
> config: openrisc-buildonly-randconfig-r003-20220411 (https://download.01.org/0day-ci/archive/20220411/202204110757.XIafvVnj-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=765c39a4fafe6f7ea0d370aa5f30c811579cf8eb
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 765c39a4fafe6f7ea0d370aa5f30c811579cf8eb
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> or1k-linux-ld: drivers/net/dsa/realtek/realtek-smi.o:(.rodata+0x16c): undefined reference to `rtl8366rb_variant'
> 

More info:

Kconfig warns like this:

WARNING: unmet direct dependencies detected for NET_DSA_SMSC_LAN9303
  Depends on [m]: NETDEVICES [=y] && NET_DSA [=y] && (VLAN_8021Q [=m] || VLAN_8021Q [=m]=n)
  Selected by [y]:
  - NET_DSA_SMSC_LAN9303_MDIO [=y] && NETDEVICES [=y] && NET_DSA [=y]
  Selected by [m]:
  - NET_DSA_SMSC_LAN9303_I2C [=m] && NETDEVICES [=y] && NET_DSA [=y] && I2C [=y]


-- 
~Randy
