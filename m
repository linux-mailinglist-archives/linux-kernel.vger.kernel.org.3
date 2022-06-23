Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7509557C60
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiFWNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiFWNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:00:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70374BFFD;
        Thu, 23 Jun 2022 06:00:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8046E21D51;
        Thu, 23 Jun 2022 13:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655989216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F5rp4biCzxhXRUFFWAT3ZfHsc7jcuLns1eT+TYiLgcU=;
        b=NqsE+R3A+G8jfvqHrFsMuoKCkpU3h16m/I3olzV12/gzWJYQnZry4r7vqoqr6NhswyO6h2
        H6QYZ7NaQx9JdHJiyXiAgpf+4bobmSp/YZsZ8Td5v6o2WBBo9q8xRUBq5rv/QmmTDOHPKw
        vTS61WJ9aH0xaigngd/NdcuTQGPeK/E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A20B13461;
        Thu, 23 Jun 2022 13:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id biyuDOBjtGITGwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Jun 2022 13:00:16 +0000
Message-ID: <7ec07c28-479a-4fa6-cd9c-dcd0b71e3f42@suse.com>
Date:   Thu, 23 Jun 2022 15:00:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] xen-blkfront: Handle NULL gendisk
Content-Language: en-US
To:     Jason Andryuk <jandryuk@gmail.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
References: <20220601195341.28581-1-jandryuk@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220601195341.28581-1-jandryuk@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DRCs634Vc3nA0yR6EDITkIC9"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------DRCs634Vc3nA0yR6EDITkIC9
Content-Type: multipart/mixed; boundary="------------l05qm07gdYiFOKB7dc7Wllsf";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jason Andryuk <jandryuk@gmail.com>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?=
 <roger.pau@citrix.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= <marmarek@invisiblethingslab.com>
Message-ID: <7ec07c28-479a-4fa6-cd9c-dcd0b71e3f42@suse.com>
Subject: Re: [PATCH] xen-blkfront: Handle NULL gendisk
References: <20220601195341.28581-1-jandryuk@gmail.com>
In-Reply-To: <20220601195341.28581-1-jandryuk@gmail.com>

--------------l05qm07gdYiFOKB7dc7Wllsf
Content-Type: multipart/mixed; boundary="------------OBLMJDStp9e1aD6PHxmVHL9f"

