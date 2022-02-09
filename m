Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9234AF4FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiBIPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiBIPRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:17:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D739DC06157B;
        Wed,  9 Feb 2022 07:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644419862; x=1675955862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iFASjSpKvo0bZl/qP9Yc/v67o7SlmFUbtvRAPvFtM4g=;
  b=LwLeq8DFjka461EFjtlHKHWr4P50Zrc1YqGDjCndXHhXpK+K8vmVBRWU
   NU/VVIB+lKhKLFdx6UUKfT20DdvKq6uDv3agR1+msGHPlgHBjmTo5NXe3
   L+KVZy7x0ooiS7LszagnY0ioXgXjYnBSC6KuagBfWZTdHvtascrKEgo4i
   Np4yemCmqRTUhnD06/s53GhxSJNKx6CbFiHZRn+iMuqQQbYntSpO+Dgua
   0P/b9VABgIbrSbd2MXMfbPujoOT2BGinwNdr18pi3/kwd/MQJrzLClHPp
   0sY0dpaRyzp7WB9jZXrFIAI8yZT+uK0EULMYuYY8R9mgXwuR2GjTFUX+w
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229871361"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="229871361"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:17:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="499998841"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:17:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHoi0-002eXj-LD;
        Wed, 09 Feb 2022 17:16:40 +0200
Date:   Wed, 9 Feb 2022 17:16:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Message-ID: <YgPa2AD727QnlRWW@smile.fi.intel.com>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220209091204.2513437-1-javierm@redhat.com>
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

On Wed, Feb 09, 2022 at 10:12:04AM +0100, Javier Martinez Canillas wrote:
> The ssd130x driver only provides the core support for these devices but it
> does not have any bus transport logic. Add a driver to interface over SPI.

Thanks!

Same set of comments as per I²C patch.

-- 
With Best Regards,
Andy Shevchenko


