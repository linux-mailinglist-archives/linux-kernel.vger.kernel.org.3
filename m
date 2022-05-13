Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179F6525B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 07:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377098AbiEMFeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 01:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377088AbiEMFdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 01:33:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D690149AB0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 22:33:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D16421AE2;
        Fri, 13 May 2022 05:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652420030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaNK9VI92CtlLRufqelHTuZqKOQA/3zBp3OZRQgQ4/A=;
        b=NGRd1kaTOR9gXF3g5ClJFREszBP4PQdh6s7fgHjNNMGjRtcluLQekZrKNbxw/xnDC3p+jq
        TuCBukRsHNhwWmix40crh+zQstPofhp/WEzn9EBQG5OwjTBZln9tLxYnQXzc3rTKh5I5ri
        YsFiMzYlJ/+Wj3ZY/LHzBJ7b/tMRzx0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF59E13A84;
        Fri, 13 May 2022 05:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sZhGMb3tfWLIFgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 13 May 2022 05:33:49 +0000
Message-ID: <d1d61bcf-86f9-68cd-9bd4-a13bf8149b88@suse.com>
Date:   Fri, 13 May 2022 07:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
 <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
In-Reply-To: <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Sr9EeqdIb8iPoFhoY08CFv9r"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Sr9EeqdIb8iPoFhoY08CFv9r
Content-Type: multipart/mixed; boundary="------------ss12YByrfgbibODZLOK0ywZB";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Julien Grall
 <julien@xen.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>
Message-ID: <d1d61bcf-86f9-68cd-9bd4-a13bf8149b88@suse.com>
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
 <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>
In-Reply-To: <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>

--------------ss12YByrfgbibODZLOK0ywZB
Content-Type: multipart/mixed; boundary="------------FphEvG0f0pwtWW6kWmn04s0b"

