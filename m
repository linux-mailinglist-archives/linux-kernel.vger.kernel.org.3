Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88855D13C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbiF0R2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbiF0R2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:28:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B3C10F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656350880; x=1687886880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0WByDonN5WjgTktzGxnKob49Bp4pihahF3HafDcF7+E=;
  b=Tmlv3AvsmZDlDRTbf3sNoJttXckkiZURZNEJ2PJwBeeAjMCW9xg+/rFi
   LJ+Lpg6MaKo7SB+ifTYAhE4I0cO+Aj05F/u/xfklsO3M/7Dmk0yO6J1Yf
   oqJUkXszyXOm3649KKhIxgSi32lh4o2hukeRholbD07vpCl89IV3aCTm4
   MFY+AbxVg5ixamHlea45RFJ6/s0Oda8GhoOZedJElL4pUZ7IC5VFVdn8g
   VHlLfFIDjgSBspw/j+zvZ6LeRHjjJCNxImtBrZe9HS7wDyP2iWWxbE3vc
   4KPslKd3LL7hoaU346gmSKhCCKDZ6aA+cKDFA2tyZkTaT/2qu5jQmTZ5m
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="280275335"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="280275335"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 10:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="916812712"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2022 10:27:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 10:27:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 10:27:58 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Mon, 27 Jun 2022 10:27:58 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: RE: [PATCH] RAS/CEC: Reduce default threshold to offline a page to
 "2"
Thread-Topic: [PATCH] RAS/CEC: Reduce default threshold to offline a page to
 "2"
Thread-Index: AQHYerRlyb6k64LVCESU0Ew6xDDN8q1j550A//+ysUA=
Date:   Mon, 27 Jun 2022 17:27:57 +0000
Message-ID: <7da92773f7084c57814f7ef4d033bc53@intel.com>
References: <20220607212015.175591-1-tony.luck@intel.com>
 <YrnBWjkX82OhXAtL@zn.tnic>
In-Reply-To: <YrnBWjkX82OhXAtL@zn.tnic>
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

Pj4gMSkgQ2hhbmdlIHRocmVzaG9sZCB0byAiMiIuDQo+DQo+IEtpbmRhIHVuY29uZGl0aW9uYWwg
dGhhdC4uLiB3ZSBoYXZlbid0IHRhbGtlZCB0byBvdGhlciB2ZW5kb3JzIGV2ZW4uDQoNCkV4aXN0
aW5nIGRlZmF1bHQgaXMgMTAyMyAuLi4gd2hpY2ggaXMgbm90IGEgZ29vZCBjaG9pY2UgZm9yIGFu
eW9uZSAoZXhjZXB0DQpwZXJoYXBzIG9zdHJpY2hlcyB0aGF0IHdhbnQgdG8gYnVyeSB0aGVpciBo
ZWFkcyBpbiB0aGUgc2FuZCBhbiBpZ25vcmUgbWFyZ2luYWwNCkRJTU1zIGZvciBhcyBsb25nIGFz
IHBvc3NpYmxlKS4NCg0KU28gY2hhbmdpbmcgdGhlIHRocmVzaG9sZCB0byAiMiIgd291bGQgYmUg
YW4gaW1wcm92ZW1lbnQgaW4gYXQgbGVhc3QgYmVpbmcgcmlnaHQgZm9yDQpvbmUgdmVuZG9yLCBp
bnN0ZWFkIG9mIHdyb25nIGZvciBhbGwuDQoNCklmIHNvbWVvbmUgY29tZXMgdXAgd2l0aCBhIGRp
ZmZlcmVudCB2YWx1ZSBmb3IgYW5vdGhlciBDUFUgb3IgRElNTSB2ZW5kb3INCmNvbWJpbmF0aW9u
IC4uLiB3b3VsZCB3ZSBoYXZlIHRoZSBSQVNfQ0VDIGRyaXZlciBjaGVjayBib290X2NwdV9kYXRh
Lng4Nl92ZW5kb3INCmFuZCBTTUJJT1MgdG8gc2V0IGEgZGlmZmVyZW50IGRlZmF1bHQ/DQoNCj4+
IDIpIERvIHZlcnkgc21hcnQgcGxhdGZvcm0gZGVwZW5kZW50IHRoaW5ncw0KPg0KPiBJZiB5b3Ug
bWVhbiBBSSwgdGhhdCBwcm9iYWJseSB3b24ndCBoYXBwZW4gaW4gdGhlIGtlcm5lbC4NCg0KQWdy
ZWVkLiBZb3UgZG9uJ3QgZXZlbiBuZWVkIHRoZSAicHJvYmFibHkiLiBUaGlzIGlzbid0IGtlcm5l
bCBtYXRlcmlhbC4NCg0KTGludXggYWxyZWFkeSBoYWQgYSBob29rIGluIHRoZSBHSEVTIGNvZGUg
dG8gdGFrZSBhbiBlcnJvciByZWNvcmQgZnJvbQ0KdGhlIHBsYXRmb3JtIGFuZCBvZmZsaW5lIGEg
cGFnZS4gU28gdGhpcyAic21hcnQiIGNvZGUgY291bGQgYmUgZG9uZQ0KYnkgQklPUyBvciBCTUMg
anVzdCBwcm92aWRpbmcgdGhlIHJlc3VsdGluZyBsaXN0IG9mIHBhZ2VzIHRoYXQgc2hvdWxkDQpi
ZSB0YWtlbiBvZmZsaW5lIHRvIExpbnV4Lg0KDQotVG9ueQ0K
