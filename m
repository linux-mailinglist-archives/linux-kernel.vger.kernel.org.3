Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E581545B86
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243878AbiFJFRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiFJFRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:17:07 -0400
Received: from enterprise01.smtp.diehl.com (enterprise01.smtp.diehl.com [193.201.238.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D9D62C1;
        Thu,  9 Jun 2022 22:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1654838226; x=1686374226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7rwE/o9oY8OmMLQPKfKQ5tSf+bnywKIWjXXOF5rWxyE=;
  b=ImrNRBeT5lyXdol3gNbXBtQPhOu112j8ZYuoaqd3LnIobRGgOIkimok/
   fU5QNaqjYfkbWiADmZClAPdAHuwL+P/RwciuRudI4sF/XirzEIzvO/xCX
   cdqqN61VDPSZgvjSAXvihZUzT1mMRHg3GdMz5Hjqg25F6iXQrcNgMM11n
   XuASPD9u+wcYKCGt9fNhE2P3dtqiW0TQ78MFvW3mbWYXKTL03aZ7GoL+y
   Q3z7C4/5z1O5RbtUnbXWqho1erG47t79Ug4MFj0kSbkbQAga6pkV7a1vZ
   4/vn0A1axCwwYcGnx9es5zB38RSRIKWzUbkmx84EMH/GyyCYWR5azAP5S
   Q==;
IronPort-Data: A9a23:iJs9GaKX8sjYv1WvFE+Ro5QlxSXFcZb7ZxGr2PjKsXjdYENS0DUCy
 mdLWzqOMvrZMWajfN11bInk9EgAvpWByYI1TAJorCE8RH908seUXt7xwmUcnc+xBpCZEBg3v
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywobVvqYy2YLjW13U4
 YuryyHiEATNNwBcYzt8B52r+EsHUMTa4Fv0aXRnOJinFHeH/5UkJMp3yZOZdhMUcaENdgKOf
 Nsv+Znilo/vE7XBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XnRfTAKtao2zhojx/9
 DlCnaKCQxwUOIzRoe8MUkgFTApCO60W95aSdBBTseTLp6HHW0HH794rKUg3OdRDvO1wG3kI+
 f0VKDRLZReG7w606OvjDLAx3YJ4apO6VG8ckigIITXxAfsgQIuFRL7W6MVc1TE8rsxPEPbaI
 cEebFKDaTybOUESYw5MUfrSms+JhHLaSH5xk2uV/4sdoEv05gpbjIrUZY+9ltuiAJ89clyjj
 mbH+XnpRxIXLtqSzRKb/X+2wOzChyX2XMQVDrLQ3uZjnlCX7nEYF1sdRzOTqP+1kE+vHclfJ
 lIf+icorq8a8E2tU8m7XhukrXrCtRkZM/JUEusn+ESJx6bPyxiWC3JCTTNbbtEi8sgsSlQXO
 kShhdjlDnlqubyRECnb/bCOtXW+OCUVKSkJYipsoRY53uQPabob1nrnJuuP2obs5jEpMVkcG
 wy3kRU=
IronPort-HdrOrdr: A9a23:jlAINK1CUaJ0QfDNrn+GawqjBJ8kLtp133Aq2lEZdPU0SKalf8
 PEpoV46fYuskdhZJhEo6HnBEDuewKnyXcY2/hpAV7aZniZhIN6RLsSkbcLtFbbalDDH7VmpN
 hdmsFFYbWaYDcV7KaKhXjeLz9K+qj9zEnHv5an85/jIDsaD52IMD0Ue2WmLnE=
X-IronPort-AV: E=Sophos;i="5.91,288,1647298800"; 
   d="scan'208";a="32451131"
From:   Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>
Subject: RE: [PATCH v1 1/1] leds: core: Refactor led_update_brightness() to
 use standard pattern
Thread-Topic: [PATCH v1 1/1] leds: core: Refactor led_update_brightness() to
 use standard pattern
Thread-Index: AQHYfB03A5G1F6o9YkqnTKEyI/bWsK1IGi4A
Date:   Fri, 10 Jun 2022 05:17:02 +0000
Message-ID: <372f05b312c54f808491d4fb3a2d7744@RCDC-Mail15.corp.diehl.com>
References: <20220609162233.80498-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220609162233.80498-1-andriy.shevchenko@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-disclaimerprocessed: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-GBS-PROC: H/EbuC12Vnf8ka8I9ZkQCV8VhTLL3jMa0+E1FTTkp2+i0DexVFrLH3cEzeoA1Fanq/8lCaVtSx+cQU62Dtu0QvVQsYtgpwLtW/9Ztuf0/GA=
X-GBS-PROCJOB: js2Vfo5hLJQGBTiPkRr5ZmfzmfY6ep9mt26pktlU7reuUpYJBOS35Xd68vHBw9ee
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEdUTQ0KDQpBY2tlZC1ieTogRGVuaXMgT3N0ZXJsYW5kLUhlaW0gPGRlbmlzLm9zdGVybGFuZEBk
aWVobC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbmR5IFNoZXZj
aGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NClNlbnQ6IFRodXJzZGF5
LCBKdW5lIDksIDIwMjIgNjoyMyBQTQ0KVG86IERlbmlzIE9TVEVSTEFORC1IRUlNIDxkZW5pcy5v
c3RlcmxhbmRAZGllaGwuY29tPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20+OyBsaW51eC1sZWRzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KQ2M6IFBhdmVsIE1hY2hlayA8cGF2ZWxAdWN3LmN6Pg0KU3ViamVj
dDogW1BBVENIIHYxIDEvMV0gbGVkczogY29yZTogUmVmYWN0b3IgbGVkX3VwZGF0ZV9icmlnaHRu
ZXNzKCkgdG8gdXNlIHN0YW5kYXJkIHBhdHRlcm4NCg0KVGhlIHN0YW5kYXJkIGNvbmRpdGlvbmFs
IHBhdHRlcm4gaXMgdG8gY2hlY2sgZm9yIGVycm9ycyBmaXJzdCBhbmQgYmFpbCBvdXQgaWYgYW55
LiBSZWZhY3RvciBsZWRfdXBkYXRlX2JyaWdodG5lc3MoKSBhY2NvcmRpbmdseS4NCg0KV2hpbGUg
YXQgaXQsIGRyb3AgdW5uZWVkZWQgYXNzaWdubWVudCBhbmQgcmV0dXJuIDAgdW5jb25kaXRpb25h
bGx5IG9uIHN1Y2Nlc3MuDQoNClNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KLS0tDQogZHJpdmVycy9sZWRzL2xlZC1jb3Jl
LmMgfCAxMiArKysrKystLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9sZWRzL2xlZC1jb3JlLmMgYi9k
cml2ZXJzL2xlZHMvbGVkLWNvcmUuYyBpbmRleCA0YTk3Y2I3NDU3ODguLjk2YTI4MTc3MTJlNSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbGVkcy9sZWQtY29yZS5jDQorKysgYi9kcml2ZXJzL2xlZHMv
bGVkLWNvcmUuYw0KQEAgLTMwNCwxNyArMzA0LDE3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKGxlZF9z
ZXRfYnJpZ2h0bmVzc19zeW5jKTsNCg0KIGludCBsZWRfdXBkYXRlX2JyaWdodG5lc3Moc3RydWN0
IGxlZF9jbGFzc2RldiAqbGVkX2NkZXYpICB7DQotaW50IHJldCA9IDA7DQoraW50IHJldDsNCg0K
IGlmIChsZWRfY2Rldi0+YnJpZ2h0bmVzc19nZXQpIHsNCiByZXQgPSBsZWRfY2Rldi0+YnJpZ2h0
bmVzc19nZXQobGVkX2NkZXYpOw0KLWlmIChyZXQgPj0gMCkgew0KLWxlZF9jZGV2LT5icmlnaHRu
ZXNzID0gcmV0Ow0KLXJldHVybiAwOw0KLX0NCitpZiAocmV0IDwgMCkNCityZXR1cm4gcmV0Ow0K
Kw0KK2xlZF9jZGV2LT5icmlnaHRuZXNzID0gcmV0Ow0KIH0NCg0KLXJldHVybiByZXQ7DQorcmV0
dXJuIDA7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKGxlZF91cGRhdGVfYnJpZ2h0bmVzcyk7DQoN
Ci0tDQoyLjM1LjENCkRpZWhsIE1ldGVyaW5nIEdtYkgsIERvbmF1c3RyYXNzZSAxMjAsIDkwNDUx
IE51ZXJuYmVyZw0KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiBBbnNiYWNoLCBSZWdpc3Rlcmdlcmlj
aHQ6IEFuc2JhY2ggSFJCIDY5DQpHZXNjaGFlZnRzZnVlaHJlcjogRHIuIENocmlzdG9mIEJvc2Jh
Y2ggKFNwcmVjaGVyKSwgRGlwbC4tRG9sbS4gQW5uZXR0ZSBHZXV0aGVyLCBEaXBsLi1LZm0uIFJl
aW5lciBFZGVsDQoNCkJpdHRlIGRlbmtlbiBTaWUgYW4gZGllIFVtd2VsdCwgYmV2b3IgU2llIGRp
ZXNlIEUtTWFpbCBkcnVja2VuLiBEaWVzZSBFLU1haWwga2FubiB2ZXJ0cmF1bGljaGUgSW5mb3Jt
YXRpb25lbiBlbnRoYWx0ZW4uIFNvbGx0ZW4gZGllIGluIGRpZXNlciBFLU1haWwgZW50aGFsdGVu
ZW4gSW5mb3JtYXRpb25lbiBuaWNodCBmw7xyIFNpZSBiZXN0aW1tdCBzZWluLCBpbmZvcm1pZXJl
biBTaWUgYml0dGUgdW52ZXJ6dWVnbGljaCBkZW4gQWJzZW5kZXIgcGVyIEUtTWFpbCB1bmQgbG9l
c2NoZW4gU2llIGRpZXNlIEUtTWFpbCBpbiBJaHJlbSBTeXN0ZW0uIEplZGUgdW5iZXJlY2h0aWd0
ZSBGb3JtIGRlciBSZXByb2R1a3Rpb24sIEJla2FubnRnYWJlLCBBZW5kZXJ1bmcsIFZlcnRlaWx1
bmcgdW5kL29kZXIgUHVibGlrYXRpb24gZGllc2VyIEUtTWFpbCBpc3Qgc3RyZW5nc3RlbnMgdW50
ZXJzYWd0LiBJbmZvcm1hdGlvbmVuIHp1bSBEYXRlbnNjaHV0eiBmaW5kZW4gU2llIGF1ZiB1bnNl
cmVyIEhvbWVwYWdlPGh0dHBzOi8vd3d3LmRpZWhsLmNvbS9tZXRlcmluZy9kZS9pbXByZXNzdW0t
dW5kLXJlY2h0bGljaGUtaGlud2Vpc2UvPi4NCg0KQmVmb3JlIHByaW50aW5nLCB0aGluayBhYm91
dCBlbnZpcm9ubWVudGFsIHJlc3BvbnNpYmlsaXR5LlRoaXMgbWVzc2FnZSBtYXkgY29udGFpbiBj
b25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBhcmUgbm90IGF1dGhvcml6ZWQgdG8gcmVj
ZWl2ZSB0aGlzIGluZm9ybWF0aW9uIHBsZWFzZSBhZHZpc2UgdGhlIHNlbmRlciBpbW1lZGlhdGVs
eSBieSByZXBseSBlLW1haWwgYW5kIGRlbGV0ZSB0aGlzIG1lc3NhZ2Ugd2l0aG91dCBtYWtpbmcg
YW55IGNvcGllcy4gQW55IGZvcm0gb2YgdW5hdXRob3JpemVkIHVzZSwgcHVibGljYXRpb24sIHJl
cHJvZHVjdGlvbiwgY29weWluZyBvciBkaXNjbG9zdXJlIG9mIHRoZSBlLW1haWwgaXMgbm90IHBl
cm1pdHRlZC4gSW5mb3JtYXRpb24gYWJvdXQgZGF0YSBwcm90ZWN0aW9uIGNhbiBiZSBmb3VuZCBv
biBvdXIgaG9tZXBhZ2U8aHR0cHM6Ly93d3cuZGllaGwuY29tL21ldGVyaW5nL2VuL2RhdGEtcHJv
dGVjdGlvbi8+Lg0K
