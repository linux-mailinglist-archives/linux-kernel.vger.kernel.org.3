Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6414147EF43
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352800AbhLXNvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:51:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51976 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbhLXNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:51:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BODouiJ025195;
        Fri, 24 Dec 2021 07:50:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640353856;
        bh=atzD/w/TVai0FPN0B6eJVShepwKKCijB+8dorelxp5c=;
        h=Date:From:To:CC:Subject;
        b=m0tOaN+VmTI2pIxZkGNq5WtrZ0YIB9qt/aqI9PCoBbPThPkOmxkxq8YjHLThTvsl/
         NJ9bTudibLGWLDxNQdgSzPe8wFVZActUk28JcTZLeUpBWAlJ/Dm9gXDm7pPnrRfcef
         FllQ3cqHyLg4nIaN+qHziGkIfcq7Fv8HEq8NLG8s=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BODouXP106066
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Dec 2021 07:50:56 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 24
 Dec 2021 07:50:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 24 Dec 2021 07:50:56 -0600
Received: from [172.24.145.18] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BODosuO057338;
        Fri, 24 Dec 2021 07:50:55 -0600
Message-ID: <cbb28885-fb36-2847-d691-cf1dc5e5c386@ti.com>
Date:   Fri, 24 Dec 2021 19:20:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     MTD Maling List <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?=5bGIT_PULL=5d_CFI_and_HyperFlash_changes_for_v5=2e17-rc1?=
 =?UTF-8?B?4oCL?=
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="------------n11j1AkCcdbMt7v4MEl7v6m6"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------n11j1AkCcdbMt7v4MEl7v6m6
Content-Type: multipart/mixed; boundary="------------nuZVpgtA9NFdZC4thV9SvGhK";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>
Cc: MTD Maling List <linux-mtd@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <cbb28885-fb36-2847-d691-cf1dc5e5c386@ti.com>
Subject: =?UTF-8?Q?=5bGIT_PULL=5d_CFI_and_HyperFlash_changes_for_v5=2e17-rc1?=
 =?UTF-8?B?4oCL?=

--------------nuZVpgtA9NFdZC4thV9SvGhK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgIE1pcXVlbCwgUmljaGFyZCwNCg0KSGVyZSBpcyB0aGUgSHlwZXJCdXMvSHlwZXJGbGFz
aCByZWxhdGVkIFBSIGZvciB2NS4xNy1yYzEuIFRoYW5rcyENCg0KUmVnYXJkcw0KVmlnbmVz
aA0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGZhNTViN2RjZGM0M2Mx
YWExYmExMmJjYTlkMmRkNDMxOGMyYTBkYmY6DQoNCiAgIExpbnV4IDUuMTYtcmMxICgyMDIx
LTExLTE0IDEzOjU2OjUyIC0wODAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVw
b3NpdG9yeSBhdDoNCg0KICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvbXRkL2xpbnV4LmdpdCB0YWdzL2NmaS9mb3ItNS4xNw0KDQpmb3IgeW91
IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYmFhZjk2NWY5NDMwODMwMWQyZGM1NTRkNzJhODdk
NzQzMmNkNWNlNjoNCg0KICAgbXRkOiBoeXBlcmJ1czogcnBjLWlmOiBmaXggYnVnIGluIHJw
Y2lmX2hiX3JlbW92ZSAoMjAyMS0xMS0yMSAxNzoyMTo0MCArMDUzMCkNCg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KSHlwZXJidXMgY2hhbmdlcyBmb3IgdjUuMTctcmMxDQoNCkh5cGVyYnVzIGNoYW5nZXM6
DQoNCkNvdXBsZSBvZiBmaXhlcyBpbiBSZW5lc2FzIGh5cGVyYnVzIHJwYy1pZiBkcml2ZXIg
dG8gYXZvaWQgY3Jhc2ggb24NCm1vZHVsZSByZW1vdmUgYW5kIGZvciBtaXNzaW5nIGNoZWNr
IGZvciBlcnJvciB2YWx1ZSBpbiBwcm9iZS4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KR2VvcmdlIEcuIERh
dmlzICgxKToNCiAgICAgICBtdGQ6IGh5cGVyYnVzOiBycGMtaWY6IGZpeCBidWcgaW4gcnBj
aWZfaGJfcmVtb3ZlDQoNCkxhZCBQcmFiaGFrYXIgKDEpOg0KICAgICAgIG10ZDogaHlwZXJi
dXM6IHJwYy1pZjogQ2hlY2sgcmV0dXJuIHZhbHVlIG9mIHJwY2lmX3N3X2luaXQoKQ0KDQog
IGRyaXZlcnMvbXRkL2h5cGVyYnVzL3JwYy1pZi5jIHwgOCArKysrKy0tLQ0KICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQotLQ0KUmVnYXJk
cw0KVmlnbmVzaA0K

--------------nuZVpgtA9NFdZC4thV9SvGhK--

--------------n11j1AkCcdbMt7v4MEl7v6m6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmHF0D0FAwAAAAAACgkQxEYeRXyRFuMv
sQgApD4ZRkT87u6AZ6A4ONUL6IOJwXhXI09rZ99Ysd/GVQeOrOgh+6NtFpYNfMxy8u+5mptNHjft
G0Pi/K+T29i3bhSGZKpIzJ/hBbuyJ9zj3fOUSiqOpCVZdgP4eg2E1+78vadbQKz3SViZROoIxEYZ
9ZrWIWSy0q9HyvyFeojy1CkTJK+Zer+Px5yEpZFkprlHmi/1KJ4aWKs9hqokv0+JiA4JLM00Jjx2
Sbh5QjTysg/DALJ7Ln0zLNdu56q74Bm3jZ+w7Suo2gSB1jlDIjXaIeoKzT9qUnlT3MQ61R4tycbX
32tcoLSt7GPq04ZTkWTne5I07Kgs7SXnAfOUe40vRg==
=G+50
-----END PGP SIGNATURE-----

--------------n11j1AkCcdbMt7v4MEl7v6m6--
