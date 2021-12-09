Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1794946E12F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhLIDRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLIDRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:17:54 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC1CC061746;
        Wed,  8 Dec 2021 19:14:21 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso4859401ota.5;
        Wed, 08 Dec 2021 19:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WV2gMjbo8zpmn6yalGVwgJz9WjCVGnOtaGEF8OGJABM=;
        b=UfHTeYzkD8dkusBEV13P7cMl5gC/axHr9uMmet5SLy4E0BBpO0RCunZvzvGC64kckk
         9qGnhqEk/QtE3VzPRmAPHNgS8uoQ9oduYboSHJ4pVb27XGiSQp1qC1cfU+K99P9CWN8X
         qb8Xyw+yY9xcuvOFrU07T7krKriOl/JHs+iS1RxLiVIoChrBIaFagRVc8LTrDK6DPSh3
         WJBsadU4DbjbOP31NKqJNClFH3/nnOMgu66j+RaYwnZVmX0skJBDWRjnjKqbv7xPhTZW
         HXr8qFFLjdQ1pP0LpwaC7qVcSxnSwxmii7ScZGsiH4Fv1KSEV0DIGNBBBoSqoKiap3eI
         lOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WV2gMjbo8zpmn6yalGVwgJz9WjCVGnOtaGEF8OGJABM=;
        b=HO4eyoHHX9yPZFCMcstwoUC30nfoN4GVz4x8u8X/KeB2coEz2eot543RXC+qK1cT+Q
         2zMw2djOAm2GYfsEcvoF963vzLrFB8Zo8HQM6wDjPJ0Y8Gpl57BFt8SA8wi8MQ5Qs3Ff
         bwc7Wj1WjFMYBGTM0KJbJ01HyMXWGAXkt3WDmLEm3MYnb9Lnm8XWT/hFFdmnUL+VGa/Z
         BTaiOd4oSdVoJLOE6i59x1G1ld4wyyP+dVIhuuISsmYC/dbYcKUifJEbS4cWYhfqdx0N
         bLoDpICcOEkFSDbmEfiwJDwVWGSzF+SYbFxb/EqGNWHT7kTGw1jG8wfzTonjM7k4B3MC
         TJOA==
X-Gm-Message-State: AOAM5338mG2kD7uzhlv7dadHdfaESWhKVW/6vsKSU2jNIFVbcwKXTHyo
        bPJniqoYIx+L1isH/nOMf+W8X4+Rn39u/oAsgpHvmI5aZcU2Dg==
X-Google-Smtp-Source: ABdhPJzevNHQupaPxXE9shHQbDlZZ2Ic4XrblmDBZxoFj6CTRsEmTN1yW6DMcJ6MJ191tFOwt9+BOTxN+T9pKgvjQM0=
X-Received: by 2002:a05:6830:2aa7:: with SMTP id s39mr3250924otu.151.1639019661036;
 Wed, 08 Dec 2021 19:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20211208114125.58472-1-alexs@kernel.org> <CAEensMwzXgw0Y_Eq=6P1LQAhcYeJ+W4UtZz6i-n2xGzc8t204A@mail.gmail.com>
 <CAJy-AmkPm3ims64OHbiT7KgT=ocxGKO_yTFigzORBgVc_7VFDg@mail.gmail.com>
