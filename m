Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7953CDDA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344289AbiFCRND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344271AbiFCRM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:12:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A2A32EFD;
        Fri,  3 Jun 2022 10:12:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d14so2180901wra.10;
        Fri, 03 Jun 2022 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=heoyqnC1HegSIl6H2Ca1sR/uckXCIN7MowxKsf+kzP4=;
        b=T8Od8q63vbj+y9+5qZEE7jxVtj3yEkAiktykXQQBxKkFaKVpBPWh3IZDcR056atxQ3
         O4D10QxWNi/mnaNj9NLldZpuGYN+6T7ofFAkpHNmwCaHhk3llqlTCqyeBU5PQaC4Xa0i
         qnRJGkCt/CqoBwGy6yCHGF2Y5hvhlRJ3BYyUfULgPs/+3wl+z5U6vV54/4MXwoi2qJdV
         Wg4bdlBcp6zU4xk+6v+Iw6JP8t9Wb/7LutbPwyE+x0peFjaWumRa+9hM0MvFTud5QjIF
         CcDWg23RSKxUJUmaVP9lwTMEbHKDst8FzkKhFetLhwRxZekq/bVoqp8pjARFQG8gIar+
         lrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=heoyqnC1HegSIl6H2Ca1sR/uckXCIN7MowxKsf+kzP4=;
        b=trK7e8tcu29NF37+Mi6WanvBplJThmHqM6piK7pqjWiu6fgMu057YHXmbblnhFqxry
         4Mhhlo3rPQTmIIpIPVXtdlygQvRM7eF2d4kr8iyDY3NHu0d+ds4kgsw3qgjJ+CdmEaA9
         8hSQDyVXyfEqhcG68QNVwywYLMeHF0l4lQLLOXnYhxiRTilQtFIISfWZZeMoSqV9QVA1
         Cki5OdEw+vfFLeGuDWOIHpXLMem0Gv3qESgotb0q1s8VWqOG539QLGyjs/rPYONgRd6A
         VvjR4LUtEUUnXo2pVVMJbsVkMIMO53z6ih6wjpXEJOHXNnEUp58reiyuky7+Lo6Rih4q
         Y47g==
X-Gm-Message-State: AOAM5325ppaHYLKWtgRSKsIeTeYT3EJG8xP6gHfwXQi1tVssb2965Cbq
        gUukh0U8XjEMqqZnrpXupAk=
X-Google-Smtp-Source: ABdhPJxHjhsbNvhiq6XGo2g+i1q6Bsw+tTdumlB4J1eE+QTxftcPa7vLaGVm9CUbEE1W0qHUdKzUkg==
X-Received: by 2002:a5d:6b07:0:b0:20d:97f:ca6b with SMTP id v7-20020a5d6b07000000b0020d097fca6bmr8989589wrw.390.1654276376388;
        Fri, 03 Jun 2022 10:12:56 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d6d47000000b0020e5e906e47sm7679363wri.75.2022.06.03.10.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 10:12:55 -0700 (PDT)
Message-ID: <22004457-a6a8-1e9e-4220-ae15339ec94b@gmail.com>
Date:   Fri, 3 Jun 2022 19:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] userfaultfd.2: Update on write-protection support
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220531011157.46868-1-peterx@redhat.com>
 <20220531011157.46868-3-peterx@redhat.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220531011157.46868-3-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fBOETOUw4GKqOh24LOYpoYQ1"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fBOETOUw4GKqOh24LOYpoYQ1
Content-Type: multipart/mixed; boundary="------------ItUDOLrw1UTMRnHSSHbj2rGi";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-man@vger.kernel.org, linux-mm@kvack.org
Cc: Axel Rasmussen <axelrasmussen@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Nadav Amit <nadav.amit@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Message-ID: <22004457-a6a8-1e9e-4220-ae15339ec94b@gmail.com>
Subject: Re: [PATCH 2/2] userfaultfd.2: Update on write-protection support
References: <20220531011157.46868-1-peterx@redhat.com>
 <20220531011157.46868-3-peterx@redhat.com>
In-Reply-To: <20220531011157.46868-3-peterx@redhat.com>

