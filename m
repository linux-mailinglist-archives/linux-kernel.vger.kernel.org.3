Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBE57D8CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiGVC75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiGVC7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:59:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21D39965A;
        Thu, 21 Jul 2022 19:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658458795; x=1689994795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jf5a6eJbd1i8i4tKIsKNe30GC5A0Ds+xBn3mTnf2sZk=;
  b=SujsOjXPrsVzGM6/P8A+Qf8sflaBKQe2np/vpNC38Y4V2JXLH4+AvTjW
   LAVPJeF+NcOKjps0U0dNIUjl84hDrfKBzBbIVY7u3kPcPPARV3GsVGDka
   tCb3QJ336yhz5PXDc24mZW+o6CmTqE863H5H/eAyNQPgwFSNtSqljvkzR
   tSphqFBDj/tImRSKqe9LVL35yqpx/+l+K5mxZRbx7ORfRdALTsdWtSKCN
   T5OI/6400VPAVfuSotk7H6WEK6rbMGMc2lhRZagRfSJzz3gHFabEnsBtA
   4jn25WJ+uxaJnKLCxDlJG4vW6clfypct13mk5u+VYQwuzmDP+7jAtOEgK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287978444"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="287978444"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 19:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="775100917"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2022 19:59:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 19:59:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 19:59:53 -0700
Received: from fmsmsx611.amr.corp.intel.com ([10.18.126.91]) by
 fmsmsx611.amr.corp.intel.com ([10.18.126.91]) with mapi id 15.01.2375.028;
 Thu, 21 Jul 2022 19:59:53 -0700
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: RE: [PATCH] intel: thermal: PCH: Drop ACPI_FADT_LOW_POWER_S0 check
Thread-Topic: [PATCH] intel: thermal: PCH: Drop ACPI_FADT_LOW_POWER_S0 check
Thread-Index: AQHYl7WLPGVORxB/C0KdIx9UYpBjiK2DFQsAgABanYCABk5YYA==
Date:   Fri, 22 Jul 2022 02:59:53 +0000
Message-ID: <65fe502db8174defba0f21958499cab0@intel.com>
References: <12013659.O9o76ZdvQC@kreacher>
 <61311732eeea1f45e85537e911e4bb024c0a30b7.camel@intel.com>
 <CAJZ5v0j+FTX4UF-9Y0BQc2mYXQiphsnkt07CALhF7BPtSdDxgg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+FTX4UF-9Y0BQc2mYXQiphsnkt07CALhF7BPtSdDxgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.108.32.68]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMTgsIDIwMjIgMzoz
