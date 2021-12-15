Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBAE4756EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbhLOKve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:51:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:4958 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241795AbhLOKvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:51:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="239012028"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="239012028"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 02:51:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="604941785"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 02:51:28 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 15 Dec 2021 12:51:26 +0200
Date:   Wed, 15 Dec 2021 12:51:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: check the return value of kmemdup()
Message-ID: <YbnIrsQGsjRnksq4@lahna>
References: <tencent_8268B88CD2F7BF04083AF35D6E2C87158506@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8268B88CD2F7BF04083AF35D6E2C87158506@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 13, 2021 at 04:27:15PM +0800, Xiaoke Wang wrote:
> Note: Compare with the last email, this one is using my full name.

This should go below the '---' line. Remember this next time, no need to
resend this one.

> kmemdup() return NULL when some internal memory errors happen, it is
> better to check the return value of it. Otherwise, some memory errors
> will not be catched in time and may further result in wrong memory
> access.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

I sligthly modified the commit message and applied to
thunderbolt.git/next, thanks!
