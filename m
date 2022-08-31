Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49955A7D11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiHaMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiHaMPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:15:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE29190C7E;
        Wed, 31 Aug 2022 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661948145; x=1693484145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9/K4sY/ISZj7uQoVHgNrvGLV0hnzb2nkflnj/eF3v+c=;
  b=g8Ux43FfUUF8YjmZLDZkdDwNH+MJrPlw2CnS4l+Ri9fQLeIJRGwPbtl0
   kwa4qin+2D7uHXR9qcBX3erDCObVZe4/oFhMABtOmU6SKa6IUOAny96Rt
   ELjFIBCIWMUQBnxADJkPQxe14+MTZSEkOQAfsiHG3PdEVjUj7Fv31atR4
   NPH6YCKUovFoG/UiZdyrYpbxpm5UsuoaceDppOqoiA2LPrKxorAYbVVYC
   T2znA/IouzxBBEGvXzzgzwQnpL216B1YgFbZkG1DWK/gZTqPyOqEKRsdC
   Bf6W1vdydqu5hOEZBKWCC2REjDpLlEnBmKnlxqG0jvHExyTK+No8k6USG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381729293"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="381729293"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:15:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="589009146"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:15:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTMd5-006MuA-0b;
        Wed, 31 Aug 2022 15:15:35 +0300
Date:   Wed, 31 Aug 2022 15:15:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com,
        rahul.tanwar@linux.intel.com
Subject: Re: [PATCH v3 19/19] hwmon: (mr75203) fix coding style space errors
Message-ID: <Yw9Q5krebHnb73vC@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-20-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-20-farbere@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:22:12PM +0000, Eliav Farber wrote:
> Fix: "ERROR: space required before the open parenthesis '('"

This patch may have other fixes like adding new blank lines (noted in one
of the patches in the series), etc.

-- 
With Best Regards,
Andy Shevchenko


