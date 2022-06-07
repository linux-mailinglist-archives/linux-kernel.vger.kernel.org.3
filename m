Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54385425B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386407AbiFHB5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588393AbiFGXyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5A93887;
        Tue,  7 Jun 2022 16:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA6E8616C3;
        Tue,  7 Jun 2022 23:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53A3C3411C;
        Tue,  7 Jun 2022 23:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654643147;
        bh=L2/9wdu7Khtn1jgRd/gRWs85FKV7GMEfu2Bx/poJDFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k+UwKDEV/MRQwkXB5GEKRtm2Di/gHC2LRSO6nQViEuk/6dD3hr7MvP/0vj0zqLVWv
         9JNVf6cy17/X+St9S61aR7O50aZcShX/CFBiouhtQyH7lXP1P09Z8/WH425ooZ8oVC
         qOwAf9x8kdCgV042PxoFEupjtD+JDsP+Rk+VMujE=
Date:   Tue, 7 Jun 2022 16:05:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master 728/1207] fs/xfs/xfs_file.c:1266:31: sparse:
 sparse: incorrect type in return expression (different base types)
Message-Id: <20220607160546.2a0a826d29bec858ca402720@linux-foundation.org>
In-Reply-To: <202206071511.FI7WLdZo-lkp@intel.com>
References: <202206071511.FI7WLdZo-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 15:09:18 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   73d0e32571a0786151eb72634f1a4c5891166176
> commit: d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c [728/1207] xfs: support CoW in fsdax mode
> config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220607/202206071511.FI7WLdZo-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-18-g56afb504-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/xfs/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> fs/xfs/xfs_file.c:1266:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted vm_fault_t @@
>    fs/xfs/xfs_file.c:1266:31: sparse:     expected int
>    fs/xfs/xfs_file.c:1266:31: sparse:     got restricted vm_fault_t
> >> fs/xfs/xfs_file.c:1260:1: sparse: sparse: symbol 'xfs_dax_fault' was not declared. Should it be static?
> >> fs/xfs/xfs_file.c:1314:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [usertype] ret @@     got int @@
>    fs/xfs/xfs_file.c:1314:21: sparse:     expected restricted vm_fault_t [usertype] ret
>    fs/xfs/xfs_file.c:1314:21: sparse:     got int
> 
> Please review and possibly fold the followup patch.

Well yes, the followup patch
(https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/xfs-support-cow-in-fsdax-mode-fix.patch)
will most definitely be folded.

Can you suggest how this can be communicated to the robot in order to
suppress this notification?  A Fixes: won't work, as neither of these
patches have yet been promoted to a "stable" state.  Their hashes will
change.
