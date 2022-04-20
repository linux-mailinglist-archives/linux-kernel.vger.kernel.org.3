Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE75092DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382841AbiDTWgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiDTWgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:36:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DAA3980A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650494028; x=1682030028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h7ss3pq1fGb/RJBq21Rmn3EWxFU3sDjJBWnaWblVCGI=;
  b=BFr7mZKIu+hV8+9HZJc+oc1NTCI9unCKnBue8/etQtCkLW7AwVPZvuYD
   CYIfVvsiy+HvZjXW/tuoIg6+hTQqR3lnlWdQ6Apuj02rFIOq7u70/ktW1
   dVEOFDnfCwTye2xbhQwlZD+ZTDcyW/9R76CWl8bNAUhfLlUEDpEDDR13z
   BEneDjWmQif/yfqT4V/wnxQIKIevKvyBpa50ELmwMG9dBwt8Zm+Yapya0
   rsfGXhXyaO65gjptuSm+8k2G5ivtR8MqtQ4jVjgkKgk5NAq2MQL7uwbvK
   J9ZAgiidXxnCXXh/KX9pC+Od+rEmMWH3vsZE8stAfZXpPIKAvbOm6bjl6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264338324"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="264338324"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 15:33:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="576833471"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 15:33:48 -0700
Date:   Wed, 20 Apr 2022 15:35:28 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v3 0/3] staging: vme: Cleanup driver tree old structures
Message-ID: <20220420223528.GA1279659@alison-desk>
References: <cover.1650321310.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650321310.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 08:29:49PM -0300, Bruno Moreira-Guedes wrote:
> This patch series modify the vme_user driver's place in
> menuconfig (1/3), fixes a missing `depends on` line in a Kconfig file
> (2/3), and rearrages the directory tree for the driver allowing a more
> straightforward comprehension of its contents (3/3).
> 
> The 'vme_user/' driver is the only remaining vme-family driver in the
> 'staging/' tree, but its structure, entry in menuconfig and building
> routines are still attached to the 'vme/' subtree now outside
> 'staging/'. The present patchset fixes it.
> 
> Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>

Hi Bruno,

I see your follow-on questions to GregKH about the 2 v2's and rolling
this set. I imagine you are going to work with many maintainers across
the kernel, so although understanding their processes is interesting and
useful, at some point just keeping your submittals clean, simple, and
straightforward is the more efficient path forward. If it were me, I think
I could get a v4 in GregKHs mailbox quicker than going around with him
on why his tools don't understand my oddities. (I admire your curiosity,
seriously! I'm just in a get it done and move on mood.)

In this case - you can see that this set is confusing because of the
v2, then v3 of a single patch. I suggest cleaning it up while GregKH is
sleeping ;) and get a clean v4 in his mbox. 

Not sure your process - but if you are using git send-email, the 
--dry-run option is how I do the final eye-balling of what I'm 
about to send. Try that out.

The changelog below can be more succinct. I made a suggestion below.

> ---
> CHANGE SUMMARY
> 
>   Version:  v1  v2  v3
> [PATCH 1/3] *   -   *
> [PATCH 2/3] -   *   *
> [PATCH 3/3] -   *   *
> 
> CHANGELOG
> [PATCH 0/3] staging: vme: Restructuring menuconfig and tree
> v1:
>   Created PATCH 1/3 as a single patch
> v2:
>   Added PATCH 2/3 and 3/3, turning it into a patchset
> v3:
>   Fixed and improved commit messages according to previous comments by
>   Greg and Alison (to whom I'm indebted for their kind reviews). The
>   commit titles got changed to be more specific and use the present
>   imperative tense as for Alison's suggestions. The message body got
>   fixed according to Greg formatting comments. The changelogs were moved
>   to the cover letter as per another suggestion by Alison, and I added
>   missing details (like the update in the MAINTAINERS I failed to
>   mention in v2) and made textual improvements for clarity that I also
>   noticed.
> 
> [PATCH 1/3] staging: vme: Move vme_user to staging KConfig
> v1:
>  - Sourced "drivers/staging/vme/devices/Kconfig" in
>    "drivers/staging/Kconfig" and unsourced in "drivers/vme/Kconfig".
> v3:
>  - Modified the commit subject and text body.
> 
> [PATCH 2/3] staging: vme: Add VME_BUS dependency to Kconfig
> v2:
>  - Added this patch to the patchset.
> v3:
>  - Modified the commit subject and text body.
> 
> [PATCH 3/3] staging: vme: Move 'vme/devices' to 'vme_user/'
> v2:
>  - Added this patch to the patchset
> v3
>  - Modified the commit subject and text body.

Changes in v4:
- Remove extraneous patch from set

Changes in v3:
- Move changelog to cover letter (Alison)
- Update commit messages and logs (Greg, Alison)

Changes in v2:
- Add new patch to set: Move 'vme/devices' to 'vme_user/'
- Add new patch to set: Add VME_BUS dependency to Kconfig


**I really want you to get this accepted before the next patch
comes along and removes the driver entirely :(.

Alison

> 
> Bruno Moreira-Guedes (3):
>   staging: vme: Adjusted VME_USER in Kconfig
>   staging: vme: Fix missing `depends on` at KConfig
>   staging: vme: "drivers/staging/vme" tree cleanup
> 
>  MAINTAINERS                                          | 2 +-
>  drivers/staging/Kconfig                              | 1 +
>  drivers/staging/Makefile                             | 2 +-
>  drivers/staging/vme/Makefile                         | 2 --
>  drivers/staging/{vme/devices => vme_user}/Kconfig    | 2 +-
>  drivers/staging/{vme/devices => vme_user}/Makefile   | 0
>  drivers/staging/{vme/devices => vme_user}/vme_user.c | 0
>  drivers/staging/{vme/devices => vme_user}/vme_user.h | 0
>  drivers/vme/Kconfig                                  | 2 --
>  9 files changed, 4 insertions(+), 7 deletions(-)
>  delete mode 100644 drivers/staging/vme/Makefile
>  rename drivers/staging/{vme/devices => vme_user}/Kconfig (93%)
>  rename drivers/staging/{vme/devices => vme_user}/Makefile (100%)
>  rename drivers/staging/{vme/devices => vme_user}/vme_user.c (100%)
>  rename drivers/staging/{vme/devices => vme_user}/vme_user.h (100%)
> 
> -- 
> 2.35.3
> 


