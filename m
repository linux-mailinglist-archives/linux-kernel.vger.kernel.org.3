Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0917D527D43
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbiEPF7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiEPF7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:59:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DAB1B7B9
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:59:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01E1C1FB11;
        Mon, 16 May 2022 05:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652680786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zsD+46oUPuW0iPz0GLsFUXWAhM91AFgIGDek/lB5qYU=;
        b=jMA7VDav2WLpRn4hMNcnLjbBCX016a90Ibh9ib2bqJK4sJd4FERHYDGkjF08ABP7tq4rpS
        AylMDkrFH0PYYGWP7DcEW0ksmkvkweEFA9LPGcx+fHanQf4tYiFGSE8mJb4uBzNyP6+gCC
        nmxTNJb5g6UFnUrh92KT8TsIxr2rOsE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AD9A13ADC;
        Mon, 16 May 2022 05:59:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KPiWI1HogWKZKQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 16 May 2022 05:59:45 +0000
Message-ID: <e04fd32d-b379-d515-2080-781e555303f1@suse.com>
Date:   Mon, 16 May 2022 07:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
 <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>
 <d1d61bcf-86f9-68cd-9bd4-a13bf8149b88@suse.com>
 <91f95228-215c-b817-8bb6-8e24c0caf925@oracle.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <91f95228-215c-b817-8bb6-8e24c0caf925@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------izYTztBjmky4hprP0vEByjQ4"
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------izYTztBjmky4hprP0vEByjQ4
Content-Type: multipart/mixed; boundary="------------QqNa6f4NuYZAGd14Kzq0ennD";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Julien Grall
 <julien@xen.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>
Message-ID: <e04fd32d-b379-d515-2080-781e555303f1@suse.com>
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
 <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>
 <d1d61bcf-86f9-68cd-9bd4-a13bf8149b88@suse.com>
 <91f95228-215c-b817-8bb6-8e24c0caf925@oracle.com>
In-Reply-To: <91f95228-215c-b817-8bb6-8e24c0caf925@oracle.com>

--------------QqNa6f4NuYZAGd14Kzq0ennD
Content-Type: multipart/mixed; boundary="------------Kc08gidKELCxlELvXF0EJn76"