--------------FphEvG0f0pwtWW6kWmn04s0b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDUuMjIgMjI6MDEsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4gDQo+IE9uIDUv
Ny8yMiAyOjE5IFBNLCBPbGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90ZToNCj4+ICsNCj4+ICsv
Kg0KPj4gKyAqIEhhbmRsaW5nIG9mIGZyZWUgZ3JhbnRzOg0KPj4gKyAqDQo+PiArICogRnJl
ZSBncmFudHMgYXJlIGluIGEgc2ltcGxlIGxpc3QgYW5jaG9yZWQgaW4gZ250dGFiX2ZyZWVf
aGVhZC4gVGhleSBhcmUNCj4+ICsgKiBsaW5rZWQgYnkgZ3JhbnQgcmVmLCB0aGUgbGFzdCBl
bGVtZW50IGNvbnRhaW5zIEdOVFRBQl9MSVNUX0VORC4gVGhlIG51bWJlcg0KPj4gKyAqIG9m
IGZyZWUgZW50cmllcyBpcyBzdG9yZWQgaW4gZ250dGFiX2ZyZWVfY291bnQuDQo+PiArICog
QWRkaXRpb25hbGx5IHRoZXJlIGlzIGEgYml0bWFwIG9mIGZyZWUgZW50cmllcyBhbmNob3Jl
ZCBpbg0KPj4gKyAqIGdudHRhYl9mcmVlX2JpdG1hcC4gVGhpcyBpcyBiZWluZyB1c2VkIGZv
ciBzaW1wbGlmeWluZyBhbGxvY2F0aW9uIG9mDQo+PiArICogbXVsdGlwbGUgY29uc2VjdXRp
dmUgZ3JhbnRzLCB3aGljaCBpcyBuZWVkZWQgZS5nLiBmb3Igc3VwcG9ydCBvZiB2aXJ0aW8u
DQo+PiArICogZ250dGFiX2xhc3RfZnJlZSBpcyB1c2VkIHRvIGFkZCBmcmVlIGVudHJpZXMg
b2YgbmV3IGZyYW1lcyBhdCB0aGUgZW5kIG9mDQo+PiArICogdGhlIGZyZWUgbGlzdC4NCj4+
ICsgKiBnbnR0YWJfZnJlZV90YWlsX3B0ciBzcGVjaWZpZXMgdGhlIHZhcmlhYmxlIHdoaWNo
IHJlZmVyZW5jZXMgdGhlIHN0YXJ0DQo+IA0KPiANCj4gSWYgdGhpcyByZWZlcmVuY2VzIHRo
ZSBzdGFydCBvZiB0aGUgZnJlZSBpbnRlcnZhbCwgd2h5IGlzIGl0IGNhbGxlZCANCj4gZ250
dGFiX2ZyZWVfKnRhaWwqX3B0cj8NCg0KQmVjYXVzZSB0aGlzIGlzIHRoZSB0YWlsIG9mIHRo
ZSB3aG9sZSBhcmVhIHdoaWNoIGlzIGZyZWUuDQoNCkl0IGNvdWxkIGJlIHJlbmFtZWQgdG8g
Z250dGFiX2ZyZWVfdGFpbF9zdGFydF9wdHIuIDotKQ0KDQo+IA0KPiANCj4+ICsgKiBvZiBj
b25zZWN1dGl2ZSBmcmVlIGdyYW50cyBlbmRpbmcgd2l0aCBnbnR0YWJfbGFzdF9mcmVlLiBU
aGlzIHBvaW50ZXIgaXMNCj4+ICsgKiB1cGRhdGVkIGluIGEgcmF0aGVyIGRlZmVuc2l2ZSB3
YXksIGluIG9yZGVyIHRvIGF2b2lkIHBlcmZvcm1hbmNlIGhpdHMgaW4NCj4+ICsgKiBob3Qg
cGF0aHMuDQo+PiArICogQWxsIHRob3NlIHZhcmlhYmxlcyBhcmUgcHJvdGVjdGVkIGJ5IGdu
dHRhYl9saXN0X2xvY2suDQo+PiArICovDQo+PiDCoCBzdGF0aWMgaW50IGdudHRhYl9mcmVl
X2NvdW50Ow0KPj4gLXN0YXRpYyBncmFudF9yZWZfdCBnbnR0YWJfZnJlZV9oZWFkOw0KPj4g
K3N0YXRpYyB1bnNpZ25lZCBpbnQgZ250dGFiX3NpemU7DQo+PiArc3RhdGljIGdyYW50X3Jl
Zl90IGdudHRhYl9mcmVlX2hlYWQgPSBHTlRUQUJfTElTVF9FTkQ7DQo+PiArc3RhdGljIGdy
YW50X3JlZl90IGdudHRhYl9sYXN0X2ZyZWUgPSBHTlRUQUJfTElTVF9FTkQ7DQo+PiArc3Rh
dGljIGdyYW50X3JlZl90ICpnbnR0YWJfZnJlZV90YWlsX3B0cjsNCj4+ICtzdGF0aWMgdW5z
aWduZWQgbG9uZyAqZ250dGFiX2ZyZWVfYml0bWFwOw0KPj4gwqAgc3RhdGljIERFRklORV9T
UElOTE9DSyhnbnR0YWJfbGlzdF9sb2NrKTsNCj4+ICsNCj4+IMKgIHN0cnVjdCBncmFudF9m
cmFtZXMgeGVuX2F1dG9feGxhdF9ncmFudF9mcmFtZXM7DQo+PiDCoCBzdGF0aWMgdW5zaWdu
ZWQgaW50IHhlbl9nbnR0YWJfdmVyc2lvbjsNCj4+IMKgIG1vZHVsZV9wYXJhbV9uYW1lZCh2
ZXJzaW9uLCB4ZW5fZ250dGFiX3ZlcnNpb24sIHVpbnQsIDApOw0KPj4gQEAgLTE3MCwxNiAr
MTk0LDExMSBAQCBzdGF0aWMgaW50IGdldF9mcmVlX2VudHJpZXModW5zaWduZWQgY291bnQp
DQo+PiDCoMKgwqDCoMKgIHJlZiA9IGhlYWQgPSBnbnR0YWJfZnJlZV9oZWFkOw0KPj4gwqDC
oMKgwqDCoCBnbnR0YWJfZnJlZV9jb3VudCAtPSBjb3VudDsNCj4+IC3CoMKgwqAgd2hpbGUg
KGNvdW50LS0gPiAxKQ0KPj4gLcKgwqDCoMKgwqDCoMKgIGhlYWQgPSBnbnR0YWJfZW50cnko
aGVhZCk7DQo+PiArwqDCoMKgIHdoaWxlIChjb3VudC0tKSB7DQo+PiArwqDCoMKgwqDCoMKg
wqAgYml0bWFwX2NsZWFyKGdudHRhYl9mcmVlX2JpdG1hcCwgaGVhZCwgMSk7DQo+PiArwqDC
oMKgwqDCoMKgwqAgaWYgKGdudHRhYl9mcmVlX3RhaWxfcHRyID09IF9fZ250dGFiX2VudHJ5
KGhlYWQpKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ250dGFiX2ZyZWVfdGFpbF9w
dHIgPSAmZ250dGFiX2ZyZWVfaGVhZDsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoY291bnQp
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoZWFkID0gZ250dGFiX2VudHJ5KGhlYWQp
Ow0KPj4gK8KgwqDCoCB9DQo+PiDCoMKgwqDCoMKgIGdudHRhYl9mcmVlX2hlYWQgPSBnbnR0
YWJfZW50cnkoaGVhZCk7DQo+PiDCoMKgwqDCoMKgIGdudHRhYl9lbnRyeShoZWFkKSA9IEdO
VFRBQl9MSVNUX0VORDsNCj4+ICvCoMKgwqAgaWYgKCFnbnR0YWJfZnJlZV9jb3VudCkgew0K
Pj4gK8KgwqDCoMKgwqDCoMKgIGdudHRhYl9sYXN0X2ZyZWUgPSBHTlRUQUJfTElTVF9FTkQ7
DQo+PiArwqDCoMKgwqDCoMKgwqAgZ250dGFiX2ZyZWVfdGFpbF9wdHIgPSBOVUxMOw0KPj4g
K8KgwqDCoCB9DQo+PiArDQo+PiDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmdudHRhYl9saXN0X2xvY2ssIGZsYWdzKTsNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIHJlZjsN
Cj4+IMKgIH0NCj4+ICtzdGF0aWMgaW50IGdldF9zZXFfZW50cnlfY291bnQodm9pZCkNCj4+
ICt7DQo+PiArwqDCoMKgIGlmIChnbnR0YWJfbGFzdF9mcmVlID09IEdOVFRBQl9MSVNUX0VO
RCB8fCAhZ250dGFiX2ZyZWVfdGFpbF9wdHIgfHwNCj4+ICvCoMKgwqDCoMKgwqDCoCAqZ250
dGFiX2ZyZWVfdGFpbF9wdHIgPT0gR05UVEFCX0xJU1RfRU5EKQ0KPj4gK8KgwqDCoMKgwqDC
oMKgIHJldHVybiAwOw0KPj4gKw0KPj4gK8KgwqDCoCByZXR1cm4gZ250dGFiX2xhc3RfZnJl
ZSAtICpnbnR0YWJfZnJlZV90YWlsX3B0ciArIDE7DQo+PiArfQ0KPj4gKw0KPj4gKy8qIFJl
YnVpbGRzIHRoZSBmcmVlIGdyYW50IGxpc3QgYW5kIHRyaWVzIHRvIGZpbmQgY291bnQgY29u
c2VjdXRpdmUgZW50cmllcy4gKi8NCj4+ICtzdGF0aWMgaW50IGdldF9mcmVlX3NlcSh1bnNp
Z25lZCBpbnQgY291bnQpDQo+PiArew0KPj4gK8KgwqDCoCBpbnQgcmV0ID0gLUVOT1NQQzsN
Cj4+ICvCoMKgwqAgdW5zaWduZWQgaW50IGZyb20sIHRvOw0KPj4gK8KgwqDCoCBncmFudF9y
ZWZfdCAqbGFzdDsNCj4+ICsNCj4+ICvCoMKgwqAgZ250dGFiX2ZyZWVfdGFpbF9wdHIgPSAm
Z250dGFiX2ZyZWVfaGVhZDsNCj4+ICvCoMKgwqAgbGFzdCA9ICZnbnR0YWJfZnJlZV9oZWFk
Ow0KPj4gKw0KPj4gK8KgwqDCoCBmb3IgKGZyb20gPSBmaW5kX2ZpcnN0X2JpdChnbnR0YWJf
ZnJlZV9iaXRtYXAsIGdudHRhYl9zaXplKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgIGZyb20g
PCBnbnR0YWJfc2l6ZTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgIGZyb20gPSBmaW5kX25leHRf
Yml0KGdudHRhYl9mcmVlX2JpdG1hcCwgZ250dGFiX3NpemUsIHRvICsgMSkpIHsNCj4+ICvC
oMKgwqDCoMKgwqDCoCB0byA9IGZpbmRfbmV4dF96ZXJvX2JpdChnbnR0YWJfZnJlZV9iaXRt
YXAsIGdudHRhYl9zaXplLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGZyb20gKyAxKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0IDwgMCAmJiB0
byAtIGZyb20gPj0gY291bnQpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9
IGZyb207DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaXRtYXBfY2xlYXIoZ250dGFi
X2ZyZWVfYml0bWFwLCByZXQsIGNvdW50KTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGZyb20gKz0gY291bnQ7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnbnR0YWJfZnJl
ZV9jb3VudCAtPSBjb3VudDsNCj4gDQo+IA0KPiBJSVVJQyB3ZSBjYW4gaGF2ZSBtdWx0aXBs
ZSBwYXNzZXMgb3ZlciB0aGlzLCBtZWFuaW5nIHRoYXQgdGhlIGdudHRhYl9mcmVlX2NvdW50
IA0KPiBtYXkgYmUgZGVjcmVtZW50ZWQgbW9yZSB0aGFuIG9uY2UuIElzIHRoYXQgaW50ZW50
aW9uYWw/DQoNCkFmdGVyIHRoZSBmaXJzdCBwYXNzIGRlY3JlbWVudGluZyBnbnR0YWJfZnJl
ZV9jbnQsIHJldCB3aWxsIG5vDQpsb25nZXIgYmUgbGVzcyB0aGFuIHplcm8sIHNvIHRoaXMg
Y2FuIGJlIGhpdCBvbmx5IG9uY2UuDQoNCj4gDQo+IA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKGZyb20gPT0gdG8pDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbnRpbnVlOw0KPj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4+ICsNCj4+ICvCoMKgwqDC
oMKgwqDCoCB3aGlsZSAoZnJvbSA8IHRvKSB7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqbGFzdCA9IGZyb207DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsYXN0ID0gX19n
bnR0YWJfZW50cnkoZnJvbSk7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnbnR0YWJf
bGFzdF9mcmVlID0gZnJvbTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20rKzsN
Cj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiANCj4gSSBoYXZlIGJlZW4gbG9va2luZyBh
dCB0aGlzIGxvb3AgYW5kIEkgY2FuJ3QgdW5kZXJzdGFuZCB3aGF0IGl0IGlzIGRvaW5nIDst
KCBDYW4gDQo+IHlvdSBlbmxpZ2h0ZW4gbWU/DQoNCkl0IGlzIHJlY3JlYXRpbmcgdGhlIGZy
ZWUgbGlzdCBpbiBvcmRlciB0byBoYXZlIGl0IHByb3Blcmx5IHNvcnRlZC4NClRoaXMgaXMg
bmVlZGVkIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBmcmVlIHRhaWwgaGFzIHRoZSBtYXhpbXVt
DQpwb3NzaWJsZSBzaXplICh5b3UgY2FuIHRha2UgdGhlIHRhaWwgb2ZmIHRoZSBsaXN0IHdp
dGhvdXQgaGF2aW5nDQp0byB3b3JyeSBhYm91dCBicmVha2luZyB0aGUgbGlua2VkIGxpc3Qg
YmVjYXVzZSBvZiByZWZlcmVuY2VzIGludG8NCnRoZSB0YWlsKS4NCg0KDQpKdWVyZ2VuDQo=

