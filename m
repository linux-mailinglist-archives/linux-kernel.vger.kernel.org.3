Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB155F984
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiF2HrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiF2HrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:47:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF8B387BC;
        Wed, 29 Jun 2022 00:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656488833; x=1688024833;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=YlxnPim1rzCpKPXxIWvBT1D3S+eCXzSTNnLPZpAqKlo=;
  b=WQ1+7UJGyviFymRBoXU44d29vBnpbAMezoreIjRmaG7z13553RJP30bO
   IkYAuzuG8+m924muhoQajI2wmYLKmmKPT4oBTjci/K5FdlFqTnphT7ajl
   RWM9FNGn1KGHMmzsY+wXYyBLCrjPPLAhBvbN4JLXib7yDvD7RcQlO/s2W
   PH2BR4WsKFKAeUhnGXOWO7/75mIn6pxp8bKbUgsthH1573A34sapTbylL
   OqXs5FDiumMhXZUUck6XlsgXteRainWcGK/n982Mo+XTtPtrfM5WMI1tJ
   yhC32rt5lysU5cXKV05t2Ssm3Hzt/qiBRHUvvmHxXp3pneU/XHwZDNgsT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="345947818"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="345947818"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 00:47:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="647274534"
Received: from dsummer-mobl.ger.corp.intel.com ([10.252.38.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 00:47:10 -0700
Date:   Wed, 29 Jun 2022 10:47:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] serial: 8250_dw: Rename offset to reg_offset
In-Reply-To: <YrtxxqnQ5fZKsUoY@smile.fi.intel.com>
Message-ID: <c2959ca9-5817-f843-4a9b-95c8ffad9fca@linux.intel.com>
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com> <20220628134234.53771-3-ilpo.jarvinen@linux.intel.com> <YrtxxqnQ5fZKsUoY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1978143705-1656488381=:1529"
Content-ID: <18fa9f5-b66c-b74c-961-a42059e76af4@linux.intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1978143705-1656488381=:1529
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <7d32f42a-d1be-fb57-f8d4-f5e92a82a942@linux.intel.com>

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> On Tue, Jun 28, 2022 at 04:42:32PM +0300, Ilpo Järvinen wrote:
> > Get 'offset' variable out of the way of parameter named 'offset',
> > rename it to 'reg_offset'. This is very short lived change as
> > reg_offset is going to be soon removed.
> 
> I'm not sure why this change then even needed...

I could either:
    1) create one large patch doing many thing (2+3 or 2+3+4)
 or
    2) add the 'offset' parameter with some other name first and rename it 
       to its final name after local var 'offset' is eliminated by patch 4
 or
    3) rename local var 'offset' first out of the way so that I can add 
       'offset' parameter in patch 3 (=this patch)

If I just drop patch 2 and only do 3, it won't build because 'offset' 
variable appears twice (as arg and local var).

-- 
 i.
--8323329-1978143705-1656488381=:1529--
