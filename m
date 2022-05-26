Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0696853544A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbiEZUMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344013AbiEZUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:12:38 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E6C1EC4;
        Thu, 26 May 2022 13:12:37 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4L8Jy21VwNzDs0j;
        Thu, 26 May 2022 13:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1653595957; bh=/h9OlJmTUr9r9fpUj2hVVrMBtpeveoTBrzqKr4leYbU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JsNttbH2GcO0qsOBMAjtUGqKkzXaeFVJwjANk7NtoCmB+yxT4m7zzpwGYcrVpq07W
         JBEn8nLsjWHC32Y5FPLFWUGY7MsU0IthOqkW5RB7eGjT6rMoggDqhNQPTvmvlEdPHM
         Y3JzKuYAVPmrMVS67ix/fq/LYHAOjCAaV4CAJk5k=
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4L8Jy1278Qz9tBX;
        Thu, 26 May 2022 13:12:25 -0700 (PDT)
X-Riseup-User-ID: FB853247F7ABA718FEEF3371A4958415B94990E7FE0E0CCDCB376597555A7E17
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4L8Jxx4PFfz1yPT;
        Thu, 26 May 2022 13:12:21 -0700 (PDT)
Message-ID: <8d25171a-5d86-9acc-0f94-1a3c6efdb360@riseup.net>
Date:   Thu, 26 May 2022 23:12:19 +0300
MIME-Version: 1.0
Subject: Re: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun attr
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
References: <20220525164013.93748-1-a5b6@riseup.net>
 <DM6PR04MB65750969ACD36EEEB48374DFFCD69@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   - <a5b6@riseup.net>
Autocrypt: addr=a5b6@riseup.net; keydata=
 xjMEYZTAJxYJKwYBBAHaRw8BAQdAeWfL/oPvU6yvaH7cClu6KaN2CflyoTcg5qPUoNLFnAzN
 Ey0gPGE1YjZAcmlzZXVwLm5ldD7CkQQTFggAORYhBLyRr+O3uqpzVxFlHDLzs9uoV47bBQJh
 lMAnBQkB4TOAAhsDBQsJCAcCBhUICQoLAgUWAgMBAAAKCRAy87PbqFeO2+KCAQDK9VqUAzN0
 N7nm9n2G8SI1gbAgbZFprSAaYvQaRIlyIQD/eSi/7185I93xAjF/AX78akjD/+tyBYl5JD+r
 iVv+8ADOOARhlMAnEgorBgEEAZdVAQUBAQdAs6KmMDge7X9mnh9UqTKC0sDdBceE2W+K+7Z8
 GPjb5SkDAQgHwn4EGBYIACYWIQS8ka/jt7qqc1cRZRwy87PbqFeO2wUCYZTAJwUJAeEzgAIb
 DAAKCRAy87PbqFeO2y/wAP92MinlCPDaPtB1JlmCNmg4638kf5qEh/kVeVPYJyGIvgD6A37W
 tjfuHjLL5Vi0iIdXGbOruHfOx3uQSocZ5UnbGwc=
