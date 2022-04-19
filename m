Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738D5506BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352454AbiDSMNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352033AbiDSML1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:11:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A843586F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:06:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6434D210F1;
        Tue, 19 Apr 2022 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650369979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17cvwrP1W/YrOePsFyFZ04xlKrMaEQxDlJS+zIqc9pc=;
        b=dvkfmdPPA2uAscpybZVMbycuKZHRII/zIQnfMZqacuqyBg1HOEDMTRApvl8F9jNVen09YF
        fruRdZL9HI75u8x+sBPWt1aYHQxEKDOod2/9D4C/WfnrVyVlXbVUQWGUEfBqE2DW6asJvI
        rFmnWmWiohFBi6W3zDYnSpBJi8HxtRk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EB38132E7;
        Tue, 19 Apr 2022 12:06:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dE/7BbulXmKyXwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 19 Apr 2022 12:06:19 +0000
Message-ID: <e1e11062-f528-ea06-cb94-fd4dadf2c5aa@suse.com>
Date:   Tue, 19 Apr 2022 14:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 06/25] x86/xen: Add ANNOTATE_ENDBR to startup_xen()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com>
 <b94cbac6-0a4d-8e4a-ec58-bbd46e385d45@citrix.com>
 <20220419115737.GU2731@worktop.programming.kicks-ass.net>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220419115737.GU2731@worktop.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2IeIEE5xYPveCwBVs3J5n4B3"
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
--------------2IeIEE5xYPveCwBVs3J5n4B3
Content-Type: multipart/mixed; boundary="------------GryZTSvTkZhEETy5NZDwJoeo";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <e1e11062-f528-ea06-cb94-fd4dadf2c5aa@suse.com>
Subject: Re: [PATCH v2 06/25] x86/xen: Add ANNOTATE_ENDBR to startup_xen()
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com>
 <b94cbac6-0a4d-8e4a-ec58-bbd46e385d45@citrix.com>
 <20220419115737.GU2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220419115737.GU2731@worktop.programming.kicks-ass.net>

--------------GryZTSvTkZhEETy5NZDwJoeo
Content-Type: multipart/mixed; boundary="------------jz6euTCJTtrrKm2dUKP9mACi"

