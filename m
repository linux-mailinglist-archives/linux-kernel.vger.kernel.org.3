Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04647472B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhLML3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:29:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:64590 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232750AbhLML3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639394970; x=1670930970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9RDE9X/9sDqBsn/mVYWwljvDotWbEy2DyOUJa2z0M0I=;
  b=At8/2+Xfbr+TJSWZVQmwGdL3Gh+vTW2RVGlH6T1I/uRYUnYdPa1WLxOl
   AaPapY6dalJhFtT/XNQjCqslwxvXhGDhFVTQxn62hN86A88ZWmjBfGsRG
   Zd2Y0McswYzjPYH4TXfuQa84gZfBZLxKc1C4zD3DfVbI5vN4tLHg27EMW
   Nk1Eh/AbE0N3MfYmeV4iZ79nfTUKEHjw6w537RCjL8a+w2pcab1fiRSJQ
   DVWm2YKAM6OpUBRqBrUHEgm6xBlDcd2mv15IluiQklPABIpg2C1H7E9Rc
   XVHtXkkeqvSzRytlnTGjEq4HV9Dse5IuP+apKsHMd2UdAo0E8t2ia7hiG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="299496735"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="299496735"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:29:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="544746742"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:29:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mwjVP-005b2F-3w;
        Mon, 13 Dec 2021 13:28:31 +0200
Date:   Mon, 13 Dec 2021 13:28:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linus.walleij@linaro.org, andy@kernel.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: sch: fix typo in a comment
Message-ID: <YbcuXo0GUGgC3jBU@smile.fi.intel.com>
References: <20211212031108.32212-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212031108.32212-1-wangborong@cdjrlc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 11:11:08AM +0800, Jason Wang wrote:
> The double `the' in the comment in line 142 is repeated. Remove one
> of them from the comment.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


