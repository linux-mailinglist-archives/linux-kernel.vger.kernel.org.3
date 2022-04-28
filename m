Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EEB513B39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350763AbiD1SOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350741AbiD1SOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:14:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A47B6E6C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651169463; x=1682705463;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=fn2OSIoko8drRj2wBoJaL4X9X6xa/xytRJ+aFijI5lE=;
  b=lUyC+2RuAGxGhLkgZBBbOYMMfaUfJtxrK2uwF0u+Htq17KzPJ0eQNFWl
   pjKWnVnO5pQ26PtQ7gJjaLD7r5JIMdcFuVzswgunfOTCo+jUAranKxFUZ
   Ra5i1ynE25CqsZpPsQm1lrdF5sA7KGKFCBk5qUnPw8bgdfNQSTpxZaY+J
   KWSBM/HpAdl9qi9HoRzfTKAO7iDB+eP4LJutH9deUwvKApb5o3KecrO1N
   1d1y6iGEE/DMc/ohGrnVtIJaKw5XfNoUJBFwS0UfJ7BxikfD8U99FGpUN
   St3WoI4aV6ZI//Vs8MCuomQxX5+V0IokjyvuEfwpOAHHVY8KtOiiX2cIH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265903475"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="265903475"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="559806115"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 28 Apr 2022 11:11:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 28 Apr 2022 11:11:02 -0700
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15]) by
 ORSMSX602.amr.corp.intel.com ([10.22.229.15]) with mapi id 15.01.2308.027;
 Thu, 28 Apr 2022 11:11:02 -0700
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Won Chung <wonchung@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] misc/mei: Add NULL check to component match callback
 functions
Thread-Topic: [PATCH 1/2] misc/mei: Add NULL check to component match callback
 functions
Thread-Index: AQHYWMWF45jFBXcTi0GPRZghoKepzq0FjbrQ
Date:   Thu, 28 Apr 2022 18:11:02 +0000
Message-ID: <0136fcb26ca8433899593208af4351c9@intel.com>
References: <20220418175932.1809770-1-wonchung@google.com>
 <20220418175932.1809770-2-wonchung@google.com>
 <CAOvb9yjCnw=-5wO5_X6ond3GFdpRaNUPyyzojE49zTGfaWNNsg@mail.gmail.com>
