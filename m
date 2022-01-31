Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178124A3DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 07:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357751AbiAaGmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 01:42:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35512 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357729AbiAaGmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 01:42:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0CC5212BE;
        Mon, 31 Jan 2022 06:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643611336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Knl5eql1MNKIO02Lh9ot4t04zTLtCICNa6Mw5TVo3YY=;
        b=MhYsbUUvHu/43ZEVwmur05PawnR8SThcCySqn6uU3oO5Wl4/PhbPyKD/XvnmqrDfVoJhAy
        EtHgW7T5XOJAvgc6iK0uBHu1L9b/Z9ByRXWolCbox/4oLoQ0+uej5g3bRaxKhnyzpsQjOC
        vG85vb3mT3mWYijwh+E5rEYecKho6ok=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0DCA13A91;
        Mon, 31 Jan 2022 06:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y+hIKciE92EINgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 31 Jan 2022 06:42:16 +0000
Message-ID: <337b7168-b1c0-cdba-2ae0-482bb16ab2ec@suse.com>
Date:   Mon, 31 Jan 2022 07:42:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] Improve docs for IOCTL_GNTDEV_MAP_GRANT_REF
Content-Language: en-US
To:     Demi Marie Obenour <demiobenour@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <68f3303d-f035-ffdf-c786-9c826e66bd0b@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <68f3303d-f035-ffdf-c786-9c826e66bd0b@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sLxdBSi77MGQaNCkedzvCcIu"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sLxdBSi77MGQaNCkedzvCcIu
Content-Type: multipart/mixed; boundary="------------mO6eTlaXpYYJSGZIjTJXCbK0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Demi Marie Obenour <demiobenour@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <337b7168-b1c0-cdba-2ae0-482bb16ab2ec@suse.com>
Subject: Re: [PATCH] Improve docs for IOCTL_GNTDEV_MAP_GRANT_REF
References: <68f3303d-f035-ffdf-c786-9c826e66bd0b@gmail.com>
In-Reply-To: <68f3303d-f035-ffdf-c786-9c826e66bd0b@gmail.com>

--------------mO6eTlaXpYYJSGZIjTJXCbK0
Content-Type: multipart/mixed; boundary="------------F04sNxcbqALEMUEh7XnVr4wS"

--------------F04sNxcbqALEMUEh7XnVr4wS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDEuMjIgMTk6MzUsIERlbWkgTWFyaWUgT2Jlbm91ciB3cm90ZToNCj4gVGhlIGN1
cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgZ250ZGV2IGd1YXJhbnRlZXMgdGhhdCB0aGUgZmly
c3QgY2FsbCB0bw0KPiBJT0NUTF9HTlRERVZfTUFQX0dSQU5UX1JFRiB3aWxsIHNldCBAaW5k
ZXggdG8gMC4gIFRoaXMgaXMgcmVxdWlyZWQgdG8NCj4gdXNlIGdudGRldiBmb3IgV2F5bGFu
ZCwgd2hpY2ggaXMgYSBmdXR1cmUgZGVzaXJlIG9mIFF1YmVzIE9TLg0KPiBBZGRpdGlvbmFs
bHksIHJlcXVlc3RpbmcgemVybyBncmFudHMgcmVzdWx0cyBpbiBhbiBlcnJvciwgYnV0IHRo
aXMgd2FzDQo+IG5vdCBkb2N1bWVudGVkIGVpdGhlci4gIERvY3VtZW50IGJvdGggb2YgdGhl
c2UuDQoNClBsZWFzZSBhZGQgYSAiU2lnbmVkLW9mZi1ieToiIHRhZyB0byB5b3VyIGNvbW1p
dCBtZXNzYWdlLg0KDQpTZWUgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0
Y2hlcy5yc3QgaW4gdGhlIGtlcm5lbCBzb3VyY2UNCnRyZWUsIGxvb2sgZm9yICJTaWduIHlv
dXIgd29yayAtIHRoZSBEZXZlbG9wZXIncyBDZXJ0aWZpY2F0ZSBvZiBPcmlnaW4iLg0KDQoN
Ckp1ZXJnZW4NCg==
--------------F04sNxcbqALEMUEh7XnVr4wS
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------F04sNxcbqALEMUEh7XnVr4wS--

--------------mO6eTlaXpYYJSGZIjTJXCbK0--

--------------sLxdBSi77MGQaNCkedzvCcIu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmH3hMgFAwAAAAAACgkQsN6d1ii/Ey/y
4wf9FbFxYuIdjwoAcOYaJz7hozERQHsJl7KdtjVLfMq7Xhoje5tuv06gQoya5GXnXKsfyqZ96ed+
ntpqP2+G4B38GH3ALLxtvFtTtVz+VuaRuQCEmAk7YZ8YeP2wYMQC2xm3NTsfRXC3Ap+CkFvDvPgX
hxrFXCXnvaDEXISDNl6gtAzAq747RCTDd1PGXKy9c03NQA2VmCMpM5LHDlWiHvHfPKpncolld/sB
lCxa9DcqTkfraqI1Xb5N78LsDquKB/OoNLBSQoOFIj7Id4t89tOuQ9ODAlWAIhf5WCvBWANjI7ap
uUqc/NMAazm3hVpt8et+/PhxqVA1tMAYCmt2YBzboQ==
=/1Zq
-----END PGP SIGNATURE-----

--------------sLxdBSi77MGQaNCkedzvCcIu--
