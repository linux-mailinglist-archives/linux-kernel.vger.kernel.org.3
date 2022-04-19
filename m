Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627AC5068E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbiDSKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiDSKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:44:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE07E22526;
        Tue, 19 Apr 2022 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650364887; x=1681900887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b4BbrvlcJlEUt6KlwjbPenGMBsgO5Lw1f0hq973jPg0=;
  b=Vo/LHV0ilIM9sYNDfFWzvQo+xSP7NFmgoB/x0go8Jj02xIiaTynsjp9Q
   cfRHbjhjoDu0w14MG44r+69FXHwyLmepb6Ny+66LKJe0TI6o33nsfsR1g
   2WSZIDU7FmXXRvNB8kMkcto+yhMUo5RQE3Fs2VZ6Ny0qj0snJ9gjxKWiz
   U9meiQ3XfSO10mffnjVjZY7Uqy17zWjrbzxwjxCccDsVOGMKQTwVnebQG
   i504MwmoWYhoL+hXuCxr13TBZFCwbByggzSsEijAxTCVD0b30leHDqzcy
   cOJUI0jA8RpQ2UtmC1PvSPBypOhowJR1NxTqrzo0rNIjNIK4H8s7ZB+s5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="251036878"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="251036878"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 03:41:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="561672309"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 03:41:13 -0700
Date:   Tue, 19 Apr 2022 11:41:05 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Marco Chiappero <marco.chiappero@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the crypto tree
Message-ID: <Yl6Rwe1okkWqC6ou@silpixa00400314>
References: <20220419071722.6e47c542@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419071722.6e47c542@canb.auug.org.au>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen.

On Tue, Apr 19, 2022 at 07:17:22AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   c690c7f6312c ("crypto: qat - rework the VF2PF interrupt handling logic")
> 
> Fixes tag
> 
>   Fixes: 993161d ("crypto: qat - fix handling of VF to PF interrupts")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").
Apologies, I missed this during the review of the patch.

@Herbert, should I resend the patch with the correct Fixes tag or can
you amend the commit in your tree.

This should be the correct tag:
    Fixes: 993161d36ab5 ("crypto: qat - fix handling of VF to PF interrupts")

Regards,

-- 
Giovanni
