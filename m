Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738B44ECD95
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiC3T7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiC3T7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:59:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4F26242
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648670246; x=1680206246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zEY+7CtlMMtQOnVlKG/bQMiw/TYsBbV+4FS/mqJPr78=;
  b=cBLdzj10MSEKkYtc9rKAtxCqNa/AyzduK7gc7od8dBRcYGleSczvYfbE
   JMUBLxURZ1J8DGlRDqNr0iWIE+8wbuw1bhSVm1TMeSRr3yxOnR6kJKAgz
   jrNyHCqmVW6h+VGzwTZXFaQEcUdetM8dkHhyZCIkZZsjmDm8Vfrb4RVxX
   A1zNSSIUD63mhQ6z1p8sND4QisXWgg4JPYqjXpxYXPiyjjCesck2WNVnR
   0PMjXRhV0xNxShuxsAgTSj0QLVcETU0/HjjmuzVgr1yTSZRZogaNApmh0
   9KIvkXGU5tJXus0keciSa+M+5gA84ZTH+w+Ujj9NbeHPqgb2yq5kSzh7o
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="239562806"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="239562806"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 12:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="503442152"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2022 12:57:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 12:57:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 12:57:09 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Wed, 30 Mar 2022 12:57:09 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/cpu: Add a third Alderlake CPU model number
Thread-Topic: [PATCH] x86/cpu: Add a third Alderlake CPU model number
Thread-Index: AQHYNMnGKZoniCv+hEOHf3mdUxW9U6zYhAeA///yAwA=
Date:   Wed, 30 Mar 2022 19:57:09 +0000
Message-ID: <29d602962d6542bd90e877c104afcc7f@intel.com>
References: <20220310215652.32025-1-tony.luck@intel.com>
 <20220330134325.GM8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220330134325.GM8939@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +#define INTEL_FAM6_ALDERLAKE_N		0xBE
>
> This is missing the /* Gracemont */ comment. That is, according to
> Google, Alder Lake N is an E core only SKU.

I can neither confirm nor deny that information.

> So alternatively, we can
> call it: INTEL_FAM6_ATOM_GRACEMONT ....
>
> /me runs like heck :-)

And so you should :-) I think that will just cause a different level
of confusion.

-Tony

