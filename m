Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3DE55217C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbiFTPqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiFTPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:46:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7351ADAE;
        Mon, 20 Jun 2022 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655739985; x=1687275985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pZhdOpmEUjMvMBePHomLslnlBLxIqNT/VNvZ7MCBzWE=;
  b=mi6GHyprWU9F0ZaXhSd3evbmL0QuMQetgGigJcLTr100Vt7HUoeK0Y9t
   ZM+TKuY9f9TxIwL6DYdzJbS6Ok16D5i5kWWISpJipgnSP+QubktOM5kP8
   wp5dPZvqXdidlU9SJCWlKUv2GKaNMa7eQZrKzt+UIb5HpMdxjzgsp7pR4
   Pl9LWbaqGOcGvzEjThCB8RtrUYZDMmstv9PRmmsyOQT2J208JBi52WvCu
   4ZFp2S+UPthpD+Aa7VfI/BQtEQdgH72IEn8E9m4BdxBVTNzISKHwxsEve
   1gUoBZdEoUUD04T3rvZHh6cPYVXF+Ou1ZCgNkJpeuO61SJaB5HTZUgyZS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="278698548"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="278698548"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:46:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="654740209"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:46:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3JbZ-000kWF-6Y;
        Mon, 20 Jun 2022 18:46:21 +0300
Date:   Mon, 20 Jun 2022 18:46:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/7] pinctrl: intel: Embed struct pingroup into struct
 intel_pingroup
Message-ID: <YrCWTAm/xAKZBCzW@smile.fi.intel.com>
References: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
 <YrBvnW/pKj2Rgft/@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrBvnW/pKj2Rgft/@lahna>
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

On Mon, Jun 20, 2022 at 04:01:17PM +0300, Mika Westerberg wrote:
> On Mon, Jun 20, 2022 at 02:44:33PM +0300, Andy Shevchenko wrote:
> > Add a new member to the struct intel_pingroup to cover generic
> > pin control group parameters. The idea is to convert all users
> > (one-by-one) to it and drop old members later on.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> For the whole series,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


