Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E301654DA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358927AbiFPGP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358915AbiFPGPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:15:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C0236170
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:15:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3C6121C58;
        Thu, 16 Jun 2022 06:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655360116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFF3k13LUKCiKrPq8kWk/hdM4VqGuJLIJy2t17i2Wfw=;
        b=AuBDIqVKHouwIEK7lqLR/FqjbC6FsLU78nEeq5YxXQOA8bIlpBeo/vxmC0zoH53AnazNEA
        /vTqSGjIy3mhHQNDb1TIVUxThona4DuuAqralDNxPb8C44JcdHyXZ4BLV7qAC2OrIMJWeY
        ZTuGrYvEJuI/08t0yGGIK2AxcH0OhfE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 856451344E;
        Thu, 16 Jun 2022 06:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pP0KH3TKqmLcUQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 16 Jun 2022 06:15:16 +0000
Message-ID: <50b72415-2e7d-b25e-0022-539d9fe91d41@suse.com>
Date:   Thu, 16 Jun 2022 08:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20220616053715.3166-1-jgross@suse.com>
 <YqrHlNOiRxxc8xcq@infradead.org>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2] xen: don't require virtio with grants for non-PV
 guests
In-Reply-To: <YqrHlNOiRxxc8xcq@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cIwu0mbjmosd8QbJsqimG8rf"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cIwu0mbjmosd8QbJsqimG8rf
Content-Type: multipart/mixed; boundary="------------J2Rq30FEtUnvERcW8kC0PDn0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 viresh.kumar@linaro.org, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-ID: <50b72415-2e7d-b25e-0022-539d9fe91d41@suse.com>
Subject: Re: [PATCH v2] xen: don't require virtio with grants for non-PV
 guests
References: <20220616053715.3166-1-jgross@suse.com>
 <YqrHlNOiRxxc8xcq@infradead.org>
In-Reply-To: <YqrHlNOiRxxc8xcq@infradead.org>

--------------J2Rq30FEtUnvERcW8kC0PDn0
Content-Type: multipart/mixed; boundary="------------NdIsUxjRwVmXlsOvTsrEHUWr"

