Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026854CA6BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiCBN41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbiCBN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:56:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002125F78;
        Wed,  2 Mar 2022 05:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646229335; x=1677765335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/S7MkHzGN31vU2aDn4zLMW/e/z4TdWeBwxC5Duf+3PY=;
  b=Bykq6cXwA0qQFKv+ALKd00hs7CIOo4lqZqTbzKJok1JkEB0sLQmr9Jcs
   7FD/9UK9uHyv5veBVem1+uq9DIzWTxn3S9HOOBo3uH2sTvKMw/SKwa/Oa
   KlULIfcHGSreu/PqUweDAT4X4ue8TqrXXV9mdDFBrdwPHGLwCLo7Sh+Wv
   8xYyVz69J0d5bm3ZscSAqTctbBtXzP0gs5joWcGLNMU/cC7cEJNc+4Bsw
   7gFhlsy0Qt1uEwg70aiuMr562jelaIeWnlsfBC8pO9Dmwwu7Uut8wgnKv
   N20DqjgXxpvRCeqvPisCEA6Frx3yArFIUlBvZcLiV//624lxgOANRbkuV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253329214"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="253329214"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 05:55:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="630417622"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 05:55:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPPRE-00AJcu-UK;
        Wed, 02 Mar 2022 15:54:44 +0200
Date:   Wed, 2 Mar 2022 15:54:44 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Sanil, Shruthi" <shruthi.sanil@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Subject: Re: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Message-ID: <Yh93JNYc/BcTquCC@smile.fi.intel.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
 <BN9PR11MB55451DB929086919F8D06390F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB55451DB929086919F8D06390F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 10:12:49AM +0000, Sanil, Shruthi wrote:
> > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Sent: Wednesday, March 2, 2022 2:39 AM
> > Subject: Re: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
> > On 22/02/2022 10:56, shruthi.sanil@intel.com wrote:

...

> > One line comment format is usually for the network subsystem
> 
> OK. I'll update the comment format.

Hold on, we need a proof from documentation.

-- 
With Best Regards,
Andy Shevchenko


