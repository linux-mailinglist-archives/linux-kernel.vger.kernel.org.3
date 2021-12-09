Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5742246E102
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhLICtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhLICtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:49:46 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30EDC061746;
        Wed,  8 Dec 2021 18:46:13 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z26so5046798iod.10;
        Wed, 08 Dec 2021 18:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qBQZYkD+88xFVH6F8V8C42mT/Ag/fZXXd5aJaeUp5sg=;
        b=IJHP+btAJdulxaK7UIdYJkYkDAW2bYHuWK31guLk4LYydSAE/8gh1zHk8B7vFJ6Wq4
         SyGZSalYED7TJax/esd0UJF3Wo/muvzMJJtkd+LWLK2DMOX54+q4/3g++JsCPclRk8YI
         OLrYozcb/yKUf9mBme5AkPo85KpRxpMa8j2S83nBi+AeFB7EnCCosfhysRIjd7cAPKhX
         ss3aQeJHHZMcecPuFmm4eDrgPMaWzQJRCuB0934vMCsp/RDj3DaJ5NP82FK3EbaYl3je
         SofTKbsBRCaRskzqYkSOvF6x7TUZBarOB9dq0WBnF3X0r/VNFIAz3RjLht2rF98YF/pc
         +fXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qBQZYkD+88xFVH6F8V8C42mT/Ag/fZXXd5aJaeUp5sg=;
        b=l8dJ6cL+CRR7a3gwCczLm/SPT8FDY1l8pFlaSFpl21QVtaL+vkjY+7xiEN42zBBXF8
         27A35EPfGT5jMFNuhmnzNhtL+TcuD5N6Ix2tnZjNaP7DhHEM/cF8pCXRFztY4FsT55RX
         W0iljtyniUL4d2Cbs3+zQQpvE9eCDZOk4N7DyuDmn3mhM6pYYX+LA1MxKi6eILBBDefj
         025PklrQA7Epj7iuziFJH6Uwl1M/G3MdcXM0NGk8+aX8adX5ZjUyCPSDCIlhBink1jCE
         Ck7Jc1meO55ZvCFCqkIFG2N2YqtRLDytvBx826G9pJfa66Xn+IvckzJSMeYB3NccrxIp
         wD+g==
X-Gm-Message-State: AOAM533DNHA5PioXBHIe1gawXoGh8vRxP7FGNO0DDuwXoYF4KAWJKv77
        9AndIoAbigYTPxagSYxvviCnJ6wMFj/ROzRXl6w=
X-Google-Smtp-Source: ABdhPJyLbzCfWKoouV9cVNBXZPBvBr6BkSRRRJ6Vq64GSCJy5b1pyPC+GKmNqx/3493L3zpcZyuk22xRmrT04FvEF5Q=
X-Received: by 2002:a05:6602:1813:: with SMTP id t19mr11497176ioh.135.1639017973244;
 Wed, 08 Dec 2021 18:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20211208114125.58472-1-alexs@kernel.org> <CAEensMwzXgw0Y_Eq=6P1LQAhcYeJ+W4UtZz6i-n2xGzc8t204A@mail.gmail.com>
