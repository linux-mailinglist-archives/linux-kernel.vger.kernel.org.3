Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBEE540011
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbiFGNcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiFGNcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:32:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69948D2460;
        Tue,  7 Jun 2022 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654608728; x=1686144728;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+RcZIolwNakk+0aUA2CQuTdiNoT9RDa+audk1teqQ/M=;
  b=d29SqU5RsG/xIkGVICYbzu3phDiU/R3+ey7nUiwJKG34dMrEaxbPd1Q0
   GlC8xC1MrFWwbmvNg1REC9G3VR0o+kOLSu43zDuFDSKJTcJFC4mNAwCRB
   Fjg7q/YMbkXSZkH/M0WeEVoMtAj14wZOVnNLA2bLd2fBZWJGdRerDk69P
   pMz9Kp9HPYkSZLxN8PmbWnZViGlBvS8AJrrW8yq9qtntZMUbyrhqFp/qs
   oNmNlo1rR4aoIo8MuhZtjnQRWDcvnmymgbKEGPfxLbQ2/9qSOnbA+iQ3f
   3R7OrRhaCPge+WUVdVefz0XVPKihMUdzOKYUf10a5hWFTWcuv/KYSHFPO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="265142390"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="265142390"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:31:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636126254"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:31:49 -0700
Date:   Tue, 7 Jun 2022 16:31:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/36] tty/vt: consolemap: convert macros to static
 inlines
In-Reply-To: <20220607104946.18710-6-jslaby@suse.cz>
Message-ID: <f87334d7-5e7e-99c3-ec83-390eb6ccccd@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-6-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-221322822-1654608710=:1622"
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

--8323329-221322822-1654608710=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> This commit changes !CONFIG_CONSOLE_TRANSLATIONS definitions to real
> (inline) functions. So the commit:
> * makes type checking much stronger,
> * removes the need of many parentheses and casts, and
> * makes the code more readable.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-221322822-1654608710=:1622--
