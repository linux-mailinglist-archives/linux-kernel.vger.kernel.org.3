Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3C54AC10
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351876AbiFNIkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355343AbiFNIkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:40:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5747145500;
        Tue, 14 Jun 2022 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655195933; x=1686731933;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zpBin9PRcIpD5gHfe2/4AZHi5R2ZDJXHpDpHe7E1fzQ=;
  b=fQXUngRX1tQWyaTSjqyB1bM2Fk/tTpeCx+8A7ULSXB7PTCAIZWwZ2hkV
   +3mWZp6fCCqssvFkHNZ6iG5kcMGyyHKooyAVVjaHfnxCCpBtUkiViXwOU
   +PQ9+xAbxQObZ1gl06WltXtWmSzoBa4QavM0OOWkv5IZIiqBxWBF6bIsQ
   pPYCXOdLv3Cu90YfJykRfYudZyXSSOHcpuW6Q0tuzC+qjA6pgZsBSGnbi
   Ww7z3XjQ2986QVvDuFYv0HFBFdjtJlmasafXjjs7ZB9tiX/gWapFQHLdw
   ++5yKfv8TGZMHPu7DkxjSEhxs+fQLX4yCNLX2tBmPpbQugMjruxjS9OfJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279270600"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="279270600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:38:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640221150"
Received: from jlaghzal-mobl1.ger.corp.intel.com ([10.252.32.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:38:50 -0700
Date:   Tue, 14 Jun 2022 11:38:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] tty/vt: consolemap: rename struct
 vc_data::vc_uni_pagedir*
In-Reply-To: <20220614075713.32767-5-jslaby@suse.cz>
Message-ID: <5bf9a7b-7e41-8a3c-769a-9b7bc3dc04d@linux.intel.com>
References: <20220614075713.32767-1-jslaby@suse.cz> <20220614075713.32767-5-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-546787174-1655195931=:1605"
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

--8323329-546787174-1655195931=:1605
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Jun 2022, Jiri Slaby wrote:

> As a follow-up to the commit 4173f018aae1 (tty/vt: consolemap: rename
> and document struct uni_pagedir), rename also the members of struct
> vc_data. I.e. pagedir -> pagedict. And while touching all the places,
> remove also the unnecessary vc_ prefix.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Look fine,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


You might want to rename vgacon_uni_pagedir too. :-)


-- 
 i.

--8323329-546787174-1655195931=:1605--
