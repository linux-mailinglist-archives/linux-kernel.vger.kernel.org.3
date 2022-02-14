Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9724A4B4596
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbiBNJYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:24:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiBNJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:24:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FFE60A87;
        Mon, 14 Feb 2022 01:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644830682; x=1676366682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ed8p7wZmfq9qaecYJ91WYD/Rtq61LoHJ4xgf1YjcwCc=;
  b=c3CoH1y1hvC3f7K38/iFAfUx3ifQbvWjuZYaLUxtA+GXdoAN590Gmx5+
   RkblPnQcWYe8dnDgFRJf/KXq0IIVNZyq6cGlVg9OoeWIlXEyvAs1SjYjy
   iUVP/F8VFabTi5DpNYwcJ6kSEnA+Nil0diX7W+aej+hf6WpUY2Y4TQHp/
   PRK9DI+lJoz57xNqNCeGsbohBYlRYVDy2UAwNmWRbLobVhF3eAGRmSdKy
   vya111AdTOc4ectwcqH1i75XyW0sCfmBxFu3Xg90emVW7e2H+Pz4p5MiF
   iTTuouFi3AcTFiRQZ0qckEfgYdk6J2wjoe4t9AtaNQKuecXR6kgXiZOgb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250256698"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250256698"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:24:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="635042341"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:24:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJXaC-004OMi-AY;
        Mon, 14 Feb 2022 11:23:44 +0200
Date:   Mon, 14 Feb 2022 11:23:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 1/3] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
Message-ID: <YgofoEOPuiB4LbQT@smile.fi.intel.com>
References: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
 <20220213175559.46e8dee2@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220213175559.46e8dee2@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 05:55:59PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Feb 2022 15:55:20 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > In a couple of messages the constants, which have their definitions,
> > are hard coded into the message text. Unhardcode them.
> > 
> > While at it, add a trailing \n where it's currently missing.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> 
> Mostly so I can remember what is going on with this patch,
> Nuno is OoO and planning to test this series when he returns.
> 
> Given that I'll wait on Nuno's testing.

Me too :-)

-- 
With Best Regards,
Andy Shevchenko


