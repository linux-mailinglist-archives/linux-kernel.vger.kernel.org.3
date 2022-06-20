Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85053551CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbiFTNRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344625AbiFTNK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:10:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130A31CFEA;
        Mon, 20 Jun 2022 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655730336; x=1687266336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZzVSD9qEoT6Yq+FOyrnnfBbkXdS74k0EP3YzW+wwaHs=;
  b=cKdUwqb927M/u3Ek04PuESB/qbsEFJspcWBZC2D3NCxrvrIWTa84pfDs
   52Sur0QTQ/2yhmf1PJMvMhXIN99HJ4ASzaDfY4f65+lAB6wVPivS5O/Vu
   3zbhXYfOT0rR47ONJLe8+bFS1jQV9zY0NP2Vu22idMlHa0ydW2wp/0SvE
   9jMVDOrgvX49GQx4CsO0p7p5rWZQ2BlJxB1ni6sASHqaY5TOA3tAVDxSm
   BTrfSJvvClqkVjkKp7yVmDtudjq0ErV0F4v5Bg1zctznVkx5wutuVNPVU
   bGNDYk3u+kAuJChMakfLWW+vioiyV6mQwsLARFaPDFvK4Fzfbj5t59ccr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341569969"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341569969"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 06:01:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="833107585"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 06:01:19 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 20 Jun 2022 16:01:17 +0300
Date:   Mon, 20 Jun 2022 16:01:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/7] pinctrl: intel: Embed struct pingroup into struct
 intel_pingroup
Message-ID: <YrBvnW/pKj2Rgft/@lahna>
References: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
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

On Mon, Jun 20, 2022 at 02:44:33PM +0300, Andy Shevchenko wrote:
> Add a new member to the struct intel_pingroup to cover generic
> pin control group parameters. The idea is to convert all users
> (one-by-one) to it and drop old members later on.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the whole series,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
