Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D394148524A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbiAEMOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:14:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:13273 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239947AbiAEMN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641384839; x=1672920839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=btgv+zb0p7yqCbFYea0y1fj6VPhvIQD6R68pT1LZWO0=;
  b=Ms8TysiyR2IG/EO/iCUT2wW3/IcjYbWRW2FkJwkiao9nlWPYGsrvKZP2
   QV7CpIGeobUljSlik/EBs9+FbJTQt+M6pVtpBxmAmj+rQBaXRGtSShjMx
   1jrDY1vtpXpBbMTrGyr0DtEueBgWAm+nr23GooatlQXGp7OqHJlGiXs+N
   ONVAjRrci8F7VgiNr/XP4GgZtuURJtEmTXYW0DXsg89RVjv6Vw9YCN09q
   yZz4RmcclvrhE2JEa+L+Aja6HQ8zCnAWUD580NjtFGBBekLl6Ch9kG1xv
   Hc02b7jZtqQHaokvdN7Km1TAeIZSWA0pO5kqrhVV2oAnKjtp3j3mGq5UM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="239966734"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="239966734"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:13:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="512926747"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:13:56 -0800
Date:   Wed, 5 Jan 2022 12:13:50 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: use signed variable to store status and error
 checking
Message-ID: <YdWLfgy2tID01F8B@silpixa00400314>
References: <YdS+cgcyKdXUQaU+@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdS+cgcyKdXUQaU+@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your patch.

Patches to the qat driver have the following headline
     crypto: qat - ...
not just
     crypto: ...

On Wed, Jan 05, 2022 at 02:38:58AM +0500, Muhammad Usama Anjum wrote:
> ret should be signed. adf_cfg_get_param_value and match_string return
Use () when refer to the function().

> signed statuses. The return status may be saved wrongly in unsigned ret
> variable. Correct the data type of ret to signed int.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
After fixing,
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Regards,

-- 
Giovanni
