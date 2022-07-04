Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5BD565C18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiGDQ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiGDQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:26:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764386263;
        Mon,  4 Jul 2022 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656951962; x=1688487962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LMKwfuDkoiu+fxZN3zB/g4qGCzPpHLIblAMJnlcZJ5Q=;
  b=LJAhwDXCk3kqBMa1+ijEuG6XHKb2vYa6Xx78lfDLxHKnm3TO5CLCTQYK
   +V0ayYN0Qa3k+90THfUqG4vOXyyOTzEEICTxQXnL9GVHfbIye/MjQCg+i
   TxvMLc8L8FPFgH4+bmYtSpQRc6GcZ+pk7RYSq2tAX/OJx7RuRKuPZh8q9
   gH7Sc8ZkTzzDuBF17zWBuLDYxRKCkP4t5T56+P6BrpWwJbkwkOfBhMP/4
   NdrDjq/Sm1KcVceAPqIsZRrZYUkGpXlGM1BwsQiDFReGpb16UoplFIB4s
   7GLD5qireFeNEX5OYYIyLzHC0U60HKYc2JMs/P0crQe8VNEOqOoZXLYG9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="280718491"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="280718491"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 09:25:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="660260208"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 09:25:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o8OtT-0015Ao-1k;
        Mon, 04 Jul 2022 19:25:51 +0300
Date:   Mon, 4 Jul 2022 19:25:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: pressure: Kconfig: Add references to BMP380
Message-ID: <YsMUj+kzVtn0HPZ0@smile.fi.intel.com>
References: <20220704002747.207401-1-ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704002747.207401-1-ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 02:27:45AM +0200, Angel Iglesias wrote:
> Adds reference to BMP380 in bmp280 driver descriptions and symbols

...

> -	  Say yes here to build support for Bosch Sensortec BMP180 and BMP280
> +	  Say yes here to build support for Bosch Sensortec BMP1/2/380

Please do not shorten them like this, list all in full:
BMP180, BMP280 and BMP380

-- 
With Best Regards,
Andy Shevchenko