--------------OBLMJDStp9e1aD6PHxmVHL9f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMDYuMjIgMjE6NTMsIEphc29uIEFuZHJ5dWsgd3JvdGU6DQo+IFdoZW4gYSBWQkQg
aXMgbm90IGZ1bGx5IGNyZWF0ZWQgYW5kIHRoZW4gY2xvc2VkLCB0aGUga2VybmVsIGNhbiBo
YXZlIGENCj4gTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlOg0KPiANCj4gVGhlIHJlcHJvZHVj
ZXIgaXMgdHJpdmlhbDoNCj4gDQo+IFt1c2VyQGRvbTAgfl0kIHN1ZG8geGwgYmxvY2stYXR0
YWNoIHdvcmsgYmFja2VuZD1zeXMtdXNiIHZkZXY9eHZkaSB0YXJnZXQ9L2Rldi9zZHoNCj4g
W3VzZXJAZG9tMCB+XSQgeGwgYmxvY2stbGlzdCB3b3JrDQo+IFZkZXYgIEJFICBoYW5kbGUg
c3RhdGUgZXZ0LWNoIHJpbmctcmVmIEJFLXBhdGgNCj4gNTE3MTIgMCAgIDI0MSAgICA0ICAg
ICAtMSAgICAgLTEgICAgICAgL2xvY2FsL2RvbWFpbi8wL2JhY2tlbmQvdmJkLzI0MS81MTcx
Mg0KPiA1MTcyOCAwICAgMjQxICAgIDQgICAgIC0xICAgICAtMSAgICAgICAvbG9jYWwvZG9t
YWluLzAvYmFja2VuZC92YmQvMjQxLzUxNzI4DQo+IDUxNzQ0IDAgICAyNDEgICAgNCAgICAg
LTEgICAgIC0xICAgICAgIC9sb2NhbC9kb21haW4vMC9iYWNrZW5kL3ZiZC8yNDEvNTE3NDQN
Cj4gNTE3NjAgMCAgIDI0MSAgICA0ICAgICAtMSAgICAgLTEgICAgICAgL2xvY2FsL2RvbWFp
bi8wL2JhY2tlbmQvdmJkLzI0MS81MTc2MA0KPiA1MTg0MCAzICAgMjQxICAgIDMgICAgIC0x
ICAgICAtMSAgICAgICAvbG9jYWwvZG9tYWluLzMvYmFja2VuZC92YmQvMjQxLzUxODQwDQo+
ICAgICAgICAgICAgICAgICAgIF4gbm90ZSBzdGF0ZSwgdGhlIC9kZXYvc2R6IGRvZXNuJ3Qg
ZXhpc3QgaW4gdGhlIGJhY2tlbmQNCj4gDQo+IFt1c2VyQGRvbTAgfl0kIHN1ZG8geGwgYmxv
Y2stZGV0YWNoIHdvcmsgeHZkaQ0KPiBbdXNlckBkb20wIH5dJCB4bCBibG9jay1saXN0IHdv
cmsNCj4gVmRldiAgQkUgIGhhbmRsZSBzdGF0ZSBldnQtY2ggcmluZy1yZWYgQkUtcGF0aA0K
PiB3b3JrIGlzIGFuIGludmFsaWQgZG9tYWluIGlkZW50aWZpZXINCj4gDQo+IEFuZCBpdHMg
Y29uc29sZSBoYXM6DQo+IA0KPiBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwNTANCj4gUEdEIDgwMDAwMDAwZWRlYmIwNjcg
UDREIDgwMDAwMDAwZWRlYmIwNjcgUFVEIGVkZWMyMDY3IFBNRCAwDQo+IE9vcHM6IDAwMDAg
WyMxXSBQUkVFTVBUIFNNUCBQVEkNCj4gQ1BVOiAxIFBJRDogNTIgQ29tbTogeGVud2F0Y2gg
Tm90IHRhaW50ZWQgNS4xNi4xOC0yLjQzLmZjMzIucXViZXMueDg2XzY0ICMxDQo+IFJJUDog
MDAxMDpibGtfbXFfc3RvcF9od19xdWV1ZXMrMHg1LzB4NDANCj4gQ29kZTogMDAgNDggODMg
ZTAgZmQgODMgYzMgMDEgNDggODkgODUgYTggMDAgMDAgMDAgNDEgMzkgNWMgMjQgNTAgNzcg
YzAgNWIgNWQgNDEgNWMgNDEgNWQgYzMgYzMgMGYgMWYgODAgMDAgMDAgMDAgMDAgMGYgMWYg
NDQgMDAgMDAgPDhiPiA0NyA1MCA4NSBjMCA3NCAzMiA0MSA1NCA0OSA4OSBmYyA1NSA1MyAz
MSBkYiA0OSA4YiA0NCAyNCA0OCA0OA0KPiBSU1A6IDAwMTg6ZmZmZmM5MDAwMGJjZmU5OCBF
RkxBR1M6IDAwMDEwMjkzDQo+IFJBWDogZmZmZmZmZmZjMDAwODM3MCBSQlg6IDAwMDAwMDAw
MDAwMDAwMDUgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFJEWDogMDAwMDAwMDAwMDAwMDAw
MCBSU0k6IDAwMDAwMDAwMDAwMDAwMDUgUkRJOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFJCUDog
ZmZmZjg4ODAwNzc1ZjAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiBmZmZmODg4MDA2
ZTYyMGI4DQo+IFIxMDogZmZmZjg4ODAwNmU2MjBiMCBSMTE6IGYwMDAwMDAwMDAwMDAwMDAg
UjEyOiBmZmZmODg4MGJmZjM5MDAwDQo+IFIxMzogZmZmZjg4ODBiZmYzOTAwMCBSMTQ6IDAw
MDAwMDAwMDAwMDAwMDAgUjE1OiBmZmZmODg4MDA2MDRiZTAwDQo+IEZTOiAgMDAwMDAwMDAw
MDAwMDAwMCgwMDAwKSBHUzpmZmZmODg4MGYzMzAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAw
MDAwMDAwMDANCj4gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4
MDA1MDAzMw0KPiBDUjI6IDAwMDAwMDAwMDAwMDAwNTAgQ1IzOiAwMDAwMDAwMGU5MzJlMDAy
IENSNDogMDAwMDAwMDAwMDM3MDZlMA0KPiBDYWxsIFRyYWNlOg0KPiAgIDxUQVNLPg0KPiAg
IGJsa2JhY2tfY2hhbmdlZCsweDk1LzB4MTM3IFt4ZW5fYmxrZnJvbnRdDQo+ICAgPyByZWFk
X3JlcGx5KzB4MTYwLzB4MTYwDQo+ICAgeGVud2F0Y2hfdGhyZWFkKzB4YzAvMHgxYTANCj4g
ICA/IGRvX3dhaXRfaW50cl9pcnErMHhhMC8weGEwDQo+ICAga3RocmVhZCsweDE2Yi8weDE5
MA0KPiAgID8gc2V0X2t0aHJlYWRfc3RydWN0KzB4NDAvMHg0MA0KPiAgIHJldF9mcm9tX2Zv
cmsrMHgyMi8weDMwDQo+ICAgPC9UQVNLPg0KPiBNb2R1bGVzIGxpbmtlZCBpbjogc25kX3Nl
cV9kdW1teSBzbmRfaHJ0aW1lciBzbmRfc2VxIHNuZF9zZXFfZGV2aWNlIHNuZF90aW1lciBz
bmQgc291bmRjb3JlIGlwdF9SRUpFQ1QgbmZfcmVqZWN0X2lwdjQgeHRfc3RhdGUgeHRfY29u
bnRyYWNrIG5mdF9jb3VudGVyIG5mdF9jaGFpbl9uYXQgeHRfTUFTUVVFUkFERSBuZl9uYXQg
bmZfY29ubnRyYWNrIG5mX2RlZnJhZ19pcHY2IG5mX2RlZnJhZ19pcHY0IG5mdF9jb21wYXQg
bmZfdGFibGVzIG5mbmV0bGluayBpbnRlbF9yYXBsX21zciBpbnRlbF9yYXBsX2NvbW1vbiBj
cmN0MTBkaWZfcGNsbXVsIGNyYzMyX3BjbG11bCBjcmMzMmNfaW50ZWwgZ2hhc2hfY2xtdWxu
aV9pbnRlbCB4ZW5fbmV0ZnJvbnQgcGNzcGtyIHhlbl9zY3NpYmFjayB0YXJnZXRfY29yZV9t
b2QgeGVuX25ldGJhY2sgeGVuX3ByaXZjbWQgeGVuX2dudGRldiB4ZW5fZ250YWxsb2MgeGVu
X2Jsa2JhY2sgeGVuX2V2dGNobiBpcG1pX2RldmludGYgaXBtaV9tc2doYW5kbGVyIGZ1c2Ug
YnBmX3ByZWxvYWQgaXBfdGFibGVzIG92ZXJsYXkgeGVuX2Jsa2Zyb250DQo+IENSMjogMDAw
MDAwMDAwMDAwMDA1MA0KPiAtLS1bIGVuZCB0cmFjZSA3YmM5NTk3ZmQwNmFlODlkIF0tLS0N
Cj4gUklQOiAwMDEwOmJsa19tcV9zdG9wX2h3X3F1ZXVlcysweDUvMHg0MA0KPiBDb2RlOiAw
MCA0OCA4MyBlMCBmZCA4MyBjMyAwMSA0OCA4OSA4NSBhOCAwMCAwMCAwMCA0MSAzOSA1YyAy
NCA1MCA3NyBjMCA1YiA1ZCA0MSA1YyA0MSA1ZCBjMyBjMyAwZiAxZiA4MCAwMCAwMCAwMCAw
MCAwZiAxZiA0NCAwMCAwMCA8OGI+IDQ3IDUwIDg1IGMwIDc0IDMyIDQxIDU0IDQ5IDg5IGZj
IDU1IDUzIDMxIGRiIDQ5IDhiIDQ0IDI0IDQ4IDQ4DQo+IFJTUDogMDAxODpmZmZmYzkwMDAw
YmNmZTk4IEVGTEFHUzogMDAwMTAyOTMNCj4gUkFYOiBmZmZmZmZmZmMwMDA4MzcwIFJCWDog
MDAwMDAwMDAwMDAwMDAwNSBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANCj4gUkRYOiAwMDAwMDAw
MDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAwMDAwNSBSREk6IDAwMDAwMDAwMDAwMDAwMDAN
Cj4gUkJQOiBmZmZmODg4MDA3NzVmMDAwIFIwODogMDAwMDAwMDAwMDAwMDAwMSBSMDk6IGZm
ZmY4ODgwMDZlNjIwYjgNCj4gUjEwOiBmZmZmODg4MDA2ZTYyMGIwIFIxMTogZjAwMDAwMDAw
MDAwMDAwMCBSMTI6IGZmZmY4ODgwYmZmMzkwMDANCj4gUjEzOiBmZmZmODg4MGJmZjM5MDAw
IFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IGZmZmY4ODgwMDYwNGJlMDANCj4gRlM6ICAw
MDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4ODgwZjMzMDAwMDAoMDAwMCkga25sR1M6
MDAwMDAwMDAwMDAwMDAwMA0KPiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAw
MDAwMDAwMDgwMDUwMDMzDQo+IENSMjogMDAwMDAwMDAwMDAwMDA1MCBDUjM6IDAwMDAwMDAw
ZTkzMmUwMDIgQ1I0OiAwMDAwMDAwMDAwMzcwNmUwDQo+IEtlcm5lbCBwYW5pYyAtIG5vdCBz
eW5jaW5nOiBGYXRhbCBleGNlcHRpb24NCj4gS2VybmVsIE9mZnNldDogZGlzYWJsZWQNCj4g
DQo+IGluZm8tPnJxIGFuZCBpbmZvLT5nZCBhcmUgb25seSBzZXQgaW4gYmxrZnJvbnRfY29u
bmVjdCgpLCB3aGljaCBpcw0KPiBjYWxsZWQgZm9yIHN0YXRlIDQgKFhlbmJ1c1N0YXRlQ29u
bmVjdGVkKS4gIEd1YXJkIGFnYWluc3QgdXNpbmcgTlVMTA0KPiB2YXJpYWJsZXMgaW4gYmxr
ZnJvbnRfY2xvc2luZygpIHRvIGF2b2lkIHRoZSBpc3N1ZS4NCj4gDQo+IFRoZSByZXN0IG9m
IGJsa2Zyb250X2Nsb3NpbmcgbG9va3Mgb2theS4gIElmIGluZm8tPm5yX3JpbmdzIGlzIDAs
IHRoZW4NCj4gZm9yX2VhY2hfcmluZm8gd29uJ3QgZG8gYW55dGhpbmcuDQo+IA0KPiBibGtm
cm9udF9yZW1vdmUgYWxzbyBuZWVkcyB0byBjaGVjayBmb3Igbm9uLU5VTEwgcG9pbnRlcnMg
YmVmb3JlDQo+IGNsZWFuaW5nIHVwIHRoZSBnZW5kaXNrIGFuZCByZXF1ZXN0IHF1ZXVlLg0K
PiANCj4gRml4ZXM6IDA1ZDY5ZDk1MGQ5ZCAieGVuLWJsa2Zyb250OiBzYW5pdGl6ZSB0aGUg
cmVtb3ZhbCBzdGF0ZSBtYWNoaW5lIg0KPiBSZXBvcnRlZC1ieTogTWFyZWsgTWFyY3p5a293
c2tpLUfDs3JlY2tpIDxtYXJtYXJla0BpbnZpc2libGV0aGluZ3NsYWIuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKYXNvbiBBbmRyeXVrIDxqYW5kcnl1a0BnbWFpbC5jb20+DQoNClB1c2hl
ZCB0byB4ZW4vdGlwLmdpdCBmb3ItbGludXMtNS4xOWENCg0KDQpKdWVyZ2VuDQo=
--------------OBLMJDStp9e1aD6PHxmVHL9f
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------OBLMJDStp9e1aD6PHxmVHL9f--

--------------l05qm07gdYiFOKB7dc7Wllsf--

--------------DRCs634Vc3nA0yR6EDITkIC9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmK0Y98FAwAAAAAACgkQsN6d1ii/Ey+B
3Af+OlWAew+/rVw9xQNVq3C6Rxh/irHSZKtoDD1WkEH8nbIsVafo7VGa6jHIZF9V4oNWBk7b2D1Y
gtdrram4DlL3XBaDPpbR9LMY4sVcfJaNomL5p1zmK/fNEXgZcqpNMaeuHxoJTDUYabe38/6LJaYJ
OKMPFu6uyfEWI7z05EDDKLy0VtYy/GtlMn0YzMk1NcR0Oc7s1lIHfXthlNW69ixsEI3dPa9WKdj1
IZzm3IJQRYH00few3/lZNbZdPaanMaP/pZEMlNMPp2yqhCdIEEBotuWmJuTRBi7FK34M37j/cJYp
Xp7Xktepq6jBTUbhXhDS//yeDrcBIqGW+qqUVppZzQ==
=tToZ
-----END PGP SIGNATURE-----

--------------DRCs634Vc3nA0yR6EDITkIC9--
