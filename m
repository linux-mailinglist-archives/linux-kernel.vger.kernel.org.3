Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE153E739
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiFFJbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiFFJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:30:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5A9D2476;
        Mon,  6 Jun 2022 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654507842; x=1686043842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uhgD5Y73qU839IGYCYks5iETug9dclDZNvPWP370A6c=;
  b=afNNbRm1tBkl8iIKGx5vBZI7U7+KFdurHxo4mPu3N0f0T9l3hNWOcfl3
   0RMk1pKYpKRFRVv0DVpRj5AQ7t4K+tH8bK7ZGI0/Ky6IMultTbRxHRX55
   IhMvoXi4Q1yqDAUZhE/Pr+8x+qouxgQuIgzpzfbPWwsaNTJyBDVOXBaUz
   N/CIuAG8b3eFLm0mTc+O8gdA4J9S4tw7vy4kp9o+CZZp7+DuhxtNwgZG1
   cmJ678q8kC/3kJpDwomG+gly7vVKwcV6e4JBF6qAUm05fikMGizjD1K8G
   2XV0PAapCbI/ln15EOr6tG8270SIpHtkmqcKQN2/Oy1wmls3DjY9H/3O3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="264501355"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="264501355"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 02:30:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="825733223"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 02:30:18 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 06 Jun 2022 12:30:16 +0300
Date:   Mon, 6 Jun 2022 12:30:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] thunderbolt: Fix some kernel-doc comments
Message-ID: <Yp3JKN5Bxc4vlKSm@lahna>
References: <20220526130154.89745-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526130154.89745-1-yang.lee@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:01:54PM +0800, Yang Li wrote:
> Remove some warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> 
> drivers/thunderbolt/ctl.c:701: warning: expecting prototype for
> tb_cfg_start(). Prototype was for tb_ctl_start() instead
> drivers/thunderbolt/ctl.c:722: warning: expecting prototype for
> tb_ctrl_stop(). Prototype was for tb_ctl_stop() instead
> drivers/thunderbolt/ctl.c:930: warning: expecting prototype for
> tb_cfg_write(). Prototype was for tb_cfg_write_raw() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied to thunderbolt.git/next, thanks!