In-Reply-To: <CAOvb9yjCnw=-5wO5_X6ond3GFdpRaNUPyyzojE49zTGfaWNNsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.15
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gVHVlLCBBcHIgMTksIDIwMjIgYXQgMjo1OSBBTSBXb24gQ2h1bmcgPHdvbmNodW5n
QGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gQ3VycmVudGx5LCBjb21wb25lbnRfbWF0
Y2ggY2FsbGJhY2sgZnVuY3Rpb25zIHVzZWQgaW4gbWVpIHJlZmVycyB0bw0KPiA+IHRoZSBkcml2
ZXIgbmFtZSwgYXNzdW1pbmcgdGhhdCB0aGUgY29tcG9uZW50IGRldmljZSBiZWluZyBtYXRjaGVk
IGhhcw0KPiA+IGEgZHJpdmVyIGJvdW5kLiBJdCBjYW4gY2F1c2UgYSBOVUxMIHBvaW50ZXIgZGVy
ZWZlcmVuY2Ugd2hlbiBhIGRldmljZQ0KPiA+IHdpdGhvdXQgYSBkcml2ZXIgYm91bmQgcmVnaXN0
ZXJzIGEgY29tcG9uZW50LiBUaGlzIGlzIGR1ZSB0byB0aGUNCj4gPiBuYXR1cmUgb2YgdGhlIGNv
bXBvbmVudCBmcmFtZXdvcmsgd2hlcmUgYWxsIHJlZ2lzdGVyZWQgY29tcG9uZW50cyBhcmUNCj4g
PiBtYXRjaGVkIGluIGFueSBjb21wb25lbnRfbWF0Y2ggY2FsbGJhY2sgZnVuY3Rpb25zLiBTbyBl
dmVuIGlmIGENCj4gPiBjb21wb25lbnQgaXMgcmVnaXN0ZXJlZCBieSBhIHRvdGFsbHkgaXJyZWxl
dmFudCBkZXZpY2UsIHRoYXQgY29tcG9uZW50DQo+ID4gaXMgYWxzbyBzaGFyZWQgdG8gdGhlc2Ug
Y2FsbGJhY2tzIGZvciBpOTE1IGRyaXZlci4NCj4gPg0KPiA+IFRvIHByZXZlbnQgdG90YWxseSBp
cnJlbGV2YW50IGRldmljZSBiZWluZyBtYXRjaGVkIGZvciBpOTE1IGFuZA0KPiA+IGNhdXNpbmcg
YSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgZm9yIGNoZWNraW5nIGRyaXZlciBuYW1lLCBhZGQg
YQ0KPiA+IE5VTEwgY2hlY2sgb24NCj4gPiBkZXYtPmRyaXZlciB0byBjaGVjayBpZiB0aGVyZSBp
cyBhIGRyaXZlciBib3VuZCBiZWZvcmUgY2hlY2tpbmcgdGhlDQo+ID4gZHJpdmVyIG5hbWUuDQo+
ID4NCj4gPiBJbiB0aGUgZnV0dXJlLCB0aGUgc3RyaW5nIGNvbXBhcmUgb24gdGhlIGRyaXZlciBu
YW1lLCAiaTkxNSIgbWF5IG5lZWQNCj4gPiB0byBiZSByZWZhY3RvcmVkIHRvby4NCj4gPg0KPiA+
IFJldmlld2VkLWJ5OiBIZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRl
bC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFByYXNoYW50IE1hbGFuaSA8cG1hbGFuaUBjaHJvbWl1
bS5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogV29uIENodW5nIDx3b25jaHVuZ0Bnb29nbGUuY29t
Pg0KQWNrZWQtYnk6IFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmtsZXJAaW50ZWwuY29tPiANCg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuYyB8IDIgKy0NCj4g
PiAgZHJpdmVycy9taXNjL21laS9weHAvbWVpX3B4cC5jICAgfCAyICstDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+ID4gYi9kcml2ZXJzL21p
c2MvbWVpL2hkY3AvbWVpX2hkY3AuYw0KPiA+IGluZGV4IGVjMmE0ZmNlODU4MS4uZTg4OWE4YmQ3
YWM4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+
ID4gKysrIGIvZHJpdmVycy9taXNjL21laS9oZGNwL21laV9oZGNwLmMNCj4gPiBAQCAtNzg0LDcg
Kzc4NCw3IEBAIHN0YXRpYyBpbnQgbWVpX2hkY3BfY29tcG9uZW50X21hdGNoKHN0cnVjdA0KPiBk
ZXZpY2UNCj4gPiAqZGV2LCBpbnQgc3ViY29tcG9uZW50LCAgew0KPiA+ICAgICAgICAgc3RydWN0
IGRldmljZSAqYmFzZSA9IGRhdGE7DQo+ID4NCj4gPiAtICAgICAgIGlmIChzdHJjbXAoZGV2LT5k
cml2ZXItPm5hbWUsICJpOTE1IikgfHwNCj4gPiArICAgICAgIGlmICghZGV2LT5kcml2ZXIgfHwg
c3RyY21wKGRldi0+ZHJpdmVyLT5uYW1lLCAiaTkxNSIpIHx8DQo+ID4gICAgICAgICAgICAgc3Vi
Y29tcG9uZW50ICE9IEk5MTVfQ09NUE9ORU5UX0hEQ1ApDQo+ID4gICAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvcHhwL21laV9w
eHAuYw0KPiA+IGIvZHJpdmVycy9taXNjL21laS9weHAvbWVpX3B4cC5jIGluZGV4IGY3MzgwZDM4
N2JhYi4uNWMzOTQ1N2UzZjUzDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9taXNjL21l
aS9weHAvbWVpX3B4cC5jDQo+ID4gKysrIGIvZHJpdmVycy9taXNjL21laS9weHAvbWVpX3B4cC5j
DQo+ID4gQEAgLTEzMSw3ICsxMzEsNyBAQCBzdGF0aWMgaW50IG1laV9weHBfY29tcG9uZW50X21h
dGNoKHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2LCBpbnQgc3ViY29tcG9uZW50LCAgew0KPiA+ICAg
ICAgICAgc3RydWN0IGRldmljZSAqYmFzZSA9IGRhdGE7DQo+ID4NCj4gPiAtICAgICAgIGlmIChz
dHJjbXAoZGV2LT5kcml2ZXItPm5hbWUsICJpOTE1IikgfHwNCj4gPiArICAgICAgIGlmICghZGV2
LT5kcml2ZXIgfHwgc3RyY21wKGRldi0+ZHJpdmVyLT5uYW1lLCAiaTkxNSIpIHx8DQo+ID4gICAg
ICAgICAgICAgc3ViY29tcG9uZW50ICE9IEk5MTVfQ09NUE9ORU5UX1BYUCkNCj4gPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzYuMC5yYzAuNDcwLmdkMzYx
Mzk3ZjBkLWdvb2cNCj4gPg0KPiANCj4gSGkgVG9tYXMsDQo+IA0KPiBJIGFtIGFkZGluZyB5b3Ug
dG8gdGhpcyBwYXRjaCBzaW5jZSB5b3UgYXJlIHRoZSBtYWludGFpbmVyIG9mIE1FSS4NCj4gSWYg
dGhpcyBsb29rcyBva2F5IHRvIHlvdSwgY291bGQgeW91IGFsc28gdGFrZSBhIGxvb2sgYXQgdGhl
IGNvbW1lbnQgdGhyZWFkIG9uDQo+IHRoZSBjb3ZlciBsZXR0ZXIgYW5kIGdpdmUgYW4gYWNrIGlm
IGl0IGlzIG9rYXkgdG8gYmUgbWVyZ2VkIGludG8gdGh1bmRlcmJvbHQNCj4gdHJlZT8NCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwNDE4MTc1OTMyLjE4MDk3NzAtMS0NCj4gd29u
Y2h1bmdAZ29vZ2xlLmNvbS8NCj4gDQo+IFRoYW5rIHlvdSwNCj4gV29uDQo=
