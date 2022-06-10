Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE059545B97
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbiFJFUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243933AbiFJFUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:20:14 -0400
Received: from enterprise02.smtp.diehl.com (enterprise02.smtp.diehl.com [193.201.238.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C803B01E;
        Thu,  9 Jun 2022 22:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1654838414; x=1686374414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vct3hYwWb/CSnrHlTvHt8/rp/9yWeC+4+rNqA9hWmwY=;
  b=QuQ2cYD405iZ8SqHJAzwbUZQsUlS1DaOBb0DiicUxNrV8ya98kwpRqfj
   9+iUwnUZiq+THrLdnGAAKYzIv3XhE93GmKLvUBxieGuISelDUfx1V+bsM
   OVBHFg+T58yjpy34GoCo/LLe3AXIP+ReaR7kXxl6mz9hu7QSIu9u06G89
   83xIv51oPDsM8tLA8EbtYZMKuxPhrXzvo5x3PHfrYKmO2f1izDl+BXMfV
   k7yTrmKLe9nWnK25K116NQKVQ7MIUbc3wzY4S9kSTpXUHmyayfif8mRLt
   rC01eglKAU88G/Shpi3CmPl1fdxcNzudzZhLF4QWpDjcD/x++mVEWJ158
   Q==;
IronPort-Data: A9a23:xstUzaMnKRtvPVHvrR3XlsFynXyQoLVcMsEvi/4bfWQNrUoihD0Cy
 jMbDziAM66OYmOnKdl/PNji8EJU6p6EyNE1TAZtpSBmQkwRpJueD7x1DKtS0wC6c5efFhI3t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M68wIFqtQw24LhXVrV4
 YqaT/D3YzdJ5RYlawr41IrT8HuDjNyq0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatA88tqBe
 gr25OrRElU1XfsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0qS2TV1hUp/0l20c95NJ
 Nplnpbgd0QnYp33tc8jfSBgNjA9OI575+qSSZS/mZT7I0zuSVDA6LBLBUAyZNZe8eFtGSdC9
 PEYLHYGaRXra+Cemer9E7Q3wJ9ldpiD0IA34xmMyRnVAPAnWtbEWLnH/9tR2jsYisFDHfKYb
 M0cAdZqRE+YP0YTZQpLYH44tPaagCT2aSN7kUuEuvo4yVn5yClI1Le4ZbI5ffTPH625hH2wr
 2TK5WXoRAoaOcKUyTeD8XWEgu7JgDO9WYQOGbn+/flv6HWLz3IeDDULXkT9quvRokq/Xc9Pb
 kgZ9jEGs6c/7gqoQ8P7Uhn+p2SL1jYYWtxNA6g55RuLx678/QmUHC4HQyRHZdhgs9U5LQHGz
 XeTlN/iQDlmsbnMEjSW8a2M6z+zNCgRa2QFYEfoUDc43jUqm6lr5jqnczqpOPfdYgHdcd0o/
 w23kQ==
IronPort-HdrOrdr: A9a23:UtQCfq+35PdhD+CTITRuk+AAI+orL9Y04lQ7vn2ZESYlF/Bw5P
 re+MjztCWE8Ar5PUtQ5OxoV5PwIk80maQY3WBzB8bYYOCFghrLEGgK1+KLqFeMJ8SUzIBgPN
 JbE5SWf+eQMbEVt6nHyTj9PPpl+d+D8Kq5wcfypk0dNz2CIJsQiDuRQjzrdHGfUmF9dOMEKK
 Y=
X-IronPort-AV: E=Sophos;i="5.91,288,1647298800"; 
   d="scan'208";a="30434754"
From:   Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Pavel Machek <pavel@ucw.cz>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] leds: core: Refactor led_update_brightness() to
 use standard pattern
Thread-Topic: [PATCH v1 1/1] leds: core: Refactor led_update_brightness() to
 use standard pattern
Thread-Index: AQHYfB03A5G1F6o9YkqnTKEyI/bWsK1IGuUw
Date:   Fri, 10 Jun 2022 05:20:11 +0000
Message-ID: <889f0750ad6b46479ac40283d3ae08c8@RCDC-Mail15.corp.diehl.com>
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
X-GBS-PROC: 5x5xXKsZ7k4sJw6jWwvS4stNlzQY9S+8US+56idKtE5Pn2RQKmNFVz/9Ho/EUmPx
X-GBS-PROCJOB: tGAIOPV4e/iCCCRvp4AeCbti/CIenwSft3sdlmLjV1t6hbHDD2PNhSw/KDckKFt7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEdUTQ0KDQpBY2tlZC1ieTogRGVuaXMgT3N0ZXJsYW5kIDxkZW5pcy5vc3RlcmxhbmRAZGllaGwu
Y29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQpTZW50OiBUaHVyc2RheSwgSnVu
ZSA5LCAyMDIyIDY6MjMgUE0NClRvOiBEZW5pcyBPU1RFUkxBTkQtSEVJTSA8ZGVuaXMub3N0ZXJs
YW5kQGRpZWhsLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXgu
aW50ZWwuY29tPjsgbGludXgtbGVkc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCkNjOiBQYXZlbCBNYWNoZWsgPHBhdmVsQHVjdy5jej4NClN1YmplY3Q6IFtQ
QVRDSCB2MSAxLzFdIGxlZHM6IGNvcmU6IFJlZmFjdG9yIGxlZF91cGRhdGVfYnJpZ2h0bmVzcygp
IHRvIHVzZSBzdGFuZGFyZCBwYXR0ZXJuDQoNClRoZSBzdGFuZGFyZCBjb25kaXRpb25hbCBwYXR0
ZXJuIGlzIHRvIGNoZWNrIGZvciBlcnJvcnMgZmlyc3QgYW5kIGJhaWwgb3V0IGlmIGFueS4gUmVm
YWN0b3IgbGVkX3VwZGF0ZV9icmlnaHRuZXNzKCkgYWNjb3JkaW5nbHkuDQoNCldoaWxlIGF0IGl0
LCBkcm9wIHVubmVlZGVkIGFzc2lnbm1lbnQgYW5kIHJldHVybiAwIHVuY29uZGl0aW9uYWxseSBv
biBzdWNjZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2
Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbGVkcy9sZWQtY29yZS5jIHwg
MTIgKysrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbGVkcy9sZWQtY29yZS5jIGIvZHJpdmVy
cy9sZWRzL2xlZC1jb3JlLmMgaW5kZXggNGE5N2NiNzQ1Nzg4Li45NmEyODE3NzEyZTUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2xlZHMvbGVkLWNvcmUuYw0KKysrIGIvZHJpdmVycy9sZWRzL2xlZC1j
b3JlLmMNCkBAIC0zMDQsMTcgKzMwNCwxNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChsZWRfc2V0X2Jy
aWdodG5lc3Nfc3luYyk7DQoNCiBpbnQgbGVkX3VwZGF0ZV9icmlnaHRuZXNzKHN0cnVjdCBsZWRf
Y2xhc3NkZXYgKmxlZF9jZGV2KSAgew0KLWludCByZXQgPSAwOw0KK2ludCByZXQ7DQoNCiBpZiAo
bGVkX2NkZXYtPmJyaWdodG5lc3NfZ2V0KSB7DQogcmV0ID0gbGVkX2NkZXYtPmJyaWdodG5lc3Nf
Z2V0KGxlZF9jZGV2KTsNCi1pZiAocmV0ID49IDApIHsNCi1sZWRfY2Rldi0+YnJpZ2h0bmVzcyA9
IHJldDsNCi1yZXR1cm4gMDsNCi19DQoraWYgKHJldCA8IDApDQorcmV0dXJuIHJldDsNCisNCits
ZWRfY2Rldi0+YnJpZ2h0bmVzcyA9IHJldDsNCiB9DQoNCi1yZXR1cm4gcmV0Ow0KK3JldHVybiAw
Ow0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTChsZWRfdXBkYXRlX2JyaWdodG5lc3MpOw0KDQotLQ0K
Mi4zNS4xDQpEaWVobCBNZXRlcmluZyBHbWJILCBEb25hdXN0cmFzc2UgMTIwLCA5MDQ1MSBOdWVy
bmJlcmcNClNpdHogZGVyIEdlc2VsbHNjaGFmdDogQW5zYmFjaCwgUmVnaXN0ZXJnZXJpY2h0OiBB
bnNiYWNoIEhSQiA2OQ0KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBDaHJpc3RvZiBCb3NiYWNoIChT
cHJlY2hlciksIERpcGwuLURvbG0uIEFubmV0dGUgR2V1dGhlciwgRGlwbC4tS2ZtLiBSZWluZXIg
RWRlbA0KDQpCaXR0ZSBkZW5rZW4gU2llIGFuIGRpZSBVbXdlbHQsIGJldm9yIFNpZSBkaWVzZSBF
LU1haWwgZHJ1Y2tlbi4gRGllc2UgRS1NYWlsIGthbm4gdmVydHJhdWxpY2hlIEluZm9ybWF0aW9u
ZW4gZW50aGFsdGVuLiBTb2xsdGVuIGRpZSBpbiBkaWVzZXIgRS1NYWlsIGVudGhhbHRlbmVuIElu
Zm9ybWF0aW9uZW4gbmljaHQgZsO8ciBTaWUgYmVzdGltbXQgc2VpbiwgaW5mb3JtaWVyZW4gU2ll
IGJpdHRlIHVudmVyenVlZ2xpY2ggZGVuIEFic2VuZGVyIHBlciBFLU1haWwgdW5kIGxvZXNjaGVu
IFNpZSBkaWVzZSBFLU1haWwgaW4gSWhyZW0gU3lzdGVtLiBKZWRlIHVuYmVyZWNodGlndGUgRm9y
bSBkZXIgUmVwcm9kdWt0aW9uLCBCZWthbm50Z2FiZSwgQWVuZGVydW5nLCBWZXJ0ZWlsdW5nIHVu
ZC9vZGVyIFB1Ymxpa2F0aW9uIGRpZXNlciBFLU1haWwgaXN0IHN0cmVuZ3N0ZW5zIHVudGVyc2Fn
dC4gSW5mb3JtYXRpb25lbiB6dW0gRGF0ZW5zY2h1dHogZmluZGVuIFNpZSBhdWYgdW5zZXJlciBI
b21lcGFnZTxodHRwczovL3d3dy5kaWVobC5jb20vbWV0ZXJpbmcvZGUvaW1wcmVzc3VtLXVuZC1y
ZWNodGxpY2hlLWhpbndlaXNlLz4uDQoNCkJlZm9yZSBwcmludGluZywgdGhpbmsgYWJvdXQgZW52
aXJvbm1lbnRhbCByZXNwb25zaWJpbGl0eS5UaGlzIG1lc3NhZ2UgbWF5IGNvbnRhaW4gY29uZmlk
ZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgYXJlIG5vdCBhdXRob3JpemVkIHRvIHJlY2VpdmUg
dGhpcyBpbmZvcm1hdGlvbiBwbGVhc2UgYWR2aXNlIHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkg
cmVwbHkgZS1tYWlsIGFuZCBkZWxldGUgdGhpcyBtZXNzYWdlIHdpdGhvdXQgbWFraW5nIGFueSBj
b3BpZXMuIEFueSBmb3JtIG9mIHVuYXV0aG9yaXplZCB1c2UsIHB1YmxpY2F0aW9uLCByZXByb2R1
Y3Rpb24sIGNvcHlpbmcgb3IgZGlzY2xvc3VyZSBvZiB0aGUgZS1tYWlsIGlzIG5vdCBwZXJtaXR0
ZWQuIEluZm9ybWF0aW9uIGFib3V0IGRhdGEgcHJvdGVjdGlvbiBjYW4gYmUgZm91bmQgb24gb3Vy
IGhvbWVwYWdlPGh0dHBzOi8vd3d3LmRpZWhsLmNvbS9tZXRlcmluZy9lbi9kYXRhLXByb3RlY3Rp
b24vPi4NCg==
