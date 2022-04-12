Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3374FE6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352050AbiDLRVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiDLRVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:21:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AED7522F4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649783929; x=1681319929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gqO9kiFi9h/R4QIs0wdglXcXClDXZyXTWIjL3/zjRXw=;
  b=hCGQ3MF6cqp6B+YizMfUu9Np+qXjszFkudmjttVf4+CctKbkcTzT3j8S
   IcgBrxJcEr/kjWCOGugvW8UHOTESivNsJGFpbiCgAG3XoPodYoEJmVcJY
   ys9C8gqx9Xr0tRNulx71BxG88tG2M5OEcKydnlxedkj6PdecTS/O0Nbnp
   4oTr51ZzxX1Yp4Ebh3oDZv0d64OHK8GtYB1btpuppqskq9idvPkb1QwsN
   i6Ej78KpS+BhtkcKuDPiNzFkFXFYw+CmO5joSQpZ7SLA6p5fKVfdokpCE
   Bn1QOD1x24CYmhtdTkWdCprRubjI5ViYpjrW+T6AXOujZnm+o/Smj9fbW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262627139"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="262627139"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 10:16:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="724544681"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 10:16:52 -0700
Date:   Tue, 12 Apr 2022 10:18:49 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 0/3] staging: vme: Restructuring menuconfig and tree
Message-ID: <20220412171849.GA1236580@alison-desk>
References: <cover.1649721450.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649721450.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 03:53:46AM -0300, Bruno Moreira-Guedes wrote:
> This patch series modify the vme_user driver's place in
> menuconfig (1/3), fixes a missing `depends on` line in a Kconfig file
> (2/3), and rearrages the directory tree for the driver allowing a more
> straightforward comprehension of its contents (3/3).

For a patchset it (typically) is OK to put the changelog in the
cover letter. See the first patch tutorial for how to format that.
That give you a little less editing to do for each individual patch.

I do see that you responded to this cover letter with clarifications.
That is fine. Just be aware that it will probably stop reviewers from
continuing their review, because you've already alerted them a v3 is
in the works. I'm going to go ahead and comment on a few format things
in this set, so maybe you can tidy them up in v3.

Alison

> 
> Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> 
> Bruno Moreira-Guedes (3):
>   staging: vme: Adjusted VME_USER in Kconfig
>   staging: vme: Fix missing `depends on` at KConfig
>   staging: vme: "drivers/staging/vme" tree cleanup
> 
>  MAINTAINERS                                          | 2 +-
>  drivers/staging/Kconfig                              | 2 ++
>  drivers/staging/Makefile                             | 2 +-
>  drivers/staging/vme/Makefile                         | 2 --
>  drivers/staging/{vme/devices => vme_user}/Kconfig    | 2 +-
>  drivers/staging/{vme/devices => vme_user}/Makefile   | 0
>  drivers/staging/{vme/devices => vme_user}/vme_user.c | 0
>  drivers/staging/{vme/devices => vme_user}/vme_user.h | 0
>  drivers/vme/Kconfig                                  | 2 --
>  9 files changed, 5 insertions(+), 7 deletions(-)
>  delete mode 100644 drivers/staging/vme/Makefile
>  rename drivers/staging/{vme/devices => vme_user}/Kconfig (93%)
>  rename drivers/staging/{vme/devices => vme_user}/Makefile (100%)
>  rename drivers/staging/{vme/devices => vme_user}/vme_user.c (100%)
>  rename drivers/staging/{vme/devices => vme_user}/vme_user.h (100%)
> 
> -- 
> 2.35.1
> 


