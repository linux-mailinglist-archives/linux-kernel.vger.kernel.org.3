Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25E64FFD32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiDMR70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiDMR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:59:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17D3CA64;
        Wed, 13 Apr 2022 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649872620; x=1681408620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XSXq+KkKbwckfZ/6ovsb8HTvP/tL2vaavaLSVBcQ3x4=;
  b=lNmXn+2Bq1I2ccbbj9L2ibPfsHP6cZ+Y5nMLalzt2gez8wr41ewxRyAF
   m810xKVEa401YtAiE9dftKi9sJ6wtzuQeNJtBGL0bOZhxFBPZ6o22eLcp
   8pD6343QLRsiD/4Ipck3HtqarqIWca7lr3jQNqrtzjinJf26tl0ebB9dx
   jvz/GmB2kyVolibK4azkj9r8cjdknM+LY4xc1UH/o6KG+uNcnB5kkCczd
   SZ2e8O9MrkTw0rouhKTMxM2EQGmQ2ju2MgH9zpUaNtSr8kwrWR3YkWEma
   ddbXKG+6hjNb7cLUod2SOPK2fjiCjtKwOZ2nB5Usf+310+3aPCZZ50II8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="287767537"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="287767537"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:57:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="508071581"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:56:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nehB9-001x5l-VL;
        Wed, 13 Apr 2022 20:53:19 +0300
Date:   Wed, 13 Apr 2022 20:53:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: imu: mpu3050: Make use of device properties
Message-ID: <YlcOD3jQpESFYjgv@smile.fi.intel.com>
References: <20220413172122.85629-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413172122.85629-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:21:22PM +0300, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.

Subject should have the proper drier name, but I'm not going to resend right
now, let's gather comments, if any, first.

-- 
With Best Regards,
Andy Shevchenko


