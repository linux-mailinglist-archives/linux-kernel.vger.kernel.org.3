Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF54578212
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiGRMTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiGRMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:19:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1514248F1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:19:39 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="372512249"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="372512249"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:19:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="624703988"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:19:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1oDPip-001OAG-1H;
        Mon, 18 Jul 2022 15:19:35 +0300
Date:   Mon, 18 Jul 2022 15:19:34 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YtVP1ua2mS9pxK/w@smile.fi.intel.com>
References: <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
 <YrxjTD0sJXh8cgVP@google.com>
 <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
 <Yr1YXHb3GqwZncFK@google.com>
 <CAHp75Vf1UK9Z2P1D9v_j9rsdKoDXWSvb=wJgmkvACYgwofWrxA@mail.gmail.com>
 <35c907e6-6018-d22b-1992-ffc66eb82b0e@redhat.com>
 <Yr1iweMUl+EUY+Q6@google.com>
 <YtHF2giNT1gG1wge@smile.fi.intel.com>
 <YtUV5sE8A3ayQ/Q3@google.com>
 <YtUWB1ncCr1i3V5x@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtUWB1ncCr1i3V5x@google.com>
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

On Mon, Jul 18, 2022 at 09:12:55AM +0100, Lee Jones wrote:
> On Mon, 18 Jul 2022, Lee Jones wrote:
> > On Fri, 15 Jul 2022, Andy Shevchenko wrote:
> > > On Thu, Jun 30, 2022 at 09:45:53AM +0100, Lee Jones wrote:

...

> > > Is it okay to be applied?
> > 
> > Yes, I think so.
> > 
> > Can you collect all of the Acked-by/Tested-by tags you received
> > and submit a [RESEND] please?  Hans' TB which should be applied to all
> > patches springs to mind.
> 
> To save yourself some pain, leave off my Acks.

Actually it's less pain to leave your tags as they are now in the commit
messages.

I will resend it soon with your tags still in.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


