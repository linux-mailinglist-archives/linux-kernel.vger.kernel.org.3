Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8E3500B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbiDNKxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbiDNKxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4552193D0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC8B60B6F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7CFC385A5;
        Thu, 14 Apr 2022 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649933466;
        bh=C2ockpuC+VfY2ilc4zS3943tBJMdpIckXQ36XeDs1E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/1FEd7+4qTo2t1i+kAr2utlpNqhT4W+LNIvVRtHuAJZI1LoPmwO2J8oijQ3ZMYNJ
         Ir0yBLfS9MSygXcPY6xJ9hvWoR3cfJicQTrkMiCwgII5XYchYToaf6Z0daMxMmvrbm
         Teoe6RETUXx3KiOOPtDvbyQ3JaGd8hsDnGjDXR+k=
Date:   Thu, 14 Apr 2022 12:51:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     kernel test robot <lkp@intel.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [linux-stable-rc:queue/5.17 638/1505]
 drivers/net/dsa/realtek/realtek-smi-core.c:494:34: warning: unused variable
 'realtek_smi_of_match'
Message-ID: <Ylf8lxYjcn2xFPLT@kroah.com>
References: <202204121538.1pGOoGfb-lkp@intel.com>
 <20220412103231.ypwovmt35cmsa6jx@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412103231.ypwovmt35cmsa6jx@bang-olufsen.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:32:31AM +0000, Alvin Šipraga wrote:
> Hello test robot,
> 
> On Tue, Apr 12, 2022 at 03:36:24PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.17
> > head:   22fa848c25c536c9ec7b151d56caa65b3e5b8b68
> > commit: b0cbd13db467ef03b28297d3effb6b726c0dcba8 [638/1505] net: dsa: realtek-smi: move to subdirectory
> > config: x86_64-randconfig-r033-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121538.1pGOoGfb-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b0cbd13db467ef03b28297d3effb6b726c0dcba8
> >         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >         git fetch --no-tags linux-stable-rc queue/5.17
> >         git checkout b0cbd13db467ef03b28297d3effb6b726c0dcba8
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/dsa/realtek/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/net/dsa/realtek/realtek-smi-core.c:494:34: warning: unused variable 'realtek_smi_of_match' [-Wunused-const-variable]
> >    static const struct of_device_id realtek_smi_of_match[] = {
> >                                     ^
> >    1 warning generated.
> 
> This should be fixed by including the commit:
> 
> 109d899452ba1 ("net: dsa: realtek: make interface drivers depend on OF").
> 
> in the stable tree.

Great, can you provide a working backport so it can be included?

thanks,

greg k-h
