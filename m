Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D63552CED3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiESI7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiESI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:59:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EADA502A;
        Thu, 19 May 2022 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652950769; x=1684486769;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=05Fuppx/L9sCpsgYnyjfWyFaI5tXbG/b+Ttzw5ROFAg=;
  b=avL7D8cSzgGgw4MppOZ8NF1YUoVk2pIrtrCyuFdFbLRlNowQN0a4f0iw
   dC+a1a5jrh1QvhszNp5uDTSC9Ol3zlm5Yh2Sh0Toc8N0rXJS1aNQWWjeD
   pDc6UYeAUDuGMoEFU/hxPotvk7W+rvRbtyCawlLOAutN1ht0QGx0Uqu5A
   ye9n3vU0Jxh0zbsBEF926VvfsL4Mi8sMwhHJ1eNAQcSBBxhqwrhQww7an
   MpPGUz8QyCg6Nh08N3WmNBIeOFM4QQkS3hq3NoVilAiZk2dSPITJQ1AgV
   3RVqO1teTPdoEGkSPkxac7pNYCFIBmcQFN2aFtVUwztxTE+mN8rSWDTy+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259679129"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259679129"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:59:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598445933"
Received: from ivanovbx-mobl1.ger.corp.intel.com ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:59:26 -0700
Date:   Thu, 19 May 2022 11:59:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/4] serial: pmac_zilog: remove initial print
In-Reply-To: <20220519075653.31356-4-jslaby@suse.cz>
Message-ID: <2adeae5a-cc42-5a3c-a1e0-2b26f294834@linux.intel.com>
References: <20220519075653.31356-1-jslaby@suse.cz> <20220519075653.31356-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-461353659-1652950754=:1628"
Content-ID: <378db1e4-e6db-c394-358f-d690cb7870f7@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-461353659-1652950754=:1628
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <9e628ba6-962-3ab-bd6a-436b56f87c8e@linux.intel.com>

On Thu, 19 May 2022, Jiri Slaby wrote:

> Don't report about the driver when loaded. It's unneeded and frowned
> upon nowadays.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

for patches 2-4.

-- 
 i.
--8323329-461353659-1652950754=:1628--