--------------jz6euTCJTtrrKm2dUKP9mACi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDQuMjIgMTM6NTcsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUdWUsIEFw
ciAxOSwgMjAyMiBhdCAxMTo0MjoxMkFNICswMDAwLCBBbmRyZXcgQ29vcGVyIHdyb3RlOg0K
Pj4gT24gMTgvMDQvMjAyMiAxNzo1MCwgSm9zaCBQb2ltYm9ldWYgd3JvdGU6DQo+Pj4gVGhl
IHN0YXJ0dXBfeGVuKCkga2VybmVsIGVudHJ5IHBvaW50IGlzIHJlZmVyZW5jZWQgYnkgdGhl
ICIubm90ZS5YZW4iDQo+Pj4gc2VjdGlvbiwgYnV0IGlzIHByZXN1bWFibHkgbm90IGluZGly
ZWN0LWJyYW5jaGVkIHRvLg0KPj4NCj4+IEl0J3MgdGhlIHJlYWwgZW50cnlwb2ludCBvZiB0
aGUgVk0uwqAgSXQncyAiZ290IHRvIiBieSBzZXR0aW5nICVyaXANCj4+IGR1cmluZyB2Y3B1
IHNldHVwLg0KPj4NCj4+IFdlIGNvdWxkIGluIHByaW5jaXBsZSBzdXBwb3J0IHN0YXJ0aW5n
IGEgUFYgVk0gd2l0aCBDRVQgYWN0aXZlLCBidXQgdGhhdA0KPj4gc291bmRzIGxpa2UgYW4g
ZW5vcm1vdXMgcXVhbnRpdHkgb2YgZWZmb3J0IGZvciB2ZXJ5IGxpdHRsZSBnYWluLsKgIENF
VA0KPj4gZm9yIFhlbiBQViByZXF1aXJlcyBwYXJhdmlydCBhbnl3YXkgKGJlY2F1c2UgdGhl
IGtlcm5lbCBydW5zIGluIENQTCE9MCkNCj4+IHNvIGRlY2lzaW9ucyBsaWtlIHRoaXMgY2Fu
IHdhaXQgdW50aWwgc29tZW9uZSBmZWVscyBsaWtlIGRvaW5nIHRoZSB3b3JrLg0KPj4NCj4+
PiAgICBBZGQgQU5OT1RBVEVfRU5EQlINCj4+PiB0byBzaWxlbmNlIGZ1dHVyZSBvYmp0b29s
IHdhcm5pbmdzLg0KPj4+DQo+Pj4gQ2M6IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0cm92
c2t5QG9yYWNsZS5jb20+DQo+Pj4gQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNv
bT4NCj4+PiBDYzogU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3Jn
Pg0KPj4+IENjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcNCj4+PiBTaWduZWQt
b2ZmLWJ5OiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNvbT4NCj4+DQo+PiBG
V0lXLCBSZXZpZXdlZC1ieTogQW5kcmV3IENvb3BlciA8YW5kcmV3LmNvb3BlcjNAY2l0cml4
LmNvbT4sIHByZWZlcmFibHkNCj4+IHdpdGggdGhlIGNvbW1pdCBtZXNzYWdlIHR3ZWFrZWQg
dG8gcmVtb3ZlIHRoZSB1bmNlcnRhaW50eS4NCj4gDQo+IFNvbWV0aGluZyBsaWtlIHNvIHRo
ZW4/DQo+IA0KPiAtLS0NCj4gU3ViamVjdDogeDg2L3hlbjogQWRkIEFOTk9UQVRFX0VOREJS
IHRvIHN0YXJ0dXBfeGVuKCkNCj4gRnJvbTogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJl
ZGhhdC5jb20+DQo+IERhdGU6IE1vbiwgMTggQXByIDIwMjIgMDk6NTA6MjUgLTA3MDANCj4g
DQo+IEZyb206IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29tPg0KPiANCj4g
VGhlIHN0YXJ0dXBfeGVuKCkga2VybmVsIGVudHJ5IHBvaW50IGlzIHJlZmVyZW5jZWQgYnkg
dGhlICIubm90ZS5YZW4iDQo+IHNlY3Rpb24sIGFuZCBpcyB0aGUgcmVhbCBlbnRyeSBwb2lu
dCBvZiB0aGUgVk0uIEl0ICp3aWxsKiBiZQ0KPiBpbmRpcmVjdGx5IGJyYW5jaGVkIHRvLCAq
aG93ZXZlciogY3VycmVudGx5IFhlbiBkb2Vzbid0IHN1cHBvcnQgUFYgVk0NCj4gd2l0aCBD
RVQgYWN0aXZlLg0KDQpIbW0sIFhlbiB3aWxsIGFsd2F5cyB1c2UgSVJFVCB0byBhY3RpdmF0
ZSB0aGUgZ3Vlc3QuDQoNCg0KSnVlcmdlbg0K
--------------jz6euTCJTtrrKm2dUKP9mACi
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------jz6euTCJTtrrKm2dUKP9mACi--

--------------GryZTSvTkZhEETy5NZDwJoeo--

--------------2IeIEE5xYPveCwBVs3J5n4B3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJepboFAwAAAAAACgkQsN6d1ii/Ey8T
oQf9EKmmEZaYjIYHk88yOKwhNPMeFNvXCN0ouhp+PLvjb3g1bSYo1nQyyWFaOEMiMhJAiAlzW7/y
sr8DkBa+LqzwCQjWux6RxMP5Cmi4BSehiPr1Gf/6mGGPt1zX6sC5DrWQbzPUgYvfiMU5YsU6thx1
YSdPGp81IV/S4vmLStF2xb+k5TN8hK4ndNAJrOzlglL+OoN8ni9I1403SUngp0EqM212ljzpWKAF
oXTSO8HvDxpdce5yKh5tmXlmuq1ncij1DasrN8ZXtCc2SjfkzelXPMru/JyVy/H7osydMmL9ZZ7x
moRE+glctru1pRnCRKR9g6UpuAW2dAFwAWri1XLOEw==
=aF2B
-----END PGP SIGNATURE-----

--------------2IeIEE5xYPveCwBVs3J5n4B3--
