Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F955A75C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiHaFhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiHaFhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:37:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D336A8327;
        Tue, 30 Aug 2022 22:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661924256; x=1693460256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2BmY08TpmPm2CQ9+xALqSFbs0LqS5Mmsg7iZ8SDKqIM=;
  b=LZSh2Olk2gwEBfbdp/eiNncZyrPWlqbPQiJLLoXnX0Gstv4n+QPDecUT
   MR9mOOB9wIgCm/toUDb9bMEFF06POnQEXTJEEpAinogvDwfnDCZ9rG2vr
   c8jRPtUxoSHhhkA41Sw4vLWCKuMolau9QO9hmB0HWjPMSEgMrJu6Yg6mp
   VXIAS2TxX6p9bnMWx2aROnCIB1y32Q/dK83yPvOj4wrvMT0ma0xN7RpCv
   CRyRgLKftYEuRRfi7i0HlrS1D/6B1iv5/RiGb6FDkG1fgnxReR2GIeRWP
   liy5uwlsu/0I7lYqpTELpv8BWoTD8cNwdUmta1F+DH7fjX/vTK3dV3Wmd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="357093844"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="357093844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 22:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="715582386"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2022 22:37:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 43556AD; Wed, 31 Aug 2022 08:37:48 +0300 (EEST)
Date:   Wed, 31 Aug 2022 08:37:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI: PMIC: Use sizeof() instead of hard coded
 value
Message-ID: <Yw7zqzuTuULMR1Yy@black.fi.intel.com>
References: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 08:11:53PM +0300, Andy Shevchenko wrote:
> It's better to use sizeof() of a given buffer than spreading
> a hard coded value.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
