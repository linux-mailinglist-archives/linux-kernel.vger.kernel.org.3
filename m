Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A1253CDD2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbiFCRLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiFCRLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:11:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E71B842;
        Fri,  3 Jun 2022 10:11:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q26so810533wra.1;
        Fri, 03 Jun 2022 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=fRgAh9J+c4jC08uZIjr2kYb768T1tZJ/nb/Oa3hwP7c=;
        b=crjJbS8WoGLij/bLFL/Nzsd81KSJtrINJrTvItv49P2SRolieRROmBigQVsGisyVG0
         HGbQvF1wru2Fbgx1Up60UQJpZIAwKNJTou9V35+fSjDEeV8iZ6lntOyLl0XbGUFeZqB+
         QInwkamUhRLy/ocVypiU+AWTIC9q/JjFDS07c8WyupLEvLHkCatu+4cEWK2UCo6kFAdp
         q7mqn4iuqWMjj+/r2RH/YuLXIVPZiWzz1SWTPwx5DTz6KF657l1G1XcStJs7evp/CDoO
         hfZPSvoKDMOcZOZq6nXmdn/zbwY+QDdjjb/GcuPa0tqGNjxdTxrCOU/RsSMGThb35Y5G
         eXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=fRgAh9J+c4jC08uZIjr2kYb768T1tZJ/nb/Oa3hwP7c=;
        b=52ek1Qfe38Y/0P9WSVk/lDe+ZFGREfzFGAfEDk6UiY3AirFjNhqb0eSAQZilgA1tqE
         0mr9AqLK5NhUZ8ak7UVAzctA/FdONwdTR4t1nnBTKPF2JRbGQghWTthPreaFZrafAcXE
         loZlqDP245LlEz2fQSfPNB3iMkcVGmLoIaehOdZS2m5BcjooJH4R2iRHHMlAIz01su0R
         GbxSkZkr+7VFaCSVyXjuEA9Pa6KIFz4w6bCB4MBMgqqqHGA3zq/izhD0bLycGWaPWoyN
         LSUUcRb8vNjRB4TKApOTDpsD+5GVUGh2WfOMw73OCGMw6vKtvjC2uH2t/+ZT6vlbCZxd
         5Fmw==
X-Gm-Message-State: AOAM5330wcmGGsudXTP34kFrvl8hH6kJy59x+uijQBpcQp4dPZp43nxV
        a/TnTdPcZuhgZtNoqRf3/Fs=
X-Google-Smtp-Source: ABdhPJyRl8yQRV3zL7FJAxD2z2vGOI8zsKa70FXhZIrYKkFfjuq0kVrfAAsKJ37AJb4NgULVZHU7Sw==
X-Received: by 2002:adf:d1c6:0:b0:20f:c7dc:8466 with SMTP id b6-20020adfd1c6000000b0020fc7dc8466mr8906508wrd.43.1654276268474;
        Fri, 03 Jun 2022 10:11:08 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4643000000b002103a7c5c91sm7628089wrs.43.2022.06.03.10.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 10:11:07 -0700 (PDT)
Message-ID: <ce05bd8d-087d-cfa8-6aca-02fd1f3aebb7@gmail.com>
Date:   Fri, 3 Jun 2022 19:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] userfaultfd.2: Add section for UFFD_USER_MODE_ONLY
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220531011157.46868-1-peterx@redhat.com>
 <20220531011157.46868-2-peterx@redhat.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220531011157.46868-2-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JWowZshMgmYd5lniQsWsnDAD"
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
--------------JWowZshMgmYd5lniQsWsnDAD
Content-Type: multipart/mixed; boundary="------------0U42xYdKBOm0yFeiwgYZ8D7l";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-man@vger.kernel.org, linux-mm@kvack.org
Cc: Axel Rasmussen <axelrasmussen@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Nadav Amit <nadav.amit@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Message-ID: <ce05bd8d-087d-cfa8-6aca-02fd1f3aebb7@gmail.com>
Subject: Re: [PATCH 1/2] userfaultfd.2: Add section for UFFD_USER_MODE_ONLY
References: <20220531011157.46868-1-peterx@redhat.com>
 <20220531011157.46868-2-peterx@redhat.com>
In-Reply-To: <20220531011157.46868-2-peterx@redhat.com>

