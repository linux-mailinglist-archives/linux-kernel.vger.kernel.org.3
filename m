Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0FD5400FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbiFGONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241035AbiFGOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:12:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C9A19E;
        Tue,  7 Jun 2022 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654611178; x=1686147178;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gBeOmaL6KbNtWkAXK4mRzbR9MnHeARJ2NfcwMDEO/5A=;
  b=mg/bMfVmv10f40UdT+wjRUH0afaeA748IfAspQXAIAVTiefSVICn0YrK
   l97GdGLo2owpu5r60i0RuBd6xF3biJ0EHmLhbPD+Z8yiRjGt89MzNHEsw
   evvENl+K9AXJTl2jHvI26osZAbrOSS8LhisggxVb1+pFDYruDoy+1biQt
   s6ERTqNA5FeIHv3hqRC7OixZ8QUvB5joVpo//drTfxSmpItWi3O4lqM66
   OJGOD4nD2QaAKOEqQCO6paa4MPGhexCSPqHHncac846aKo23RDXr/Oqma
   BqlVMFlNO1UuQRU7cR2TDlACiPb4As0jEhcmiRpV9jeGTo/pJ8b7NrgNz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277531492"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277531492"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:07:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636138930"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:06:57 -0700
Date:   Tue, 7 Jun 2022 17:06:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/36] tty/vt: consolemap: make con_set_unimap() more
 readable
In-Reply-To: <20220607104946.18710-13-jslaby@suse.cz>
Message-ID: <73d65e7-7635-55d7-415e-7c2af3c267f4@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-13-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-716620653-1654610818=:1622"
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

--8323329-716620653-1654610818=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> The indentation was completely broken in con_set_unimap(). Reorder the
> code using 'if (!cond) continue;'s so that the code makes sense. Not
> that it is perfect now, but it can be followed at least. More cleanup to
> come. And remove all those useless whitespaces at the EOLs too.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-716620653-1654610818=:1622--
