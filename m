Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74356560D40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiF2Xa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiF2XaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:30:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2803BCB;
        Wed, 29 Jun 2022 16:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656545424; x=1688081424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1anJ9NGJcKLa6e/D7V0Zt8acNtVMLDtbJsZPuDI7X/4=;
  b=Piyrg3IIapoLdlMxUetKadtQm1VeP0C0625hERxNkESWec+EBpKt3u20
   6Vcg4sV+Ag2ZzZNGrqK/Ph9+elO49/tYd8hAMVdRDnphR2USOjdcB2/sr
   +Z3auuoyxTxWEmhG6EbGeYlPTNE7UMd0zYEZ3k718hExiFJw+l/++hzMM
   Kbt6s0IysP0DcNpFh9FVO5YZXsvhLAoqVZmBy6SHVPO5/wO0aJqsdMcvE
   DXs4ooPgIV3Y81Q02AKGv9qCSlP86IgFlOhoKVWU73cCHg9w9sGjDBIVq
   tK9bYCMz2ldAYXWlryRosyQX42qNnQ0b69f0zfNHP/f0kugVTLf8LiK58
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="270956712"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="270956712"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 16:30:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="595450183"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2022 16:30:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 16:30:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 16:30:16 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Wed, 29 Jun 2022 16:30:16 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] Documentation/x86: Add the AMX enabling example
Thread-Topic: [PATCH v2 1/1] Documentation/x86: Add the AMX enabling example
Thread-Index: AQHYjArQoWH2w9xfNEO7Tn8LqH3Xaq1nBneQ
Date:   Wed, 29 Jun 2022 23:30:16 +0000
Message-ID: <f01bb09a504240059a79a94c24ba4eba@intel.com>
References: <20220629224235.20589-1-chang.seok.bae@intel.com>
 <20220629224235.20589-2-chang.seok.bae@intel.com>
In-Reply-To: <20220629224235.20589-2-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+        #define ARCH_GET_XCOMP_SUPP  0x1021
+
+        #define XFEATURE_XTILECFG    17
+        #define XFEATURE_XTILEDATA   18

What's the long-term plan for these #defines?  I see that ARCH_GET_XCOMP_SU=
PP
is in arch/x86/include/uapi/asm/prctl.h ... so eventually that will show up=
 in distribution
/usr/include/asm/prctl.h courtesy of a glibc update.

But the XFEATURE bits aren't in a "uapi" file. They are an "enum" in:

arch/x86/include/asm/fpu/types.h

How will that get to /usr/include?

-Tony