--------------0U42xYdKBOm0yFeiwgYZ8D7l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUGV0ZXIsDQoNCk9uIDUvMzEvMjIgMDM6MTEsIFBldGVyIFh1IHdyb3RlOg0KPiBBZGQg
YSBwYXJhZ3JhcGggZm9yIFVGRkRfVVNFUl9NT0RFX09OTFkgZmxhZyB0aGF0IHdhcyBpbnRy
b2R1Y2VkIGluDQo+IExpbnV4IDUuMTEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBY
dSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQoNClNlZSBzb21lIG1pbm9yIGNvbW1lbnRzIGJlbG93
Lg0KDQpDaGVlcnMsDQoNCkFsZXgNCg0KPiAtLS0NCj4gICBtYW4yL3VzZXJmYXVsdGZkLjIg
fCAxNCArKysrKysrKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21hbjIvdXNlcmZhdWx0
ZmQuMiBiL21hbjIvdXNlcmZhdWx0ZmQuMg0KPiBpbmRleCBjZWU3YzAxZDIuLjA5MjhhNzZk
MiAxMDA2NDQNCj4gLS0tIGEvbWFuMi91c2VyZmF1bHRmZC4yDQo+ICsrKyBiL21hbjIvdXNl
cmZhdWx0ZmQuMg0KPiBAQCAtMjksOCArMjksOSBAQA0KPiAgIHVzZXJmYXVsdGZkIFwtIGNy
ZWF0ZSBhIGZpbGUgZGVzY3JpcHRvciBmb3IgaGFuZGxpbmcgcGFnZSBmYXVsdHMgaW4gdXNl
ciBzcGFjZQ0KPiAgIC5TSCBTWU5PUFNJUw0KPiAgIC5uZg0KPiAtLkJSICIjaW5jbHVkZSA8
ZmNudGwuaD4iICIgICAgICAgICAgICAvKiBEZWZpbml0aW9uIG9mICIgT18qICIgY29uc3Rh
bnRzICovIg0KPiAtLkJSICIjaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4iICIgICAgICAvKiBE
ZWZpbml0aW9uIG9mICIgU1lTXyogIiBjb25zdGFudHMgKi8iDQo+ICsuQlIgIiNpbmNsdWRl
IDxmY250bC5oPiIgIiAgICAgICAgICAgICAvKiBEZWZpbml0aW9uIG9mICIgT18qICIgY29u
c3RhbnRzICovIg0KPiArLkJSICIjaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4iICIgICAgICAg
LyogRGVmaW5pdGlvbiBvZiAiIFNZU18qICIgY29uc3RhbnRzICovIg0KPiArLkJSICIjaW5j
bHVkZSA8bGludXgvdXNlcmZhdWx0ZmQuaD4iICIgLyogRGVmaW5pdGlvbiBvZiAiIFVGRkRf
KiAiIGNvbnN0YW50cyAqLyINCj4gICAuQiAjaW5jbHVkZSA8dW5pc3RkLmg+DQo+ICAgLlBQ
DQo+ICAgLkJJICJpbnQgc3lzY2FsbChTWVNfdXNlcmZhdWx0ZmQsIGludCAiIGZsYWdzICk7
DQo+IEBAIC03Niw2ICs3NywxNSBAQCBTZWUgdGhlIGRlc2NyaXB0aW9uIG9mIHRoZQ0KPiAg
IC5CUiBPX05PTkJMT0NLDQo+ICAgZmxhZyBpbg0KPiAgIC5CUiBvcGVuICgyKS4NCj4gKy5U
UA0KPiArLkJSIFVGRkRfVVNFUl9NT0RFX09OTFkNCg0KDQpzL0JSL0IvDQoNCnNlZSBncm9m
Zl9tYW4oNyk6DQoNClsNCglbLi4uXQ0KDQogICAgICAgIC5CIFt0ZXh0XQ0KICAgICAgICAg
ICAgICAgU2V0IHRleHQgaW4gYm9sZC4gIElmIHRoZSBtYWNybyBpcyBnaXZlbiBubyAgYXJn
deKAkA0KICAgICAgICAgICAgICAgbWVudHMsICB0aGUgIHRleHQgb2YgdGhlIG5leHQgaW5w
dXQgbGluZSBpcyBzZXQgaW4NCiAgICAgICAgICAgICAgIGJvbGQuDQoNCglbLi4uXQ0KDQog
ICAgICAgIC5CUiBib2xk4oCQdGV4dCByb21hbuKAkHRleHQgLi4uDQogICAgICAgICAgICAg
ICBTZXQgZWFjaCBhcmd1bWVudCBpbiBib2xkIGFuZCByb21hbiwgYWx0ZXJuYXRlbHkuDQpd
DQoNCj4gK1RoaXMgaXMgYW4gdXNlcmZhdWx0ZmQgc3BlY2lmaWMgZmxhZyB0aGF0IHdhcyBp
bnRyb2R1Y2VkIHNpbmNlIExpbnV4IDUuMTEuDQo+ICtXaGVuIHNldCwgdGhlIHVzZXJmYXVs
dGZkIG9iamVjdCB3aWxsIG9ubHkgYmUgYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVsdHMNCj4g
K29yaWdpbmF0ZWQgZnJvbSB0aGUgdXNlcnNwYWNlIG9uIHRoZSByZWdpc3RlcmVkIHJlZ2lv
bnMuDQo+ICtXaGVuIGEga2VybmVsIG9yaWdpbmF0ZWQgZmF1bHQgd2FzIHRyaWdnZXJlZCBv
biB0aGUgcmVnaXN0ZXJlZCByYW5nZSB3aXRoDQo+ICt0aGlzIHVzZXJmYXVsdGZkLCBhDQo+
ICsuQlIgU0lHQlVTDQoNCnMvQlIvQi8NCg0KPiArc2lnbmFsIHdpbGwgYmUgZGVsaXZlcmVk
Lg0KPiAgIC5QUA0KPiAgIFdoZW4gdGhlIGxhc3QgZmlsZSBkZXNjcmlwdG9yIHJlZmVycmlu
ZyB0byBhIHVzZXJmYXVsdGZkIG9iamVjdCBpcyBjbG9zZWQsDQo+ICAgYWxsIG1lbW9yeSBy
YW5nZXMgdGhhdCB3ZXJlIHJlZ2lzdGVyZWQgd2l0aCB0aGUgb2JqZWN0IGFyZSB1bnJlZ2lz
dGVyZWQNCg0KLS0gDQpBbGVqYW5kcm8gQ29sb21hcg0KPGh0dHA6Ly93d3cuYWxlamFuZHJv
LWNvbG9tYXIuZXMvPg0K

