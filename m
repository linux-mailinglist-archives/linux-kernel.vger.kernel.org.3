Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7784AFEB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiBIUrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:47:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiBIUrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:47:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725CBC03E953;
        Wed,  9 Feb 2022 12:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644439669; x=1675975669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xILz1dK9rB40StPz2WiguItjJtnKtaNQWzhC2fRZekg=;
  b=HOAIcuzftPTd47+kZb5NxBrsEE7hrtlWGUJefrge4qee59jIygKZCV0k
   xdZXtQmEmFucTjRuo0a0NkOEHVZMprBZz0h5sNiW/UN/5hfaxLE5YB5Pi
   Qu9yB9G2KJ2uBrnlftiBqkTLzluUO9vrdNoGXNssnexiftD4++KKfN4Pi
   RPJ+a/8vGaB9A77f0HuF+vjUWamUONDMpcwBHAMSMRTuXyAxFpmiw+TdD
   BIIxnnUo4M8RfgUolmN2BcHhzoXn5K30GwOICo0KUy4Bcd6JFXaWSXy/N
   +4W0n2+L2ASU1BrNsMjWmlAPqC+b696rGzVE8C8J4mZwKGhfiqe/r9YyV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="236733919"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="236733919"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 12:47:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="485408727"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 12:47:47 -0800
Date:   Wed, 9 Feb 2022 20:47:39 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jack Xu <jack.xu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Zhehui Xiang <zhehui.xiang@intel.com>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v1 1/1] crypto: qat - don't cast parameter in bit
 operations
Message-ID: <YgQoa/8OXXFl4qUo@silpixa00400314>
References: <20220209180047.54829-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209180047.54829-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy.

On Wed, Feb 09, 2022 at 08:00:47PM +0200, Andy Shevchenko wrote:
> While in this particular case it would not be a (critical) issue,
> the pattern itself is bad and error prone in case the location
> of the parameter is changed.
> 
> Don't cast parameter to unsigned long pointer in the bit operations.
> Instead copy to a local variable on stack of a proper type and use.
> 
> Fixes: b4b7e67c917f ("crypto: qat - Intel(R) QAT ucode part of fw loader")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

-- 
Giovanni
