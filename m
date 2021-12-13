Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09647363D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbhLMUpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:45:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:9028 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236136AbhLMUpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:45:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="238772610"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="238772610"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 12:45:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="603854155"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 12:45:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwsBc-005m8o-4m;
        Mon, 13 Dec 2021 22:44:40 +0200
Date:   Mon, 13 Dec 2021 22:44:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li Wang <liwang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] radix-tree: Replace kernel.h with the necessary
 inclusions
Message-ID: <Ybewt64Szbudu6B+@smile.fi.intel.com>
References: <20211027150528.80003-1-andriy.shevchenko@linux.intel.com>
 <CAEemH2edgtA+XOY8WjgwFD-50qcw_MGFSgjjBjgKVi_dAwtR6w@mail.gmail.com>
 <YZT7q+Eo9mudqOLF@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZT7q+Eo9mudqOLF@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:55:08PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 17, 2021 at 03:01:12PM +0800, Li Wang wrote:
> 
> Thanks for the report! And do not top post next time, please.
> 
> > This patch breaks the radix tree test building.
> 
> Yes and no. The dirty tricks with kernel headers that tools/ do is what has
> been revealed by this patch.

Should be fixed by Matthew's patch.

-- 
With Best Regards,
Andy Shevchenko


