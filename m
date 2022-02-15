Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0774B75B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbiBOQrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:47:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbiBOQrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:47:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EAEBDE71;
        Tue, 15 Feb 2022 08:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644943615; x=1676479615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U9cLS970bwlyW17ctpm79Dm5QjC8dMWPZatYaS+V9SM=;
  b=LT67/gCzFP+d0j5GALSpoymfzjiLht6Do3kAmv6iK1L3XpRWn2mZ3Q1t
   blBYkOwjzMiS/SQB1nHj9U/sHEyIfRVN5esL0Mz53H43tHJk3IK24audp
   inxCwbD4wkr9R1llQDN9e4IE+E/1JEEqKTanFbBabTdySGAkxnS5theMf
   XJIHM0ssiv7MwHguImTQTkIY5Ejf5uNRPtAe8P9CzpyjCjf3LWeYyH7S3
   pFap486XI+/82+S36y4riGDUokkXubB1R8EdduJ7kXHI3HinL+KiLcCAv
   3iqgS8rWBKbU3hZhJB48tnxb+kVP8v+VrnUd35JMYPR0pmm6keRrEoOfH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250133755"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250133755"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 08:46:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="570911110"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 08:46:52 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 15 Feb 2022 18:44:40 +0200
Date:   Tue, 15 Feb 2022 18:44:40 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/4] pinctrl: tigerlake: Revert "Add Alder Lake-M ACPI
 ID"
Message-ID: <YgvYeJSvwaCXzISF@lahna>
References: <20220215152800.21104-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215152800.21104-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 05:27:57PM +0200, Andy Shevchenko wrote:
> It appears that last minute change moved ACPI ID of Alder Lake-M
> to the INTC1055, which is already in the driver.
> 
> This ID on the other hand will be used elsewhere.
> 
> This reverts commit 258435a1c8187f559549e515d2f77fa0b57bcd27.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Please mark this for stable too as discussed.
