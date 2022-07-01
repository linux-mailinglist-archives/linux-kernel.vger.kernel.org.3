Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C255632E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiGALuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiGALui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:50:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BC87B357;
        Fri,  1 Jul 2022 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656676237; x=1688212237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NiYL5Jr2KLxooX4pas5+jSalXMUHhgELTa/NNp/8y1o=;
  b=KRPFDWU5piVo4snfhWXICTiLmBDrov6hLF+Py2huxBYNdrOt5R0PS5NW
   MiPAqr7BUR+E4hUNlBHlHPIHrlUybr5BlJM0PeEEMTggjX4lZHgjhGaQM
   Fo1ErV6pP+BN3mBXVbGOD0MqTTtdL0g4havFYtFN+PHvYm0qNcJp+71x2
   TU/mV97zhqidtoa0rdEevBRJyR81UI291WJM/B7trwVKUAcgHlQeL7m4i
   v0uCwhHnoPYz8VinnICcevcKmuIXu5jN0RZvJbMraJ2KMGX8nO6praQFe
   AIUUaZEN6YjejdWTnv4oMYJ58LDqXXQ9NNp+7Sc+7aJ4+sBTxgmvwI8Z+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="265664543"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="265664543"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 04:50:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="768481899"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 04:50:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7FAP-000zK4-Ir;
        Fri, 01 Jul 2022 14:50:33 +0300
Date:   Fri, 1 Jul 2022 14:50:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86: xo15-ebook: Replace open coded
 acpi_match_device()
Message-ID: <Yr7fiZlwLIiCE9Ys@smile.fi.intel.com>
References: <20220630194335.3730-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630194335.3730-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:43:35PM +0300, Andy Shevchenko wrote:
> Replace open coded acpi_match_device() in ebook_switch_add().
> 
> Note, while it is a bit longer it is more robust in case more ID
> are coming.

Discard this, a last minute change that makes it not buildable.

-- 
With Best Regards,
Andy Shevchenko


