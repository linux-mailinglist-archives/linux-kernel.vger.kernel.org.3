Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5702D50656A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349210AbiDSHOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbiDSHOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:14:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6102E9E6;
        Tue, 19 Apr 2022 00:11:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 17C891F37D;
        Tue, 19 Apr 2022 07:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650352307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YWsoHdvGijiz2E0tFAMBnFdzxibxDqGsWjmzZn6KKaw=;
        b=I/yPomsZUHDQhZ+rQ06Vk79LvPOUFUE0apEbHvAVaNSz4a50/eTry5j0nXFNeiWqJc89Vx
        4rU5TneXRp8lsGmcXI3tlc54buASVsnKRLbZ5aiahBrstXaJCWj4rkN5BZDfTSm1YcESq2
        GZhrvlLJd0SAxhz37NWsSQI9YpxeDjM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2B1F132E7;
        Tue, 19 Apr 2022 07:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OYPYLbJgXmKORQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 19 Apr 2022 07:11:46 +0000
Message-ID: <521cad0a-d6ef-77a8-9258-1cf9d3b6d63d@suse.com>
Date:   Tue, 19 Apr 2022 09:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH rcu 04/11] kernel/smp: Provide boot-time timeout for CSD
 lock diagnostics
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
 <20220418225359.3945217-4-paulmck@kernel.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220418225359.3945217-4-paulmck@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------D0GS3lmZWKjnxqU11SmidYyo"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------D0GS3lmZWKjnxqU11SmidYyo
Content-Type: multipart/mixed; boundary="------------5T25XL3x1VVjY75FyAnu0oZL";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org,
 Rik van Riel <riel@surriel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <521cad0a-d6ef-77a8-9258-1cf9d3b6d63d@suse.com>
Subject: Re: [PATCH rcu 04/11] kernel/smp: Provide boot-time timeout for CSD
 lock diagnostics
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
 <20220418225359.3945217-4-paulmck@kernel.org>
In-Reply-To: <20220418225359.3945217-4-paulmck@kernel.org>

--------------5T25XL3x1VVjY75FyAnu0oZL
Content-Type: multipart/mixed; boundary="------------ZxIQcku5g8vTMgLTNl3zdqql"

