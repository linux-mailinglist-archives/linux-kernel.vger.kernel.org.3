Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB0F5A6891
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiH3QlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiH3QlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:41:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760DAA50CF;
        Tue, 30 Aug 2022 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661877667; x=1693413667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ry8/6c1jhzg+tAE0icVZIgeSJDHu/T4hEJBLEUslJHs=;
  b=b90sHZ85HqyOi0ISUx2J/v2GjNN2ngviIY/qcpTWN3q+xEoriJvX/zPk
   IJaCKOdjM26yDsbO+yR+YX4f9HsfrWShyz05JgdeewsfAzkegttG3uaLI
   L+4YXJ4z/gRD3N27Zpqm58FbFiIhTdPZsFe5Pv/Ifc+97FTnaMYUyG16h
   ItYlqOFGyQSh0fiQW8dlcXX+fwPM1xACkM7CuEDhhU3Z7jkdOq5J3rpNR
   wLgZqqz75qtbSArbo+4kWb+fkLmg3zL6yHfzMEZmqGp62to7SlHNzAeHJ
   nV/Jn8vCwrXavOo9+S4CVuiqQkGcJEnnkttMZ/08PB64ed5la7RO6ZVC7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296514300"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296514300"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:37:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="562720029"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:37:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oT4F2-00625J-1T;
        Tue, 30 Aug 2022 19:37:32 +0300
Date:   Tue, 30 Aug 2022 19:37:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 2/2] ACPI: PMIC: Replace open coded be16_to_cpu()
Message-ID: <Yw48zDlSGCbquPSb@smile.fi.intel.com>
References: <20220830135532.28992-1-andriy.shevchenko@linux.intel.com>
 <20220830135532.28992-2-andriy.shevchenko@linux.intel.com>
 <Yw41ai0mYHIgtgs4@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw41ai0mYHIgtgs4@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:06:02PM +0300, Mika Westerberg wrote:
> On Tue, Aug 30, 2022 at 04:55:32PM +0300, Andy Shevchenko wrote:
> > +
> > +#include <asm/byteorder.h>
> 
> Isn't there <linux/byteorder/*> as well? Is there something that
> prevents using it?

Nothing. Actually above is my local stuff, that has not to be used.

> Otherwise looks good to me.

-- 
With Best Regards,
Andy Shevchenko


