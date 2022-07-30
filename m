Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EF0585B2D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiG3Pzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiG3Pzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:55:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE4EE0C
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659196536; x=1690732536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GH5Qn/oqgJv/KZAJ6M4hNx4oH+5v+S8EyuyVYp5QGtE=;
  b=BFy4QVl7k7DXEzZYd+Imh3PFrS0hb7hcjhV3J1xjc5gJHIRsNBfQQwJ3
   7BsgU799MGRxR83aBm4PUBTgp914nRHaPSy8m4C/dBQEhTP8IraeXNH+2
   9xmJ1djye3mn9DGIE9NYKAJ9qvxpWOvioflBnJc34C9ZiuhZvHPH52hN3
   vyuq4UUVLW+jRDQv1yQ88kVuKyTjlSx4dBT9RIKLbtTxK/X/bA+2eNxd6
   6/0u+YON5k0fNKnS84J8dCFviluE5XIWldO31OwWkUOKtWh/jP7ui0fBR
   0pIOb0F1Lp7QOu7RjBE/1JQZv6YfuJ4/udTE6bfD9taxYPuFoFfWL1i7q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="268691544"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="268691544"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 08:55:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="629718847"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 08:55:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oHooO-001fM9-2t;
        Sat, 30 Jul 2022 18:55:32 +0300
Date:   Sat, 30 Jul 2022 18:55:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] firmware: dmi: Don't take garbage into
 consideration in dmi_smbios3_present()
Message-ID: <YuVUdOUl7zwE0QsV@smile.fi.intel.com>
References: <20220726094329.1725-1-andriy.shevchenko@linux.intel.com>
 <20220727102504.6bbefcf9@endymion.delvare>
 <YuQljCM4LZXhSkbh@smile.fi.intel.com>
 <20220730113302.6215923d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730113302.6215923d@endymion.delvare>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 11:33:02AM +0200, Jean Delvare wrote:
> On Fri, 29 Jul 2022 21:23:08 +0300, Andy Shevchenko wrote:

...

> So I'll apply your patch, thanks for contributing it.

Thanks for a nice discussion, I have learnt something new!

-- 
With Best Regards,
Andy Shevchenko


