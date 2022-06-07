Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8287C54001A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244750AbiFGNej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiFGNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:34:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB56C0E36;
        Tue,  7 Jun 2022 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654608876; x=1686144876;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3zCSg2piam2X4diNokposYw0qSR7ja+acziGOwRIYoM=;
  b=MmoDxjXC3rj9EQSoRBpaDef6Lz+az7mOGu7Fe4rqLdyMFMBumqJeJc/u
   0JgEHnS3Wi9jz836ImJO0X/+/DZGe0BVLEPBp5bSThS9hTnFhSHSKRQNJ
   +BvCZtHyX645nm6ZyF61gHZwDtmEspXWbn03/nKtxC24EwgcAM4rUVWji
   Ytmy43h2tzMB3OEwJ8vjiK5SIJWfZePCGrT+D0WZdS6YrTQa8XnqZuUK4
   TyeT3CKnEq/rzluqmwnSK4TMvu/E2H2lJIaUmb8TlQT+M69E+E9b+Ig8n
   WJyYj1d6tmXGAdXN4RyWo6AWGw8EGQwxGrgYCZYFP7mT7TecrXtY3XDdU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277514868"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277514868"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:34:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="826358269"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:33:58 -0700
Date:   Tue, 7 Jun 2022 16:33:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/36] tty/vt: consolemap: remove extern from function
 decls
In-Reply-To: <20220607104946.18710-5-jslaby@suse.cz>
Message-ID: <b74b3f59-a955-a1b1-9310-415c4c9992c@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-5-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1852436768-1654608839=:1622"
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

--8323329-1852436768-1654608839=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> The extern keyword is not needed for function declarations. Remove it,
> so that the consolemap header conforms to other tty headers.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1852436768-1654608839=:1622--
