Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3B46E047
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhLIBiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhLIBh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:37:59 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93B6C061746;
        Wed,  8 Dec 2021 17:34:26 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so4637088otv.9;
        Wed, 08 Dec 2021 17:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=22Mvx3aSrXvm/szku+TvvA36vqtRCRUXnrutVlQnAkQ=;
        b=ZtgNidVzo/7Q6MWazHWXL7dP5rcso3MRI7sGT9gqUV7I6Aw2yBnn/K1mxjYtW0cA0A
         nz/fVRZFFKgwdzt5REvb/5yaVWSgtQT/Iev3grT9Ma5g80Jys1lAl+Vgr0a36NXhWDSP
         r+5q1j8ba4xOV3JGN15j7XNq+ELjqHXOGtdW8/zWROBzl3E0QRQxwkwZXn4dcd8goknz
         2xnUMU4JFnA5zCF6gs6stu55nfhOTG2g+iyHx5PeKOfsHJ9LBmO4qjqrXyBV5cIhGSw3
         XDFczAzERARCB3qlATdDU6W/XMeuA0x1FmjGUMYJjv3oxkmaOA7T5qGulYzWqqnlF34M
         CqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=22Mvx3aSrXvm/szku+TvvA36vqtRCRUXnrutVlQnAkQ=;
        b=6seEDWrYaO643D/3mphLBIy3d0VspdlsAY4iztxkCAeE92f7j1MAVd26B2jnAAWRHs
         1iutrYPyj1+Pz1YpczwOxBsvw5axG2JSk9PYGgT6dTzMfomgms4XpDLEoPYTR/nDLEHy
         YBZTDiwuK+NLqBQ14VDyT7B01VicdYQNzK3PDsADT+WxDjPY+RVI8WHX0GIB7mB9uzIL
         WBElB+yCUvNr93g5KZme9wcvOQJF00IPOYKof59BXRsgH/F/jTDqhU0TzQOBMQ+HxmQv
         8wMfKwEpFwgeK093WrrmoT1nEU0fJ15QJwpCDA4ZrzncV7l9inaZnVKO69RMHpND/7Z4
         pzeg==
X-Gm-Message-State: AOAM533kqya4iCTpDt/fVM1ng4fPODENRs14iPGGtAPer5UlSvzaMBxm
        fMhdUatrmLSymAdsRq/2lXdrSy1O9h02LiL1PgvOFpyjGdKibQ==
X-Google-Smtp-Source: ABdhPJy3fe9qAaB9qWWCKnju1XDgZFgcpoQpJ4FhM96X0V/Cpc9OtJU4sxohYy6wKiTkPp6t7ktXxeMj81daxTRai58=
X-Received: by 2002:a05:6830:1605:: with SMTP id g5mr2970541otr.46.1639013666031;
 Wed, 08 Dec 2021 17:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20211208114125.58472-1-alexs@kernel.org>
