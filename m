Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C235767D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiGOTyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiGOTyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:54:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AF712D2B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:54:08 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="266299929"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="266299929"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:54:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="546774096"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:54:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1oCRNz-001JDv-0h;
        Fri, 15 Jul 2022 22:54:03 +0300
Date:   Fri, 15 Jul 2022 22:54:02 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YtHF2giNT1gG1wge@smile.fi.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <Yrmr175fsQi6ToEY@google.com>
 <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
 <YrxjTD0sJXh8cgVP@google.com>
 <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
 <Yr1YXHb3GqwZncFK@google.com>
 <CAHp75Vf1UK9Z2P1D9v_j9rsdKoDXWSvb=wJgmkvACYgwofWrxA@mail.gmail.com>
 <35c907e6-6018-d22b-1992-ffc66eb82b0e@redhat.com>
 <Yr1iweMUl+EUY+Q6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1iweMUl+EUY+Q6@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:45:53AM +0100, Lee Jones wrote:
> On Thu, 30 Jun 2022, Hans de Goede wrote:
> > On 6/30/22 10:07, Andy Shevchenko wrote:

...

> > Note that I already did a manual compare of the moved code blocks
> > to check that they were not changed before giving my Reviewed-by.
> 
> Super, thanks Hans.

Is it okay to be applied?

-- 
With Best Regards,
Andy Shevchenko


