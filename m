Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B804C4B74
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbiBYQzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbiBYQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:55:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D91E6953;
        Fri, 25 Feb 2022 08:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645808111; x=1677344111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a/2QHHN/ETWTPtmCEfGXBl9buOitSAcfb/bJHn2KyY0=;
  b=aEtKsCDGlXMH+++MMqQOG1eb2JKVNPnIchpUA7Pn4EeVmtTFyOPlwRi/
   Ilqpgpb28m9jcp/DlbzGPESomgkChUTuva5sA8Bd/CpwMwLIOCpEiCyXK
   SY+EhDyV57W5AxuAssbPuPmd7WJpnYlf68+nnmSnHzAaBxYh35c5nYX5J
   4G9npQ7GRcVRdefsQ7RUxdFmxBDwb3wcWifVa0ZiJrMjNwsZ2GkStFihi
   KW0w9ND5ZznU7vRRj7J6waYsSw+lUmUJBJzoiY8IFPSXLP+3ke3HCu/oz
   LBIg8XQXetQ5DHTX3pF/QpDYDvKIsrCjaAc+EamfV8irEO+LZGKjzS0YA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="250112543"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="250112543"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:55:10 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="640169939"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:55:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nNdrG-008GpT-3G;
        Fri, 25 Feb 2022 18:54:18 +0200
Date:   Fri, 25 Feb 2022 18:54:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        yoshihiro.shimoda.uh@renesas.com, adrian.hunter@intel.com,
        swboyd@chromium.org, dev@lynxeye.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: check the return value of
 wakeup_source_register()
Message-ID: <YhkJuZb7PfGvmRTY@smile.fi.intel.com>
References: <20220225121858.25638-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225121858.25638-1-baijiaju1990@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 04:18:58AM -0800, Jia-Ju Bai wrote:
> The function wakeup_source_register() in mmc_alloc_host() can fail, so
> its return value should be checked.

NAK.

This doesn't explain why this resource must be non-optional.

One should not dumbly use the robots.

-- 
With Best Regards,
Andy Shevchenko


