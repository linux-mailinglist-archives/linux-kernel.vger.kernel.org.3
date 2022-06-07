Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3088540076
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243926AbiFGNvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiFGNvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:51:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ADA80228;
        Tue,  7 Jun 2022 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654609872; x=1686145872;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aTQVJGHukZ+DXGo1nAWZtVgF8dVNyTuGQVmEw5cyJMo=;
  b=PHavkbjYf0KL/42UL6fYGMYQAL7dyMVhr6/rERLPxboD7QZucike/eJ5
   pnoP/knXZgUvghvw2d1Mu+RXm/IOWKGPt+W0x3A+rj6uwaEEwJBuNN3vg
   Gi4npM+xjyKhyq/E2lM0WgVw2Qk5Le0JsICB40JCXfO95GkmaZTd9soA7
   mG3ygV1l3VjZ+ZKyMTL9o8beDUad99sjdkeYLMtIlXDqzE2acYKoPJNlc
   lFTbrkdeLCJOo1/2lN4/fmnsHkF5wBxzqgeVjwggRpLJi8JRnXybDj4B4
   gJFldw+CJ5eXujS9jferbGS9W5Gs+J8eXthgaKkmzYlLxIf2BRobttv5h
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="340484807"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="340484807"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:51:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636133043"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:51:10 -0700
Date:   Tue, 7 Jun 2022 16:51:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/36] tty/vt: consolemap: zero uni_pgdir using
 kcalloc()
In-Reply-To: <20220607104946.18710-11-jslaby@suse.cz>
Message-ID: <73266f16-ccd2-19fa-f83c-9b43dc8ca054@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-11-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1047197857-1654609871=:1622"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1047197857-1654609871=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> The newly allocated p->uni_pgdir[n] is initialized to NULLs right after
> a kmalloc_array() allocation. Combine these two using kcalloc().
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1047197857-1654609871=:1622--
