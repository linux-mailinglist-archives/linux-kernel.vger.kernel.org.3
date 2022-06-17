Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F39D54F542
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381811AbiFQKVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiFQKVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:21:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E5B6A405;
        Fri, 17 Jun 2022 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655461310; x=1686997310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9630itfmTE2oQKIg/VF8dscV4gSxkZdc73h/4g/mwqg=;
  b=CJYkm2NlIq4d9ZUDORk7b0AmyodHYf0XTMh7er83spYeVOqO9Gmqr+9j
   2EsC4Lrn64bc70QgHPJJZgms6QEq43KENowIL6vsf1NnHJCO8aPN7eJUK
   eUEZPTQw1/71IOV+IHJ8cwDjGe/a9ERXEJbhjHJ9G5D3ASZNQduKlvr14
   pAnnn2ffIpEPoG/cz2TgJr7tNAldd1iRIc4ZkMiUVd5OS+HdWiObcICHK
   xY8GOxN04z9FA61n04y7I9hi7RxohpOpbO78yyVH+f06lz/VSodl1cOZX
   Vyq1qoAfJV+kuDr98nmSGjs4cDSM3JeL7Pua23fHzP36w25gUe0sxbQAF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280186031"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280186031"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 03:21:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831984894"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 03:21:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o296n-000eyc-GZ;
        Fri, 17 Jun 2022 13:21:45 +0300
Date:   Fri, 17 Jun 2022 13:21:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update DW 8250 UART maintainership
Message-ID: <YqxVuaCeT+TH7co0@smile.fi.intel.com>
References: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com>
 <YqxNHJ5mGA1tJamh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqxNHJ5mGA1tJamh@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:45:00AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 17, 2022 at 12:39:29PM +0300, Ilpo Järvinen wrote:
> > Add myself as maintainer for DW 8250 UART and up it to Supported.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Obviously I need an ack from Andy too.

I just gave my Rb, but just in case
Acked-by: From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> And thanks for doing this and
> all the work you have already done so far, it's appreciated.

+1 and many, thanks, Ilpo!

-- 
With Best Regards,
Andy Shevchenko


