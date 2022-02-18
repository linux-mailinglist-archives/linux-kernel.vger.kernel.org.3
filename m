Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E474BB4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiBRI4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:56:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiBRI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:56:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B5E93183;
        Fri, 18 Feb 2022 00:56:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93EB22110B;
        Fri, 18 Feb 2022 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645174567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kiKJN3y1zPPffaYK4kA7yK6j2A+IN68x5YRAkMEkxns=;
        b=ST0zI4SIO9pKYnFSsCihkpuuVeeZTkpZpgIFWmSbU+6ywoosWw+HSpts2/8BSZxLvgqBBI
        lTL2SrZhR/SVUnvUgjtBNJBun4SZWf7RSWt/b7VLdRQXmj5nNgBQfw0o1+yDwZ7RN0H6Ex
        ZgB9Lpzmq58MZrKM6ipK7J1NGvyrcAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645174567;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kiKJN3y1zPPffaYK4kA7yK6j2A+IN68x5YRAkMEkxns=;
        b=SJAmdwxVRT+8UTh25usTxlotiF0iAwJNgZg0QV77ZeFCcn8bqYvfANy8UyhqFEpgNfi6zJ
        4COKQEvjRvvXtzCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 556BB13C34;
        Fri, 18 Feb 2022 08:56:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KgjdEydfD2JqWwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 18 Feb 2022 08:56:07 +0000
Message-ID: <bdfe2a30-de5c-f05c-dc31-d405efc3a82d@suse.de>
Date:   Fri, 18 Feb 2022 09:56:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/8] drm: Add support for low-color frame buffer formats
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220215165226.2738568-1-geert@linux-m68k.org>
 <Yg6yBOVTEqyPqRUc@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <Yg6yBOVTEqyPqRUc@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pbHRuaPfqnEZ3GGSaEqbXb0i"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pbHRuaPfqnEZ3GGSaEqbXb0i
Content-Type: multipart/mixed; boundary="------------aGaloi2WMOqYILvg9n6s2SgG";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-fbdev@vger.kernel.org,
 linux-m68k@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-ID: <bdfe2a30-de5c-f05c-dc31-d405efc3a82d@suse.de>
Subject: Re: [PATCH 0/8] drm: Add support for low-color frame buffer formats
References: <20220215165226.2738568-1-geert@linux-m68k.org>
 <Yg6yBOVTEqyPqRUc@ravnborg.org>
In-Reply-To: <Yg6yBOVTEqyPqRUc@ravnborg.org>

--------------aGaloi2WMOqYILvg9n6s2SgG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDE3LjAyLjIyIHVtIDIxOjM3IHNjaHJpZWIgU2FtIFJhdm5ib3JnOg0KPiBIaSBH
ZWVydCwNCj4gDQo+IE9uIFR1ZSwgRmViIDE1LCAyMDIyIGF0IDA1OjUyOjE4UE0gKzAxMDAs
IEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4+IAlIaSBhbGwsDQo+Pg0KPj4gQSBsb25n
IG91dHN0YW5kaW5nIGlzc3VlIHdpdGggdGhlIERSTSBzdWJzeXN0ZW0gaGFzIGJlZW4gdGhl
IGxhY2sgb2YNCj4+IHN1cHBvcnQgZm9yIGxvdy1jb2xvciBkaXNwbGF5cywgYXMgdXNlZCB0
eXBpY2FsbHkgb24gb2xkZXIgZGVza3RvcA0KPj4gc3lzdGVtcyBhbmQgc21hbGwgZW1iZWRk
ZWQgZGlzcGxheXMuDQo+IA0KPiBUaGlzIGlzIG9uZSBvZiB0aGUgcGllY2VzIG1pc3Npbmcg
Zm9yIGEgbG9uZyB0aW1lIC0gZ3JlYXQgdG8gc2VlDQo+IHNvbWV0aGluZyBkb25lIGhlcmUu
IFRoYW5rcyBHZWVydCENCg0KQWJzb2x1dGVseSEgSSdtIGxvb2tpbmcgZm9yd2FyZCB0byBz
ZWUgdGhlc2UgcGF0Y2hlcyBiZWluZyBtZXJnZWQuDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFz
DQoNCj4gDQo+IAlTYW0NCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJp
dmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFH
IE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------aGaloi2WMOqYILvg9n6s2SgG--

--------------pbHRuaPfqnEZ3GGSaEqbXb0i
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmIPXyYFAwAAAAAACgkQlh/E3EQov+CR
bxAAyAmhIJ/PgdOp5h3c83lSq7wy8ua2Kw84LB3k1nwb4LVsj5Gmk84XfgU9C2Lod2ytNiDeeNq8
DxLhss+/rXSKDLr9WZLmWo5NCbx1M/Ui5a9HfNUx378mqw3NP6sSuR77ksLkJ3XWPqFMUhjNyV3x
h2jwHjAf9Q5aZTIoQPfEAcdB3NNPRmloOT79J26LI+D5IK1UlRKlRjA82bcqx1UxcPUNKtOp0hE1
kmu5fitApliapki0GHW9WJML0oT8+TLjv4VUXQAXC2LxqcquvVPkjEQYURF3Q0zDIoiuFIQo6FJB
H3VwwFzPx9IXy6lgWrYvw31dH0hwjfjB9rr9rHP0JE4/e4FoLTUJCUqWaafAnHF2LAdHPzrsTAQN
FGnU0ki6Edfph2RGTBVwbaA3Q+SERyVjTbSfKeyt8R3GENBhhgQQLYwRZvmXmsgWQNbSB7QDxRTf
xALw+p+We3vXrwUsh64gMfpe4qoX6MPeqXrVWvVqtNthqDs6MfYOoK0yqL/utvvWI5HUqhqA+Dv/
PASz06hZQD78BBMm/UmH7PP6mJAPVhcPJKBUBKUQhcfOxI0k2RkctxARcuKazBApCUtBEQyIr5HE
JKs3XvuN4ZqXuovpIrVMs8lN5+fwlEMYanTgpzy5qVoScTuU5m1TEs0f0uanzQ88clDs0/KXbyqC
qBc=
=OjU+
-----END PGP SIGNATURE-----

--------------pbHRuaPfqnEZ3GGSaEqbXb0i--
