Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30902503079
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356318AbiDOWO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiDOWO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:14:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A1443AC0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RTy/XhFfjbfRDd109gg9EIJraOMtOqiIkjkCpzcfEgc=; b=Glu8o13q4TMSd1rjIzANrpVTWb
        2jNx5xL8yQJyDN6T2HY8wPdECWpORg3qMBsd86l1hsaLXqXWZhUFPIEY3M/GwWoCrldvb0KqhpWUf
        SOsMLqgPvQnNFXjupktJn/j6Ue6fhrTH4wsuqQoMcMKAPjhzXv1DDI/NMa4yqidrshpopERqstDji
        Ij044gEhrFKFlbRW4oYijylwVEXNKziGvqXGl4AUlUBBMu36+kGGM8mk5uA/IvdKGGMM+fGpB9/Ip
        JjumCNJeFtJBRq22dEiEmireHlDO3RDZaLorQ/iYs6O035TCpTMx2pfCGIR5AEhF1WAWa5YgmmyE4
        zuVNrxXg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfUAT-00BXGO-2K; Fri, 15 Apr 2022 22:11:53 +0000
Date:   Fri, 15 Apr 2022 15:11:53 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     zhanglianjie <zhanglianjie@uniontech.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [mcgrof:sysctl-testing 12/18] mm/page-writeback.c:93:28:
 warning: unused variable 'dirty_bytes_min'
Message-ID: <YlntqSsx17+PReMW@bombadil.infradead.org>
References: <202204081510.D41wQr6m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204081510.D41wQr6m-lkp@intel.com>
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

On Fri, Apr 08, 2022 at 03:38:53PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-testing
> head:   7cde53da38a3ea00d75ef6a6ab06fa85b80bcf87
> commit: 87125d15aa3c4046e902758a39062f213b3664ad [12/18] mm: move page-writeback sysctls to their own file
> config: s390-randconfig-r034-20220406 (https://download.01.org/0day-ci/archive/20220408/202204081510.D41wQr6m-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b306233f78876a1d197ed6e1f05785505de7c63)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=87125d15aa3c4046e902758a39062f213b3664ad
>         git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
>         git fetch --no-tags mcgrof sysctl-testing
>         git checkout 87125d15aa3c4046e902758a39062f213b3664ad
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):

I'll post a fix.

 Luis