--------------ZxIQcku5g8vTMgLTNl3zdqql
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDQuMjIgMDA6NTMsIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+IERlYnVnZ2lu
ZyBvZiBwcm9ibGVtcyBpbnZvbHZpbmcgaW5zYW5lbHkgbG9uZy1ydW5uaW5nIFNNSSBoYW5k
bGVycw0KPiBwcm9jZWVkcyBiZXR0ZXIgaWYgdGhlIENTRC1sb2NrIHRpbWVvdXQgY2FuIGJl
IGFkanVzdGVkLiAgVGhpcyBjb21taXQNCj4gdGhlcmVmb3JlIHByb3ZpZGVzIGEgbmV3IHNt
cC5jc2RfbG9ja190aW1lb3V0IGtlcm5lbCBib290IHBhcmFtZXRlcg0KPiB0aGF0IHNwZWNp
ZmllcyB0aGUgdGltZW91dCBpbiBtaWxsaXNlY29uZHMuICBUaGUgZGVmYXVsdCByZW1haW5z
IGF0IHRoZQ0KPiBwcmV2aW91c2x5IGhhcmQtY29kZWQgdmFsdWUgb2YgZml2ZSBzZWNvbmRz
Lg0KPiANCj4gQ2M6IFJpayB2YW4gUmllbCA8cmllbEBzdXJyaWVsLmNvbT4NCj4gQ2M6IFBl
dGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IEluZ28gTW9sbmFy
IDxtaW5nb0BrZXJuZWwub3JnPg0KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0
cm9uaXguZGU+DQo+IENjOiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIDxiaWdlYXN5QGxp
bnV0cm9uaXguZGU+DQo+IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4N
Cj4gLS0tDQo+ICAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVy
cy50eHQgfCAxMSArKysrKysrKysrKw0KPiAgIGtlcm5lbC9zbXAuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDcgKysrKystLQ0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBiL0Rv
Y3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+IGluZGV4
IDNmMWNjNWUzMTdlZC4uNjQ1YzRjMDAxYjE2IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiBAQCAtNTM3Nyw2
ICs1Mzc3LDE3IEBADQo+ICAgCXNtYXJ0Mj0JCVtIV10NCj4gICAJCQlGb3JtYXQ6IDxpbzE+
Wyw8aW8yPlssLi4uLDxpbzg+XV0NCj4gICANCj4gKwlzbXAuY3NkX2xvY2tfdGltZW91dD0g
W0tOTF0NCj4gKwkJCVNwZWNpZnkgdGhlIHBlcmlvZCBvZiB0aW1lIGluIG1pbGxpc2Vjb25k
cw0KPiArCQkJdGhhdCBzbXBfY2FsbF9mdW5jdGlvbigpIGFuZCBmcmllbmRzIHdpbGwgd2Fp
dA0KPiArCQkJZm9yIGEgQ1BVIHRvIHJlbGVhc2UgdGhlIENTRCBsb2NrLiAgVGhpcyBpcw0K
PiArCQkJdXNlZnVsIHdoZW4gZGlhZ25vc2luZyBidWdzIGludm9sdmluZyBDUFVzDQo+ICsJ
CQlkaXNhYmxpbmcgaW50ZXJydXB0cyBmb3IgZXh0ZW5kZWQgcGVyaW9kcw0KPiArCQkJb2Yg
dGltZS4gIERlZmF1bHRzIHRvIDUsMDAwIG1pbGxpc2Vjb25kcywgYW5kDQo+ICsJCQlzZXR0
aW5nIGEgdmFsdWUgb2YgemVybyBkaXNhYmxlcyB0aGlzIGZlYXR1cmUuDQo+ICsJCQlUaGlz
IGZlYXR1cmUgbWF5IGJlIG1vcmUgZWZmaWNpZW50bHkgZGlzYWJsZWQNCj4gKwkJCXVzaW5n
IHRoZSBjc2Rsb2NrX2RlYnVnLSBrZXJuZWwgcGFyYW1ldGVyLg0KPiArDQo+ICAgCXNtc2Mt
aXJjYzIubm9wbnAJW0hXXSBEb24ndCB1c2UgUE5QIHRvIGRpc2NvdmVyIFNNQyBkZXZpY2Vz
DQo+ICAgCXNtc2MtaXJjYzIuaXJjY19jZmc9CVtIV10gRGV2aWNlIGNvbmZpZ3VyYXRpb24g
SS9PIHBvcnQNCj4gICAJc21zYy1pcmNjMi5pcmNjX3Npcj0JW0hXXSBTSVIgYmFzZSBJL08g
cG9ydA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NtcC5jIGIva2VybmVsL3NtcC5jDQo+IGlu
ZGV4IDAxYTdjMTcwNmE1OC4uZDgyNDM5YmFjNDAxIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwv
c21wLmMNCj4gKysrIGIva2VybmVsL3NtcC5jDQo+IEBAIC0xODMsNyArMTgzLDkgQEAgc3Rh
dGljIERFRklORV9QRVJfQ1BVKHNtcF9jYWxsX2Z1bmNfdCwgY3VyX2NzZF9mdW5jKTsNCj4g
ICBzdGF0aWMgREVGSU5FX1BFUl9DUFUodm9pZCAqLCBjdXJfY3NkX2luZm8pOw0KPiAgIHN0
YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1Y3QgY2ZkX3NlcV9sb2NhbCwgY2ZkX3NlcV9sb2Nh
bCk7DQo+ICAgDQo+IC0jZGVmaW5lIENTRF9MT0NLX1RJTUVPVVQgKDVVTEwgKiBOU0VDX1BF
Ul9TRUMpDQo+ICtzdGF0aWMgdWxvbmcgY3NkX2xvY2tfdGltZW91dCA9IDUwMDA7ICAvKiBD
U0QgbG9jayB0aW1lb3V0IGluIG1pbGxpc2Vjb25kcy4gKi8NCj4gK21vZHVsZV9wYXJhbShj
c2RfbG9ja190aW1lb3V0LCB1bG9uZywgMDQ0NCk7DQo+ICsNCj4gICBzdGF0aWMgYXRvbWlj
X3QgY3NkX2J1Z19jb3VudCA9IEFUT01JQ19JTklUKDApOw0KPiAgIHN0YXRpYyB1NjQgY2Zk
X3NlcTsNCj4gICANCj4gQEAgLTMyOSw2ICszMzEsNyBAQCBzdGF0aWMgYm9vbCBjc2RfbG9j
a193YWl0X3Rvb2xvbmcoc3RydWN0IF9fY2FsbF9zaW5nbGVfZGF0YSAqY3NkLCB1NjQgdHMw
LCB1NjQgKg0KPiAgIAl1NjQgdHMyLCB0c19kZWx0YTsNCj4gICAJY2FsbF9zaW5nbGVfZGF0
YV90ICpjcHVfY3VyX2NzZDsNCj4gICAJdW5zaWduZWQgaW50IGZsYWdzID0gUkVBRF9PTkNF
KGNzZC0+bm9kZS51X2ZsYWdzKTsNCj4gKwl1bnNpZ25lZCBsb25nIGxvbmcgY3NkX2xvY2tf
dGltZW91dF9ucyA9IGNzZF9sb2NrX3RpbWVvdXQgKiBOU0VDX1BFUl9NU0VDOw0KPiAgIA0K
PiAgIAlpZiAoIShmbGFncyAmIENTRF9GTEFHX0xPQ0spKSB7DQo+ICAgCQlpZiAoIXVubGlr
ZWx5KCpidWdfaWQpKQ0KPiBAQCAtMzQxLDcgKzM0NCw3IEBAIHN0YXRpYyBib29sIGNzZF9s
b2NrX3dhaXRfdG9vbG9uZyhzdHJ1Y3QgX19jYWxsX3NpbmdsZV9kYXRhICpjc2QsIHU2NCB0
czAsIHU2NCAqDQo+ICAgDQo+ICAgCXRzMiA9IHNjaGVkX2Nsb2NrKCk7DQo+ICAgCXRzX2Rl
bHRhID0gdHMyIC0gKnRzMTsNCj4gLQlpZiAobGlrZWx5KHRzX2RlbHRhIDw9IENTRF9MT0NL
X1RJTUVPVVQpKQ0KPiArCWlmIChsaWtlbHkodHNfZGVsdGEgPD0gY3NkX2xvY2tfdGltZW91
dF9ucyB8fCBjc2RfbG9ja190aW1lb3V0X25zIDw9IDApKQ0KDQpjc2RfbG9ja190aW1lb3V0
X25zIGlzIHVuc2lnbmVkLCBzbyAiY3NkX2xvY2tfdGltZW91dF9ucyA8PSAwIiBzaG91bGQg
YmUgcmF0aGVyDQoiY3NkX2xvY2tfdGltZW91dF9ucyA9PSAwIi4NCg0KV2l0aCB0aGF0IGZp
eGVkIHlvdSBjYW4gYWRkIG15DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------ZxIQcku5g8vTMgLTNl3zdqql
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ZxIQcku5g8vTMgLTNl3zdqql--

--------------5T25XL3x1VVjY75FyAnu0oZL--

--------------D0GS3lmZWKjnxqU11SmidYyo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJeYLIFAwAAAAAACgkQsN6d1ii/Ey9v
igf+PeJUbQBi+Zc2gtKAel1emDs62CQiryXKyAYnTjQaEtYUtJDoda00ED7s4gOMdGvmclgmyiFV
UkVwwoh1XQhCfpevJcBA4Ygjx05E1flbgfvAD4FvPAlJ0LkwZjY2dta/Y9Q9aRGJ88tBua8OAcN1
yBHMAaPKwTIiV/YnoH4qG40qt74BHP7NBMjt/FvGXx192Sd9hb3OGxffvjnA18Z2yjKk8Vgc31ii
/hp8U8pWyyotmKdLUx00vlTaYe2FqXdKO8qolCirXuj7GMN2KpbEW5VNYv02iiiYYyQD08CQtytG
FB92iiNKp5NIGUjJWiV/zbq0N/o8Iec5NOq0h+NqcQ==
=esuf
-----END PGP SIGNATURE-----

--------------D0GS3lmZWKjnxqU11SmidYyo--
