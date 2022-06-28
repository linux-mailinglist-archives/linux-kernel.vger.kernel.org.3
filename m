Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C383F55CA14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbiF1Jt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344506AbiF1Jsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:48:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228852873B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656409720; x=1687945720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FRBxCbYiUWrteKcBH2DUqIllhNNpMr6+IwG37LU4VDk=;
  b=TVJcUUXAqelcUYJ1pzaW/9D6C3Ap/l0EPQ242bVqlfFfH1JIPmAcKRUa
   TrTOBHUMGV+WqSRfplPju9wc58oSmRiyuNEzAGPmTIcNXztaSYTwYNxH7
   vbpZAseF56C78YtVkCuvTtnAXGdMoLNnrTCk6DpCdx3oSYVU/RrfVoAss
   YKZVdvbPiO8PxAmQ/S9L/fK/4XtS2HVw0Y9dN3OWw9MFyVG4PptEcMa27
   BBLBFY0InjPaGMgA8zMLTqqxlcmYcJ2v14MRJAQ32XJhwRPF0pm8GGccC
   erXNyyr9A/ddqOD1yW4hRiXJZQFTwYpx3k31CQT+LdA9vSAPz08RdQ4AI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282430314"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282430314"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:48:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="679976651"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:48:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o67pi-000wfm-Tb;
        Tue, 28 Jun 2022 12:48:34 +0300
Date:   Tue, 28 Jun 2022 12:48:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 9/9] mfd: intel_soc_pmic_crc: Update the copyright year
Message-ID: <YrrOcptvDNE3L5g6@smile.fi.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-9-andriy.shevchenko@linux.intel.com>
 <Yrm0rXd2ok8bJkTm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrm0rXd2ok8bJkTm@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:46:21PM +0100, Lee Jones wrote:
> On Thu, 16 Jun 2022, Andy Shevchenko wrote:

> > - * Copyright (C) 2012-2014 Intel Corporation. All rights reserved.
> > + * Copyright (C) 2012-2014, 2022 Intel Corporation. All rights reserved.
> 
> Same question as before.
> 
> What happens between these dates?

Same answer as before. I believe nothing (which may justify Copyright update)
happened.

-- 
With Best Regards,
Andy Shevchenko


