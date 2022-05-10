Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0C5520CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiEJEcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiEJE3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:29:20 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBC9200F64
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:20:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 24CA25C01E5;
        Tue, 10 May 2022 00:20:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 10 May 2022 00:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652156407; x=
        1652242807; bh=as0nbBT5XoQXRrXJLN/v8UdLz8TC49sB1/eyhm8FVLw=; b=t
        YS2ty10wMkPXkYiyfY2G+qolMiP1S3J8xOy92kP6dXeXhGRJOjExXfvw61mw1qso
        XAg0Or3fW/Z/4/Xr9gzlhT+S/kWmA5eP6jUaJEMpm0fC5WzLVTEQXXTunEpYcxA9
        QpmNciY1X+1UbmorloXqDEJWllSpUF/h2NVSMZIvBzl5UEXvi562t33gZaMFfObT
        wIsQIY9TnHSHNqXDEUnRbbpNF761Z1/VehVN3XlIC7JM2QQnGukVGvHrD0EeThI7
        nBy070didr9h1ZGW305wOQK9Zda6Js5F1Bvn/ggLAUD3RO09uNweZfAVxCP1u4Qv
        rm4rQ63LfOWoDfgDnCebQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652156407; x=1652242807; bh=as0nbBT5XoQXR
        rXJLN/v8UdLz8TC49sB1/eyhm8FVLw=; b=aTgRkgfe4qujxTtpecU47cRkfSuMq
        2eMCscoDer/3OKxwOMOl/7QRki793H816X+3AuIhkLM+YEA8+6I2ZQJl5pb6yAhN
        Tx3KzbY7Ns24LcvCb5Rk8Oj2yQEB+2U9aXdU4T76EK3yVy89qABAN2Q9MHFR1UML
        S7FkQawHWX/uUi91VECTBhfmt1OwuVBiMdrSokUueWqODTf8BIILhdM23y6eFGa8
        5r8mY/OHZ6S+jSyydLTSyRu1H5tv0JleixCvKQpEYdEBjnM2vPZ0bcOMEQZVZdMq
        YNjG5WlN6JZ97cbTH1s5IUZfmoJbKoHAUU0oW52R/tB0+tpH4gQOxdGjg==
X-ME-Sender: <xms:9ud5Yu78zKtL0VRMk98Sal9B9jDsDJcKNkIVueUs8x96WuuzTdzLCg>
    <xme:9ud5Yn6h4yjeomDqmJDEdO-f3eFTBOVN1IdRpKTp7QhweeJdIDNcfIhNFuqXmR1gp
    nXTZf0nR7a1PcCOLA>
X-ME-Received: <xmr:9ud5YtdOiwemFqxVOKHTAcJGtIfb-6YC4QrM0cNys7Jt2qM7hFkN1l9M22Om2xbAt2lGuOgmo_Xq0wAZFpPzoFiKA7pSW-Vgk4GNtcbFFZA-cLQpKNk06VpGZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudeluedvhfdttedtvdethfdvhedvkedtvddtgeetueeuvdeufeff
    teevleekgeetnecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhgihhthhhusgdrtg
    homhdpkhgvrhhnvghlrdhorhhgpddtuddrohhrghdpghhithhhuhgsuhhsvghrtghonhht
    vghnthdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:9ud5YrInPcS0r2F0CBpRSo2ks6J7cquZh8BiQktOddVaCAZPEl0UOg>
    <xmx:9ud5YiKXD7CREvggdEGUU0B8Lpaf5CF1XbPtqEDMoz8XM2DXfqWDlw>
    <xmx:9ud5YsyBqkgCX2jjmaNRuSvaVv4jTq14LG8e1rLVJ8fQ6Sw_hRn9Rg>
    <xmx:9-d5YkA6OpxErHxIiBR9uSSqd-dWfH5_D4BKPRua290jOJpkffpaeQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 May 2022 00:20:06 -0400 (EDT)
Subject: Re: [PATCH 3/5] genirq: Provide an IRQ affinity mask in non-SMP
 configs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220509034333.60017-4-samuel@sholland.org>
 <202205091545.QhhCDxVm-lkp@intel.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <372caaac-0a76-965f-2678-79ea368e39ba@sholland.org>
Date:   Mon, 9 May 2022 23:20:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202205091545.QhhCDxVm-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 2:52 AM, kernel test robot wrote:
> Hi Samuel,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/irq/core]
> [also build test ERROR on soc/for-next linus/master v5.18-rc6 next-20220506]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/genirq-irqchip-RISC-V-PLIC-cleanup-and-optimization/20220509-115510
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ce4818957fdc5bca57fc2c92b0dfe109d26bcc47
> config: mips-randconfig-r024-20220509 (https://download.01.org/0day-ci/archive/20220509/202205091545.QhhCDxVm-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a385645b470e2d3a1534aae618ea56b31177639f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/4bca5b436c97eb2ee232dd23f262ebad05fa183c
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Samuel-Holland/genirq-irqchip-RISC-V-PLIC-cleanup-and-optimization/20220509-115510
>         git checkout 4bca5b436c97eb2ee232dd23f262ebad05fa183c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> kernel/irq/ipi.c:94:30: error: no member named 'affinity' in 'struct irq_common_data'
>                    cpumask_copy(data->common->affinity, dest);
>                                 ~~~~~~~~~~~~  ^
>    1 error generated.

I think the fix here is to make GENERIC_IRQ_IPI also depend on SMP. I will add a
patch doing this for v2.

Regards,
Samuel