In-Reply-To: <CAJy-AmkPm3ims64OHbiT7KgT=ocxGKO_yTFigzORBgVc_7VFDg@mail.gmail.com>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Thu, 9 Dec 2021 11:14:09 +0800
Message-ID: <CAEensMwjbBhnqhKZjMyMxm1d-aAw6omxmR5yM=6ChKonezxFPg@mail.gmail.com>
Subject: Re: [PATCH] doc/zh_CN: add Chinese document coding style reminder
To:     Alex Shi <seakeel@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Tang Yizhou <tangyizhou@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxleCBTaGkgPHNlYWtlZWxAZ21haWwuY29tPiDkuo4yMDIx5bm0MTLmnIg55pel5ZGo5ZubIDEw
OjQ25YaZ6YGT77yaDQo+DQo+IE9uIFRodSwgRGVjIDksIDIwMjEgYXQgOTozNCBBTSB5YW50ZW5n
IHNpIDxzaXlhbnRlbmcwMUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPGFsZXhzQGtlcm5l
bC5vcmc+IOS6jjIwMjHlubQxMuaciDjml6XlkajkuIkgMTk6NDHlhpnpgZPvvJoNCj4gPiA+DQo+
ID4gPiBGcm9tOiBBbGV4IFNoaSA8YWxleHNAa2VybmVsLm9yZz4NCj4gPiA+DQo+ID4gPiBUaGUg
Y29kaW5nIHN0eWxlIHJlcXVpcmVtZW50IGZvciBDaGluZXNlIGRvY3VtZW50IGlzIGVhc3kgdG8g
YmUgb3Zlcmxvb2tlZC4NCj4gPiA+IEFkZCB0aGUgcmVxdWVzdCBhcyBhIHJlbWRpbmVyLg0KPiA+
ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggU2hpIDxhbGV4c0BrZXJuZWwub3JnPg0KPiA+
ID4gQ2M6IFlhbnRlbmcgU2kgPHNpeWFudGVuZzAxQGdtYWlsLmNvbT4NCj4gPiA+IENjOiBUYW5n
IFlpemhvdSA8dGFuZ3lpemhvdUBodWF3ZWkuY29tPg0KPiA+ID4gQ2M6IEpvbmF0aGFuIENvcmJl
dCA8Y29yYmV0QGx3bi5uZXQ+DQo+ID4gPiBDYzogbGludXgtZG9jQHZnZXIua2VybmVsLm9yZw0K
PiA+ID4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IC0tLQ0KPiA+ID4g
IERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJzdCB8IDQgKysrKw0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0IGIvRG9jdW1l
bnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0DQo+ID4gPiBpbmRleCBhMzRlNTg3
MzNhYzguLjhjMjc4NmVkMDI3OSAxMDA2NDQNCj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJh
bnNsYXRpb25zL3poX0NOL2luZGV4LnJzdA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMvemhfQ04vaW5kZXgucnN0DQo+ID4gPiBAQCAtMjMsNiArMjMsMTAgQEANCj4gPiA+
ICDlj6blpJbvvIzpmo/ml7bmrKLov47mgqjlr7nlhoXmoLjmlofmoaPov5vooYzmlLnov5vvvJvl
poLmnpzmgqjmg7Pmj5DkvpvluK7liqnvvIzor7fliqDlhaV2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+
ICDkuIrnmoRsaW51eC1kb2Ppgq7ku7bliJfooajjgIINCj4gPiA+DQo+ID4gPiAr6aG65L6/6K+0
5LiL77yM5Lit5paH5paH5qGj5Lmf6ZyA6KaB6YG15a6I5YaF5qC457yW56CB6aOO5qC877yM6aOO
5qC85Lit5Lit5paH5ZKM6Iux5paH55qE5Li76KaB5LiN5ZCM5bCx5piv5Lit5paHDQo+ID4gPiAr
55qE5a2X56ym5qCH54K55Y2g55So5Lik5Liq6Iux5paH5a2X56ym5a695bqm77yMIOaJgOS7pe+8
jOW9k+iLseaWh+imgeaxguS4jeimgei2hei/h+avj+ihjDEwMOS4quWtl+espuaXtu+8jA0KPiA+
ID4gK+S4reaWh+WwseS4jeimgei2hei/hzUw5Liq5a2X56ym44CC5Y+m5aSW77yM5Lmf6KaB5rOo
5oSPJy0n77yMJz0nIOetieespuWPt+S4juebuOWFs+agh+mimOeahOWvuem9kOOAgg0KPiA+IEhv
dyBhYm91dDoNCj4gPiDlj6blpJbvvIwnLSfvvIwnPScg562J56ym5Y+36ZyA6KaB5LiO55u45YWz
5qCH6aKY5a+56b2QLCDkuLrkuobnhafpob7msqHmnInlm77lvaLnlYzpnaLlkozkuaDmg6/nlKh2
aeafpemYheaWh+ahow0KPiA+IOeahOW8gOWPkeiAhe+8jOS4reaWh+aWh+aho+eahOaWh+acrOWd
l+OAgeauteiQveetieS5n+W6lOWDj+iLseaWh+aWh+aho+mCo+agt+aVtOaVtOm9kOm9kOOAgg0K
PiA+DQo+ID4g5Zyo5bCG6KGl5LiB5o+Q5Lqk5Yiw56S+5Yy65LmL5YmN77yM5LiA5a6a6KaB6L+b
6KGM5b+F6KaB55qEY2hlY2twYXRjaC5wbOajgOafpeWSjOe8luivkea1i+ivle+8jOe9kemhteeJ
iA0KPiA+IOaWh+aho+WcqOmDqOWIhua1j+iniOWZqOS4reaaguaXtuWPr+iDveS8muWHuueOsOWk
muS9meeahOepuuagvO+8jOebruWJjeW3suefpWZpcmVmb3jmraPluLjvvIzmja7kuobop6PvvIzm
tY8NCj4gPiDop4jlmajop4TojIPojYnmoYjkuK3lt7LmnInor6Xpl67popjnmoTop6PlhrPmlrnm
oYjvvIzlsIbmnaXmnInluIzmnJvop6PlhrPjgIINCj4NCj4gbmljZS4NCj4NCj4gPg0KPiA+IC4u
IOWwj+aKgOW3pzog57+76K+R5pe26Lef6ZqP6Iux5paH5paH5pys5Z2X5o2i6KGM5peg6ZyA5YWz
5b+D5Lit5paH5q+P6KGM5piv5ZCm6LaF5a2X5pWw77yM5Lmf5LiN55So5ouF5b+D5ryP5o6J56m6
DQo+ID4gICAgICAgICAgICAgICAg6KGM5ZKM57yp6L+b5Lul5Y+K5ryP57+76K+R77yM5Zug5Li6
5oiR5Lus5Y+q6ZyA5Y6f5Zyw6L+b6KGM5Lit6Iux5paH5a2X56ym5Liy5pu/5o2i5bCx5Y+v5Lul
5LqG44CCDQo+DQo+IHRoZSBsaW5lIGJ5IGxpbmUgcmVwbGFjZSBtYXkgbGVhZCB0byB1bmFsaWdu
bWVudCBpc3N1ZSwgZG8gd2UgbmVlZCB0aGlzIHRpcHM/DQpJIG1lYW4gdGhhdCB1c3VhbGx5LCB0
aGUgRW5nbGlzaCBkb2N1bWVudCBhIGxpbmUgb2YgY2hhcnMgaXMgYWJvdXQgODAsDQp3ZSB0cmFu
c2xhdGUsIGEgbGluZSBvZiBDaGluZXNlIHdyaXR0ZW4gdG8gdGhlIHNhbWUgbGVuZ3RoIGFzIHRo
ZQ0KRW5nbGlzaCwgd2Ugd2lsbCBicmVhayB0aGUgbGluZSwgc28gdGhhdCB3ZSBkbyBub3QgaGF2
ZSB0byBjb3VudC4NCuWkp+aEj+WwseaYr+e/u+ivkeaXtu+8jOaKiuiLseaWh+aWh+aho+WkjeWI
tuWIsHpoX0NO5a+55bqU5Zyw5pa577yM55u05o6l5Zyo6Iux5paH5paH5qGj6YeM6Z2i5YGa5q61
6JC95pu/5o2i77yM5oiR5Lus5Y+q6KaB5pe25Yi75L+d5oyB5a+56b2Q6Iux5paH6ZW/5bqm5bCx
5LiN55So6aKR57mB5pWw5pWw5LqG44CCDQoNCkl0J3MgdXAgdG8geW91ISA+XzwNCg0KVGhhbmtz
LA0KWWFudGVuZw0KPg0KPiBUaGFua3MNCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBZYW50ZW5nDQo+
ID4gPiArDQo+ID4gPiAg6K645Y+v6K+B5paH5qGjDQo+ID4gPiAgLS0tLS0tLS0tLQ0KPiA+ID4N
Cj4gPiA+IC0tDQo+ID4gPiAyLjI3LjANCj4gPiA+DQo=
