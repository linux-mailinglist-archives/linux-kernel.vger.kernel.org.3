Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1359F55F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbiHXIdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiHXIda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:33:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1003D5B9;
        Wed, 24 Aug 2022 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661330009; x=1692866009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tVYV8x5KqSC9OSZo8dHmjJz6cGc4M/c0VgmXCI9d7qs=;
  b=d/hcibLeRwq0wjwGPCPm3DXDLmMym9XGVV0wWsSWfjuUl0xH/d5w0yPe
   J2KWSxMeyE0FXIKT4vRvUaORqIyUoLtuRhGEq7bLmyCChX9wXhTa7nUZz
   zcGFSWfPJGkt0eSKTXJBBNzEa2ZGaS/Lzt6Qbn8uvMw6OkEe0Dm+OjzNR
   bg8up/YJ0ZEasM+qHxtf9PcNIiMKTWKSrzoJkQCba5mmOwDQYf781DG5c
   7DKu7uPnXcbYuwBEAZFlt9aLOo/HXYKpN13bnM1eOKCEEyfFcs01EELgY
   lMfo6R7yvC1mZRmgR3d3sgk3ewyUJRSiKA+yDykYjUAbUYrLh9oGgfzY/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="292649768"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="292649768"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 01:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="735799593"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2022 01:33:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DC93A19D; Wed, 24 Aug 2022 11:33:25 +0300 (EEST)
Date:   Wed, 24 Aug 2022 11:33:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH] ACPI: PM: Fix up documentation reference
Message-ID: <YwXiVUigUmesHRuS@black.fi.intel.com>
References: <5852809.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5852809.lOV4Wx5bFT@kreacher>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 03:28:02PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The acpi_dev_state_d0() kerneldoc comment should refer to
> non-d0-probe.rst which is there in the tree instead of
> low-power-probe.rst which is not.  Fix it up.
> 
> While at it, adjust the formatting of that comment to save space.
> 
> No functional impact.
> 
> Fixes: b82a7df4a7f3 ("ACPI: Add a convenience function to tell a device is in D0 state")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
