Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71D648CA96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350078AbiALSDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:03:48 -0500
Received: from foss.arm.com ([217.140.110.172]:34158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356014AbiALSDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:03:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 534ED6D;
        Wed, 12 Jan 2022 10:03:33 -0800 (PST)
Received: from bogus (unknown [10.57.38.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17A553F766;
        Wed, 12 Jan 2022 10:03:31 -0800 (PST)
Date:   Wed, 12 Jan 2022 18:03:16 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: drivers/acpi/acpi_pcc.c:34:22: sparse: sparse: symbol 'pcc_ctx'
 was not declared. Should it be static?
Message-ID: <20220112180316.w5velznut6wqx7yw@bogus>
References: <202201122308.6u2N4BuL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201122308.6u2N4BuL-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 11:18:49PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   daadb3bd0e8d3e317e36bc2c1542e86c528665e5
> commit: 77e2a04745ff8e391ad402e2d2d1157a5d3a7ebc ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype
> date:   8 days ago
> config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220112/202201122308.6u2N4BuL-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77e2a04745ff8e391ad402e2d2d1157a5d3a7ebc
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 77e2a04745ff8e391ad402e2d2d1157a5d3a7ebc
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>

You have already submitted the fix[1] which I have reviewed and added the tag[2]

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/20220105174554.GA29945@1e936cf764ba
[2] https://lore.kernel.org/lkml/20220106141230.qddcwyycefxlbrma@bogus
