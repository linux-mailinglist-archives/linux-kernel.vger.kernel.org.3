Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1045C53FF76
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244272AbiFGMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbiFGMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:54:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BCC6F48F;
        Tue,  7 Jun 2022 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654606481; x=1686142481;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AuKX2dSKfHj6UrzbicC0l/d9bTqLUEAbVOs1DM+WGTk=;
  b=cakTLInNOtI4KEgulj59HsApQYTm8W/cn90fcFmmTyA5vAL/jl2k/kmA
   3ozkWxRmDCdRrXUJRiXy0Gh2pNQt0EfzgC6+04zhl6mI9kB98BKz8TWA5
   0jtkIoKJsm9izJQAIrlYUkSSp0fv9badtX5TRSdOMuuQo39bzi73A4RHQ
   nsbd8E5vDzEYG/QNt5bZ6pGy0TKa3Uat90/aznFPOtJk6tKu4j4acsK6u
   E0jkXvqvhsASrzFrNMdIluxzNE5EO1Mzo9qzbQJGXwu3FQxjRIwuWm2yT
   etPVtlPzO2nGK/isbHeLlXn8wUR8Q4GuUFZnfP1q+SEmvC6LNzZSSWXZq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="265125934"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="265125934"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 05:54:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="636112135"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 05:54:39 -0700
Date:   Tue, 7 Jun 2022 15:54:36 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/36] tty/vt: consolemap: decrypt inverse_translate()
In-Reply-To: <20220607104946.18710-4-jslaby@suse.cz>
Message-ID: <e7db78b-99a0-d996-f23e-d1ee8811e951@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2147149149-1654606480=:1622"
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

--8323329-2147149149-1654606480=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> Fix invalid indentation and demystify the code by removing superfluous
> "else"s. The "else"s are unneeded as they always follow an "if"-true
> branch containing a "return". The code is now way more readable.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2147149149-1654606480=:1622--
