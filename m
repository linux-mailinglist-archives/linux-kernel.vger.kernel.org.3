Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671B44B91C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbiBPTvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:51:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiBPTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:51:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1B2B1024;
        Wed, 16 Feb 2022 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645041069; x=1676577069;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HH+CeWCLXFRu3dE8FJg+idDdWcYVfzcRC1ijA/ezLtk=;
  b=HpPZHxWdVzKhimmviWkNWnFxNp7nzpmEJM4Ik8IBIJ5LDPNip2etXhv2
   92H+UESES9GmzMQDNyznEVlEPyyd/x7KaStqCSdY1RZRxCE6TDl/5Ejel
   nw9CUkcEGFDkLHDqQKCORTK9A4rqQDA6aUKNPnIBbh7ubPqoZUr5tAeUX
   hQh0pmc+0jvF1tK1bfTSiE2jsaMhklM3ViB8a7jX5mYFdsA3C87ortJM4
   Q8QyvsZf/kN2kV7t6bx6XlRvE7g1cGqbXcUGzdH0OXikWy7cLiXGJXY5Q
   kJUI5yzY+MmpBGOnN45Ee6TqbWMAonpjPY+4nJ8SgwQ0pgoS+Og9JUSkt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="238115738"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="238115738"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:51:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="503180886"
Received: from ddahlenx-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.148.13])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:51:08 -0800
Message-ID: <11b23ddcbd05e277f5511557ee954e2fade0039a.camel@linux.intel.com>
Subject: Re: [PATCH] Documentation: admin-guide: pm: Document uncore
 frequency scaling
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Wed, 16 Feb 2022 11:51:08 -0800
In-Reply-To: <CAJZ5v0gqatnkRt0VqTyHjgL8yNp40Ui3UCMv-PV8qvzefaV5HQ@mail.gmail.com>
References: <20220207191307.2903314-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0gqatnkRt0VqTyHjgL8yNp40Ui3UCMv-PV8qvzefaV5HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-16 at 19:44 +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 7, 2022 at 8:13 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > Added documentation to configure uncore frequency limits in Intel
> > Xeon processors.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > Resent by adding linux-pm@vger.kernel.org
> > 
> >  .../pm/intel_uncore_frequency_scaling.rst     | 56
> > +++++++++++++++++++
> >  .../admin-guide/pm/working-state.rst          |  1 +
> >  2 files changed, 57 insertions(+)
> >  create mode 100644 Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst
> > 
> > diff --git a/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst b/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst
> > new file mode 100644
> > index 000000000000..b3519560594b
> > --- /dev/null
> > +++ b/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst
> > @@ -0,0 +1,56 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> > +
> > +==============================
> > +Intel Uncore Frequency Scaling
> > +==============================
> > +
> > +:Copyright: |copy| 2022 Intel Corporation
> > +
> > +:Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > +
> > +Introduction
> > +===========================================
> 
> There are no other sections in this file, so can the section header
> above be dropped?
> 
Sure.

Thanks,
Srinivas

> > +
> > +Uncore can consume significant amount of power in Intel's Xeon
> > servers based
> > +on the workload characteristics. To optimize total power and
> > improve overall
> > +performance, SoC has an internal algorithm for scaling uncore
> > frequency. These
> > +algorithms monitor workload usage of uncore and set a desirable
> > frequency.
> > +
> > +It is possible that users have different expectations of uncore
> > performance and
> > +want to have control over it. The objective is similar to set
> > scaling min/max
> > +frequencies using cpufreq sysfs to improve compute performance.
> > Users may have
> > +some latency sensitive workload where they do not want any change
> > to uncore
> > +frequency. Also, users may have workload which requires different
> > core and
> > +uncore performance at distinct phases and they want to use both
> > cpufreq and
> > +uncore scaling interface to distribute power and improve overall
> > performance.
> > +
> > +To control uncore frequency, a sysfs interface is provided in the
> > directory:
> > +`/sys/devices/system/cpu/intel_uncore_frequency/`.
> > +
> > +There is one directory for each package and die combination as the
> > scope of
> > +uncore scaling control is per die in multiple dies/package SoC or
> > per
> > +package for single die per package SoC. The name represents the
> > +scope of control. For example: 'package_00_die_00' is for package
> > id 0 and
> > +die 0 in it.
> > +
> > +Each package_*_die_* contains following attributes:
> > +
> > +``initial_max_freq_khz``
> > +       Out of reset, this attribute represent the maximum possible
> > frequency.
> > +       This is a read only attribute. If users adjust
> > max_freq_khz,
> > +       they can always go back to maximum using the value from
> > this attribute.
> > +
> > +``initial_min_freq_khz``
> > +       Out of reset, this attribute represent the minimum possible
> > frequency.
> > +       This is a read only attribute. If users adjust
> > min_freq_khz,
> > +       they can always go back to minimum using the value from
> > this attribute.
> > +
> > +``max_freq_khz``
> > +       This attribute is used to set the maximum uncore frequency.
> > +
> > +``min_freq_khz``
> > +       This attribute is used to set the minimum uncore frequency.
> > +
> > +``current_freq_khz``
> > +       This attribute is used to get the current uncore frequency.
> > diff --git a/Documentation/admin-guide/pm/working-state.rst
> > b/Documentation/admin-guide/pm/working-state.rst
> > index 5d2757e2de65..ee45887811ff 100644
> > --- a/Documentation/admin-guide/pm/working-state.rst
> > +++ b/Documentation/admin-guide/pm/working-state.rst
> > @@ -15,3 +15,4 @@ Working-State Power Management
> >     cpufreq_drivers
> >     intel_epb
> >     intel-speed-select
> > +   intel_uncore_frequency_scaling
> > --
> > 2.34.1
> > 

