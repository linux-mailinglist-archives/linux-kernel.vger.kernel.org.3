Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4159F564001
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiGBL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiGBL4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:56:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D3613F3C;
        Sat,  2 Jul 2022 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656762965; x=1688298965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IHRxPXI2AjXfX75L8NFTEgjJ1hQ1grsVio3ExHvN1eY=;
  b=iYFzn/mj8dMKK+pa/Wa0cGKGr5yTXYAZyoymdvBAQ6CKDTzSKuhYrlIH
   4sXsI1nNbWcdwhUNbQjkPdrMtzsxNPArL17UB35vCMhwtmr45jzpUGMe0
   sgG7BAza0fUQdKQTkd0v2IONCypcMuomdwIwGLVHgIcoSbT8whS4F00qF
   cPN7bGr7Iz4+qih1hCx7KjgWopD3b5wtzkhSl7S1u5f75P1PnrE7Egb/L
   pw7CN2m+i0KaXCGo9HepHTJHGtrsz58N/RvsbIB/WzXz1seKdIgWCGeGI
   OqMCqfpakRJQ98AltTHdvFteZ/bjQo9Vo3m8v/sNXdHJww/aJ+TJJkkXz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="346808053"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="346808053"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 04:56:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="768758377"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 04:56:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7bjA-0013aa-2j;
        Sat, 02 Jul 2022 14:55:56 +0300
Date:   Sat, 2 Jul 2022 14:55:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/8] arm: align find_bit declarations with generic kernel
Message-ID: <YsAyTNMvCNLeDZY/@smile.fi.intel.com>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
 <20220701125430.2907638-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701125430.2907638-2-yury.norov@gmail.com>
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

On Fri, Jul 01, 2022 at 05:54:23AM -0700, Yury Norov wrote:
> ARM has their own implementation for find_bit functions, and function
> declarations are different with those in generic headers. Fix it.

...

> -extern int _find_first_zero_bit_le(const unsigned long *p, unsigned size);
> -extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
> -extern int _find_first_bit_le(const unsigned long *p, unsigned size);
> -extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
> +unsigned long  _find_first_zero_bit_le(const unsigned long *p, unsigned long size);
> +unsigned long  _find_next_zero_bit_le(const unsigned long *p,
> +					unsigned long size, unsigned long offset);
> +unsigned long  _find_first_bit_le(const unsigned long *p, unsigned long size);

> +unsigned long  _find_next_bit_le(const unsigned long *p,
> +					unsigned long size, unsigned long offset);

Indentation seems broken.

Also for all: is double space required?


...

> +unsigned long _find_next_bit_be(const unsigned long *p,
> +					unsigned long size, unsigned long offset);

Indentation of the second line is broken (u in 'unsigned' should be in the same
column as 'const').

-- 
With Best Regards,
Andy Shevchenko