--------------ItUDOLrw1UTMRnHSSHbj2rGi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUGV0ZXIsDQoNCk9uIDUvMzEvMjIgMDM6MTEsIFBldGVyIFh1IHdyb3RlOg0KPiBUaGUg
c2htZW0vaHVnZXRsYmZzIG1lbW9yeSB0eXBlcyBhcmUgc3VwcG9ydGVkIGZvciB3cml0ZS1w
cm90ZWN0aW9uDQo+IG1lc3NhZ2VzIHZlcnkgbGF0ZWx5LiAgVXBkYXRlIHRoZSBtYW4gcGFn
ZSB0byByZWZsZWN0IHRoYXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBYdSA8cGV0
ZXJ4QHJlZGhhdC5jb20+DQoNClBsZWFzZSBzZWUgc29tZSBzb3VyY2UgZm9ybWF0dGluZyBj
b21tZW50cyBiZWxvdy4NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCj4gLS0tDQo+ICAgbWFuMi91
c2VyZmF1bHRmZC4yIHwgOCArKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWFuMi91c2Vy
ZmF1bHRmZC4yIGIvbWFuMi91c2VyZmF1bHRmZC4yDQo+IGluZGV4IDA5MjhhNzZkMi4uOTlh
YWU4YjUwIDEwMDY0NA0KPiAtLS0gYS9tYW4yL3VzZXJmYXVsdGZkLjINCj4gKysrIGIvbWFu
Mi91c2VyZmF1bHRmZC4yDQo+IEBAIC0yNzMsMTMgKzI3MywxNyBAQCBTaW5jZSBMaW51eCA0
LjExLA0KPiAgIHVzZXJmYXVsdGZkIGNhbiBiZSBhbHNvIHVzZWQgd2l0aCBodWdldGxiZnMg
YW5kIHNoYXJlZCBtZW1vcnkgbWFwcGluZ3MuDQo+ICAgLlwiDQo+ICAgLlNTIFVzZXJmYXVs
dGZkIHdyaXRlLXByb3RlY3QgbW9kZSAoc2luY2UgNS43KQ0KPiAtU2luY2UgTGludXggNS43
LCB1c2VyZmF1bHRmZCBzdXBwb3J0cyB3cml0ZS1wcm90ZWN0IG1vZGUuDQo+ICtTaW5jZSBM
aW51eCA1LjcsIHVzZXJmYXVsdGZkIHN1cHBvcnRzIHdyaXRlLXByb3RlY3QgbW9kZSBmb3Ig
YW5vbnltb3VzIG1lbW9yeS4NCj4gICBUaGUgdXNlciBuZWVkcyB0byBmaXJzdCBjaGVjayBh
dmFpbGFiaWxpdHkgb2YgdGhpcyBmZWF0dXJlIHVzaW5nDQo+ICAgLkIgVUZGRElPX0FQSQ0K
PiAgIGlvY3RsIGFnYWluc3QgdGhlIGZlYXR1cmUgYml0DQo+ICAgLkIgVUZGRF9GRUFUVVJF
X1BBR0VGQVVMVF9GTEFHX1dQDQo+ICAgYmVmb3JlIHVzaW5nIHRoaXMgZmVhdHVyZS4NCj4g
ICAuUFANCj4gK1NpbmNlIExpbnV4IDUuMTksIHRoZSB3cml0ZS1wcm90ZWN0aW9uIG1vZGUg
d2FzIGFsc28gc3VwcG9ydGVkIG9uIHNobWVtIGFuZCBodWdldGxiZnMNCj4gK21lbW9yeSB0
eXBlcy4gSXQgY2FuIGJlIGRldGVjdGVkIHdpdGggdGhlIGZlYXR1cmUgYml0DQoNClNlZSBt
YW4tcGFnZXMoNyk6DQoNClsNCiAgICBVc2Ugc2VtYW50aWMgbmV3bGluZXMNCiAgICAgICAg
SW4gdGhlIHNvdXJjZSBvZiBhIG1hbnVhbCBwYWdlLCBuZXcgc2VudGVuY2VzICBzaG91bGQg
IGJlDQogICAgICAgIHN0YXJ0ZWQgIG9uIG5ldyBsaW5lcywgYW5kIGxvbmcgc2VudGVuY2Vz
IHNob3VsZCBiZSBzcGxpdA0KICAgICAgICBpbnRvIGxpbmVzIGF0IGNsYXVzZSBicmVha3Mg
KGNvbW1hcywgc2VtaWNvbG9ucywgIGNvbG9ucywNCiAgICAgICAgYW5kICBzbyBvbikuICBU
aGlzIGNvbnZlbnRpb24sIHNvbWV0aW1lcyBrbm93biBhcyAic2VtYW7igJANCiAgICAgICAg
dGljIG5ld2xpbmVzIiwgbWFrZXMgaXQgIGVhc2llciAgdG8gIHNlZSAgdGhlICBlZmZlY3Qg
IG9mDQogICAgICAgIHBhdGNoZXMsICB3aGljaCAgb2Z0ZW4gb3BlcmF0ZSBhdCB0aGUgbGV2
ZWwgb2YgaW5kaXZpZHVhbA0KICAgICAgICBzZW50ZW5jZXMgb3Igc2VudGVuY2UgY2xhdXNl
cy4NCl0NCg0KPiArLkJSIFVGRkRfRkVBVFVSRV9XUF9IVUdFVExCRlNfU0hNRU0gLg0KPiAr
LlBQDQo+ICAgVG8gcmVnaXN0ZXIgd2l0aCB1c2VyZmF1bHRmZCB3cml0ZS1wcm90ZWN0IG1v
ZGUsIHRoZSB1c2VyIG5lZWRzIHRvIGluaXRpYXRlIHRoZQ0KPiAgIC5CIFVGRkRJT19SRUdJ
U1RFUg0KPiAgIGlvY3RsIHdpdGggbW9kZQ0KPiBAQCAtMzMwLDggKzMzNCw2IEBAIGlvY3Rs
LCB3aG9zZQ0KPiAgIHNob3VsZCBoYXZlIHRoZSBmbGFnDQo+ICAgLkIgVUZGRElPX1dSSVRF
UFJPVEVDVF9NT0RFX1dQDQo+ICAgY2xlYXJlZCB1cG9uIHRoZSBmYXVsdGVkIHBhZ2Ugb3Ig
cmFuZ2UuDQo+IC0uUFANCj4gLVdyaXRlLXByb3RlY3QgbW9kZSBzdXBwb3J0cyBvbmx5IHBy
aXZhdGUgYW5vbnltb3VzIG1lbW9yeS4NCj4gICAuU1MgUmVhZGluZyBmcm9tIHRoZSB1c2Vy
ZmF1bHRmZCBzdHJ1Y3R1cmUNCj4gICBFYWNoDQo+ICAgLkJSIHJlYWQgKDIpDQoNCi0tIA0K
QWxlamFuZHJvIENvbG9tYXINCjxodHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4N
Cg==

