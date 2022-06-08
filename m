Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201EA542766
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiFHHBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352234AbiFHGPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:15:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA4A3C882E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 22:48:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 922BF1F8D1;
        Wed,  8 Jun 2022 05:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654666598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KG3MDIb67Cqj3RdRueGPvqWvK42QvayLSNru55CBb90=;
        b=l6p0EyyOntxOCkumtHy+TYe+0fcvpu5XzkIU9L9sw5emNs2sb9u6q0cbasELYKZ6guYJ8y
        bqfBuxiQMkkeDsKknt5kFOY103Tn/3WWPgHQ6XipWaOOOY2/0M2q8lnEPJ5c3lL3/UtZ8Q
        Plu258Ciw/rvsjRMm3ohr4Dk/Rh4UAg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0601E13638;
        Wed,  8 Jun 2022 05:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bvEEAGY1oGK7bwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 08 Jun 2022 05:36:37 +0000
Message-ID: <6f09de90-e287-b2c0-2d28-2689337ed768@suse.com>
Date:   Wed, 8 Jun 2022 07:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V4 0/8] virtio: Solution to restrict memory access under
 Xen using xen-grant DMA-mapping layer
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org, x86@kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------P34y19ERRK8XCSHtZtdwIlHD"
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
--------------P34y19ERRK8XCSHtZtdwIlHD
Content-Type: multipart/mixed; boundary="------------4Cjni3eD5XJyKJTrynMPYfTl";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 virtualization@lists.linux-foundation.org, x86@kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig
 <hch@infradead.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Julien Grall <julien@xen.org>,
 Bertrand Marquis <bertrand.marquis@arm.com>, Wei Chen <Wei.Chen@arm.com>,
 Henry Wang <Henry.Wang@arm.com>, Kaly Xin <Kaly.Xin@arm.com>,
 Jiamei Xie <Jiamei.Xie@arm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Message-ID: <6f09de90-e287-b2c0-2d28-2689337ed768@suse.com>
Subject: Re: [PATCH V4 0/8] virtio: Solution to restrict memory access under
 Xen using xen-grant DMA-mapping layer
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
In-Reply-To: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>

--------------4Cjni3eD5XJyKJTrynMPYfTl
Content-Type: multipart/mixed; boundary="------------dd4p2vIgYKq6Mo1aY8vQl8HD"

