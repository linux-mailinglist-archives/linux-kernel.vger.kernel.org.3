Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE6B57554A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbiGNSpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiGNSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:45:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4CA27148
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657824318; x=1689360318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5XgSObRvgCEBVYMNFLgm/u5va9kqcKxCl7i6MOEhDrY=;
  b=IHEMW4bpwlMVJGVsjJTzTpULfrsyndpDjBoTrOLlKxT0tv4uJcR2RMFM
   hpfEPytX2598kKCW+7qBNgHIzBj0GJK61RKsMUxcikT0vlqcIyOPTBa/1
   TMM92ANtf2ffKufzwf3CdvKb+t18woqkZ6XD6qEFAZ4kLc83urfFc2fry
   JPkJgk1QRU+8F8EpmDfXd/g7Vx25TkAtudWtnf8EJt95tFKGLF5u1Kc8P
   yFIv1DmyHviWl/NedqI66uQVANwTRYPCXfmHEMQWBNqzmC5L8U1RAz6Wm
   zVlxi9ZF1pG8rgwmFg+dTE+8Je09GN98qZ1rPJv6612WLdO7ghmGkAVLS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286741071"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="286741071"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:45:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="685678001"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:45:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oC3pq-001Dco-13;
        Thu, 14 Jul 2022 21:45:14 +0300
Date:   Thu, 14 Jul 2022 21:45:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v1 1/1] nvdimm/namespace: return uuid_null only once in
 nd_dev_to_uuid()
Message-ID: <YtBkOo2vME1jgU1C@smile.fi.intel.com>
References: <20220607152525.33468-1-andriy.shevchenko@linux.intel.com>
 <62d05f453b73e_1643dc29412@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d05f453b73e_1643dc29412@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:24:05AM -0700, Dan Williams wrote:
> Andy Shevchenko wrote:
> > Refactor nd_dev_to_uuid() in order to make code shorter and cleaner
> > by joining conditions and hence returning uuid_null only once.
> 
> Apologies for the delay, applied for v5.20.

No problem and thanks!

P.S. One patch out of three is a fix, would be nice to have it in v5.19
release.

-- 
With Best Regards,
Andy Shevchenko


