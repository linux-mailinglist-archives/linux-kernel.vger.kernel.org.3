Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01D4CD631
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiCDOSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiCDOSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:18:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1842559B;
        Fri,  4 Mar 2022 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646403470; x=1677939470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=or3pXL7frdL+sQOxlxnzqbp2iB/FyXVFN2iAqqfq00c=;
  b=gFMQ9jfeg38vNguS5itQreotU4r2bH/Brn7m+7HSPGJ63/+LFihsNQp+
   2azxkFZPQ28jKmGDY8s5zjVYH3ufj3L8/pPEoD4X0+ND1Jhm+qMvCOuKS
   rtRzGHOsotROQfa4BmiGsrL2cbWV/ps0p5LfJUGQlL3l9ZXRSKvN1GDt/
   ZWcTyPCwWF6kqadDRhou9FTLtyl3yS8Nj7eN5OwihB/8Cq4XQV3LFIsAv
   VJutUV+urkdsRLvzg/CCxyBaPrF+wHmNvx+tg47awQCqGOwCK5OmWl4iU
   H/XtkoJhlGFopRg1P8aT3gJzN+orsJiUXEeQ7QxS9ulvthT7ymDj/wTOd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="253711653"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="253711653"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 06:17:50 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="710345703"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 06:17:48 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 04 Mar 2022 16:17:45 +0200
Date:   Fri, 4 Mar 2022 16:17:45 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Sanju.Mehta@amd.com
Subject: Re: [PATCH v2 1/5] thunderbolt: Retry DROM reads for more failure
 scenarios
Message-ID: <YiIfiYyJrdmavuAD@lahna>
References: <20220303131328.4150454-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303131328.4150454-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Thu, Mar 03, 2022 at 07:13:24AM -0600, Mario Limonciello wrote:
> Currently DROM reads are only retried in the case that parsing failed.
> However if the size or CRC fails, then there should also be a retry.
> 
> This helps with reading the DROM on TBT3 devices connected to AMD
> Yellow Carp which will sometimes fail on the first attempt.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

This and the rest of the patches applied to thunderbolt.git/next,
thanks!