In-Reply-To: <20211208114125.58472-1-alexs@kernel.org>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Thu, 9 Dec 2021 09:34:14 +0800
Message-ID: <CAEensMwzXgw0Y_Eq=6P1LQAhcYeJ+W4UtZz6i-n2xGzc8t204A@mail.gmail.com>
Subject: Re: [PATCH] doc/zh_CN: add Chinese document coding style reminder
To:     Alex Shi <alexs@kernel.org>
Cc:     Tang Yizhou <tangyizhou@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PGFsZXhzQGtlcm5lbC5vcmc+IOS6jjIwMjHlubQxMuaciDjml6XlkajkuIkgMTk6NDHlhpnpgZPv
vJoNCj4NCj4gRnJvbTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+DQo+IFRoZSBjb2Rp
bmcgc3R5bGUgcmVxdWlyZW1lbnQgZm9yIENoaW5lc2UgZG9jdW1lbnQgaXMgZWFzeSB0byBiZSBv
dmVybG9va2VkLg0KPiBBZGQgdGhlIHJlcXVlc3QgYXMgYSByZW1kaW5lci4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+IENjOiBZYW50ZW5nIFNpIDxz
aXlhbnRlbmcwMUBnbWFpbC5jb20+DQo+IENjOiBUYW5nIFlpemhvdSA8dGFuZ3lpemhvdUBodWF3
ZWkuY29tPg0KPiBDYzogSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCj4gQ2M6IGxp
bnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3Qg
fCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJzdCBiL0RvY3Vt
ZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJzdA0KPiBpbmRleCBhMzRlNTg3MzNh
YzguLjhjMjc4NmVkMDI3OSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vaW5kZXgucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3po
X0NOL2luZGV4LnJzdA0KPiBAQCAtMjMsNiArMjMsMTAgQEANCj4gIOWPpuWklu+8jOmaj+aXtuas
oui/juaCqOWvueWGheaguOaWh+aho+i/m+ihjOaUuei/m++8m+WmguaenOaCqOaDs+aPkOS+m+W4
ruWKqe+8jOivt+WKoOWFpXZnZXIua2VybmVsLm9yZw0KPiAg5LiK55qEbGludXgtZG9j6YKu5Lu2
5YiX6KGo44CCDQo+DQo+ICvpobrkvr/or7TkuIvvvIzkuK3mlofmlofmoaPkuZ/pnIDopoHpgbXl
rojlhoXmoLjnvJbnoIHpo47moLzvvIzpo47moLzkuK3kuK3mloflkozoi7HmlofnmoTkuLvopoHk
uI3lkIzlsLHmmK/kuK3mlocNCj4gK+eahOWtl+espuagh+eCueWNoOeUqOS4pOS4quiLseaWh+Wt
l+espuWuveW6pu+8jCDmiYDku6XvvIzlvZPoi7HmlofopoHmsYLkuI3opoHotoXov4fmr4/ooYwx
MDDkuKrlrZfnrKbml7bvvIwNCj4gK+S4reaWh+WwseS4jeimgei2hei/hzUw5Liq5a2X56ym44CC
5Y+m5aSW77yM5Lmf6KaB5rOo5oSPJy0n77yMJz0nIOetieespuWPt+S4juebuOWFs+agh+mimOea
hOWvuem9kOOAgg0KSG93IGFib3V0Og0K5Y+m5aSW77yMJy0n77yMJz0nIOetieespuWPt+mcgOim
geS4juebuOWFs+agh+mimOWvuem9kCwg5Li65LqG54Wn6aG+5rKh5pyJ5Zu+5b2i55WM6Z2i5ZKM
5Lmg5oOv55Sodmnmn6XpmIXmlofmoaMNCueahOW8gOWPkeiAhe+8jOS4reaWh+aWh+aho+eahOaW
h+acrOWdl+OAgeauteiQveetieS5n+W6lOWDj+iLseaWh+aWh+aho+mCo+agt+aVtOaVtOm9kOm9
kOOAgg0KDQrlnKjlsIbooaXkuIHmj5DkuqTliLDnpL7ljLrkuYvliY3vvIzkuIDlrpropoHov5vo
oYzlv4XopoHnmoRjaGVja3BhdGNoLnBs5qOA5p+l5ZKM57yW6K+R5rWL6K+V77yM572R6aG154mI
DQrmlofmoaPlnKjpg6jliIbmtY/op4jlmajkuK3mmoLml7blj6/og73kvJrlh7rnjrDlpJrkvZnn
moTnqbrmoLzvvIznm67liY3lt7Lnn6VmaXJlZm945q2j5bi477yM5o2u5LqG6Kej77yM5rWPDQro
p4jlmajop4TojIPojYnmoYjkuK3lt7LmnInor6Xpl67popjnmoTop6PlhrPmlrnmoYjvvIzlsIbm
naXmnInluIzmnJvop6PlhrPjgIINCg0KLi4g5bCP5oqA5benOiDnv7vor5Hml7bot5/pmo/oi7Hm
lofmlofmnKzlnZfmjaLooYzml6DpnIDlhbPlv4PkuK3mlofmr4/ooYzmmK/lkKbotoXlrZfmlbDv
vIzkuZ/kuI3nlKjmi4Xlv4PmvI/mjonnqboNCiAgICAgICAgICAgICAgIOihjOWSjOe8qei/m+S7
peWPiua8j+e/u+ivke+8jOWboOS4uuaIkeS7rOWPqumcgOWOn+WcsOi/m+ihjOS4reiLseaWh+Wt
l+espuS4suabv+aNouWwseWPr+S7peS6huOAgg0KDQpUaGFua3MsDQpZYW50ZW5nDQo+ICsNCj4g
IOiuuOWPr+ivgeaWh+ahow0KPiAgLS0tLS0tLS0tLQ0KPg0KPiAtLQ0KPiAyLjI3LjANCj4NCg==
