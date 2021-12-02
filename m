Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9714D465EFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355864AbhLBH4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:56:54 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41088 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345499AbhLBH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:56:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CEE64CE213D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 07:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDF3C53FD0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 07:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638431604;
        bh=vDkEhSqD+ujVAiltZ+1ZuypT6BrxKFkvrBRzO+zPZjg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MUdfLsV46UrOqwItheS63HqfeuvoT0RGnk3GN7DjOg7My1N7Lx4Xu/OW446sc0EwZ
         GB7RZI7YJEPRZj7Ggo30Pid/0kHTFyBJb7l+Lh3pkjuGllMb/rD9Kcu0SoFO2Bnbm7
         qTCTqS3VU+akEI+84b7LAHQ8goq2CIXoY8PmCIaVk9Mi6N+saPV1lZHp0qB4xKlym+
         QDLZ69SX1nnFdszljp02GQGgatQwy1tNOpaY3HigPf3v1bZW8fv9OEmGCJO1tmvw+4
         Lu56kNaZwHAyIEVryhEXgkYkV2oGLDy5JppI6tKZijUTpkXjPSDACgjzETi57y4cGC
         ogYyTRD46vmdQ==
Received: by mail-oi1-f182.google.com with SMTP id r26so53837920oiw.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 23:53:24 -0800 (PST)
X-Gm-Message-State: AOAM533b+JW8Mjx+TqE8WlWqAheU+3g+k/VX0vRPCpO8X1Jg2dNizYGx
        TBZGBfKwEDy5fiROQHMhSvyO9srn/yv3DaQFMNM=
X-Google-Smtp-Source: ABdhPJwHk9inBwUri8dumWBzkiBg7OngXRR9JuRnEjTNs/KxrE3/qw71V2J4DYiRI3bZ4xvLrqjqZKaU/S9LRIat1Vw=
X-Received: by 2002:aca:ad95:: with SMTP id w143mr3099973oie.47.1638431604034;
 Wed, 01 Dec 2021 23:53:24 -0800 (PST)
MIME-Version: 1.0
References: <202111250918.ErFZktQF-lkp@intel.com> <CAMj1kXHrRYagSVniSetHdG15rkQS+fm4zVOtN=Zda3W0QaEoJA@mail.gmail.com>
 <a03e765d-c22a-3bd8-8d94-36966b91dc2c@intel.com>
In-Reply-To: <a03e765d-c22a-3bd8-8d94-36966b91dc2c@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 2 Dec 2021 08:53:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFKYX+XsojJGzYZryHht=CV-7-R+aNXaSO9zabunXYNqg@mail.gmail.com>
Message-ID: <CAMj1kXFKYX+XsojJGzYZryHht=CV-7-R+aNXaSO9zabunXYNqg@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [ardb:for-kernelci 25/25] arch/arm/kernel/traps.c:865:17:
 warning: no previous prototype for function 'handle_bad_stack'
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 at 08:34, Rong Chen <rong.a.chen@intel.com> wrote:
>
>
>
> On 11/30/21 21:12, Ard Biesheuvel wrote:
> > On Thu, 25 Nov 2021 at 02:35, kernel test robot <lkp@intel.com> wrote:
> >> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
> >> head:   5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
> >> commit: 5da04a8b7050432b72f6551b6c95e4b5b5fd68d1 [25/25] ARM: implement THREAD_INFO_IN_TASK for uniprocessor systems
> >> config: arm-randconfig-r024-20211124 (https://download.01.org/0day-ci/archive/20211125/202111250918.ErFZktQF-lkp@intel.com/config)
> >> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
> >> reproduce (this is a W=1 build):
> >>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>          chmod +x ~/bin/make.cross
> >>          # install arm cross compiling tool for clang build
> >>          # apt-get install binutils-arm-linux-gnueabi
> >>          # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
> >>          git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
> >>          git fetch --no-tags ardb for-kernelci
> >>          git checkout 5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
> >>          # save the config file to linux build tree
> >>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All warnings (new ones prefixed by >>):
> >>
> > This is yet another false positive. asmlinkage routines don't need a
> > prototype because they are called from assembler. This is not going to
> > get fixed, so please don't report this error anymore.
>
> Hi Ard,
>
> Sorry for the noise, we'll ignore the warnings in the future.
>

Thanks! And if at all possible, please extend this to all routines
marked as asmlinkage?

-- 
Ard.
