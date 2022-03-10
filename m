Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784364D4093
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiCJFQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:16:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E75D444E;
        Wed,  9 Mar 2022 21:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646889334; x=1678425334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mzYuh5RW9nKcXHrOjs3Ig4o7YuxMGRq5XdQyJ6YCauw=;
  b=GpoNnlgpiG9/VI2LE0IWE94F0blPKF/1fbH+xdsIznzOakt7uP23cEJB
   /SmjkjFD/Kp3x3v9frg++khvaHjSjSydBiPveD4emMqMfmr5NVHZAdmfb
   ZQlNpETR84OkLdPCg4IbGf/OoienuWr9Rq0zlurDjkzujbVDDg5Kb4E7q
   IhvaO/Rjfj1WqCsRVg+Vc52fMUC+PcfHY4T+CHGZCBJneJe/dvgOS0Bnq
   VSel2ZCQ5JkkM8TegeRd1t+n/DoXeCrZeBBow/YT+MOq4Ls9zRzxc6c/u
   3Q8UOWJalcLqmRl2W/sBfLRwdn7MmQ2gM63y2q5VcboEcCsBntLQMUM55
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318386660"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="318386660"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 21:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="781333188"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2022 21:15:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 21:15:33 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 21:15:32 -0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2308.021;
 Thu, 10 Mar 2022 13:15:30 +0800
From:   "Zhang, Cathy" <cathy.zhang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 09/11] x86/microcode: Expose EUPDATESVN procedure via
 sysfs
Thread-Topic: [RFC PATCH 09/11] x86/microcode: Expose EUPDATESVN procedure via
 sysfs
Thread-Index: AQHYM6IeumOy+rFqFUmvW+82UJROGKy2Ye0AgAGxnHA=
Date:   Thu, 10 Mar 2022 05:15:30 +0000
Message-ID: <b006e694e1ba4d41a001040b0ce3205a@intel.com>
References: <20220309104050.18207-1-cathy.zhang@intel.com>
 <20220309104050.18207-10-cathy.zhang@intel.com> <YiiNPWdsYtWiULZm@zn.tnic>
In-Reply-To: <YiiNPWdsYtWiULZm@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-reaction: no-action
dlp-product: dlpe-windows
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBhbGwgeW91ciBwYXRjaGVzIGZvciB0aGUgZnV0dXJlOiBkb24ndCBmb3JnZXQgdG8gQ2Mg
TEtNTC4NClRoYW5rcyBCb3JpcyEgSSB3aWxsIGRvIGl0Lg0K
