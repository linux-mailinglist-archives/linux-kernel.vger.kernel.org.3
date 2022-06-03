Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E846453CD84
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbiFCQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiFCQum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:50:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B025517FF;
        Fri,  3 Jun 2022 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654275040; x=1685811040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NzC/yKGfgbXpUiptMc8VzWfAMs4deWz+1hiZ7ehs/Ys=;
  b=XOgG/vGN9kcSEtYZOjlYXrwoUYQ9sCBKO3c6ccEZ7FWiMOvpEkeErXsA
   9e8k9iJstw6RNYlKCPkuuNvuL5oSDh45YzFDXBt5Hl8Lpu9tzkmlvgV/X
   43q/xfN4oIoq0T43AtGwBre7ZXOh+94s5zpHUDqT+QtGjnkJXKDBQdYrM
   W26gQ+jR0aHZBVlX3VuTwlm/gaCmjsuaKDFZ+f34izK1VahIP83S3Yzxj
   rh5y7JWOqW4sB1ZYaWjaOkB4X1ceFQNCctR0PosdnmrQpyXyLVh5v5tO1
   ZCk3CvFRORV0oK/QDfOKOkqpvVsenISSkiJOSd3bVLXt4nyRo9vrUQXTy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="263951283"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="263951283"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 09:50:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="553410112"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 09:50:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nxAVO-000Sbi-9J;
        Fri, 03 Jun 2022 19:50:34 +0300
Date:   Fri, 3 Jun 2022 19:50:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 2/6] iio: adc: meson_saradc: Align messages to be with
 physical device prefix
Message-ID: <Ypo72X1X3aCtBBGd@smile.fi.intel.com>
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
 <20220603100004.70336-2-andriy.shevchenko@linux.intel.com>
 <20220603172117.792ce869@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603172117.792ce869@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 05:21:17PM +0100, Jonathan Cameron wrote:
> On Fri,  3 Jun 2022 13:00:00 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Align messages to be printed with the physical device prefix as it's done
> > everywhere else in this driver.

> Here I'm fine with the use of the parent as can only happen after all
> the setup is done, so it's obvious the parent will be assigned
> (some might argue it is obvious in the previous patch, but I had to check
> as I couldn't remember when we set it :)
> 
> Anyhow, LGTM. 

Thanks!

> > v3: new patch (inspired by previous change)

-- 
With Best Regards,
Andy Shevchenko


