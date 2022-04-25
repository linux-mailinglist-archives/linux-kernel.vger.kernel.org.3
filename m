Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2750DAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiDYH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbiDYH4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:56:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF71D44
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:53:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2084210E3;
        Mon, 25 Apr 2022 07:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650873204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6J/iNUKJLZU6UZVIYmW6fFp8/3H1kEij2Zec5To3N0Y=;
        b=VK+MEYCddHzu2chMnuBog0HhHzDWTsWO0kmAh0n6rBNTGvYIU99i5py8YfvtmdmIpZ5PbH
        5KfvHmprQjqkkoLetj6MvrWlmPP8TcW26ax/HStcwGdPPLBmtXufZm2f/LXkfuABmpJg8Q
        MOvPo6hKLF5Ipdy1doBtgq7a38GHnEo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37F6513AED;
        Mon, 25 Apr 2022 07:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lC4uDHRTZmJKbAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 25 Apr 2022 07:53:24 +0000
Message-ID: <22a6eb7e-f98c-ff15-f4dd-b2834ad345c8@suse.com>
Date:   Mon, 25 Apr 2022 09:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr <olekstysh@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
 <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
 <e63bfa2c-6edb-f224-1d2a-0c69330492ad@oracle.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <e63bfa2c-6edb-f224-1d2a-0c69330492ad@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UMN1MmzbWRc84Fi7yZ5FDfaK"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UMN1MmzbWRc84Fi7yZ5FDfaK
Content-Type: multipart/mixed; boundary="------------vBUQSUV9DXk8H0gwrYNEVMMz";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Oleksandr <olekstysh@gmail.com>, Christoph Hellwig <hch@infradead.org>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <22a6eb7e-f98c-ff15-f4dd-b2834ad345c8@suse.com>
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
 <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
 <e63bfa2c-6edb-f224-1d2a-0c69330492ad@oracle.com>
In-Reply-To: <e63bfa2c-6edb-f224-1d2a-0c69330492ad@oracle.com>

--------------vBUQSUV9DXk8H0gwrYNEVMMz
Content-Type: multipart/mixed; boundary="------------CscnO1cb8JXTmYt8xaramFbd"

--------------CscnO1cb8JXTmYt8xaramFbd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDQuMjIgMjA6MDgsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4gDQo+IE9uIDQv
MjQvMjIgMTI6NTMgUE0sIE9sZWtzYW5kciB3cm90ZToNCj4+DQo+PiBPbiAyMy4wNC4yMiAx
OTo0MCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+Pg0KPj4NCj4+DQo+Pg0KPj4+DQo+
Pj4+ICsNCj4+Pj4gKyNpZmRlZiBDT05GSUdfQVJDSF9IQVNfUkVTVFJJQ1RFRF9WSVJUSU9f
TUVNT1JZX0FDQ0VTUw0KPj4+PiAraW50IGFyY2hfaGFzX3Jlc3RyaWN0ZWRfdmlydGlvX21l
bW9yeV9hY2Nlc3Modm9pZCkNCj4+Pj4gK3sNCj4+Pj4gK8KgwqDCoCByZXR1cm4gKHhlbl9o
YXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2VzcygpIHx8DQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0dVRVNUX01FTV9FTkNS
WVBUKSk7DQo+Pj4+ICt9DQo+Pj4gU28gaW5zdGVhZCBvZiBoYXJkY29kaW5nIFhlbiBoZXJl
LCB0aGlzIHNlZW1zIGxpa2UgYSBjYW5kaWRhdGUgZm9yDQo+Pj4gYW5vdGhlciBjY19wbGF0
Zm9ybV9oYXMgZmxhZy4NCj4+DQo+Pg0KPj4gSSBoYXZlIGEgbGltaXRlZCBrbm93bGVkZ2Ug
b2YgeDg2IGFuZCBYZW4gb24geDg2Lg0KPj4NCj4+IFdvdWxkIHRoZSBYZW4gc3BlY2lmaWMg
Yml0cyBmaXQgaW50byBDb25maWRlbnRpYWwgQ29tcHV0aW5nIFBsYXRmb3JtIGNoZWNrcz8g
SSANCj4+IHdpbGwgbGV0IEp1ZXJnZW4vQm9yaXMgY29tbWVudCBvbiB0aGlzLg0KPj4NCj4g
DQo+IFRoaXMgaXMgdW5yZWxhdGVkIHRvIGNvbmZpZGVudGlhbCBzbyBJIGRvbid0IHRoaW5r
IHdlIGNhbiBhZGQgYW5vdGhlciBDQ18gZmxhZy4NCj4gDQo+IA0KPiBXb3VsZCBhcmNoL3g4
Ni9rZXJuZWwvY3B1L2h5cGVydmlzb3IuYyBiZSBhIGJldHRlciBob21lIGZvciB0aGlzPw0K
DQpPciBhIGNhbGxiYWNrIGluIHN0cnVjdCBzdHJ1Y3QgeDg2X2h5cGVyX3J1bnRpbWUgbWF5
YmU/DQoNCg0KSnVlcmdlbg0K
--------------CscnO1cb8JXTmYt8xaramFbd
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------CscnO1cb8JXTmYt8xaramFbd--

--------------vBUQSUV9DXk8H0gwrYNEVMMz--

--------------UMN1MmzbWRc84Fi7yZ5FDfaK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJmU3MFAwAAAAAACgkQsN6d1ii/Ey/e
6wf/UlTnGioaYcmvwVrbHCMgdeIF87ezgg0eMIIROuAmVceVaVjdBTSC4AN4Aa3Z4flFUi80wC/q
SZI7MKBolM6UwNTFybbyltBjRxGeVCDT00kzWiAZxIWCjWBVq16P1XkOJe/B1cLKkyFLRwCOkqEs
f50IWV3DadHahPJSoygFSucX9PNybmD7N8sP/yKwIOVxIgnZ4NrghbPnhtF7WCCJkgYXzEW1yzd+
wWIvBNMiZoAawYn7IUhj63lqjbFQYLnYxOY2VAcPwhXxMgSSuJVkzLlu/KIGuZbrwVqNi8qzSeTK
Z4eWZo6AUCpQKIYWUxSy7ZtdljjRC/M7UE8M6AE/HA==
=PvOM
-----END PGP SIGNATURE-----

--------------UMN1MmzbWRc84Fi7yZ5FDfaK--
