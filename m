Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853E3506787
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbiDSJTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiDSJTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:19:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E5026570
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:16:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62195210F4;
        Tue, 19 Apr 2022 09:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650359792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpJbvqgQUJ8X2kcphBh+0uKSEVkbF9cJfYcLIzuVqyA=;
        b=hDul1sqy58qB9kficlyggAc8SgDIhrlLzjE3rX0oWjFD3BfL86cuE2+5KgFADUhxG6N5kE
        LtpS9EKc1f++W5n8u6/Sa40utnibS+JQp5R89n2G8EDE8Z31J1cTygmNq2sSepwFMjUHwS
        IxOdiDE5F1FUdQ0gCSSmLrM5OIgOydA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28E9B132E7;
        Tue, 19 Apr 2022 09:16:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y8iOCPB9XmKaCgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 19 Apr 2022 09:16:32 +0000
Message-ID: <cc7e517a-b1e7-95f1-d230-a635f7d84ef5@suse.com>
Date:   Tue, 19 Apr 2022 11:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] xen: gntalloc.c: Convert kmap() to kmap_local_page()
Content-Language: en-US
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        ira.weiny@intel.com
References: <20220418061927.6833-1-eng.alaamohamedsoliman.am@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220418061927.6833-1-eng.alaamohamedsoliman.am@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9vkSMHlYMu8moakU4AvthWPm"
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
--------------9vkSMHlYMu8moakU4AvthWPm
Content-Type: multipart/mixed; boundary="------------S5XLYnp6xrs0fDIWycnnF3TJ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
 outreachy@lists.linux.dev
Cc: boris.ostrovsky@oracle.com, sstabellini@kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 ira.weiny@intel.com
Message-ID: <cc7e517a-b1e7-95f1-d230-a635f7d84ef5@suse.com>
Subject: Re: [PATCH] xen: gntalloc.c: Convert kmap() to kmap_local_page()
References: <20220418061927.6833-1-eng.alaamohamedsoliman.am@gmail.com>
In-Reply-To: <20220418061927.6833-1-eng.alaamohamedsoliman.am@gmail.com>

--------------S5XLYnp6xrs0fDIWycnnF3TJ
Content-Type: multipart/mixed; boundary="------------QEG3IN2lZzp121HpNvmVs0ze"

--------------QEG3IN2lZzp121HpNvmVs0ze
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTguMDQuMjIgMDg6MTksIEFsYWEgTW9oYW1lZCB3cm90ZToNCj4gVGhlIHVzZSBvZiBr
bWFwKCkgaXMgYmVpbmcgZGVwcmVjYXRlZCBpbiBmYXZvciBvZiBrbWFwX2xvY2FsX3BhZ2Uo
KQ0KPiB3aGVyZSBpdCBpcyBmZWFzaWJsZS4NCj4gDQo+IFdpdGgga21hcF9sb2NhbF9wYWdl
KCksIHRoZSBtYXBwaW5nIGlzIHBlciB0aHJlYWQsIENQVSBsb2NhbCBhbmQgbm90DQo+IGds
b2JhbGx5IHZpc2libGUuIFRoZXJlZm9yZSBfX2RlbF9ncmVmKCkgaXMgYSBmdW5jdGlvbg0K
PiB3aGVyZSB0aGUgdXNlIG9mIGttYXBfbG9jYWxfcGFnZSgpIGluIHBsYWNlIG9mIGttYXAo
KSBpcyBjb3JyZWN0bHkNCj4gc3VpdGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxhYSBN
b2hhbWVkIDxlbmcuYWxhYW1vaGFtZWRzb2xpbWFuLmFtQGdtYWlsLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQo=

--------------QEG3IN2lZzp121HpNvmVs0ze
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------QEG3IN2lZzp121HpNvmVs0ze--

--------------S5XLYnp6xrs0fDIWycnnF3TJ--

--------------9vkSMHlYMu8moakU4AvthWPm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJefe8FAwAAAAAACgkQsN6d1ii/Ey8S
wgf/YdYBK3TJNqEFYhYzob4kXXTI/Q7kjJSzXiu5Nag8Sl8TC9nVthn7m35+2s7/l5oNDp6j4sn4
HhEdNvmsWptIfy95yxQdCbzoTkD2Vz6NXFi1lbTJvmpUp6y2yTtoE4mOhCsqNCcdCKKw0+gWbqbD
cH7sRAiGNlj4RCUR4TaTqbhJIvZUgzTfLwVbOVZDiK9x76Ua58DAh44qm4G+A7s53woIljMcD7Y/
vDYurOJJeQ+TPro4K7ass7aIQQfisdg7mMqnUsdtZ0fljdqss0ufJSK4Wyx7pdZj40YDyJL0Da7+
Ft/Kd38C4ddUurRyQqNJ3hkk8WztoR6OGAVD66Kgcg==
=vt7X
-----END PGP SIGNATURE-----

--------------9vkSMHlYMu8moakU4AvthWPm--
