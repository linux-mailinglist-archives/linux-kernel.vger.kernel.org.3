Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895D75AFC42
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiIGGQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIGGQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:16:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1938E7675C;
        Tue,  6 Sep 2022 23:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662531377; x=1694067377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NGaqSH0ZslZqUY/EZngXurSVn33PaCjTie4iKRJhveA=;
  b=UEkHTKCAEMYYqs/wBOr+4OaTnUGaVuNPbg1yVTqJke833CtUN1qy0of1
   1IRke8mnGOiFkl1PLu6jV8rwVPqxwxezSuygQ1uh/MZYzVkC3McjBacK8
   G2c0As1Oo0W1OSH2kuiDdf+/eyeN0GNHec20BDe6Ow+IjC5hM1FO7mKDv
   u9A61AntPcs12ckoFb96ZnNFcPK5uo3jMFl/I433HXG4hGqbYxbZn5jUN
   CJ7eHtr5RpdG3vBUb/RRFMJ41P55sdUwo2ckY8GOusmyiknPzCDlRhkmH
   gHJ0B+Z98XVh179lepnlBgei3uMh3N0YA9p2CKeDq+glgkbjcAqKCphD1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="294375702"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="294375702"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 23:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="591559643"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2022 23:16:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8B9DFF7; Wed,  7 Sep 2022 09:16:30 +0300 (EEST)
Date:   Wed, 7 Sep 2022 09:16:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Fix spelling mistake "simultaneusly" ->
 "simultaneously"
Message-ID: <Yxg3PnpqBlPRvttu@black.fi.intel.com>
References: <20220906140552.194869-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906140552.194869-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:05:52PM +0100, Colin Ian King wrote:
> There are spelling mistakes in the thunderbolt sysfs documentation.
> Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

It seems I have an issue writing this particular word ;-)

Applied to thunderbolt.git/next, thanks!
