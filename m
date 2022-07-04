Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92B564CE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 07:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiGDFSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 01:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGDFSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 01:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B4645D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 22:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDC736147E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159ACC341CD;
        Mon,  4 Jul 2022 05:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656911879;
        bh=YYVfOsG0afNMKH+3kAB4LFCQYR8lp0ZsH+G+gsLOJjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l5Wjn48325jRK/oQrjvNUz8KQXMVexIkG449iJv1UqzEccvnyxJk78ssln5PaozBY
         mQlVBdhdzBm82B5FbwtX/nOUZqLiGXDnyZGqN8hlb73NxEqufwtCQ3XIl47eC2WI9m
         yflVZ7Tyl9b2FZo51JahEMeaYxgVWvYJWM+lS4HU=
Date:   Sun, 3 Jul 2022 22:17:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jakub =?UTF-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [akpm-mm:mm-unstable 102/232] mm/mmap.c:1094:9: error: 'area'
 undeclared
Message-Id: <20220703221758.619e283069ac685ce9c321c2@linux-foundation.org>
In-Reply-To: <202207041144.WB9XlrTL-lkp@intel.com>
References: <202207041144.WB9XlrTL-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 11:42:55 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> head:   ff9d7221f1fc9bddb4f71f7501154c68b6942b9b
> commit: 24a134b0c0a857bbf193eb7b3d8fcbbf77517c5f [102/232] mm: refactor of vma_merge()
> config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220704/202207041144.WB9XlrTL-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=24a134b0c0a857bbf193eb7b3d8fcbbf77517c5f
>         git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>         git fetch --no-tags akpm-mm mm-unstable
>         git checkout 24a134b0c0a857bbf193eb7b3d8fcbbf77517c5f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    mm/mmap.c: In function 'vma_merge':
> >> mm/mmap.c:1094:9: error: 'area' undeclared (first use in this function)
>     1094 |         area = next;
>          |         ^~~~

Thanks, that was a merge messup.  Already fixed.  You evidently pulled
during the half-hour window when it wasn't :(


