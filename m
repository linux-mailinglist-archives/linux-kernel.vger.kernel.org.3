Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E1B50A43A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390148AbiDUPcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390112AbiDUPcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:32:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB0E42A3F;
        Thu, 21 Apr 2022 08:29:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B7D71F388;
        Thu, 21 Apr 2022 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650554968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h3T6oVdIEiAoOknXMJQlzGlmDQWgAHO2WwHFfzVsC2E=;
        b=AC/ZydHm/km1YL9h4guPQXh8abUCS2NHWmcApokIFGKvYAEuqWAK7J3zK9EzsEDxjv8YoB
        zLtmjfoV7igAOIMoR5MazGk7By6G65HQeZAI5Fq3gMEmCU5pDPht5+tyP/gVRy90qlkppD
        WFiExHABJWkpdZbeA7sKqqhICNanNvY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5468A13446;
        Thu, 21 Apr 2022 15:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LBK5Elh4YWJyZAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 21 Apr 2022 15:29:28 +0000
Message-ID: <15c89971-aefb-e71c-3798-c2e3820601f8@suse.com>
Date:   Thu, 21 Apr 2022 17:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] xen/scsifront: harden driver against malicious
 backend
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20220420092503.11123-1-jgross@suse.com>
 <20220420092503.11123-5-jgross@suse.com>
 <00c1cd38-5164-edfa-6c47-606803629dcf@oracle.com>
 <9d8c453b-7147-d80c-3d4f-666a3b530929@suse.com>
In-Reply-To: <9d8c453b-7147-d80c-3d4f-666a3b530929@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lrbiipHtViPigkxsk5QxRda5"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lrbiipHtViPigkxsk5QxRda5
Content-Type: multipart/mixed; boundary="------------dNyHNIA0JsXSFk76jcObWza7";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <15c89971-aefb-e71c-3798-c2e3820601f8@suse.com>
Subject: Re: [PATCH 4/4] xen/scsifront: harden driver against malicious
 backend
References: <20220420092503.11123-1-jgross@suse.com>
 <20220420092503.11123-5-jgross@suse.com>
 <00c1cd38-5164-edfa-6c47-606803629dcf@oracle.com>
 <9d8c453b-7147-d80c-3d4f-666a3b530929@suse.com>
In-Reply-To: <9d8c453b-7147-d80c-3d4f-666a3b530929@suse.com>

--------------dNyHNIA0JsXSFk76jcObWza7
Content-Type: multipart/mixed; boundary="------------JopTs9tb0nos5y7CFuy9ALV3"

