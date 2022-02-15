Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BC64B6470
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiBOHgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:36:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiBOHgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:36:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CD9F68
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XuivQHXzqmT3xw61eBb+t7LNnzD2mGSvYyypQI3V5GI=; b=iaDEe79+/Uc/gess0wmJTlIL8U
        5DFDxn475BXEw/HDVuz3/0Y9SlI4HNyyg6AwtlTUyLfQjnh0bSxHMiQrIQMY9OmdWDRtKqsn+iaea
        pQDV/5wZC22JMbQRJEgtSmIRcYMZQN53zqfKiQoVXnAVfHA9AC5/tXmDjheIV/TPldoFSSFJIwUkx
        iaXtPMTL+1nI+FCpV2sQu9/Kq0GQfajluvgiFIzZmT/l88cFvgYAMODIL5zhv8ztUXpokP7YLXD+H
        iI4Akk72TV+8kRHRyW0UmLHPStZMjWwbEtn+ytHrkaK1O0oNRkVvQI8/qUYnLqyrNiG0A4uB6RO2J
        ybA/xRZA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJsNo-001H5m-C5; Tue, 15 Feb 2022 07:36:20 +0000
Date:   Mon, 14 Feb 2022 23:36:20 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/module_decompress.c:264:36: error: 'module_kset'
 undeclared; did you mean 'module_use'?
Message-ID: <YgtX9OFbeNZdCZTp@bombadil.infradead.org>
References: <202202140027.K0xZn3T2-lkp@intel.com>
 <b45a15ec-549d-25ba-f818-ed503ba991de@infradead.org>
 <YgnEsbnHXiuanfY/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgnEsbnHXiuanfY/@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 06:55:45PM -0800, Dmitry Torokhov wrote:
> On Sun, Feb 13, 2022 at 04:34:49PM -0800, Randy Dunlap wrote:
> > 
> > 
> > On 2/13/22 08:57, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
> > > commit: b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7 module: add in-kernel support for decompressing
> > > date:   5 weeks ago
> > > config: sparc-randconfig-r005-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140027.K0xZn3T2-lkp@intel.com/config)
> > > compiler: sparc-linux-gcc (GCC) 11.2.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7
> > >         # save the config file to linux build tree
> > >         mkdir build_dir
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash
> > 
> > FTR/FYI:
> > # CONFIG_SYSFS is not set
> 
> Ugh, why is this even a thing?

If the kconfig supports it we need to support it. If you think
we need to remove the option to be built-in we can take that
up separately. In the meantime it would be wonderful if you
can address this issue for Linus' tree.

  Luis
