Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C86459E86D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbiHWQ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244089AbiHWQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:57:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB53140BD2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:27:55 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="293686188"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="293686188"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:27:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="638655547"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:27:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1oQTwd-002S63-0K;
        Tue, 23 Aug 2022 16:27:51 +0300
Date:   Tue, 23 Aug 2022 16:27:50 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>
Subject: Re: [PATCH v2 1/4] bus: hisi_lpc: Don't dereference fwnode handle
Message-ID: <YwTV1g4RCgiCNl68@smile.fi.intel.com>
References: <20220708210859.6774-1-andriy.shevchenko@linux.intel.com>
 <f1d58027-099c-0486-0433-f97ec64ecfb7@huawei.com>
 <CAHp75Vf1JmkJ06np18+iTb+U7RZtbFQTRg-COyc+-V6URSsfZA@mail.gmail.com>
 <b83244b2-8881-bd74-a7e1-33006b42a636@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b83244b2-8881-bd74-a7e1-33006b42a636@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:16:48PM +0100, John Garry wrote:
> On 11/07/2022 09:59, Andy Shevchenko wrote:
> > On Mon, Jul 11, 2022 at 10:17 AM John Garry <john.garry@huawei.com> wrote:
> > > 
> > > Andy, Thanks for this work. I am not sure if you are hoping that Rafael
> > > picks up this series also. JFYI, I would normally route any changes to
> > > this driver through the arm soc tree via xuwei5@huawei.com, but if we
> > > want to try that it may take an extra cycle now.
> > 
> > The series has been inspired by the recent work Rafael has done
> > regarding some ACPI API changes. It's not critical per se and can be
> > routed as the best for all maintainers.
> 
> I'll pick these up to be sent upstream by xu wei through the arm-soc tree.

Thanks!

...

> b. Add a patch to convert this driver to use
> platform_device_register_full(). This obviously conflicts with a.

This one can be done beforehand, because it doesn't change flow, correct?

-- 
With Best Regards,
Andy Shevchenko


