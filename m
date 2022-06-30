Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18410561FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiF3QHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiF3QHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:07:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07331AF0F;
        Thu, 30 Jun 2022 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656605251; x=1688141251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rVhsXlaSwKi/9ubObaloKtFwrU5bFv0Ykt9c96pG2MQ=;
  b=ax5J+5tQdvIcxPU6y1UC1yWN2tNzAWlDqY8RJPqdTc5r9AZBRep9kx/8
   4mAABkrvMKCteDXnqix8pDVQkDtkNoQ64L3IHXGDHAMJL3klqc8VHs7jA
   ox0qKfSbnuZoejJ+f/mx+01b4JAt5Kn0ARTmKFxt0R4lXZ6Rc67TVtCqV
   uXMX4OkE47CBnx8s0/rOctzVHAB9EzZdF6USmnmkx4zrIB+XcaSw6XJda
   lXrHWL3faKHQAksIERb2wKMNZcWPoKRo6HcKUwVvccAqq+SBX9U8HOWmK
   2OLz5eo7qMeyI3m2UqRXYRSC9CTuihknXNiMyz0RqLsXp2FNZ2JSokuPp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262793284"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="262793284"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 09:07:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="647949156"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2022 09:07:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 09:07:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 09:07:29 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Thu, 30 Jun 2022 09:07:29 -0700
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
Thread-Index: AQHYjArQoWH2w9xfNEO7Tn8LqH3Xaq1nBneQgAGCcwD//5Sy0A==
Date:   Thu, 30 Jun 2022 16:07:29 +0000
Message-ID: <66c4d3ce4c6f47d29bbb951739555eb0@intel.com>
References: <20220629224235.20589-1-chang.seok.bae@intel.com>
 <20220629224235.20589-2-chang.seok.bae@intel.com>
 <f01bb09a504240059a79a94c24ba4eba@intel.com>
 <5c67d453-a162-b61d-4a27-c854f1ef3587@intel.com>
In-Reply-To: <5c67d453-a162-b61d-4a27-c854f1ef3587@intel.com>
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

PiBCdXQgdGhlc2Ugc3RhdGUgY29tcG9uZW50cyBhcmUgYXJjaGl0ZWN0dXJhbC4gV2hpbGUgdGhp
cyBjYW4gaGVscCANCj4gdXNlcnNwYWNlIGFueXdheSwgc2F5aW5nICJYU1RBVEUgY29tcG9uZW50
IiBoZXJlIGFuZCBvbiB0aGUgbWFuLXBhZ2UgaXMgDQo+IHByb2JhYmx5IGl0IGFzIHRoZXkgYXJl
IGFscmVhZHkgZGVmaW5lZCBpbiB0aGUgeDg2IHNwZWMuDQoNCkFuIGFwcGxpY2F0aW9uIHdyaXRl
ciBjYW4ndCB1c2U6DQoNCiMgaW5jbHVkZSB7eDg2IHNwZWN9Ig0KDQp0byBnZXQgdGhlc2UgdmFs
dWVzIC4uLiBpZiBhcHBsaWNhdGlvbnMgbmVlZCB0aGVtIHRvIGZpbmQgb3V0IGlmIEFNWCBpcyBw
cmVzZW50LA0KYW5kIHRvIGVuYWJsZSBpdCwgdGhlbiB0aGV5IG5lZWQgYW4gQVBJLg0KDQpNYXli
ZSB5b3VyIGV4YW1wbGUgY29kZSBzaG91bGQganVzdCBiZSBhIGxpYnJhcnkgcm91dGluZT8gU28g
YXBwbGljYXRpb24gd3JpdGVycw0KY2FuIGp1c3QgZG86DQoNCglpZiAoIWludGVsX2FteF9lbmFi
bGUoKSkgew0KCQllcnJvciBtZXNzYWdlLCBvciBmYWxsIGJhY2sgdG8gbm9uLUFNWCBpbXBsZW1l
bnRhdGlvbg0KCX0NCg0Kd2l0aG91dCBoYXZpbmcgdG8gd29ycnkgYWJvdXQgdGhvc2UgI2RlZmlu
ZXMuDQoNCi1Ub255DQo=