--------------FphEvG0f0pwtWW6kWmn04s0b
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------FphEvG0f0pwtWW6kWmn04s0b--

--------------ss12YByrfgbibODZLOK0ywZB--

--------------Sr9EeqdIb8iPoFhoY08CFv9r
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJ97b0FAwAAAAAACgkQsN6d1ii/Ey/l
FQf/WRYZFQzeL2rCU3Bru0qDZto4066JMU0804HHabSJhzePs20dNQpUSPrqiIPkCy3cFlcjs/uQ
gh8ThS9wdbfxqmSpG6PDqiKVU3ggP9mcz7OUiGXVH5z3mv4Pxa7xRWc6t8NHm2DbfGi4q/nMHKcq
0CPLvRHfQXugz27DOZWxjx3SmvYQuoNsPyTK7qnuAl8Bq2KwGJEhipNX69aCDrlZLVsCxqWHtBkF
te7agxLVIRoX/ify9yjnWmGeRo/3Zbbv1UDGCNCUlWzwg/9j92N9/y0PzAbn4219F1pxyDMV4BEV
nY3AH1mPgUCiM4gUFkjgFAyZsH2F/W16iFMkSoSqEA==
=Pt1N
-----END PGP SIGNATURE-----

--------------Sr9EeqdIb8iPoFhoY08CFv9r--