In-Reply-To: <DM6PR04MB65750969ACD36EEEB48374DFFCD69@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk15IHVzZWNhc2UgaXMgZW5hYmxpbmcgYm9vdCBzbG90IHN3aXRjaGluZyBvbiBB
bmRyb2lkIEEvQiBkZXZpY2VzLCB3aGVyZQ0KdGhlIGFjdGl2ZSBMVU4gaGFzIHRvIGJlIGNo
YW5nZWQgaW4gb3JkZXIgdG8gZmFjaWxpdGF0ZSBlLmcuIGR1YWwtYm9vdGluZw0KQW5kcm9p
ZCBhbmQgbWFpbmxpbmUgTGludXguIEEgc2ltaWxhciBpbnRlcmZhY2UgaXMgZXhwb3NlZCBi
eSBBbmRyb2lkLCANCmFsYmVpdA0KdmlhIGlvY3RsLiBJJ3ZlIHRlc3RlZCB0aGlzIHBhdGNo
IGFuZCBjb25maXJtZWQgaXQgZW5hYmxlZCB0aGUgbmVjZXNzYXJ5DQpmdW5jdGlvbmFsaXR5
Lg0KDQpPbiAyNS8wNS8yMDIyIDIxOjM0LCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gSGksDQo+
PiBFeHBhbmRzIHN5c2ZzIGJvb3RfbHVuIGF0dHJpYnV0ZSB0byBiZSB3cml0YWJsZS4gTmVj
ZXNzYXJ5IHRvIGVuYWJsZQ0KPj4gcHJvcGVyIHN1cHBvcnQgZm9yIExVTiBzd2l0Y2hpbmcg
b24gc29tZSBVRlMgZGV2aWNlcy4NCj4gQ2FuIHlvdSBwbGVhc2UgZWxhYm9yYXRlIHdoeSBp
cyBpdCBuZWNlc3Nhcnk/DQo+IFdoYXQgdXNlIGNhc2UgYXJlIHlvdSBydW5uaW5nPw0KPg0K
Pj4gU2lnbmVkLW9mZi1ieTogTmlhIEVzcGVyYSA8YTViNkByaXNldXAubmV0Pg0KPj4gLS0t
DQo+PiAgIGRyaXZlcnMvc2NzaS91ZnMvdWZzLXN5c2ZzLmMgfCA2NyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDY2IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
Y3NpL3Vmcy91ZnMtc3lzZnMuYyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLXN5c2ZzLmMNCj4+
IGluZGV4IDVjNDA1ZmY3YjZlYS4uN2JmNWQ2YzNkMGVjIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9zY3NpL3Vmcy91ZnMtc3lzZnMuYw0KPj4gKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91
ZnMtc3lzZnMuYw0KPj4gQEAgLTEwNDcsNiArMTA0Nyw3MSBAQCBzdGF0aWMgaW5saW5lIGJv
b2wgdWZzaGNkX2lzX3diX2F0dHJzKGVudW0gYXR0cl9pZG4NCj4+IGlkbikNCj4+ICAgICAg
ICAgICAgICAgICAgaWRuIDw9IFFVRVJZX0FUVFJfSUROX0NVUlJfV0JfQlVGRl9TSVpFOw0K
Pj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBzc2l6ZV90IGJvb3RfbHVuX2VuYWJsZWRfc2hvdyhz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4+ICt7
DQo+PiArICAgICAgIHN0cnVjdCB1ZnNfaGJhICpoYmEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4+ICsgICAgICAgdTMyIHNsb3Q7DQo+PiArICAgICAgIGludCByZXQ7DQo+PiArICAg
ICAgIHU4IGluZGV4ID0gMDsNCj4+ICsNCj4+ICsgICAgICAgZG93bigmaGJhLT5ob3N0X3Nl
bSk7DQo+PiArICAgICAgIGlmICghdWZzaGNkX2lzX3VzZXJfYWNjZXNzX2FsbG93ZWQoaGJh
KSkgew0KPj4gKyAgICAgICAgICAgICAgIHVwKCZoYmEtPmhvc3Rfc2VtKTsNCj4+ICsgICAg
ICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPj4gKyAgICAgICB9DQo+PiArICAgICAgIGlm
ICh1ZnNoY2RfaXNfd2JfYXR0cnMoUVVFUllfQVRUUl9JRE5fQk9PVF9MVV9FTikpDQo+IENs
ZWFybHkgYkJvb3RMdW5FbiBpcyBub3QgYSBXQiBhdHRyaWJ1dGUuDQo+DQo+PiArICAgICAg
ICAgICAgICAgaW5kZXggPSB1ZnNoY2Rfd2JfZ2V0X3F1ZXJ5X2luZGV4KGhiYSk7DQo+PiAr
ICAgICAgIHVmc2hjZF9ycG1fZ2V0X3N5bmMoaGJhKTsNCj4+ICsNCj4+ICsgICAgICAgcmV0
ID0gdWZzaGNkX3F1ZXJ5X2F0dHIoaGJhLCBVUElVX1FVRVJZX09QQ09ERV9SRUFEX0FUVFIs
DQo+PiArICAgICAgICAgICAgICAgUVVFUllfQVRUUl9JRE5fQk9PVF9MVV9FTiwgaW5kZXgs
IDAsICZzbG90KTsNCj4+ICsNCj4+ICsgICAgICAgdWZzaGNkX3JwbV9wdXRfc3luYyhoYmEp
Ow0KPj4gKyAgICAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgICAgcmV0ID0gLUVJ
TlZBTDsNCj4+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+ICsgICAgICAgfQ0KPj4g
Kw0KPj4gKyAgICAgICByZXQgPSBzeXNmc19lbWl0KGJ1ZiwgIjB4JTA4WFxuIiwgc2xvdCk7
DQo+PiArb3V0Og0KPj4gKyAgICAgICB1cCgmaGJhLT5ob3N0X3NlbSk7DQo+PiArICAgICAg
IHJldHVybiByZXQ7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBzc2l6ZV90IGJvb3RfbHVu
X2VuYWJsZWRfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAq
YnVmLCBzaXplX3QgY291bnQpDQo+PiArew0KPj4gKyAgICAgICBzdHJ1Y3QgdWZzX2hiYSAq
aGJhID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+PiArICAgICAgIHUzMiBzbG90Ow0KPj4g
KyAgICAgICBpbnQgcmV0Ow0KPj4gKyAgICAgICB1OCBpbmRleCA9IDA7DQo+PiArDQo+PiAr
ICAgICAgIGlmIChrc3RydG91aW50KGJ1ZiwgMCwgJnNsb3QpIDwgMCkNCj4+ICsgICAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gWW91IG5lZWQgdG8gdmVyaWZ5IHRoYXQgbm8g
b25lIHNldCBiQm9vdEx1bkVuID0gMHgwIGJlY2F1c2UgdGhlIGRldmljZSB3b24ndCBib290
Lg0KPiBCZXR0ZXIgY2hlY2sgZXhwbGljaXRseSB0aGF0IHNsb3QgIT0gYkJvb3RMdW5FbiBh
bmQgaXRzIGVpdGhlciAxIG9yIDIuDQo+DQo+IFRoYW5rcywNCj4gQXZyaQ0KPg0KPj4gKw0K
Pj4gKyAgICAgICBkb3duKCZoYmEtPmhvc3Rfc2VtKTsNCj4+ICsgICAgICAgaWYgKCF1ZnNo
Y2RfaXNfdXNlcl9hY2Nlc3NfYWxsb3dlZChoYmEpKSB7DQo+PiArICAgICAgICAgICAgICAg
dXAoJmhiYS0+aG9zdF9zZW0pOw0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7
DQo+PiArICAgICAgIH0NCj4+ICsgICAgICAgaWYgKHVmc2hjZF9pc193Yl9hdHRycyhRVUVS
WV9BVFRSX0lETl9CT09UX0xVX0VOKSkNCj4+ICsgICAgICAgICAgICAgICBpbmRleCA9IHVm
c2hjZF93Yl9nZXRfcXVlcnlfaW5kZXgoaGJhKTsNCj4+ICsgICAgICAgdWZzaGNkX3JwbV9n
ZXRfc3luYyhoYmEpOw0KPj4gKw0KPj4gKyAgICAgICByZXQgPSB1ZnNoY2RfcXVlcnlfYXR0
cl9yZXRyeShoYmEsIFVQSVVfUVVFUllfT1BDT0RFX1dSSVRFX0FUVFIsDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFVRVJZX0FUVFJfSUROX0JPT1RfTFVf
RU4sIGluZGV4LCAwLCAmc2xvdCk7DQo+PiArICAgICAgIHVmc2hjZF9ycG1fcHV0X3N5bmMo
aGJhKTsNCj4+ICsgICAgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgICAgICAgIHJldCA9
IC1FSU5WQUw7DQo+PiArICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+PiArICAgICAgIH0N
Cj4+ICtvdXQ6DQo+PiArICAgICAgIHVwKCZoYmEtPmhvc3Rfc2VtKTsNCj4+ICsgICAgICAg
cmV0dXJuIHJldCA/IHJldCA6IGNvdW50Ow0KPj4gK30NCj4+ICsNCj4+ICAgI2RlZmluZSBV
RlNfQVRUUklCVVRFKF9uYW1lLCBfdW5hbWUpICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcDQo+PiAgIHN0YXRpYyBzc2l6ZV90IF9uYW1lIyNfc2hvdyhzdHJ1Y3QgZGV2
aWNlICpkZXYsICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+PiAgICAgICAg
ICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKSAgICAgICAgICAg
ICAgICAgICAgICAgXA0KPj4gQEAgLTEwNzcsOCArMTE0Miw4IEBAIG91dDogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPj4gICAgICAgICAgcmV0dXJuIHJldDsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4+ICAgfSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcDQo+PiAgIHN0YXRpYyBERVZJQ0VfQVRUUl9STyhfbmFtZSkNCj4+ICtzdGF0aWMgREVW
SUNFX0FUVFJfUlcoYm9vdF9sdW5fZW5hYmxlZCk7DQo+Pg0KPj4gLVVGU19BVFRSSUJVVEUo
Ym9vdF9sdW5fZW5hYmxlZCwgX0JPT1RfTFVfRU4pOw0KPj4gICBVRlNfQVRUUklCVVRFKG1h
eF9kYXRhX3NpemVfaHBiX3NpbmdsZV9jbWQsIF9NQVhfSFBCX1NJTkdMRV9DTUQpOw0KPj4g
ICBVRlNfQVRUUklCVVRFKGN1cnJlbnRfcG93ZXJfbW9kZSwgX1BPV0VSX01PREUpOw0KPj4g
ICBVRlNfQVRUUklCVVRFKGFjdGl2ZV9pY2NfbGV2ZWwsIF9BQ1RJVkVfSUNDX0xWTCk7DQo+
PiAtLQ0KPj4gMi4zNi4xDQo=
