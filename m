Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6014451A55A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353353AbiEDQ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiEDQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:26:01 -0400
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 09:22:24 PDT
Received: from mail.pre-sense.de (blockout.pre-sense.de [213.238.39.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CCC366B4;
        Wed,  4 May 2022 09:22:24 -0700 (PDT)
Received: from smtp.pre-sense.de (tetris_b.pre-sense.de [10.9.0.76])
        by mail.pre-sense.de (Postfix) with ESMTP id C76CC5E5EC;
        Wed,  4 May 2022 18:12:23 +0200 (CEST)
Received: from [192.168.37.21] (84.242.30.158.dynamic-pppoe.dt.ipv4.wtnet.de [84.242.30.158])
        by smtp.pre-sense.de (Postfix) with ESMTPS id 0BD191DF2;
        Wed,  4 May 2022 18:12:24 +0200 (CEST)
Message-ID: <64a7de55-8f93-8e7a-4102-26f7d4dbe1dc@pre-sense.de>
Date:   Wed, 4 May 2022 18:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Regression: CIFS umount fails since 14302ee33 with some servers
 (exit code 32)
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Aurelien Aptel <aaptel@suse.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
References: <715d745d-5a85-092a-68c2-b9b1dd8ad53e@leemhuis.info>
 <5fc82f02-be3a-6bb4-0800-aaf19a782655@leemhuis.info>
From:   Moritz Duge <duge@pre-sense.de>
Autocrypt: addr=duge@pre-sense.de; keydata=
 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
Organization: PRESENSE Technologies GmbH
In-Reply-To: <5fc82f02-be3a-6bb4-0800-aaf19a782655@leemhuis.info>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------osYFDXJN0RTZ0crL0W29qUCY"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------osYFDXJN0RTZ0crL0W29qUCY
Content-Type: multipart/mixed; boundary="------------kXnQYx9Zcl0OZkoyqBmrGBUI";
 protected-headers="v1"
From: Moritz Duge <duge@pre-sense.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Aurelien Aptel <aaptel@suse.com>, Ronnie Sahlberg <lsahlber@redhat.com>,
 Steve French <stfrench@microsoft.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Message-ID: <64a7de55-8f93-8e7a-4102-26f7d4dbe1dc@pre-sense.de>
Subject: Re: Regression: CIFS umount fails since 14302ee33 with some servers
 (exit code 32)
References: <715d745d-5a85-092a-68c2-b9b1dd8ad53e@leemhuis.info>
 <5fc82f02-be3a-6bb4-0800-aaf19a782655@leemhuis.info>
In-Reply-To: <5fc82f02-be3a-6bb4-0800-aaf19a782655@leemhuis.info>

--------------kXnQYx9Zcl0OZkoyqBmrGBUI
Content-Type: multipart/mixed; boundary="------------HP1rgS1mHeAAOMygkmDQckEr"

--------------HP1rgS1mHeAAOMygkmDQckEr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgVGhvcnN0ZW4sDQoNCkknbSBzdGlsbCB3YWl0aW5nIGZvciBhIHJlcGx5IGZyb20gUGF1
bC4NCg0KSSdtIG5vdCBhIGtlcm5lbCBkZXZlbG9wZXIgYW5kIEkgcmVwb3J0ZWQgZXZlcnl0
aGluZyBJIGtub3cgYWJvdXQNCnRoZSBidWcuIEluY2x1ZGluZyB0aGUgcmVzdWx0IG9mIGEg
R2l0IGJpc2VjdCwgc2hvd2luZyB0aGUNCnByb2JsZW1hdGljIGNvbW1pdC4NCg0KU28gY3Vy
cmVudGx5IEkgZG9uJ3Qgc2VlIG11Y2ggZWxzZSBJIGNhbiBkby4NCg0KDQpLaW5kIHJlZ2Fy
ZHMsDQpNb3JpdHoNCg0KDQpBbSAwNC4wNS4yMiB1bSAxNToxOSBzY2hyaWViIFRob3JzdGVu
IExlZW1odWlzOg0KPiBIaSwgdGhpcyBpcyB5b3VyIExpbnV4IGtlcm5lbCByZWdyZXNzaW9u
IHRyYWNrZXIuIFRvcC1wb3N0aW5nIGZvciBvbmNlLA0KPiB0byBtYWtlIHRoaXMgZWFzaWx5
IGFjY2Vzc2libGUgdG8gZXZlcnlvbmUuDQo+IA0KPiBQYXVsLCBNb3JpdHosIHdoYXQncyB0
aGUgc3RhdHVzIGhlcmU/IEl0IHNlZW1zIG5vdGhpbmcgaGFwcGVuZWQgYXQgYWxsDQo+IHNp
bmNlIGJlbG93IG1haWwuIFdhcyB0aGUgaXNzdWUgZml4ZWQ/IE9yIGRpZCBpdCBmYWxsIHRo
cm91Z2ggdGhlIGNyYWNrcz8NCj4gDQo+IENpYW8sIFRob3JzdGVuICh3ZWFyaW5nIGhpcyAn
dGhlIExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tlcicgaGF0KQ0KPiANCj4gUC5T
LjogQXMgdGhlIExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tlciBJIGRlYWwgd2l0
aCBhIGxvdCBvZg0KPiByZXBvcnRzIGFuZCBzb21ldGltZXMgbWlzcyBzb21ldGhpbmcgaW1w
b3J0YW50IHdoZW4gd3JpdGluZyBtYWlscyBsaWtlDQo+IHRoaXMuIElmIHRoYXQncyB0aGUg
Y2FzZSBoZXJlLCBkb24ndCBoZXNpdGF0ZSB0byB0ZWxsIG1lIGluIGEgcHVibGljDQo+IHJl
cGx5LCBpdCdzIGluIGV2ZXJ5b25lJ3MgaW50ZXJlc3QgdG8gc2V0IHRoZSBwdWJsaWMgcmVj
b3JkIHN0cmFpZ2h0Lg0KPiANCj4gI3JlZ3pib3QgcG9rZQ0K
--------------HP1rgS1mHeAAOMygkmDQckEr
Content-Type: application/pgp-keys; name="OpenPGP_0x8F88310D16CDB92E.asc"
Content-Disposition: attachment; filename="OpenPGP_0x8F88310D16CDB92E.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
S/Ei8x1yBkHyVw=3D=3D
=3D2jFE
-----END PGP PUBLIC KEY BLOCK-----

--------------HP1rgS1mHeAAOMygkmDQckEr--

--------------kXnQYx9Zcl0OZkoyqBmrGBUI--

--------------osYFDXJN0RTZ0crL0W29qUCY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEGkJ4nJCHkYc10aoWj4gxDRbNuS4FAmJypeYFAwAAAAAACgkQj4gxDRbNuS4i
DBAAtS4dEFOKgztnvEKebd6AoMPGjAsU/39ODmoImxlZoiKS8YGHtqpU7yNdMWjoVyvadEZHP7DU
ItbmdlIC/EqizC7vbkDAgC/lT42AkKESVDInfcZRHoIJCzECE9wmyHhbwidtJjGiJZA+duI1uSVZ
MdXzcAGBdG40jmunUSgJ626+0jp+H17SFxmE7PTKcI3+pFjIcWnNC0ktSLg0mRBgRs2M65FKplvq
A3hxRk+ZxrnMwKTiOamlJucQIAIcpbB5E0BlvqnV0LkPQzUqGpjY3W7Kbu2PspFEeUvUrFOMqLLU
3+Vcv86L9MWz5/7zKuC49DO+030prWaKCy4W3pvzGZKWxFG2cz+Ley1ZHIbfCdWPfEtL/QcbjJSk
WjxDgFNPYqRchk1DY1+uqa60wLEaFkU+s5pttHapCqAfWh1spIaOmbzpWcSSbDQo8zXXqqUZFrTp
qMhDXSam0syuc5/vvpMaeeOz6ccwdY2uV76o+Fi7olJVdX/Zh60SQe/XiiuvMt2aRQOqRk/7Tg5H
vA8OEX+yELM6JxheZ3D5kUWQ4D9kSqSTk90EDjDaj5jIpmCdOPqAq26DaOT7v2g+mWQrGXaO7G4z
j+6C5NvxmomuL0ko1uu4/CGFdqzaWNYMKN+qUGhL+TsKGW21i/AXANN9fbbpwqBnu85eC4ydi5/H
mUE=
=C5AZ
-----END PGP SIGNATURE-----

--------------osYFDXJN0RTZ0crL0W29qUCY--
