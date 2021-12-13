Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A2472E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhLMOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:00:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:62847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhLMOAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:00:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="226012670"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="226012670"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 06:00:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="464640047"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 06:00:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwlrs-005dsW-JF;
        Mon, 13 Dec 2021 15:59:52 +0200
Date:   Mon, 13 Dec 2021 15:59:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v21] tty: Fix the keyboard led light display problem
Message-ID: <YbdR2BoCCXY62kKS@smile.fi.intel.com>
References: <20211213124122.25605-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213124122.25605-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 08:41:22PM +0800, lianzhi chang wrote:

>  v20:
>  New solution: kbd_struct adds a new "kbdledctl" attribute,
>  which can be obtained or changed through ioctl;
>  "kbdledctl" is used to determine whether the current VT
>  can set the keyboard led light;
>  v21:
>  Format correction

It's good to wait at least 24h before sending a new version. Not everybody who
might comment is awake, for example.

-- 
With Best Regards,
Andy Shevchenko


