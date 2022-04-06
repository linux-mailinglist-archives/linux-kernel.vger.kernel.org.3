Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F24F5AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiDFKGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244241AbiDFKE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:04:56 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93CD3158DB1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:47:28 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(7803:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 06 Apr 2022 09:47:11 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 09:47:10 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0986.022; Wed, 6 Apr 2022
 09:47:10 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: rtq2134: Fix missing active_discharge_on
 setting
Thread-Topic: [PATCH] regulator: rtq2134: Fix missing active_discharge_on
 setting
Thread-Index: AQHYR8tQ9pi7OoOc3kOG+WPCRwxXEKzhmsIA
Date:   Wed, 6 Apr 2022 01:47:10 +0000
Message-ID: <1649209630.3282.2.camel@richtek.com>
References: <20220404022514.449231-1-axel.lin@ingics.com>
In-Reply-To: <20220404022514.449231-1-axel.lin@ingics.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.18.182]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C344EE769DF4FA408122293B755DD08A@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5pa8IOS4gO+8jDIwMjItMDQtMDQg5pa8IDEwOjI1ICswODAw77yMQXhlbCBMaW4g5o+Q5Yiw77ya
DQo+IFRoZSBhY3RpdmVfZGlzY2hhcmdlX29uIHNldHRpbmcgd2FzIG1pc3NlZCwgc28gb3V0cHV0
IGRpc2NoYXJnZSByZXNpc3Rvcg0KPiBpcyBhbHdheXMgZGlzYWJsZWQuIEZpeCBpdC4NCj4NCj4g
Rml4ZXM6IDA1NTVkNDE0OTdkZSAoInJlZ3VsYXRvcjogcnRxMjEzNDogQWRkIHN1cHBvcnQgZm9y
IFJpY2h0ZWsgUlRRMjEzNA0KPiBTdWJQTUlDIikNCj4gU2lnbmVkLW9mZi1ieTogQXhlbCBMaW4g
PGF4ZWwubGluQGluZ2ljcy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9yZWd1bGF0b3IvcnRxMjEz
NC1yZWd1bGF0b3IuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
DQpIaSwgQXhlbDoNClRoYW5rcyBmb3IgdGhlIGZpeC4NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9yZWd1bGF0b3IvcnRxMjEzNC1yZWd1bGF0b3IuYw0KPiBiL2RyaXZlcnMvcmVndWxhdG9yL3J0
cTIxMzQtcmVndWxhdG9yLmMNCj4gaW5kZXggZjIxZTNmOGIyMWYyLi44ZTEzZGVhMzU0YTIgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvcmVndWxhdG9yL3J0cTIxMzQtcmVndWxhdG9yLmMNCj4gKysr
IGIvZHJpdmVycy9yZWd1bGF0b3IvcnRxMjEzNC1yZWd1bGF0b3IuYw0KPiBAQCAtMjg1LDYgKzI4
NSw3IEBAIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBpbnQgcnRxMjEzNF9idWNrX3JhbXBfZGVsYXlf
dGFibGVbXQ0KPiA9IHsNCj4gIC5lbmFibGVfbWFzayA9IFJUUTIxMzRfVk9VVEVOX01BU0ssIFwN
Cj4gIC5hY3RpdmVfZGlzY2hhcmdlX3JlZyA9IFJUUTIxMzRfUkVHX0JVQ0sjI19pZCMjX0NGRzAs
IFwNCj4gIC5hY3RpdmVfZGlzY2hhcmdlX21hc2sgPSBSVFEyMTM0X0FDVERJU0NIR19NQVNLLCBc
DQo+ICsuYWN0aXZlX2Rpc2NoYXJnZV9vbiA9IFJUUTIxMzRfQUNURElTQ0hHX01BU0ssIFwNCj4g
IC5yYW1wX3JlZyA9IFJUUTIxMzRfUkVHX0JVQ0sjI19pZCMjX1JTUENGRywgXA0KPiAgLnJhbXBf
bWFzayA9IFJUUTIxMzRfUlNQVVBfTUFTSywgXA0KPiAgLnJhbXBfZGVsYXlfdGFibGUgPSBydHEy
MTM0X2J1Y2tfcmFtcF9kZWxheV90YWJsZSwgXA0KKioqKioqKioqKioqKiBFbWFpbCBDb25maWRl
bnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQoNClRoZSBpbmZvcm1hdGlvbiBj
b250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50
cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQsIG9yIG90aGVy
d2lzZSBleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMg
aW50ZW5kZWQgdG8gYmUgY29udmV5ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQo
cykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJldGFp
bmluZyBvciBjb3B5aW5nIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1lbnRz
KSBieSB1bmludGVuZGVkIHJlY2lwaWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZCBt
YXkgYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBvZiB0
aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZSB0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWls
IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgKGJ5IHJlcGx5
aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgYWxsIGNvcGllcyBvZiB0aGlzIGUt
bWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgZnJvbSB5b3VyIHN5c3RlbSwgYW5kIGRv
IG5vdCBkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFpbCB0byBhbnkgb3RoZXIgcGVy
c29uLiBUaGFuayB5b3UhDQo=