OSBBTQ0KPiBUbzogWmhhbmcsIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gQ2M6IFJhZmFl
bCBKLiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5ldD47IExpbnV4IFBNIDxsaW51eC0NCj4gcG1A
dmdlci5rZXJuZWwub3JnPjsgTGludXggQUNQSSA8bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+
OyBMS01MIDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IE1hcmlvIExpbW9uY2ll
bGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPjsNCj4gU3Jpbml2YXMgUGFuZHJ1dmFkYSA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGludGVsOiB0aGVybWFsOiBQQ0g6IERyb3AgQUNQSV9GQURUX0xPV19QT1dFUl9TMA0KPiBj
aGVjaw0KPiBJbXBvcnRhbmNlOiBIaWdoDQo+IA0KPiBPbiBTdW4sIEp1bCAxNywgMjAyMiBhdCA4
OjE0IEFNIFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBP
biBUaHUsIDIwMjItMDctMTQgYXQgMjE6MTEgKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3Rl
Og0KPiA+ID4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwu
Y29tPg0KPiA+ID4NCj4gPiA+IElmIEFDUElfRkFEVF9MT1dfUE9XRVJfUzAgaXMgbm90IHNldCwg
dGhpcyBkb2Vzbid0IG1lYW4gdGhhdCBsb3ctDQo+ID4gPiBwb3dlcg0KPiA+ID4gUzAgaWRsZSBp
cyBub3QgdXNhYmxlLiAgSXQgbWVyZWx5IG1lYW5zIHRoYXQgdXNpbmcgUzMgb24gdGhlIGdpdmVu
DQo+ID4gPiBzeXN0ZW0gaXMgbW9yZSBiZW5lZmljaWFsIGZyb20gdGhlIGVuZXJneSBzYXZpbmcg
cGVyc3BlY3RpdmUgdGhhbg0KPiA+ID4gdXNpbmcgbG93LXBvd2VyIFMwIGlkbGUsIGFzIGxvbmcg
YXMgUzMgaXMgc3VwcG9ydGVkLg0KPiA+DQo+ID4gQWdyZWVkLg0KPiA+DQo+ID4gPg0KPiA+ID4g
U3VzcGVuZC10by1pZGxlIGlzIHN0aWxsIGEgdmFsaWQgc3VzcGVuZCBtb2RlIGlmDQo+ID4gPiBB
Q1BJX0ZBRFRfTE9XX1BPV0VSX1MwDQo+ID4gPiBpcyBub3Qgc2V0IGFuZCB0aGUgcG1fc3VzcGVu
ZF92aWFfZmlybXdhcmUoKSBjaGVjayBpbg0KPiA+ID4gcGNoX3dwdF9zdXNwZW5kKCkNCj4gPiA+
IGlzIHN1ZmZpY2llbnQgdG8gZGlzdGluZ3Vpc2ggc3VzcGVuZC10by1pZGxlIGZyb20gUzMsIHNv
IGRyb3AgdGhlDQo+ID4gPiBjb25mdXNpbmcgQUNQSV9GQURUX0xPV19QT1dFUl9TMCBjaGVjay4N
Cj4gPg0KPiA+IHRoZSBjb29saW5nIGRlbGF5IGluIHRoZSBzdXNwZW5kIGNhbGxiYWNrIGlzIHRv
IG1ha2Ugc3VyZSBQQ0gNCj4gPiB0ZW1wZXJhdHVyZSB3b24ndCBibG9jayBTMGl4IGR1cmluZyBz
MmlkbGUuIFNvIGlmIFMwaXggaXMgbm90DQo+ID4gc3VwcG9ydGVkLCBpdCBpcyBtZWFuaW5nbGVz
cyB0byBpbnZva2UgdGhlIGNvb2xpbmcgZGVsYXkgZHVyaW5nIHMyaWRsZS4NCj4gDQo+IEJ1dCB0
aGVyZSBpcyBubyB3YXkgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgb3Igbm90IFMwaXggaXMgc3VwcG9y
dGVkLiAgSW4NCj4gcGFydGljdWxhciwgQUNQSV9GQURUX0xPV19QT1dFUl9TMCBpcyBub3Qgb25l
Lg0KPiANCj4gPiBzbyB0aGUgcHJvYmxlbSBpcyB0aGF0IHdlIGRvbid0IGhhdmUgYW4gaW5kaWNh
dG9yIGZvciBTMGl4IGNhcGFiaWxpdHkuDQo+ID4gQW5kIHRoaXMgYWxzbyBhcHBsaWVzIHRvIGRy
aXZlcnMvcnRjL3J0Yy1jbW9zLmMsIHdoZXJlIHdlIHVzZSBBQ1BJIFNDSQ0KPiA+IGZvciBydW50
aW1lIFJUQyB3YWtldXAgaW5zdGVhZCBvZiBIUEVUIGludGVycnVwdCBvbiAiUzBpeCBjYXBhYmxl
Ig0KPiA+IHBsYXRmb3JtcyBiZWNhdXNlIHRoZSBIUEVUIHRpbWVyIG1heSBibG9jayBTMGl4Lg0K
PiANCj4gIlMwaXggY2FwYWJsZSIgZG9lc24ndCBtYXR0ZXIuICBXaGF0IG1hdHRlcnMgaXMgd2hl
dGhlciBvciBub3QgdGhlIGN1cnJlbnQNCj4gdHJhbnNpdGlvbiB1bmRlciB3YXkgaXMgaW50byBT
MCBvciBpbnRvIHN1c3BlbmQtdG8taWRsZS4gIEluIHRoZSBsYXR0ZXIgY2FzZQ0KPiB0aGVyZSBp
cyBubyByZWFzb24gdG8gYXZvaWQgZG9pbmcgd2hhdGV2ZXIgaXMgZG9uZSBpbiB0aGUgZXhwZWN0
YXRpb24gdGhhdA0KPiBTMGl4IG1heSBiZSBlbnRlcmVkIGdvaW5nIGZvcndhcmQuDQoNCk9rYXku
IEl0IGlzIG5vdCBwZXJmZWN0IGJ1dCB3ZSBoYXZlIHRvIGxpdmUgd2l0aCB0aGlzLg0KDQpBY2tl
ZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0K
