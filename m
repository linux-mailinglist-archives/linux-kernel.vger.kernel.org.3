Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9FC5403D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345031AbiFGQdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbiFGQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:33:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6420E140E9;
        Tue,  7 Jun 2022 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654619623; x=1686155623;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GVRCx6VMUkvoUh4rTdpxk3rMYV/vXBx5Cs+h/nOmupc=;
  b=eKCDwCHYMQ9NvBS0sJJtTA4/GH3FO29lKA7VPy6O9a9qQAYtR0okQs9I
   2Ja45QlHYNOB5fJi5y23IckyfK+GSzrhsaxRUrx53l2hV+427hBikQD0T
   E4GBtdKIwDtBBnR1m2unYm4gZSUt35iR/YTsMasHqU+WqR60KFoddTbZO
   +E+DTTGqF2f4xGTwkUr1eFO/jPHN7OW/YUOJuAxAR9XyMoJd2ouPgLdis
   Ly1jsScUa7BDw1CTGffZEx+bRhjyu+CAfJNEGXoHNMOsrhOBiK7KvkmBd
   BNGynOUZ4NVgNg2gyHKIks9GO/4aVhDZJsUU7BY8sNztGFtKvW5d0+ZC3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="265231020"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="265231020"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 09:25:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636199916"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 09:25:05 -0700
Date:   Tue, 7 Jun 2022 19:25:03 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/36] tty/vt: consolemap: walk the buffer only once in
 con_set_trans_old()
In-Reply-To: <20220607104946.18710-36-jslaby@suse.cz>
Message-ID: <4fee5c3-bdd7-f69-d8c5-2d5610eb5c3b@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-36-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1117444838-1654619107=:1622"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1117444838-1654619107=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> Fetch the user data one by one (by get_user()) and fill in the local
> buffer simultaneously. I.e. we no longer require to walk two buffers and
> save thus 256 B from stack (whole ubuf).
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
...for this and all patches that were not commented individually.

-- 
 i.

--8323329-1117444838-1654619107=:1622--
