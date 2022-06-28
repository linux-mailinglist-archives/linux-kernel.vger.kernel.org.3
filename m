Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB055F1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiF1XH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiF1XHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:07:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084BE3878B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656457643; x=1687993643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3D9hkszS5Sp6QtIVbfbCRR9ndazwg0ccWrCPWGf2ahs=;
  b=T4IjQqWoAYL9k5MmeQP+CE4gza6/MHf2+JhD+i/59HmF9T8GqYjnQ8RI
   7AGOXOw9fpZqCMVaTrXI+gOfp/9G88HEMjElIvfPnfMqVYNrDiVfcr9Wh
   KrcX/c8/f2/HInemAdqQ4rzYDd0kQ+EmQ3/IX/nxh3yifmos2EmDcjJtF
   v5w/tRNErgtJJzm2WaCa//PUS/g7Rj1R5La463phuc4iQxiZGvwdWUupF
   u8KYnXyCiM9I4cmySyxpH/u109qVv7DRnxX+v2OHmVSav9SwO3nWYx5Ah
   K8GLB/qlEs7GipZOTRVGHl+uStaY9M4Hc3kv8LXgKzMQy3T7DjyvRU7Sd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282605078"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="282605078"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 16:07:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="594988838"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 16:07:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o6KIN-000xG1-Bk;
        Wed, 29 Jun 2022 02:06:59 +0300
Date:   Wed, 29 Jun 2022 02:06:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YruJk4aAmFo/mihX@smile.fi.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <81201d93-ffc5-024c-c132-36f91d9e663e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81201d93-ffc5-024c-c132-36f91d9e663e@redhat.com>
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

On Mon, Jun 20, 2022 at 11:04:38AM +0200, Hans de Goede wrote:
> p.s.
> 
> I've added this commit to my local tree, so that the next time I boot
> a device with a CRC PMIC it will get some testing.

Have you had a chance to boot such device?

-- 
With Best Regards,
Andy Shevchenko


