Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC14D979A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbiCOJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiCOJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:27:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45483A18F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 706ECB811ED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B849C340F3;
        Tue, 15 Mar 2022 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647336362;
        bh=VJM7sDym86/lza1kH/xMxX8izissnjFWq5ayCrHZOv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wxb9JuGMDlcCc/UU0TaEZdQLbwUiu4YEGCvJTIXXZtBq4kfrGG1Dz+oSK51rLUils
         Z2mCmQqqfLggEKmQXHKhLbsWP3cr7emZuIcCwXN6ubTfkYFL7CzXcPKk5YBMAQ6Yj9
         lw2eqmXe+rEbA7A0b93NOflruCS5RmxTanIXBidOs6sb62s+TqCgSKRKYyQ/DG/gaN
         ZPtNiEKbm3yAo/xfTetyxS0azZJU+6OSdwTx3namIhBWEZiQFxkGEayNDHB8HleD36
         NjoYI7Smi0lPLF3HtUIliYul1+G27ZblTQJt1ZAwXdXF3B4thKohNVSlokEohfLQ41
         YlDY/tj9dVrTw==
Date:   Tue, 15 Mar 2022 18:25:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: /tmp/ccIWiggX.s:22: Error: invalid literal constant: pool needs
 to be closer
Message-Id: <20220315182558.1a056d8b3975932f6589b60f@kernel.org>
In-Reply-To: <202203150516.KTorSVVU-lkp@intel.com>
References: <202203150516.KTorSVVU-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 06:00:48 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   09688c0166e76ce2fb85e86b9d99be8b0084cdf9
> commit: 7e9bf33b812471ee57a03ec7f9b544ca437cc706 ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
> date:   5 months ago
> config: arm-randconfig-r002-20220313 (https://download.01.org/0day-ci/archive/20220315/202203150516.KTorSVVU-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e9bf33b812471ee57a03ec7f9b544ca437cc706
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7e9bf33b812471ee57a03ec7f9b544ca437cc706
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm/probes/kprobes/core.c:236:16: warning: no previous prototype for 'kprobe_handler' [-Wmissing-prototypes]
>      236 | void __kprobes kprobe_handler(struct pt_regs *regs)
>          |                ^~~~~~~~~~~~~~
>    arch/arm/probes/kprobes/core.c: In function 'arch_init_kprobes':
>    arch/arm/probes/kprobes/core.c:465:12: warning: old-style function definition [-Wold-style-definition]
>      465 | int __init arch_init_kprobes()
>          |            ^~~~~~~~~~~~~~~~~
>    /tmp/ccIWiggX.s: Assembler messages:
> >> /tmp/ccIWiggX.s:22: Error: invalid literal constant: pool needs to be closer

OK, I finally reproduced it and could make a fix.
It seems that I have to avoid accessing a C function address from the inline assembler in that function.
This can be gcc-11's bug, but to avoid this issue, I decided not using inline asm in the function.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
