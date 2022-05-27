Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A793F535BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349855AbiE0IqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349833AbiE0Ip4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:45:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D13A60049;
        Fri, 27 May 2022 01:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653641155; x=1685177155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9bepD47vCeMvE7f7fT/wncmqPaqG2rgfKFf1L1RcCWQ=;
  b=I9FSyVjEloRTCgm8ZGtGpOa5xK40Q5pQjQQYAMougG6S2vcuDN7gddnH
   yVsjF8b8R8HpXJvLQq9qBdyYrCg19864isCOeC9NY/HdUfrxexi6nB+61
   QLere64zHaRNsZgKFKf8Czl968Ova36AvU+1SqyH40H6Xh1pIUF5idsE0
   r7FTxVpsVSiJGtDqSjRgW+IEc2XRi8kHYH3jp48Ch3/t9qjb2ED9g5lxv
   2M+IjX53839UznJEUwpE/KehlfSEf7pmq0K7vRDlEKCTPZYEpVFRgJq2A
   UXl/YTaivHu8vG3SQREzKGRvBQ+FkIOAfjR3FcQAmjwBWTbShl2MF9RjD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="256495633"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="256495633"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:45:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="631495516"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:45:53 -0700
Date:   Fri, 27 May 2022 09:45:46 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     yoan.picchi@arm.com, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, qat-linux@intel.com
Subject: Re: [RFC PATCH 2/2] Removes the x86 dependency on the QAT drivers
Message-ID: <YpCPulwFuNHHtw1V@silpixa00400314>
References: <CAMj1kXGAiA-SkTFD5EgcacYao0RKT7oK0AxvxkR7Ho_KZSGXCw@mail.gmail.com>
 <8f6d8d1f-2872-15b9-d38b-1e8eb26f781b@foss.arm.com>
 <YoyOg/kYGtO+nQac@silpixa00400314>
 <20220525141239.48589f25@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525141239.48589f25@donnerap.cambridge.arm.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 02:12:39PM +0100, Andre Przywara wrote:
> So testing this in BE is a bit more involved, and the practicality of such
> a setup is very questionable. If you are concerned, should we just say:
> 	depends on PCI && !CPU_BIG_ENDIAN
> At least until we have reports that confirm proper BE operation?
Sounds reasonable.

Thanks,

-- 
Giovanni
