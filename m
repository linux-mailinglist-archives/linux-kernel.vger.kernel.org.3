Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0384DE4F6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbiCSBSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiCSBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:17:58 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC4C2BB7EE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:16:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 00A5C3200D78;
        Fri, 18 Mar 2022 21:16:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 18 Mar 2022 21:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=BuzvtTqDk6f0Smw5E
        Nzbj0bjU7GjOoh4sZORUG04JeY=; b=P3PsPreo282SrYl4BjMlc5BrrpouzAPxn
        CRCu/VVqoLQ6X6Xt0JK59IsHIX70LUZ4CY1SsDdvqYD+Qk2bMs2Vf7HcjHW+CRrP
        DBsWmc7cs1OTSIkZottIzLkNBIL7+f0HR3B1v2Lc5dhdmc2z3aD+KDV8MBSONhAM
        lCCtFUf/B8C6VJDeSnR8wrXgL4wrSwcOh4wEpNiS8c7HLpwG+3V6V8k8KWI4hDZC
        s4GpJSvQI5B8QirKZk8e9TlprH3ZaO/YR3feZWFkBhhx8txmAGOE0BrpnlzT1Hhy
        3vwWY2z1oG0iP0Ajt9+iQ/Y8q/vsJwp/VPHQZCp+aSYdWxtyujF2g==
X-ME-Sender: <xms:8S41Yo1SJY76S135ZR1sBNyHKtR_IjYWdlBgA_VNaKyAM81A40-o_Q>
    <xme:8S41YjHwALaklX64HoPg_yWx_UpklYMq3El0Ghje9IPqPkzVSOwuOLJEkGrv0SaNG
    l1uStqrtLRx2k5Wuwc>
X-ME-Received: <xmr:8S41Yg6jvjj5EEgxBqOxEb7yYZzopLat7VdDROzqIjr5RdH7BaKpT0d4Pd3bl8xNEdNdsXw7YZZK802lbkM9i26lAqy5DMNd0uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhephffhjeejvdejtdejjeeffeefjefgieeijeegveeljeeffffgueevkeehieek
    vdetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgpdhgihhthhhusg
    hushgvrhgtohhnthgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:8S41Yh1tdSn2befUzGH03Db_CYJM8y_0mtcBvTY6WNMU-E4V64hlFQ>
    <xmx:8S41YrFHByC2nR3JlC0IGwixkzu0Sg5IH30P_I_t8coMMrq_wBAXkQ>
    <xmx:8S41Yq8olUOuPfzSpDwNk5L1UqoNgsSrgLN6TseIyNzatKI5DqAumA>
    <xmx:8S41YgQ6166YyOexK8jak1_s53Mp_yDaZwRKy8s04G37KFI2Deevow>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Mar 2022 21:16:31 -0400 (EDT)
Date:   Sat, 19 Mar 2022 12:16:38 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     kernel test robot <lkp@intel.com>
cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: via-pmu-event.c:undefined reference to `input_event'
In-Reply-To: <202203190015.8LPNVVK5-lkp@intel.com>
Message-ID: <c22262dc-b71c-bc9-b5b6-1abc593bdc4d@linux-m68k.org>
References: <202203190015.8LPNVVK5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2022, kernel test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   551acdc3c3d2b6bc97f11e31dcf960bc36343bfc
> commit: ebd722275f9cfc6752e29d2412fa3816ca05764b macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
> date:   3 years, 8 months ago
> config: m68k-randconfig-r021-20220317 (https://download.01.org/0day-ci/archive/20220319/202203190015.8LPNVVK5-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebd722275f9cfc6752e29d2412fa3816ca05764b
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ebd722275f9cfc6752e29d2412fa3816ca05764b
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `via_pmu_event':
> >> via-pmu-event.c:(.text+0x32): undefined reference to `input_event'
> >> m68k-linux-ld: via-pmu-event.c:(.text+0x54): undefined reference to `input_event'
>    m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `via_pmu_event_init':
> >> via-pmu-event.c:(.init.text+0xe): undefined reference to `input_allocate_device'
> >> m68k-linux-ld: via-pmu-event.c:(.init.text+0x56): undefined reference to `input_register_device'
> >> m68k-linux-ld: via-pmu-event.c:(.init.text+0x68): undefined reference to `input_free_device'

That config file has CONFIG_INPUT=n which is unusual. The problem affects 
m68k builds since I enabled the driver 3 years ago but powerpc builds have 
always been affected by this.

via_pmu_event() does nothing unless the hardware happens to be a 
particular powerpc PMU models but that logic is questionable (see comment 
in via-pmu-event.c). So I think the best solution is to make the 
via_pmu_event() code conditional on CONFIG_INPUT.

I'll send a patch to that effect.