--------------Kc08gidKELCxlELvXF0EJn76
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMDUuMjIgMDQ6MzQsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4gDQo+IA0KPiBP
biA1LzEzLzIyIDE6MzMgQU0sIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBPbiAxMi4wNS4y
MiAyMjowMSwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPj4+DQo+Pj4gT24gNS83LzIyIDI6
MTkgUE0sIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4+Pj4gKy8qIFJlYnVp
bGRzIHRoZSBmcmVlIGdyYW50IGxpc3QgYW5kIHRyaWVzIHRvIGZpbmQgY291bnQgY29uc2Vj
dXRpdmUgDQo+Pj4+IGVudHJpZXMuICovDQo+Pj4+ICtzdGF0aWMgaW50IGdldF9mcmVlX3Nl
cSh1bnNpZ25lZCBpbnQgY291bnQpDQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqAgaW50IHJldCA9
IC1FTk9TUEM7DQo+Pj4+ICvCoMKgwqAgdW5zaWduZWQgaW50IGZyb20sIHRvOw0KPj4+PiAr
wqDCoMKgIGdyYW50X3JlZl90ICpsYXN0Ow0KPj4+PiArDQo+Pj4+ICvCoMKgwqAgZ250dGFi
X2ZyZWVfdGFpbF9wdHIgPSAmZ250dGFiX2ZyZWVfaGVhZDsNCj4+Pj4gK8KgwqDCoCBsYXN0
ID0gJmdudHRhYl9mcmVlX2hlYWQ7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoCBmb3IgKGZyb20g
PSBmaW5kX2ZpcnN0X2JpdChnbnR0YWJfZnJlZV9iaXRtYXAsIGdudHRhYl9zaXplKTsNCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqAgZnJvbSA8IGdudHRhYl9zaXplOw0KPj4+PiArwqDCoMKg
wqDCoMKgwqDCoCBmcm9tID0gZmluZF9uZXh0X2JpdChnbnR0YWJfZnJlZV9iaXRtYXAsIGdu
dHRhYl9zaXplLCB0byArIDEpKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB0byA9IGZpbmRf
bmV4dF96ZXJvX2JpdChnbnR0YWJfZnJlZV9iaXRtYXAsIGdudHRhYl9zaXplLA0KPj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJvbSArIDEpOw0KPj4+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJldCA8IDAgJiYgdG8gLSBmcm9tID49IGNvdW50KSB7
DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGZyb207DQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJpdG1hcF9jbGVhcihnbnR0YWJfZnJlZV9iaXRtYXAsIHJl
dCwgY291bnQpOw0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tICs9IGNvdW50
Ow0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnbnR0YWJfZnJlZV9jb3VudCAtPSBj
b3VudDsNCj4+Pg0KPj4+DQo+Pj4gSUlVSUMgd2UgY2FuIGhhdmUgbXVsdGlwbGUgcGFzc2Vz
IG92ZXIgdGhpcywgbWVhbmluZyB0aGF0IHRoZSANCj4+PiBnbnR0YWJfZnJlZV9jb3VudCBt
YXkgYmUgZGVjcmVtZW50ZWQgbW9yZSB0aGFuIG9uY2UuIElzIHRoYXQgaW50ZW50aW9uYWw/
DQo+Pg0KPj4gQWZ0ZXIgdGhlIGZpcnN0IHBhc3MgZGVjcmVtZW50aW5nIGdudHRhYl9mcmVl
X2NudCwgcmV0IHdpbGwgbm8NCj4+IGxvbmdlciBiZSBsZXNzIHRoYW4gemVybywgc28gdGhp
cyBjYW4gYmUgaGl0IG9ubHkgb25jZS4NCj4gDQo+IE9oLCB5ZXMsIG9mIGNvdXJzZS4NCj4g
DQo+Pg0KPj4+DQo+Pj4NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGZyb20g
PT0gdG8pDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7
DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IHdoaWxlIChmcm9tIDwgdG8pIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmxh
c3QgPSBmcm9tOw0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsYXN0ID0gX19nbnR0
YWJfZW50cnkoZnJvbSk7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdudHRhYl9s
YXN0X2ZyZWUgPSBmcm9tOw0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tKys7
DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4NCj4+Pg0KPj4+IEkgaGF2ZSBiZWVuIGxv
b2tpbmcgYXQgdGhpcyBsb29wIGFuZCBJIGNhbid0IHVuZGVyc3RhbmQgd2hhdCBpdCBpcyBk
b2luZyA7LSggDQo+Pj4gQ2FuIHlvdSBlbmxpZ2h0ZW4gbWU/DQo+Pg0KPj4gSXQgaXMgcmVj
cmVhdGluZyB0aGUgZnJlZSBsaXN0IGluIG9yZGVyIHRvIGhhdmUgaXQgcHJvcGVybHkgc29y
dGVkLg0KPj4gVGhpcyBpcyBuZWVkZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIGZyZWUgdGFp
bCBoYXMgdGhlIG1heGltdW0NCj4+IHBvc3NpYmxlIHNpemUgKHlvdSBjYW4gdGFrZSB0aGUg
dGFpbCBvZmYgdGhlIGxpc3Qgd2l0aG91dCBoYXZpbmcNCj4+IHRvIHdvcnJ5IGFib3V0IGJy
ZWFraW5nIHRoZSBsaW5rZWQgbGlzdCBiZWNhdXNlIG9mIHJlZmVyZW5jZXMgaW50bw0KPj4g
dGhlIHRhaWwpLg0KPiANCj4gDQo+IFNvIGxldCdzIHNheSB3ZSBoYXZlIHRoZSAob25lLWRp
bWVuc2lvbmFsKSB0YWJsZSBvZiBsZW5ndGggMTMNCj4gDQo+IGlkeMKgwqDCoCAuLsKgwqDC
oCAywqDCoMKgIDPCoCAuLi7CoCAxMMKgIDExwqAgMTINCj4gDQo+IGdyYW50wqDCoMKgwqDC
oMKgIDEywqDCoCAxMcKgwqDCoMKgwqDCoMKgIDLCoCAtMcKgwqAgMw0KPiANCj4gDQo+IGFu
ZCBnbnR0YWJfZnJlZV9oZWFkIGlzIDEwLiBJLmUuIHRoZSBmcmVlIGxpc3QgaXMgMiwgMTIs
IDMsIDExLg0KDQpZb3UgbWVhbnQgMTAsIDIsIDEyLCAzLCAxMSwgSSBndWVzcz8NCg0KPiAN
Cj4gV2hhdCB3aWxsIHRoaXMgbG9vayBsaWtlIGFmdGVyIHRoZSAyIGl0ZXJhdGlvbnMgb2Yg
dGhlIG91dGVyIGxvb3A/DQoNCmlkeCAgICAuLiAgICAyICAgIDMgIC4uLiAgMTAgIDExICAx
Mg0KDQpncmFudCAgICAgICAgMyAgIDEwICAgICAgIDExICAxMiAgLTENCg0Kd2l0aCBnbnR0
YWJfZnJlZV9oZWFkIGJlaW5nIDIsIGkuZSB0aGUgZnJlZSBsaXN0IGlzIG5vdyAyLCAzLCAx
MCwgMTEsIDEyLg0KDQoNCkp1ZXJnZW4NCg==
--------------Kc08gidKELCxlELvXF0EJn76
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Kc08gidKELCxlELvXF0EJn76--

--------------QqNa6f4NuYZAGd14Kzq0ennD--

--------------izYTztBjmky4hprP0vEByjQ4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKB6FEFAwAAAAAACgkQsN6d1ii/Ey/d
EQgAiKCBU/TDtz6MajOwcYCi/wUu4GKy6pG13fgmx30aWBd2dm7HxTJaDmS0VS/h5kJDtRtYZpxD
btng409Ev/OZ82h0vvZocXNI5KSVUHOBUVfNda7UfUDbf/S9Z19GkRAd4TcpnvK7rt7FODLP1S7a
GO3kjy2SMYtqtqZxoxuxzim730M/9rPCVDM7nXhEw3bha1b0wMQ5l8rVxDfd1oLuY1xgvV8gDYxW
3s2fa4vDj3t7u3L6mKSvQbofqd+fRu01fUtBH5VC1bOsWmSdbSRbzl5qjTk4Y/IRag3k0NzkPT4r
//GM8ltxQYcISIIWeSG5VkuTjl/fNlEfKPRqiGkIBw==
=mcgR
-----END PGP SIGNATURE-----

--------------izYTztBjmky4hprP0vEByjQ4--