--------------0U42xYdKBOm0yFeiwgYZ8D7l--

--------------JWowZshMgmYd5lniQsWsnDAD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmKaQKkACgkQnowa+77/
2zIg6Q/+N9zRypAYrL2ekgAA+dd3ddjtfgtwoqh6y+pIg25ukaFt5sCVtsZa42CG
cShBf/T+4k3OYpNYGylNPBBPsW60dpgn7F3ZVw8oA1EG7+R8fn079BTrmzKE6Eb/
lQ1vJCfEeHIRc3S1g/2dngjXP0c5IuJNT/uIqmRg3hPhZxuT2SVSPD/DpuAD9u/U
lRCUoqLyKmqQMAZE87wNXyEoaKSg/Nuo2NlqfCDgDsrvvipkluk0zprv12qVezlW
7t8mJkgrX8gKNiuEz4I1ORhk5m2bmhR6BNGgmgFPXPN7hNgtYyXPrNq86wepC8Zt
HuJpoD8CLmM4rx9FBSx6W3oTNUMKSlbvFz72qjO6rW4OwRhHKbrgOg2URqggEphJ
oG2XW90e13UJnlkujyvmk4KlhxbMtFE/JcksLBp1Aw9GN/o4UNQCpDSv5xLoscy/
297y/k/oIqDRR8A1pwx77wYDik0eiDKd6QAqXU9z3ChZAS2kQw7l9IbQur1er1Pu
dIvl//EYri7aytBC72S3FwvNjOFVBe0YtjiDvr/4G2ia611DOnJf3lrxkNBa6SW5
eCwXfMfFv0SO8TMRSkbAJaY+iZwmGUVkzl0LTb8lG+FjQnTaCuArtYM6hiqKu7hs
B45lR5meM/zv9ImkWVh0JdD276QsPKU9GzNDdM80a9jhd2ETBpw=
=oyqT
-----END PGP SIGNATURE-----

--------------JWowZshMgmYd5lniQsWsnDAD--
