Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D52356383B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiGAQop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiGAQon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:44:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA986140DE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656693882; x=1688229882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cRtHb/QFfRriofqwE9XMiI47bka0HMatE7/O6gRQa90=;
  b=G3mpDZE2XjDFMlS9C8S/X2IYKFWpy2j8SNXsuwn7OqM9leq9qMNgblB4
   2UAa5g/SPgTy4OoGWdgXbue4IXqdWk/7sQ4CQ4XDRpJkWTOlX9yA2HTvz
   +HKH6QuXtZrdD8Dk0v/qQJazw1IxjiJqdeIy2ya8dbbYJ0AScnIGRrvOe
   KZy48Siv72pELjvrC/+nWfRkehPIdMzU2MusiUK+/hwYVHNUPd8OD1vkw
   qvnrpm2gyZcJOVvqFjnmSzQFLPJG0ddz7FDaccdQhXDTLJb21OCDpQg00
   ymBg4ORzKrxlODeaoOU6Kbo7z/IL1FLBQApVeUGnL+4+8vuwCwl1cdI+f
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="263090990"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="263090990"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 09:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="918534177"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jul 2022 09:44:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 09:44:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 09:44:41 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Fri, 1 Jul 2022 09:44:41 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH] RAS/CEC: Reduce default threshold to offline a page to
 "2"
Thread-Topic: [PATCH] RAS/CEC: Reduce default threshold to offline a page to
 "2"
Thread-Index: AQHYerRlyb6k64LVCESU0Ew6xDDN8q1j550A//+ysUCAAfXYAP//lk5ggAL6tQCAAC/VAIABffWAgAAN4wA=
Date:   Fri, 1 Jul 2022 16:44:41 +0000
Message-ID: <a871b8bd35604921b842dcd65aed0f6c@intel.com>
References: <20220607212015.175591-1-tony.luck@intel.com>
 <YrnBWjkX82OhXAtL@zn.tnic> <7da92773f7084c57814f7ef4d033bc53@intel.com>
 <Yrsleko0MnGtwaaR@zn.tnic> <8f580a2544d846c69c9941e151fa7cc3@intel.com>
 <Yr1MntoeRKAmkxAf@zn.tnic> <Yr3XLMwYnRMa3Opw@agluck-desk3.sc.intel.com>
 <Yr61Jy6aGhxeulxN@zn.tnic>
In-Reply-To: <Yr61Jy6aGhxeulxN@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZb3UgY2FuIG1ha2UgdGhhdCBjb25maWd1cmFibGUgb3IgSW50ZWwtb25seSBvciB3aGF0ZXZl
ciAtIGJ1dCBub3QNCj4gdW5jb25kaXRpb25hbCBmb3IgZXZlcnlvbmUuDQoNCkknbSBuZXJ2b3Vz
IGFib3V0IG1ha2luZyBhIGNoYW5nZSBmb3IgSW50ZWwgdGhhdCBleGNsdWRlcyBBTUQuIEl0IGRv
ZXNuJ3QNCmxvb2sgbGlrZSBnb29kIGNvbW11bml0eSBzcGlyaXQuDQoNCllhemVuOiBCb3JpcyBh
ZGRlZCB5b3UgdG8gdGhlIHRocmVhZC4gV291bGQgdGhpcyBjaGFuZ2UgaHVydC9oZWxwL2RvX25v
dGhpbmcNCmZvciBBTUQgc3lzdGVtcz8NCg0KSWYgSSBwb3N0IGEgcGF0Y2ggdGhhdCBmb2xsb3dz
IEJvcmlzJ3Mgc3VnZ2VzdGlvbiBhYm92ZSB0byBjaGFuZ2UgdGhlIHRocmVzaG9sZA0KdG8gIjIi
IG9ubHkgZm9yIEludGVsIHN5c3RlbXMsIGNvdWxkIEkgZ2V0IGEgUmV2aWV3ZWQtYnk6IHRhZyBm
cm9tIHlvdSwgb3Igc29tZW9uZQ0KZWxzZSBhdCBBTUQ/DQoNCi1Ub255DQo=