--------------NdIsUxjRwVmXlsOvTsrEHUWr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDYuMjIgMDg6MDMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUaHUs
IEp1biAxNiwgMjAyMiBhdCAwNzozNzoxNUFNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3Rl
Og0KPj4gQ29tbWl0IGZhMWY1NzQyMWUwYiAoInhlbi92aXJ0aW86IEVuYWJsZSByZXN0cmlj
dGVkIG1lbW9yeSBhY2Nlc3MgdXNpbmcNCj4+IFhlbiBncmFudCBtYXBwaW5ncyIpIGludHJv
ZHVjZWQgYSBuZXcgcmVxdWlyZW1lbnQgZm9yIHVzaW5nIHZpcnRpbw0KPj4gZGV2aWNlczog
dGhlIGJhY2tlbmQgbm93IG5lZWRzIHRvIHN1cHBvcnQgdGhlIFZJUlRJT19GX0FDQ0VTU19Q
TEFURk9STQ0KPj4gZmVhdHVyZS4NCj4+DQo+PiBUaGlzIGlzIGFuIHVuZHVlIHJlcXVpcmVt
ZW50IGZvciBub24tUFYgZ3Vlc3RzLCBhcyB0aG9zZSBjYW4gYmUgb3BlcmF0ZWQNCj4+IHdp
dGggZXhpc3RpbmcgYmFja2VuZHMgd2l0aG91dCBhbnkgcHJvYmxlbSwgYXMgbG9uZyBhcyB0
aG9zZSBiYWNrZW5kcw0KPj4gYXJlIHJ1bm5pbmcgaW4gZG9tMC4NCj4+DQo+PiBQZXIgZGVm
YXVsdCBhbGxvdyB2aXJ0aW8gZGV2aWNlcyB3aXRob3V0IGdyYW50IHN1cHBvcnQgZm9yIG5v
bi1QVg0KPj4gZ3Vlc3RzLg0KPj4NCj4+IEFkZCBhIG5ldyBjb25maWcgaXRlbSB0byBhbHdh
eXMgZm9yY2UgdXNlIG9mIGdyYW50cyBmb3IgdmlydGlvLg0KPiANCj4gV2hhdCDDjSdkIHJl
YWxseSBleHBlY3QgaGVyZSBpcyB0byBvbmx5IHNldCB0aGUgbGltaXRhdGlvbnMgZm9yIHRo
ZQ0KPiBhY3R1YWwgZ3JhbnQtYmFzZWQgZGV2aWMuICBVbmZvcnR1bmF0ZWx5DQo+IFBMQVRG
T1JNX1ZJUlRJT19SRVNUUklDVEVEX01FTV9BQ0NFU1MgaXMgZ2xvYmFsIGluc3RlYWQgb2Yg
cGVyLWRldmljZSwNCg0KSSB0aGluayB0aGUgZ2xvYmFsIHNldHRpbmcgaXMgZmluZSwgYXMg
aXQgc2VydmVzIGEgc3BlY2lmaWMgcHVycG9zZToNCmRvbid0IGFsbG93IEFOWSB2aXJ0aW8g
ZGV2aWNlcyB3aXRob3V0IHRoZSBzcGVjaWFsIGhhbmRsaW5nIChsaWtlIHRoZQ0KLzM5MCBQ
ViBjYXNlLCBTRVYsIFREWCwgb3IgWGVuIFBWLWd1ZXN0cykuIFRob3NlIGNhc2VzIGNhbid0
IHNlbnNpYmx5DQp3b3JrIHdpdGhvdXQgdGhlIHNwZWNpYWwgRE1BIG9wcy4NCg0KSW4gY2Fz
ZSB0aGUgc3BlY2lhbCBETUEgb3BzIGFyZSBqdXN0IGEgIm5pY2UgdG8gaGF2ZSIgbGlrZSBm
b3IgWGVuIEhWTQ0KZ3Vlc3RzLCBQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUND
RVNTIHdvbid0IGJlIHNldC4NCg0KQW5kIGlmIHNvbWVvbmUgd2FudHMgYSBndWVzdCBvbmx5
IHRvIHVzZSBncmFudCBiYXNlZCB2aXJ0aW8gZGV2aWNlcywNCnRoZSBndWVzdCBrZXJuZWwg
Y2FuIGJlIGJ1aWx0IHdpdGggQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQgKGUuZy4N
CmluIGNhc2UgdGhlIGJhY2tlbmRzIGFyZSBydW5uaW5nIGluIHNvbWUgbGVzcyBwcml2aWxl
Z2VkIGVudmlyb25tZW50DQphbmQgdGh1cyBjYW4ndCBtYXAgYXJiaXRyYXJ5IGd1ZXN0IG1l
bW9yeSBwYWdlcykuDQoNCg0KSnVlcmdlbg0K
--------------NdIsUxjRwVmXlsOvTsrEHUWr
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------NdIsUxjRwVmXlsOvTsrEHUWr--

--------------J2Rq30FEtUnvERcW8kC0PDn0--

--------------cIwu0mbjmosd8QbJsqimG8rf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKqynQFAwAAAAAACgkQsN6d1ii/Ey+m
/Af+Me+q12n9oI6lTeU8OHRs26Qw8RWbpRpvU1UN411+ZPsDSQDIskyhXMFatSSg2OBQ4aL638I6
kzH/SkxM5n6z2ckLvxym3Hgdd8BJ/VI4ih3zBcRJNaQeKf9tIFcBWUzAMda8OFKiKOKPBoQWGe6L
HiC5ckXiK/i4p/U1exxWzNwQmnvE83wAO8+YjF94R1vxlBPlSou6ceRlAhSdNsK9EBDDPk4YSktX
DCz3X4sqrzAh53qCpWgxWgs+jg9MeP3bdACBOPnzdg08CMApUZ1+pOIFS2B1zqQSZmFKiM4+YgjE
AzJ8pjry/nnoC7+MNmWGNcFeDI7TDtFmbkfFoO766w==
=NX7Z
-----END PGP SIGNATURE-----

--------------cIwu0mbjmosd8QbJsqimG8rf--
