Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C66A4E7D36
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiCYUCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiCYUCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:02:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBA2986D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:53:18 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8619D210E6;
        Fri, 25 Mar 2022 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648237997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxYb5yHhmm3/dSyN/bJZ8zKU0ICNkPQKubctgz6pQVQ=;
        b=u3hLN86z6WCVrY2IaBcsH32z/krz/DbRJdTO+apO8S3XEB984cj1LCU8GAitNl88nAa47I
        mqzd2wc11ToN3YFSlyjjCESZJEK3RB0P/hd60WRiFwy+seA7CaiZ3H9880dstt4veu8Dgg
        xLjKSWr26YTPot685XAqF0DOPgI7dZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648237997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxYb5yHhmm3/dSyN/bJZ8zKU0ICNkPQKubctgz6pQVQ=;
        b=HAl1C9hB/ROrCdXUdRGV9GEObNZq+JVOZUIwUyuow8GywW4wjtKFKn7qyefeHtC93dyPI0
        UfDTmGqdABgzlMBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7065213873;
        Fri, 25 Mar 2022 19:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HNZLGq0dPmJ8fQAAGKfGzw
        (envelope-from <tzimmermann@suse.de>); Fri, 25 Mar 2022 19:53:17 +0000
Message-ID: <70c6bc0c-72a1-7d0c-5bc1-a1c5b92af032@suse.de>
Date:   Fri, 25 Mar 2022 20:53:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [Bisected] Latest kernel won't boot
Content-Language: en-US
To:     Harald Arnesen <harald@skogtun.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <934ec507-a2cb-28cc-cb36-9b07519c4302@skogtun.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <934ec507-a2cb-28cc-cb36-9b07519c4302@skogtun.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9B9UdUCAEMKYXjUUmSOpmhpT"
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
--------------9B9UdUCAEMKYXjUUmSOpmhpT
Content-Type: multipart/mixed; boundary="------------yOt7Gjn02fPqiIQIiIzFOAio";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Harald Arnesen <harald@skogtun.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <70c6bc0c-72a1-7d0c-5bc1-a1c5b92af032@suse.de>
Subject: Re: [Bisected] Latest kernel won't boot
References: <934ec507-a2cb-28cc-cb36-9b07519c4302@skogtun.org>
In-Reply-To: <934ec507-a2cb-28cc-cb36-9b07519c4302@skogtun.org>

--------------yOt7Gjn02fPqiIQIiIzFOAio
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjUuMDMuMjIgdW0gMTk6NDEgc2NocmllYiBIYXJhbGQgQXJuZXNlbjoNCj4g
U2VlIGF0dGFjaGVkIHBpY3R1cmUuDQo+IA0KPiBSZXZlcnRpbmcgY29tbWl0IDBkMDMwMTE4
OTRkMjMyNDFkYjFhMWNhZDVjMTJhZWRlNjA4OTdkNSBmaXhlcyB0aGUgaXNzdWUuDQo+IA0K
PiBUaGlzIGlzIG9uIGEgVGhpbmtwYWQgVDUyMCB3aXRoIEludGVsIGdyYXBoaWNzLiBDb25m
aWcgaXMgYXR0YWNoZWQuDQoNCkEgZml4IGlzIGFscmVhZHkgb24gaXQncyB3YXkgaW50byB0
aGUga2VybmVsLiBTZWUNCg0KIA0KaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9kcm0v
ZHJtL2NvbW1pdC8/aD1kcm0tbmV4dC0yMDIyLTAzLTI1JmlkPTJhODFkYmE0YjU3NzA5OTcx
N2NlYTg2ZDQyOWYwNTNlODVlNzRkOTYNCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KDQot
LSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jD
pGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------yOt7Gjn02fPqiIQIiIzFOAio--

--------------9B9UdUCAEMKYXjUUmSOpmhpT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmI+HawFAwAAAAAACgkQlh/E3EQov+DM
kg//WhZH3H2g2eHfXEBQJX3okVg79KCLN6AXO+LDdrXt/abwBa02pTJpZjxzdVd7SGjDUwjZyHcr
JOexfIXLLT3yhHoSrUn4fetQyAC7Kim0zV2l5xzUyV4ijKaLmeOZKr7z7CvRMoDhLc5nPSfXKyai
W83n2r8jPiqYs1XNblH2jaCRtLRxQaUR0VrIkVd6dUfotsWMCNAphg1h4e/FJe0NtI30zH6SoMiL
NOk/7BztOyr/KwJPu5OwWGQ2Mq3h0FyI73xBfcYjZ1CRw0JAFSjBXcC5f3lh/fTpMU5JIcgmVJtL
waEL8IyNcqH2P4aIXwiZ88+q5BentqbMEF/8PfFDny1lBEQcRI6xy5vnkIh6NPV2Aw5WRUxiRNYZ
VlE0BPdFsGoybMYPoyn1a80gyE4YT0sSLM+6CjVZOitI3vJS8V/tG3fO1z2LSdPThm+U/TwuZvnq
Z9qwzymlJxjHHK0vAifi9o0xgOf8cveS1ijFLlne/+Ijl8kFwt129FVIDDG6Lwao3F3hQ98Q3q8M
OHEpi1HLRMB+r6vOXi/Z3abWzsfONqO0PaUKBgI6IEuzvSAYZ7VfEf3ldOJObdvLtgACwuUePdfb
PcCXOUIJ5ce6S+2iEHKP6//bVkxsrmrgeIkq9sy/AvDJAPl44E8nFq/aIB6DccPSm1pga+RRm553
m6w=
=j6W6
-----END PGP SIGNATURE-----

--------------9B9UdUCAEMKYXjUUmSOpmhpT--