--------------ItUDOLrw1UTMRnHSSHbj2rGi--

--------------fBOETOUw4GKqOh24LOYpoYQ1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmKaQRUACgkQnowa+77/
2zKQfQ/+IhnZ8dmD1iq7u4YhY9yS7igSYq5xcG9CDNg6CkEqWCEurL4ZC76qSu2I
JoR3CHfy4FzYB9fQ/WE6qd/EZRLEPHnooagzd2j3rnE36tyxuRBwc7Hurzt2VUtw
tSODui8yWhs6w/1VDiHIw7bXhJ+xd8Qo4h9Guz2HzeiiH62YLpTINu4UzwwVB/ID
MfxAf2vxAA/S9NWUn20gPEvdHlUQGU6Yc+F45eS30fwSwp6IASW8VbMwfoWqqvMU
k2AK47HvyFmPD7iG2LeM3AKd98/KxFqIAHsQ42tKuXr19L9+zXr6KXD7KciGvkQb
29oviQ3Y6CUPYHipiXIDodsyuJDSbMQy3bbsqMK8tR5iSNFy7kEw4/J4tFMRKX8W
Vr1evE9tQ4yJuI+H0Wd0KcnP81rHK46rZJl8SBMEyU5O77D2uCKaoR33cNHCAkQZ
bYo4OvGBFxe4+L1wqq1a6WpmTMm2MQKsVLLbVQtCLqQL8YB5gk9HiZ3xqLepoUSn
K77nsVf+VJGbxnYPaiHEhjYrr/i3KXx+K4wQ/8o/Uiz8SE5bsO9217HJbxpA/uXd
3OhpzF06pMCmgWmQLcbohdX5M9P7TIoIMzH8mfFpijHOO7MEpoeUzHQGk3bnw3QS
t0wrVfOyUnyvRqJxdHnnAStrVvTgNGahLZ6+SbcXST6s8kaDyjc=
=BkMT
-----END PGP SIGNATURE-----

--------------fBOETOUw4GKqOh24LOYpoYQ1--