--------------JopTs9tb0nos5y7CFuy9ALV3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDQuMjIgMTI6MTMsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDIwLjA0LjIy
IDE4OjEzLCBCb3JpcyBPc3Ryb3Zza3kgd3JvdGU6DQo+PiBKdXN0IGEgY291cGxlIG9mIG5p
dHMuDQo+Pg0KPj4NCj4+IE9uIDQvMjAvMjIgNToyNSBBTSwgSnVlcmdlbiBHcm9zcyB3cm90
ZToNCj4+PiAtc3RhdGljIGludCBzY3NpZnJvbnRfcmluZ19kcmFpbihzdHJ1Y3QgdnNjc2lm
cm50X2luZm8gKmluZm8pDQo+Pj4gK3N0YXRpYyBpbnQgc2NzaWZyb250X3JpbmdfZHJhaW4o
c3RydWN0IHZzY3NpZnJudF9pbmZvICppbmZvLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdW5zaWduZWQgaW50ICplb2lmbGFnKQ0KPj4+IMKgIHsNCj4+PiAtwqDC
oMKgIHN0cnVjdCB2c2NzaWlmX3Jlc3BvbnNlICpyaW5nX3JzcDsNCj4+PiArwqDCoMKgIHN0
cnVjdCB2c2NzaWlmX3Jlc3BvbnNlIHJpbmdfcnNwOw0KPj4+IMKgwqDCoMKgwqAgUklOR19J
RFggaSwgcnA7DQo+Pj4gwqDCoMKgwqDCoCBpbnQgbW9yZV90b19kbyA9IDA7DQo+Pj4gLcKg
wqDCoCBycCA9IGluZm8tPnJpbmcuc3JpbmctPnJzcF9wcm9kOw0KPj4+IC3CoMKgwqAgcm1i
KCk7wqDCoMKgIC8qIG9yZGVyaW5nIHJlcXVpcmVkIHJlc3BlY3RpdmUgdG8gZG9tMCAqLw0K
Pj4+ICvCoMKgwqAgcnAgPSBSRUFEX09OQ0UoaW5mby0+cmluZy5zcmluZy0+cnNwX3Byb2Qp
Ow0KPj4+ICvCoMKgwqAgdmlydF9ybWIoKTvCoMKgwqAgLyogb3JkZXJpbmcgcmVxdWlyZWQg
cmVzcGVjdGl2ZSB0byBiYWNrZW5kICovDQo+Pj4gK8KgwqDCoCBpZiAoUklOR19SRVNQT05T
RV9QUk9EX09WRVJGTE9XKCZpbmZvLT5yaW5nLCBycCkpIHsNCj4+PiArwqDCoMKgwqDCoMKg
wqAgc2NzaWZyb250X3NldF9lcnJvcihpbmZvLCAiaWxsZWdhbCBudW1iZXIgb2YgcmVzcG9u
c2VzIik7DQo+Pg0KPj4NCj4+IEluIG5ldCBhbmQgYmxvY2sgZHJpdmVycyB3ZSByZXBvcnQg
bnVtYmVyIG9mIHN1Y2ggcmVzcG9uc2VzLiAoQnV0IG5vdCBpbiB1c2IpDQo+IEknbSBub3Qg
c3VyZSB0aGUgc3BlY2lmaWMgdmFsdWUgaXMgb2YgYW55IGludGVyZXN0Lg0KPiANCj4+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+Pj4gK8KgwqDCoCB9DQo+Pj4gwqDCoMKgwqDC
oCBmb3IgKGkgPSBpbmZvLT5yaW5nLnJzcF9jb25zOyBpICE9IHJwOyBpKyspIHsNCj4+PiAt
wqDCoMKgwqDCoMKgwqAgcmluZ19yc3AgPSBSSU5HX0dFVF9SRVNQT05TRSgmaW5mby0+cmlu
ZywgaSk7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHNjc2lmcm9udF9kb19yZXNwb25zZShpbmZv
LCByaW5nX3JzcCk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIFJJTkdfQ09QWV9SRVNQT05TRSgm
aW5mby0+cmluZywgaSwgJnJpbmdfcnNwKTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgc2NzaWZy
b250X2RvX3Jlc3BvbnNlKGluZm8sICZyaW5nX3JzcCk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKg
IGlmIChpbmZvLT5ob3N0X2FjdGl2ZSA9PSBTVEFURV9FUlJPUikNCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+PiArwqDCoMKgwqDCoMKgwqAgKmVvaWZsYWcg
PSAwOw0KPj4NCj4+DQo+PiAqZW9pZmxhZ3MgJj0gflhFTl9FT0lfRkxBR19TUFVSSU9VUzsg
Pw0KPiANCj4gWWVzLCBwcm9iYWJseSBiZXR0ZXIuDQo+IA0KPj4gV2UgYWxzbyB1c2UgZW9p
X2ZsYWdzIG5hbWUgaW4gb3RoZXIgaW5zdGFuY2VzIGluIHRoaXMgZmlsZS4NCj4gDQo+IEkn
bGwgdW5pZnkgdGhlIG5hbWUuDQoNCk9oLCBlb2lfZmxhZ3MgaXMgdXNlZCBpbiB0aGUgYmFj
a2VuZCBkcml2ZXIuIFNvIG5vdGhpbmcgdG8gdW5pZnkuDQoNCg0KSnVlcmdlbg0K
--------------JopTs9tb0nos5y7CFuy9ALV3
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------JopTs9tb0nos5y7CFuy9ALV3--

--------------dNyHNIA0JsXSFk76jcObWza7--

--------------lrbiipHtViPigkxsk5QxRda5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJheFcFAwAAAAAACgkQsN6d1ii/Ey/T
jAf+PLx0YSgtXWb/kP9ZZG/6r1QHcj88BZwf8qFrjRFvlKsjF1KOxvZCn2AMroAqiv8RtgjeDjbv
z/7Ub9WUrQSezMH4Iznz+ppWGsnha88EAyNXlzE4mmn2GT/IfVgyHoM9NcrCb3cJK1+mXlSQ0VNj
Ti0/rkX6cNXcWwd1fRs9uTJq/rwlXVJn8l8gZ8EBY6LTVVEA5Scj9YczFGT6tkYFFsA1iZcmCcjC
yDTI4tecM2nSUMcoiYh5L2hQ5Uup0AQ1UORotJP/VKpmSLURcPIIFrN66hgOqDe0WZOXZcMFKuuw
So+lAQ/L7yK1vvBmSLNHfu/smOtXpyVOB3SFL9gVrQ==
=urCh
-----END PGP SIGNATURE-----

--------------lrbiipHtViPigkxsk5QxRda5--
