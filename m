Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6593555F04B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiF1VZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiF1VZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:25:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0293A731;
        Tue, 28 Jun 2022 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656451530; x=1687987530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Oyn51vMDRf7A3tVCT6X7kOOy8czfccgv/KeqlJoi94o=;
  b=jEMy/gxTOzfYZMeKvYzSgf2JnjI88JEN+JkTIIZsT1HL1hNuNtK6hc6I
   bTXZ4CAW5QAeVgBods3mHhDGttNcN3JfPA/e7dH/pVXUZctNghDmk+XWs
   FL6sXjRXPA9Y57U2kSRoZ8Hwv/XZ3+vKCaeuW24SXyVclZA/78bBx598s
   i9YV5URNXCEjz5yf3aBmCLw32Oj4DC0OUf/gP3OkAyGa3pz6740xWKvwM
   dLsZNMALbxZPLxqC2cJspFhkck9LFDIDitspKiTjrZcf3vcEaBzxjCnQk
   mBtPEiwmFpTf4kBRrZLbyu9EKQDsUuEhiCpi1s9dNW0NhD2hvmc2s3Rih
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281886709"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="281886709"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 14:25:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="680213065"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 14:25:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o6Ii6-000xAc-L0;
        Wed, 29 Jun 2022 00:25:26 +0300
Date:   Wed, 29 Jun 2022 00:25:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] serial: 8250_dw: Rename offset to reg_offset
Message-ID: <YrtxxqnQ5fZKsUoY@smile.fi.intel.com>
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
 <20220628134234.53771-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628134234.53771-3-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:42:32PM +0300, Ilpo Järvinen wrote:
> Get 'offset' variable out of the way of parameter named 'offset',
> rename it to 'reg_offset'. This is very short lived change as
> reg_offset is going to be soon removed.

I'm not sure why this change then even needed...

-- 
With Best Regards,
Andy Shevchenko


