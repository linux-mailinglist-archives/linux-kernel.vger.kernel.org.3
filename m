Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEC456423F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiGBTA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGBTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:00:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36C162EA;
        Sat,  2 Jul 2022 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656788453; x=1688324453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yvU0XF5WPIv08rLvOwNYp2E3/4NRlwUAnfDXcMlIHUk=;
  b=cG8aEcx/2bhZKTeFMropjaTrZ8NwWn6IwmC8nWSP5Ty5PmFd4SgA9RDm
   slS7CmkVvdgBO6hdxPcg9emOIXk4zgnzwlfAcfW/kscqZhI3jBpmUqULH
   rydNDLwA8v9+aoaq6wgTXyN0b9Wg8CW90VKDqzDygN1IFIEArEtDlD5RA
   4YIEN+I/3b5NtutvYyr/aY/tHS/OJGOKfscdpNsYFSi6B2zrVKFChflAD
   7k9+6X5sb1FiKgt14viqmQuaYCXXBtSEOdPQHP2Sb2AuS4e0ZQRpek1u4
   PUs+1vtqzcML7eKuqJyEeG6rZ41GAAgQ4+Fi5DE9gR4rFynx/OkCl6OkW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="282893247"
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="282893247"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 12:00:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="542052848"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 12:00:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7iKB-0013px-1y;
        Sat, 02 Jul 2022 21:58:35 +0300
Date:   Sat, 2 Jul 2022 21:58:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-s390@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/4] fs/ntfs3: Rename bitmap_size() as ntfs3_bitmap_size()
Message-ID: <YsCVW5Dt3YcE3TLL@smile.fi.intel.com>
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <56a3cb896ec446ca24e4756042d9f0829afc671a.1656785856.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a3cb896ec446ca24e4756042d9f0829afc671a.1656785856.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 08:29:27PM +0200, Christophe JAILLET wrote:
> In order to introduce a bitmap_size() function in the bitmap API, we have
> to rename functions with a similar name.

...

>  /* NTFS uses quad aligned bitmaps. */
> -static inline size_t bitmap_size(size_t bits)
> +static inline size_t ntfs3_bitmap_size(size_t bits)
>  {
>  	return ALIGN((bits + 7) >> 3, 8);

It would be easier to understand in a way

	return BITS_TO_BYTES(ALIGN(bits, 64));

>  }

-- 
With Best Regards,
Andy Shevchenko


