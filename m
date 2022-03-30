Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EEA4EBD12
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244517AbiC3JCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbiC3JCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:02:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B31FCF4;
        Wed, 30 Mar 2022 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648630815; x=1680166815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uVMz7WXAbeoZtbwpOTIiCsAzbncsiypCdbGej/zEJ20=;
  b=ECtvXKNSJD3r6MGX7dGV9aruZ9Gh7urKG+XblwFlHovuissz0/Vg+tbn
   6a2VKrVfRMDFpcW86V9bqUr0fv89YHkP+crkWhGH6EIYYNZaQXazxbx3s
   O/lQkQALyu82yjXYGjRgPRCAIeVdFidi8VZkBJkNV/F5yzS4UwNPQlDax
   VWWvdMMtdBWaEq6E27RFoY/IP9sNjd3FIm0kPpswBLvSAG2h2lfpWZ1yA
   9MDbDMmW1C2VXLK25QcKr3cUGRmCmJG0CFMA28PmWjNL+sKwaxMKWiQn0
   DNpHQgMR3ZuGihKi78DQBD7ApcAm/6Dfyo6Fh8ITuJDgFpQ7zeMULdIht
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259205103"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="259205103"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 02:00:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="519596744"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 02:00:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZUAw-009IW2-QF;
        Wed, 30 Mar 2022 11:59:34 +0300
Date:   Wed, 30 Mar 2022 11:59:34 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Sanil, Shruthi" <shruthi.sanil@intel.com>
Cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: Re: [PATCH v10 0/2] Add the driver for Intel Keem Bay SoC timer block
Message-ID: <YkQb9jX7A+10+DNp@smile.fi.intel.com>
References: <20220322130005.16045-1-shruthi.sanil@intel.com>
 <BN9PR11MB55459A4EA8D0599DCB753173F11F9@BN9PR11MB5545.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB55459A4EA8D0599DCB753173F11F9@BN9PR11MB5545.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 05:04:01AM +0000, Sanil, Shruthi wrote:
> Gentle Reminder!

It's a merge window time. Be patient!
Also, please avoid top-posting.

> > From: Sanil, Shruthi <shruthi.sanil@intel.com>
> > Sent: Tuesday, March 22, 2022 6:30 PM

-- 
With Best Regards,
Andy Shevchenko