--------------dd4p2vIgYKq6Mo1aY8vQl8HD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMDYuMjIgMjE6MjMsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiBGcm9t
OiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+
DQo+IA0KPiBIZWxsbyBhbGwuDQo+IA0KPiBUaGUgcHVycG9zZSBvZiB0aGlzIHBhdGNoIHNl
cmllcyBpcyB0byBhZGQgc3VwcG9ydCBmb3IgcmVzdHJpY3RpbmcgbWVtb3J5IGFjY2VzcyB1
bmRlciBYZW4gdXNpbmcgc3BlY2lmaWMNCj4gZ3JhbnQgdGFibGUgWzFdIGJhc2VkIERNQS1t
YXBwaW5nIGxheWVyLiBQYXRjaCBzZXJpZXMgaXMgYmFzZWQgb24gSnVlcmdlbiBHcm9zc+KA
mSBpbml0aWFsIHdvcmsgWzJdIHdoaWNoIGltcGxpZXMNCj4gdXNpbmcgZ3JhbnQgcmVmZXJl
bmNlcyBpbnN0ZWFkIG9mIHJhdyBndWVzdCBwaHlzaWNhbCBhZGRyZXNzZXMgKEdQQSkgZm9y
IHRoZSB2aXJ0aW8gY29tbXVuaWNhdGlvbnMgKHNvbWUNCj4ga2luZCBvZiB0aGUgc29mdHdh
cmUgSU9NTVUpLg0KPiANCj4gWW91IGNhbiBmaW5kIFJGQy1WMyBwYXRjaCBzZXJpZXMgKGFu
ZCBwcmV2aW91cyBkaXNjdXNzaW9ucykgYXQgWzNdLg0KPiANCj4gISEhIFBsZWFzZSBub3Rl
LCB0aGUgb25seSBkaWZmIGJldHdlZW4gVjMgYW5kIFY0IGlzIGluIGNvbW1pdCAjNSwgYWxz
byBJIGhhdmUgY29sbGVjdGVkIHRoZSBhY2tzIChjb21taXRzICMjNC03KS4NCj4gDQo+IFRo
ZSBoaWdoIGxldmVsIGlkZWEgaXMgdG8gY3JlYXRlIG5ldyBYZW7igJlzIGdyYW50IHRhYmxl
IGJhc2VkIERNQS1tYXBwaW5nIGxheWVyIGZvciB0aGUgZ3Vlc3QgTGludXggd2hvc2UgbWFp
bg0KPiBwdXJwb3NlIGlzIHRvIHByb3ZpZGUgYSBzcGVjaWFsIDY0LWJpdCBETUEgYWRkcmVz
cyB3aGljaCBpcyBmb3JtZWQgYnkgdXNpbmcgdGhlIGdyYW50IHJlZmVyZW5jZSAoZm9yIGEg
cGFnZQ0KPiB0byBiZSBzaGFyZWQgd2l0aCB0aGUgYmFja2VuZCkgd2l0aCBvZmZzZXQgYW5k
IHNldHRpbmcgdGhlIGhpZ2hlc3QgYWRkcmVzcyBiaXQgKHRoaXMgaXMgZm9yIHRoZSBiYWNr
ZW5kIHRvDQo+IGJlIGFibGUgdG8gZGlzdGluZ3Vpc2ggZ3JhbnQgcmVmIGJhc2VkIERNQSBh
ZGRyZXNzIGZyb20gbm9ybWFsIEdQQSkuIEZvciB0aGlzIHRvIHdvcmsgd2UgbmVlZCB0aGUg
YWJpbGl0eQ0KPiB0byBhbGxvY2F0ZSBjb250aWd1b3VzIChjb25zZWN1dGl2ZSkgZ3JhbnQg
cmVmZXJlbmNlcyBmb3IgbXVsdGktcGFnZSBhbGxvY2F0aW9ucy4gQW5kIHRoZSBiYWNrZW5k
IHRoZW4gbmVlZHMNCj4gdG8gb2ZmZXIgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGFuZCBW
SVJUSU9fRl9WRVJTSU9OXzEgZmVhdHVyZSBiaXRzIChpdCBtdXN0IHN1cHBvcnQgdmlydGlv
LW1taW8gbW9kZXJuDQo+IHRyYW5zcG9ydCBmb3IgNjQtYml0IGFkZHJlc3NlcyBpbiB0aGUg
dmlydHF1ZXVlKS4NCj4gDQo+IFhlbidzIGdyYW50IG1hcHBpbmcgbWVjaGFuaXNtIGlzIHRo
ZSBzZWN1cmUgYW5kIHNhZmUgc29sdXRpb24gdG8gc2hhcmUgcGFnZXMgYmV0d2VlbiBkb21h
aW5zIHdoaWNoIHByb3Zlbg0KPiB0byB3b3JrIGFuZCB3b3JrcyBmb3IgeWVhcnMgKGluIHRo
ZSBjb250ZXh0IG9mIHRyYWRpdGlvbmFsIFhlbiBQViBkcml2ZXJzIGZvciBleGFtcGxlKS4g
U28gZmFyLCB0aGUgZm9yZWlnbg0KPiBtYXBwaW5nIGlzIHVzZWQgZm9yIHRoZSB2aXJ0aW8g
YmFja2VuZCB0byBtYXAgYW5kIGFjY2VzcyBndWVzdCBtZW1vcnkuIFdpdGggdGhlIGZvcmVp
Z24gbWFwcGluZywgdGhlIGJhY2tlbmQNCj4gaXMgYWJsZSB0byBtYXAgYXJiaXRyYXJ5IHBh
Z2VzIGZyb20gdGhlIGd1ZXN0IG1lbW9yeSAob3IgZXZlbiBmcm9tIERvbTAgbWVtb3J5KS4g
QW5kIGFzIHRoZSByZXN1bHQsIHRoZSBtYWxpY2lvdXMNCj4gYmFja2VuZCB3aGljaCBydW5z
IGluIGEgbm9uLXRydXN0ZWQgZG9tYWluIGNhbiB0YWtlIGFkdmFudGFnZSBvZiB0aGlzLiBJ
bnN0ZWFkLCB3aXRoIHRoZSBncmFudCBtYXBwaW5nDQo+IHRoZSBiYWNrZW5kIGlzIG9ubHkg
YWxsb3dlZCB0byBtYXAgcGFnZXMgd2hpY2ggd2VyZSBleHBsaWNpdGx5IGdyYW50ZWQgYnkg
dGhlIGd1ZXN0IGJlZm9yZSBhbmQgbm90aGluZyBlbHNlLg0KPiBBY2NvcmRpbmcgdG8gdGhl
IGRpc2N1c3Npb25zIGluIHZhcmlvdXMgbWFpbmxpbmUgdGhyZWFkcyB0aGlzIHNvbHV0aW9u
IHdvdWxkIGxpa2VseSBiZSB3ZWxjb21lIGJlY2F1c2UgaXQNCj4gcGVyZmVjdGx5IGZpdHMg
aW4gdGhlIHNlY3VyaXR5IG1vZGVsIFhlbiBwcm92aWRlcy4NCj4gDQo+IFdoYXQgaXMgbW9y
ZSwgdGhlIGdyYW50IHRhYmxlIGJhc2VkIHNvbHV0aW9uIHJlcXVpcmVzIHplcm8gY2hhbmdl
cyB0byB0aGUgWGVuIGh5cGVydmlzb3IgaXRzZWxmIGF0IGxlYXN0DQo+IHdpdGggdmlydGlv
LW1taW8gYW5kIERUIChpbiBjb21wYXJpc29uLCBmb3IgZXhhbXBsZSwgd2l0aCAiZm9yZWln
biBtYXBwaW5nICsgdmlydGlvLWlvbW11IiBzb2x1dGlvbiB3aGljaCB3b3VsZA0KPiByZXF1
aXJlIHRoZSB3aG9sZSBuZXcgY29tcGxleCBlbXVsYXRvciBpbiBoeXBlcnZpc29yIGluIGFk
ZGl0aW9uIHRvIG5ldyBmdW5jdGlvbmFsaXR5L2h5cGVyY2FsbCB0byBwYXNzIElPVkENCj4g
ZnJvbSB0aGUgdmlydGlvIGJhY2tlbmQgcnVubmluZyBlbHNld2hlcmUgdG8gdGhlIGh5cGVy
dmlzb3IgYW5kIHRyYW5zbGF0ZSBpdCB0byB0aGUgR1BBIGJlZm9yZSBtYXBwaW5nIGludG8N
Cj4gUDJNIG9yIGRlbnlpbmcgdGhlIGZvcmVpZ24gbWFwcGluZyByZXF1ZXN0IGlmIG5vIGNv
cnJlc3BvbmRpbmcgSU9WQS1HUEEgbWFwcGluZyBwcmVzZW50IGluIHRoZSBJT01NVSBwYWdl
IHRhYmxlDQo+IGZvciB0aGF0IHBhcnRpY3VsYXIgZGV2aWNlKS4gV2Ugb25seSBuZWVkIHRv
IHVwZGF0ZSB0b29sc3RhY2sgdG8gaW5zZXJ0ICJ4ZW4sZ3JhbnQtZG1hIiBJT01NVSBub2Rl
ICh0byBiZSByZWZlcnJlZA0KPiBieSB0aGUgdmlydGlvLW1taW8gZGV2aWNlIHVzaW5nICJp
b21tdXMiIHByb3BlcnR5KSB3aGVuIGNyZWF0aW5nIGEgZ3Vlc3QgZGV2aWNlLXRyZWUgKHRo
aXMgaXMgYW4gaW5kaWNhdG9yIGZvcg0KPiB0aGUgZ3Vlc3QgdG8gdXNlIFhlbiBncmFudCBt
YXBwaW5ncyBzY2hlbWUgZm9yIHRoYXQgZGV2aWNlIHdpdGggdGhlIGVuZHBvaW50IElEIGJl
aW5nIHVzZWQgYXMgSUQgb2YgWGVuIGRvbWFpbg0KPiB3aGVyZSB0aGUgY29ycmVzcG9uZGlu
ZyBiYWNrZW5kIGlzIHJ1bm5pbmcsIHRoZSBiYWNrZW5kIGRvbWlkIGlzIHVzZWQgYXMgYW4g
YXJndW1lbnQgdG8gdGhlIGdyYW50IG1hcHBpbmcgQVBJcykuDQo+IEl0IHdvcnRoIG1lbnRp
b25pbmcgdGhhdCB0b29sc3RhY2sgcGF0Y2ggaXMgYmFzZWQgb24gbm9uIHVwc3RyZWFtZWQg
eWV0IOKAnFZpcnRpbyBzdXBwb3J0IGZvciB0b29sc3RhY2sgb24gQXJt4oCdDQo+IHNlcmll
cyB3aGljaCBpcyBvbiByZXZpZXcgbm93IFs0XS4NCj4gDQo+IFBsZWFzZSBub3RlIHRoZSBm
b2xsb3dpbmc6DQo+IC0gUGF0Y2ggc2VyaWVzIG9ubHkgY292ZXJzIEFybSBhbmQgdmlydGlv
LW1taW8gKGRldmljZS10cmVlKSBmb3Igbm93LiBUbyBlbmFibGUgdGhlIHJlc3RyaWN0ZWQg
bWVtb3J5IGFjY2Vzcw0KPiAgICBmZWF0dXJlIG9uIEFybSB0aGUgZm9sbG93aW5nIG9wdGlv
biBzaG91bGQgYmUgc2V0Og0KPiAgICBDT05GSUdfWEVOX1ZJUlRJTz15DQo+IC0gUGF0Y2gg
c2VyaWVzIGlzIGJhc2VkIG9uICJrZXJuZWw6IGFkZCBuZXcgaW5mcmFzdHJ1Y3R1cmUgZm9y
IHBsYXRmb3JtX2hhcygpIHN1cHBvcnQiIHBhdGNoIHNlcmllcyB3aGljaA0KPiAgICBpcyBv
biByZXZpZXcgbm93IFs1XQ0KPiAtIFhlbiBzaG91bGQgYmUgYnVpbHQgd2l0aCB0aGUgZm9s
bG93aW5nIG9wdGlvbnM6DQo+ICAgIENPTkZJR19JT1JFUV9TRVJWRVI9eQ0KPiAgICBDT05G
SUdfRVhQRVJUPXkNCj4gDQo+IFBhdGNoIHNlcmllcyBpcyByZWJhc2VkIG9uICJmb3ItbGlu
dXMtNS4xOSIgYnJhbmNoIFsxXSB3aXRoICJwbGF0Zm9ybV9oYXMoKSIgc2VyaWVzIGFwcGxp
ZWQgYW5kIHRlc3RlZCBvbiBSZW5lc2FzDQo+IFNhbHZhdG9yLVggYm9hcmQgKyBIMyBFUzMu
MCBTb0MgKEFybTY0KSB3aXRoIHN0YW5kYWxvbmUgdXNlcnNwYWNlIChub24tUWVtdSkgdmly
dGlvLW1taW8gYmFzZWQgdmlydGlvLWRpc2sgYmFja2VuZA0KPiBydW5uaW5nIGluIERyaXZl
ciBkb21haW4gYW5kIExpbnV4IGd1ZXN0IHJ1bm5pbmcgb24gZXhpc3RpbmcgdmlydGlvLWJs
ayBkcml2ZXIgKGZyb250ZW5kKS4gTm8gaXNzdWVzIHdlcmUgb2JzZXJ2ZWQuDQo+IEd1ZXN0
IGRvbWFpbiAncmVib290L2Rlc3Ryb3knIHVzZS1jYXNlcyB3b3JrIHByb3Blcmx5Lg0KPiBJ
IGhhdmUgYWxzbyB0ZXN0ZWQgb3RoZXIgdXNlLWNhc2VzIHN1Y2ggYXMgYXNzaWduaW5nIHNl
dmVyYWwgdmlydGlvIGJsb2NrIGRldmljZXMgb3IgYSBtaXggb2YgdmlydGlvIGFuZCBYZW4g
UFYgYmxvY2sNCj4gZGV2aWNlcyB0byB0aGUgZ3Vlc3QuIFBhdGNoIHNlcmllcyB3YXMgYnVp
bGQtdGVzdGVkIG9uIEFybTMyIGFuZCB4ODYuDQo+IA0KPiAxLiBYZW4gY2hhbmdlcyBsb2Nh
dGVkIGF0IChsYXN0IHBhdGNoKToNCj4gaHR0cHM6Ly9naXRodWIuY29tL290eXNoY2hlbmtv
MS94ZW4vY29tbWl0cy9saWJ4bF92aXJ0aW9fbmV4dDJfMQ0KPiAyLiBMaW51eCBjaGFuZ2Vz
IGxvY2F0ZWQgYXQgKGxhc3QgOCBwYXRjaGVzKToNCj4gaHR0cHM6Ly9naXRodWIuY29tL290
eXNoY2hlbmtvMS9saW51eC9jb21taXRzL3ZpcnRpb19ncmFudDkNCj4gMy4gdmlydGlvLWRp
c2sgY2hhbmdlcyBsb2NhdGVkIGF0Og0KPiBodHRwczovL2dpdGh1Yi5jb20vb3R5c2hjaGVu
a28xL3ZpcnRpby1kaXNrL2NvbW1pdHMvdmlydGlvX2dyYW50DQo+IA0KPiBBbnkgZmVlZGJh
Y2svaGVscCB3b3VsZCBiZSBoaWdobHkgYXBwcmVjaWF0ZWQuDQo+IA0KPiBbMV0gaHR0cHM6
Ly94ZW5iaXRzLnhlbnByb2plY3Qub3JnL2RvY3MvNC4xNi10ZXN0aW5nL21pc2MvZ3JhbnQt
dGFibGVzLnR4dA0KPiBbMl0gaHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj1JcmxF
ZGFJVURQaw0KPiBbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRldmVsLzE2NDk5
NjM5NzMtMjI4NzktMS1naXQtc2VuZC1lbWFpbC1vbGVrc3R5c2hAZ21haWwuY29tLw0KPiAg
ICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3hlbi1kZXZlbC8xNjUwNjQ2MjYzLTIyMDQ3
LTEtZ2l0LXNlbmQtZW1haWwtb2xla3N0eXNoQGdtYWlsLmNvbS8NCj4gICAgICBodHRwczov
L2xvcmUua2VybmVsLm9yZy94ZW4tZGV2ZWwvMTY1MTk0NzU0OC00MDU1LTEtZ2l0LXNlbmQt
ZW1haWwtb2xla3N0eXNoQGdtYWlsLmNvbS8NCj4gICAgICBodHRwczovL2xvcmUua2VybmVs
Lm9yZy94ZW4tZGV2ZWwvMTY1Mzk0NDQxNy0xNzE2OC0xLWdpdC1zZW5kLWVtYWlsLW9sZWtz
dHlzaEBnbWFpbC5jb20vDQo+IFs0XSBodHRwczovL2xvcmUua2VybmVsLm9yZy94ZW4tZGV2
ZWwvMTY1NDEwNjI2MS0yODA0NC0xLWdpdC1zZW5kLWVtYWlsLW9sZWtzdHlzaEBnbWFpbC5j
b20vDQo+ICAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRldmVsLzE2NTM5NDQ4
MTMtMTc5NzAtMS1naXQtc2VuZC1lbWFpbC1vbGVrc3R5c2hAZ21haWwuY29tLw0KPiBbNV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRldmVsLzIwMjIwNTA0MTU1NzAzLjEzMzM2
LTEtamdyb3NzQHN1c2UuY29tLw0KPiBbNl0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQveGVuL3RpcC5naXQvbG9nLz9oPWZvci1saW51cy01LjE5
DQo+IA0KPiBKdWVyZ2VuIEdyb3NzICgzKToNCj4gICAgeGVuL2dyYW50czogc3VwcG9ydCBh
bGxvY2F0aW5nIGNvbnNlY3V0aXZlIGdyYW50cw0KPiAgICB4ZW4vZ3JhbnQtZG1hLW9wczog
QWRkIG9wdGlvbiB0byByZXN0cmljdCBtZW1vcnkgYWNjZXNzIHVuZGVyIFhlbg0KPiAgICB4
ZW4vdmlydGlvOiBFbmFibGUgcmVzdHJpY3RlZCBtZW1vcnkgYWNjZXNzIHVzaW5nIFhlbiBn
cmFudCBtYXBwaW5ncw0KPiANCj4gT2xla3NhbmRyIFR5c2hjaGVua28gKDUpOg0KPiAgICBh
cm0veGVuOiBJbnRyb2R1Y2UgeGVuX3NldHVwX2RtYV9vcHMoKQ0KPiAgICBkdC1iaW5kaW5n
czogQWRkIHhlbixncmFudC1kbWEgSU9NTVUgZGVzY3JpcHRpb24gZm9yIHhlbi1ncmFudCBE
TUEgb3BzDQo+ICAgIHhlbi9ncmFudC1kbWEtaW9tbXU6IEludHJvZHVjZSBzdHViIElPTU1V
IGRyaXZlcg0KPiAgICB4ZW4vZ3JhbnQtZG1hLW9wczogUmV0cmlldmUgdGhlIElEIG9mIGJh
Y2tlbmQncyBkb21haW4gZm9yIERUIGRldmljZXMNCj4gICAgYXJtL3hlbjogQXNzaWduIHhl
bi1ncmFudCBETUEgb3BzIGZvciB4ZW4tZ3JhbnQgRE1BIGRldmljZXMNCj4gDQo+ICAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUveGVuLGdyYW50LWRtYS55YW1sICAgfCAgMzkg
KysrDQo+ICAgYXJjaC9hcm0vaW5jbHVkZS9hc20veGVuL3hlbi1vcHMuaCAgICAgICAgICAg
ICAgICAgfCAgIDIgKw0KPiAgIGFyY2gvYXJtL21tL2RtYS1tYXBwaW5nLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICA3ICstDQo+ICAgYXJjaC9hcm0veGVuL2VubGlnaHRlbi5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgIGFyY2gvYXJtNjQvaW5j
bHVkZS9hc20veGVuL3hlbi1vcHMuaCAgICAgICAgICAgICAgIHwgICAyICsNCj4gICBhcmNo
L2FybTY0L21tL2RtYS1tYXBwaW5nLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyAr
LQ0KPiAgIGFyY2gveDg2L3hlbi9lbmxpZ2h0ZW5faHZtLmMgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAyICsNCj4gICBhcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2LmMgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgMiArDQo+ICAgZHJpdmVycy94ZW4vS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjAgKysNCj4gICBkcml2ZXJzL3hlbi9NYWtl
ZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ICAgZHJpdmVy
cy94ZW4vZ3JhbnQtZG1hLWlvbW11LmMgICAgICAgICAgICAgICAgICAgICAgfCAgNzggKysr
KysNCj4gICBkcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMgICAgICAgICAgICAgICAgICAg
ICAgICB8IDM0NSArKysrKysrKysrKysrKysrKysrKysNCj4gICBkcml2ZXJzL3hlbi9ncmFu
dC10YWJsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDI1MSArKysrKysrKysrKyst
LS0NCj4gICBpbmNsdWRlL3hlbi9hcm0veGVuLW9wcy5oICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxOCArKw0KPiAgIGluY2x1ZGUveGVuL2dyYW50X3RhYmxlLmggICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gICBpbmNsdWRlL3hlbi94ZW4tb3BzLmggICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMyArDQo+ICAgaW5jbHVkZS94ZW4veGVu
LmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDggKw0KPiAgIDE3IGZp
bGVzIGNoYW5nZWQsIDc1NiBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkNCj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lv
bW11L3hlbixncmFudC1kbWEueWFtbA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2Fy
bS9pbmNsdWRlL2FzbS94ZW4veGVuLW9wcy5oDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gvYXJtNjQvaW5jbHVkZS9hc20veGVuL3hlbi1vcHMuaA0KPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL3hlbi9ncmFudC1kbWEtaW9tbXUuYw0KPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgaW5jbHVkZS94ZW4vYXJtL3hlbi1vcHMuaA0KPiANCg0KU2VyaWVzIHB1c2hlZCB0byB4
ZW4vdGlwLmdpdCBmb3ItbGludXMtNS4xOWENCg0KDQpKdWVyZ2VuDQo=
--------------dd4p2vIgYKq6Mo1aY8vQl8HD
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------dd4p2vIgYKq6Mo1aY8vQl8HD--

--------------4Cjni3eD5XJyKJTrynMPYfTl--

--------------P34y19ERRK8XCSHtZtdwIlHD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKgNWUFAwAAAAAACgkQsN6d1ii/Ey+Y
VQf+MQwIc1tv3W1x0pqbhO3puOeqRHmfRA5BwDPmgpPLyriNEGyDPD2/94WysvuZSCqvQFFq9V3m
E1XshX6hY1GwLE0tx6CKT7pcRbAJxKr6sV5bn7TUBHE0Xc5A3Tm3IyHzrgPMuK2+2pIIMpN5NpoO
kOq9Exlj3ZNktlJytoEyWcbTqHrSK8L0RNjszXglC8qzG0qkWCaimopz23VnV7tD3mFjGWgz+6qS
RLM+cRYW2A86h07mIFtB5qRvsPIdaCWAe9/MrKt5mZ4QlPaHUX4WEkEF1kjS19bX5pzuhvwwNY5P
YaWzFRnrPQQjKqSl0s+7nLarLEhIvC2tx0qBxDFHFw==
=4rPU
-----END PGP SIGNATURE-----

--------------P34y19ERRK8XCSHtZtdwIlHD--
