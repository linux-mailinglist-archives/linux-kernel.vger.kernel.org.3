Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836614D9458
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbiCOGLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbiCOGLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:11:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5549F9D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:10:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B5C8E1F391;
        Tue, 15 Mar 2022 06:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647324619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBMUNurecPF8Y85BnPuMM4wfLEGKltenwgjpYkSDT+s=;
        b=sZolrUCxYPQvi/BHcF3UJt08AscdC4sI33LAKS/jmq8MYkYqjIYlnTgBdaLxCGGJonyy6t
        LGR1aA79id76b6DWEHF0dalvRRssYscuOx1yiR+7pfrraDGV15Ew14BQi4lr3+2ohHJrVR
        gHKgbi9YzGZaF04odj4Yklqgaeq78+o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91F9B1333E;
        Tue, 15 Mar 2022 06:10:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TYYDIsstMGKOMgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 15 Mar 2022 06:10:19 +0000
Message-ID: <1633fb91-3771-e37c-14ce-43f1b0cda6a0@suse.com>
Date:   Tue, 15 Mar 2022 07:10:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] xen/grant-table: remove gnttab_*transfer*() functions
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20220311103429.12845-1-jgross@suse.com>
 <20220311103429.12845-2-jgross@suse.com>
 <63365484-7035-f2bd-5317-2e95d65993f7@oracle.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <63365484-7035-f2bd-5317-2e95d65993f7@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EEIkysVNYzUiG06vSeZ1qouw"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EEIkysVNYzUiG06vSeZ1qouw
Content-Type: multipart/mixed; boundary="------------zaOqujjtlt1VlU0O9yUFZMcY";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <1633fb91-3771-e37c-14ce-43f1b0cda6a0@suse.com>
Subject: Re: [PATCH 1/2] xen/grant-table: remove gnttab_*transfer*() functions
References: <20220311103429.12845-1-jgross@suse.com>
 <20220311103429.12845-2-jgross@suse.com>
 <63365484-7035-f2bd-5317-2e95d65993f7@oracle.com>
In-Reply-To: <63365484-7035-f2bd-5317-2e95d65993f7@oracle.com>

--------------zaOqujjtlt1VlU0O9yUFZMcY
Content-Type: multipart/mixed; boundary="------------wU4WnJfcRK4iZYGFdve8dTAt"

--------------wU4WnJfcRK4iZYGFdve8dTAt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMDMuMjIgMDA6MzcsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4gDQo+IE9uIDMv
MTEvMjIgNTozNCBBTSwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IEFsbCBncmFudCB0YWJs
ZSBvcGVyYXRpb25zIHJlbGF0ZWQgdG8gdGhlICJ0cmFuc2ZlciIgZnVuY3Rpb25hbGl0eQ0K
Pj4gYXJlIHVudXNlZCBjdXJyZW50bHkuIFRoZXJlIGhhdmUgYmVlbiB1c2VycyBpbiB0aGUg
b2xkIGRheXMgb2YgdGhlDQo+PiAiWGVuLW8tTGludXgiIGtlcm5lbCwgYnV0IHRob3NlIGRp
ZG4ndCBtYWtlIGl0IHVwc3RyZWFtLg0KPj4NCj4+IFNvIHJlbW92ZSB0aGUgInRyYW5zZmVy
IiByZWxhdGVkIGZ1bmN0aW9ucy4NCj4gDQo+IA0KPiBEbyB3ZSBuZWVkIHRvIGFzc2VydCBz
b21ld2hlcmUgdGhhdCB0cmFuc2ZlciBmbGFncyBhcmUgbm90IHNldD8NCg0KVGhpcyB3b3Vs
ZCBiZSBhbiBvcnRob2dvbmFsIGNoYW5nZSwgcmlnaHQ/IE15IHBhdGNoIGlzIGp1c3QgcmVt
b3ZpbmcNCm5ldmVyIGNhbGxlZCBmdW5jdGlvbnMuDQoNCkluIGFueSBjYXNlIEkgYmVsaWV2
ZSBjaGVja2luZyB0aG9zZSBmbGFncyBpcyB0aGUgam9iIG9mIHRoZSBoeXBlcnZpc29yLg0K
SWYgYW4gb3BlcmF0aW9uIGlzIGlsbGVnYWwgZHVlIHRvIGEgdHJhbnNmZXIgZmxhZyBiZWlu
ZyBzZXQsIGl0IG5lZWRzIHRvDQpiZSByZWplY3RlZCBhdCBoeXBlcnZpc29yIGxldmVsLg0K
DQoNCkp1ZXJnZW4NCg==
--------------wU4WnJfcRK4iZYGFdve8dTAt
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------wU4WnJfcRK4iZYGFdve8dTAt--

--------------zaOqujjtlt1VlU0O9yUFZMcY--

--------------EEIkysVNYzUiG06vSeZ1qouw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmIwLcsFAwAAAAAACgkQsN6d1ii/Ey8I
7QgAiF6wFA5yY04zgn6CQwqX1adP+E1VtWJ8sWb3d4FZnlSs6MB9eeggPF8yknmaWzhBCFQiXDXk
Brr4CVryD9lBc0ZSvgB7DmxAlxgA6XfZce+8rlY0LDqElhBy0PZ+YH4QNnhb0HchUtbl4/w8Iafh
XWNpEcAP5hkOo0oFeny6N2RinnxWrQUecNyASdwKc/35HXnvcriiJ2YQ1uFowE2Hu0cxtG5vCpn3
K7b8Vdd+e/YbBG3H0ulwP8aE3v1bJDq4/BSz3b/5anIVPKjIIk+R1t0l73aQt6+EWACZMT1svn9r
LWSQ5AdvRg8omZjJu02sKxT7n4QbpF9owGdYkugn8w==
=+ElC
-----END PGP SIGNATURE-----

--------------EEIkysVNYzUiG06vSeZ1qouw--
