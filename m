Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F44A9666
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357602AbiBDJZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:25:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34558 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357478AbiBDJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:24:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 211F0218F0;
        Fri,  4 Feb 2022 09:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643966654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8cDBknFJRIpxf5l9AdOZUIo0+FnYIcgRzSzamZqBACo=;
        b=gyCozaF0GvUFq5S0NlfbfbHKvuxPf62o/USaPhpLav/RBPVy4Nr0Bk1+fgGQgJBBV05yi9
        QZyhBkHtXcNpy0ehgel1ozmfdJra4Ag9a2khtpiKNnmGi1ma2A7SGfCSvLmalFvOQa+pct
        absX5Rsz6cck3tpMHMwWSp2M1NF/XxA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAB4013322;
        Fri,  4 Feb 2022 09:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oy3ON73w/GEMeQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 04 Feb 2022 09:24:13 +0000
Message-ID: <1af6c334-4c5c-66da-7fea-0dfd0339e665@suse.com>
Date:   Fri, 4 Feb 2022 10:24:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2] Improve docs for IOCTL_GNTDEV_MAP_GRANT_REF
Content-Language: en-US
To:     Demi Marie Obenour <demiobenour@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <f66c5a4e-2034-00b5-a635-6983bd999c07@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <f66c5a4e-2034-00b5-a635-6983bd999c07@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Eg4rG6ujboyviXGmG1PlN7iq"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Eg4rG6ujboyviXGmG1PlN7iq
Content-Type: multipart/mixed; boundary="------------sgWeOpdNgNKChkm3psCKSe9q";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Demi Marie Obenour <demiobenour@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <1af6c334-4c5c-66da-7fea-0dfd0339e665@suse.com>
Subject: Re: [PATCH v2] Improve docs for IOCTL_GNTDEV_MAP_GRANT_REF
References: <f66c5a4e-2034-00b5-a635-6983bd999c07@gmail.com>
In-Reply-To: <f66c5a4e-2034-00b5-a635-6983bd999c07@gmail.com>

--------------sgWeOpdNgNKChkm3psCKSe9q
Content-Type: multipart/mixed; boundary="------------We0Qqb4jVkRXwDCuJewzkpGp"

--------------We0Qqb4jVkRXwDCuJewzkpGp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDEuMjIgMTg6MjMsIERlbWkgTWFyaWUgT2Jlbm91ciB3cm90ZToNCj4gVGhlIGN1
cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgZ250ZGV2IGd1YXJhbnRlZXMgdGhhdCB0aGUgZmly
c3QgY2FsbCB0bw0KPiBJT0NUTF9HTlRERVZfTUFQX0dSQU5UX1JFRiB3aWxsIHNldCBAaW5k
ZXggdG8gMC4gIFRoaXMgaXMgcmVxdWlyZWQgdG8NCj4gdXNlIGdudGRldiBmb3IgV2F5bGFu
ZCwgd2hpY2ggaXMgYSBmdXR1cmUgZGVzaXJlIG9mIFF1YmVzIE9TLg0KPiBBZGRpdGlvbmFs
bHksIHJlcXVlc3RpbmcgemVybyBncmFudHMgcmVzdWx0cyBpbiBhbiBlcnJvciwgYnV0IHRo
aXMgd2FzDQo+IG5vdCBkb2N1bWVudGVkIGVpdGhlci4gIERvY3VtZW50IGJvdGggb2YgdGhl
c2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZW1pIE1hcmllIE9iZW5vdXIgPGRlbWlvYmVu
b3VyQGdtYWlsLmNvbT4NCg0KUHVzaGVkIHRvIHhlbi90aXAuZ2l0IGZvci1saW51cy01LjE3
YQ0KDQoNCkp1ZXJnZW4NCg==
--------------We0Qqb4jVkRXwDCuJewzkpGp
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------We0Qqb4jVkRXwDCuJewzkpGp--

--------------sgWeOpdNgNKChkm3psCKSe9q--

--------------Eg4rG6ujboyviXGmG1PlN7iq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmH88L0FAwAAAAAACgkQsN6d1ii/Ey/j
WQf/YxiHmXcPdXmmKLO9PoqWdFJfJJn4O4YaSkpUpk7v31m2RRyFhLTRjvlcqHoAj7z2OM1oYV6h
6khY2LgSF5OyioiowZU+47QNu354PbVPg2uJ2sRS2Av5836QiyNirH3Al7thSfLxtvtdReGE2xnJ
P9AaeiVxC4s8N/lKjFqIlnqh/vPXBiVanmWzuByQ4Z0F8F+u/KVUoy26C8I3twUWyze7IabD5MIO
NYMLENNFb3ByCgokQgoksiBuHDE3WBWxY4pLKO0J/V4t/MC6WElMzk4k2GSO6qfsoPrzormxytlW
hwvyvt5qWnWSFC0Iigka9n7N875aR+0PjtobEGve3A==
=yOqa
-----END PGP SIGNATURE-----

--------------Eg4rG6ujboyviXGmG1PlN7iq--