In-Reply-To: <CAEensMwzXgw0Y_Eq=6P1LQAhcYeJ+W4UtZz6i-n2xGzc8t204A@mail.gmail.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Thu, 9 Dec 2021 10:45:37 +0800
Message-ID: <CAJy-AmkPm3ims64OHbiT7KgT=ocxGKO_yTFigzORBgVc_7VFDg@mail.gmail.com>
Subject: Re: [PATCH] doc/zh_CN: add Chinese document coding style reminder
To:     yanteng si <siyanteng01@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Tang Yizhou <tangyizhou@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBEZWMgOSwgMjAyMSBhdCA5OjM0IEFNIHlhbnRlbmcgc2kgPHNpeWFudGVuZzAxQGdt
YWlsLmNvbT4gd3JvdGU6DQo+DQo+IDxhbGV4c0BrZXJuZWwub3JnPiDkuo4yMDIx5bm0MTLmnIg4
5pel5ZGo5LiJIDE5OjQx5YaZ6YGT77yaDQo+ID4NCj4gPiBGcm9tOiBBbGV4IFNoaSA8YWxleHNA
a2VybmVsLm9yZz4NCj4gPg0KPiA+IFRoZSBjb2Rpbmcgc3R5bGUgcmVxdWlyZW1lbnQgZm9yIENo
aW5lc2UgZG9jdW1lbnQgaXMgZWFzeSB0byBiZSBvdmVybG9va2VkLg0KPiA+IEFkZCB0aGUgcmVx
dWVzdCBhcyBhIHJlbWRpbmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBTaGkgPGFs
ZXhzQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFlhbnRlbmcgU2kgPHNpeWFudGVuZzAxQGdtYWlsLmNv
bT4NCj4gPiBDYzogVGFuZyBZaXpob3UgPHRhbmd5aXpob3VAaHVhd2VpLmNvbT4NCj4gPiBDYzog
Sm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCj4gPiBDYzogbGludXgtZG9jQHZnZXIu
a2VybmVsLm9yZw0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gLS0t
DQo+ID4gIERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJzdCB8IDQgKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0IGIvRG9jdW1l
bnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0DQo+ID4gaW5kZXggYTM0ZTU4NzMz
YWM4Li44YzI3ODZlZDAyNzkgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xh
dGlvbnMvemhfQ04vaW5kZXgucnN0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vaW5kZXgucnN0DQo+ID4gQEAgLTIzLDYgKzIzLDEwIEBADQo+ID4gIOWPpuWklu+8
jOmaj+aXtuasoui/juaCqOWvueWGheaguOaWh+aho+i/m+ihjOaUuei/m++8m+WmguaenOaCqOaD
s+aPkOS+m+W4ruWKqe+8jOivt+WKoOWFpXZnZXIua2VybmVsLm9yZw0KPiA+ICDkuIrnmoRsaW51
eC1kb2Ppgq7ku7bliJfooajjgIINCj4gPg0KPiA+ICvpobrkvr/or7TkuIvvvIzkuK3mlofmlofm
oaPkuZ/pnIDopoHpgbXlrojlhoXmoLjnvJbnoIHpo47moLzvvIzpo47moLzkuK3kuK3mloflkozo
i7HmlofnmoTkuLvopoHkuI3lkIzlsLHmmK/kuK3mlocNCj4gPiAr55qE5a2X56ym5qCH54K55Y2g
55So5Lik5Liq6Iux5paH5a2X56ym5a695bqm77yMIOaJgOS7pe+8jOW9k+iLseaWh+imgeaxguS4
jeimgei2hei/h+avj+ihjDEwMOS4quWtl+espuaXtu+8jA0KPiA+ICvkuK3mloflsLHkuI3opoHo
toXov4c1MOS4quWtl+espuOAguWPpuWklu+8jOS5n+imgeazqOaEjyctJ++8jCc9JyDnrYnnrKbl
j7fkuI7nm7jlhbPmoIfpopjnmoTlr7npvZDjgIINCj4gSG93IGFib3V0Og0KPiDlj6blpJbvvIwn
LSfvvIwnPScg562J56ym5Y+36ZyA6KaB5LiO55u45YWz5qCH6aKY5a+56b2QLCDkuLrkuobnhafp
ob7msqHmnInlm77lvaLnlYzpnaLlkozkuaDmg6/nlKh2aeafpemYheaWh+ahow0KPiDnmoTlvIDl
j5HogIXvvIzkuK3mlofmlofmoaPnmoTmlofmnKzlnZfjgIHmrrXokL3nrYnkuZ/lupTlg4/oi7Hm
lofmlofmoaPpgqPmoLfmlbTmlbTpvZDpvZDjgIINCj4NCj4g5Zyo5bCG6KGl5LiB5o+Q5Lqk5Yiw
56S+5Yy65LmL5YmN77yM5LiA5a6a6KaB6L+b6KGM5b+F6KaB55qEY2hlY2twYXRjaC5wbOajgOaf
peWSjOe8luivkea1i+ivle+8jOe9kemhteeJiA0KPiDmlofmoaPlnKjpg6jliIbmtY/op4jlmajk
uK3mmoLml7blj6/og73kvJrlh7rnjrDlpJrkvZnnmoTnqbrmoLzvvIznm67liY3lt7Lnn6VmaXJl
Zm945q2j5bi477yM5o2u5LqG6Kej77yM5rWPDQo+IOiniOWZqOinhOiMg+iNieahiOS4reW3suac
ieivpemXrumimOeahOino+WGs+aWueahiO+8jOWwhuadpeacieW4jOacm+ino+WGs+OAgg0KDQpu
aWNlLg0KDQo+DQo+IC4uIOWwj+aKgOW3pzog57+76K+R5pe26Lef6ZqP6Iux5paH5paH5pys5Z2X
5o2i6KGM5peg6ZyA5YWz5b+D5Lit5paH5q+P6KGM5piv5ZCm6LaF5a2X5pWw77yM5Lmf5LiN55So
5ouF5b+D5ryP5o6J56m6DQo+ICAgICAgICAgICAgICAgIOihjOWSjOe8qei/m+S7peWPiua8j+e/
u+ivke+8jOWboOS4uuaIkeS7rOWPqumcgOWOn+WcsOi/m+ihjOS4reiLseaWh+Wtl+espuS4suab
v+aNouWwseWPr+S7peS6huOAgg0KDQp0aGUgbGluZSBieSBsaW5lIHJlcGxhY2UgbWF5IGxlYWQg
dG8gdW5hbGlnbm1lbnQgaXNzdWUsIGRvIHdlIG5lZWQgdGhpcyB0aXBzPw0KDQpUaGFua3MNCj4N
Cj4gVGhhbmtzLA0KPiBZYW50ZW5nDQo+ID4gKw0KPiA+ICDorrjlj6/or4HmlofmoaMNCj4gPiAg
LS0tLS0tLS0tLQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjI3LjANCj4gPg0K
