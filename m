Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79B147E1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347838AbhLWLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:00:12 -0500
Received: from foss.arm.com ([217.140.110.172]:39522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347830AbhLWLAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:00:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E03131FB;
        Thu, 23 Dec 2021 03:00:10 -0800 (PST)
Received: from bogus (unknown [10.57.36.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D5693F718;
        Thu, 23 Dec 2021 03:00:09 -0800 (PST)
Date:   Thu, 23 Dec 2021 11:00:06 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kbuild-all@lists.01.org, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: PCC: Implement OperationRegion handler for the PCC
 Type 3 subtype
Message-ID: <20211223110006.mgkuwojkhgofeety@bogus>
References: <20211222190919.137550-1-sudeep.holla@arm.com>
 <202112230517.xGNBVseT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112230517.xGNBVseT-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 05:53:59AM +0800, kernel test robot wrote:
> Hi Sudeep,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on rafael-pm/linux-next]
> [also build test ERROR on linux/master linus/master v5.16-rc6 next-20211222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Sudeep-Holla/ACPI-PCC-Implement-OperationRegion-handler-for-the-PCC-Type-3-subtype/20211223-030953
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: arm64-randconfig-r034-20211222 (https://download.01.org/0day-ci/archive/20211223/202112230517.xGNBVseT-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/d47183476e4a00211d39cd175b92fe5c11fbb65a
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Sudeep-Holla/ACPI-PCC-Implement-OperationRegion-handler-for-the-PCC-Type-3-subtype/20211223-030953
>         git checkout d47183476e4a00211d39cd175b92fe5c11fbb65a
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
>

Thanks for the report. As stated in the patch it depend on another series
by Rafael @[1]. Sorry for rushing and posting this patch before the content
of [1] appeared in linux-pm linux-next.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/11889746.O9o76ZdvQC@kreacher
