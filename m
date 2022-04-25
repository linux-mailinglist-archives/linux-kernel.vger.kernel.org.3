Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952AA50DA6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbiDYHvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbiDYHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:51:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1947863D2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:47:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D1053210E3;
        Mon, 25 Apr 2022 07:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650872870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOZ4B64PQp3QRZDkrypCGMf/bZ0hCmFjlGKE4h24+mM=;
        b=PK0exDEEY6G0RKSVAYgvQ3K/zqysbdYeTj5P2OWOYQeGD4yDVU0gcaTHnBLurBsf5QgfoT
        fAH14WNJ9QRhLfjDUm8YmHYbC1hcVVvzXyUCWIBIkc3plaYi3dYcjyxRuQBNzQFZpqmJ1T
        TXZUceooP1N5NHCaZflRC187gXd97IY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E2A213AED;
        Mon, 25 Apr 2022 07:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id anV8ESZSZmLGaQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 25 Apr 2022 07:47:50 +0000
Message-ID: <abc5d23d-3d38-d198-4646-e886df2e83d4@suse.com>
Date:   Mon, 25 Apr 2022 09:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
 <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RTRugpKcpQELUP0Gus1cI1VK"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RTRugpKcpQELUP0Gus1cI1VK
Content-Type: multipart/mixed; boundary="------------XSdyHfDZ8NSbH9riXD1TXs2C";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr <olekstysh@gmail.com>, Christoph Hellwig <hch@infradead.org>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <abc5d23d-3d38-d198-4646-e886df2e83d4@suse.com>
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
 <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
In-Reply-To: <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>

--------------XSdyHfDZ8NSbH9riXD1TXs2C
Content-Type: multipart/mixed; boundary="------------AUotc6vkbgM0g5J5WIJwHZMe"

--------------AUotc6vkbgM0g5J5WIJwHZMe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDQuMjIgMTg6NTMsIE9sZWtzYW5kciB3cm90ZToNCj4gDQo+IE9uIDIzLjA0LjIy
IDE5OjQwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gDQo+IA0KPiBIZWxsbyBDaHJp
c3RvcGgNCj4gDQo+PiBQbGVhc2Ugc3BsaXQgdGhpcyBpbnRvIG9uZSBwYXRjaCB0aGF0IGNy
ZWF0ZXMgZ3JhbnQtZG1hLW9wcywgYW5kIGFub3RoZXINCj4+IHRoYXQgc2V0cyB1cCB0aGUg
dmlydGlvIHJlc3RyaWN0ZWQgYWNjZXNzIGhlbHBlcnMuDQo+IA0KPiANCj4gU291bmRzIHJl
YXNvbmFibGUsIHdpbGwgZG86DQo+IA0KPiAxLiBncmFudC1kbWEtb3BzLmMgd2l0aCBjb25m
aWcgWEVOX0dSQU5UX0RNQV9PUFMNCj4gDQo+IDIuIGFyY2hfaGFzX3Jlc3RyaWN0ZWRfdmly
dGlvX21lbW9yeV9hY2Nlc3MoKSB3aXRoIGNvbmZpZyBYRU5fVklSVElPDQo+IA0KPiANCj4+
DQo+Pj4gKw0KPj4+ICsjaWZkZWYgQ09ORklHX0FSQ0hfSEFTX1JFU1RSSUNURURfVklSVElP
X01FTU9SWV9BQ0NFU1MNCj4+PiAraW50IGFyY2hfaGFzX3Jlc3RyaWN0ZWRfdmlydGlvX21l
bW9yeV9hY2Nlc3Modm9pZCkNCj4+PiArew0KPj4+ICvCoMKgwqAgcmV0dXJuICh4ZW5faGFz
X3Jlc3RyaWN0ZWRfdmlydGlvX21lbW9yeV9hY2Nlc3MoKSB8fA0KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0dVRVNUX01FTV9FTkNSWVBU
KSk7DQo+Pj4gK30NCj4+IFNvIGluc3RlYWQgb2YgaGFyZGNvZGluZyBYZW4gaGVyZSwgdGhp
cyBzZWVtcyBsaWtlIGEgY2FuZGlkYXRlIGZvcg0KPj4gYW5vdGhlciBjY19wbGF0Zm9ybV9o
YXMgZmxhZy4NCj4gDQo+IA0KPiBJIGhhdmUgYSBsaW1pdGVkIGtub3dsZWRnZSBvZiB4ODYg
YW5kIFhlbiBvbiB4ODYuDQo+IA0KPiBXb3VsZCB0aGUgWGVuIHNwZWNpZmljIGJpdHMgZml0
IGludG8gQ29uZmlkZW50aWFsIENvbXB1dGluZyBQbGF0Zm9ybSBjaGVja3M/IEkgDQo+IHdp
bGwgbGV0IEp1ZXJnZW4vQm9yaXMgY29tbWVudCBvbiB0aGlzLg0KDQpJIGRvbid0IHRoaW5r
IGNjX3BsYXRmb3JtX2hhcyB3b3VsZCBiZSBjb3JyZWN0IGhlcmUuIFhlbiBjZXJ0YWlubHkN
CnByb3ZpZGVzIG1vcmUgaXNvbGF0aW9uIGJldHdlZW4gZ3Vlc3RzIGFuZCBkb20wLCBidXQg
IkNvbmZpZGVudGlhbA0KQ29tcHV0aW5nIiBpcyBiYXNpY2FsbHkgb3J0aG9nb25hbCB0byB0
aGF0IGZlYXR1cmUuDQoNCg0KSnVlcmdlbg0K
--------------AUotc6vkbgM0g5J5WIJwHZMe
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------AUotc6vkbgM0g5J5WIJwHZMe--

--------------XSdyHfDZ8NSbH9riXD1TXs2C--

--------------RTRugpKcpQELUP0Gus1cI1VK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJmUiUFAwAAAAAACgkQsN6d1ii/Ey83
vQgAllvB7gAmPzj4MJJf1J3ydVrvO/9eWJrgz/vrZAJPBT28frjIAcyOkmnvU61akrHDYp0TdaFR
xsXXrTja9p8p1wkcizFfvwEO43WaFmTnxVO5LQyw0xZyPQVwsRmZ6cdcnStlwDUc6HqFghpiDSVQ
NFosdwG/eB81MFHq2sSyhuc+ZpAd1+/GKk9Gri46PgO7m1NCBqiN6eBNoWkik6DUkR32fPutFw3e
4m6UqtOYu6htLUYWx+gF3Iq9KSafJLSypAJ09YS8dOvNzCrXmwFSRp6Ri43VJ2LJQc1Eo0++cFlC
9Ho5QTt1fs81HBVVA6FWCCeLJ4LIeMQG5Q9sKPUb2w==
=8gGu
-----END PGP SIGNATURE-----

--------------RTRugpKcpQELUP0Gus1cI1VK--
