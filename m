Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C848D058
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiAMCLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiAMCLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:11:21 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ADBC06173F;
        Wed, 12 Jan 2022 18:11:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so16200013pjf.3;
        Wed, 12 Jan 2022 18:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ef/mLPMKbhLWhqaguXllHE7NE7yV19XSyM4CrMJujKk=;
        b=ONj78WQFMc3NWqeQkjiDpJVvDEzQhcYNRAlQEFCj/tXMwi1OrY2oWgzuqsLNMeUrSE
         Wk2trwQ0yj0COTGqv8DcV3/GRFhShgcJk5uR3h2R0t5YzWAZGpW2zJ1K7qnv8Dbo2LjA
         wDFjPD1gkOmP3AgN3cSPF3dr6wdce0wQhmD0Ax06SK1LSxPaYXh0rwheY2X5I3d8swGW
         pNnC4QKPd2/ueHZ0kdkkB2xkIdSEFTyMAPu8r/yTHQa8qE2gqwf9NcPS4ytIYyubK/m0
         2rZLh7y8+1dphMWUvel/d3KdkBDpQHNmD2ZZWaVlOJcHz54GEiNhJQIUsyO4uZP/PFPC
         /acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ef/mLPMKbhLWhqaguXllHE7NE7yV19XSyM4CrMJujKk=;
        b=rzeXHvWPuc8zDP36JXPdb1tAnQoynUuwo8oHM9+XZ3Aawg0DBaNiMREr+z0DFZ17/1
         xFUuRvfi0+Bjybpjk7cJxYco+pfuF3zat91K54xtZzPSogJFfM2DE6kms1UXtELmalVE
         gNIQODepLG4U8nP70Ibg68Xym2hgSEQ6GMZyNfCEkm6jfxDZ7gojP8nHj/vZKUHKOlY3
         zOZLaKxRGXxOafd95LwXd5Hc6C/xPoiqnur68dc1HFjUqeQb3gcbyAqEiE97aWlqOb1k
         lvJa04oNFJd1ZQZ58ghX1kSdVhBNJGTf9/d7Jj1KT7YIC+98EnTV/fNgS4xR43O3tspg
         bCuA==
X-Gm-Message-State: AOAM533RVh3HWZVGpPu4OJZMTPwKmY2tko2uV8lweZz/Bq+iYRUcOuWT
        LD9CD2HoetPzzCwBw6DKhegYHMwupaovKapw5Dc=
X-Google-Smtp-Source: ABdhPJzqFwMSDdD5v9CCm4K4fbLwRYHtWsnPn8FpiKBIemln49UmRwM4u7YOngvQ+wFuHeQszK8olk7m8Nh45vPtVe8=
X-Received: by 2002:a17:903:24d:b0:14a:677d:843a with SMTP id
 j13-20020a170903024d00b0014a677d843amr2554699plh.129.1642039880305; Wed, 12
 Jan 2022 18:11:20 -0800 (PST)
MIME-Version: 1.0
References: <1642003482-48935-1-git-send-email-wang.yong12@zte.com.cn>
In-Reply-To: <1642003482-48935-1-git-send-email-wang.yong12@zte.com.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Thu, 13 Jan 2022 10:11:09 +0800
Message-ID: <CAMU9jJquKLfzLOjN3xTLHgPJFWONpeVgUDG-0vsf_8ia3r3ALQ@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Update zh_CN/accounting/delay-accounting.rst
To:     yongw.pur@gmail.com
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, wang.yong12@zte.com.cn,
        yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWW9uZywNCjx5b25ndy5wdXJAZ21haWwuY29tPiDkuo4yMDIy5bm0MeaciDEz5pel5ZGo5Zub
IDA3OjI35YaZ6YGT77yaDQo+DQo+IEZyb206IHdhbmd5b25nIDx3YW5nLnlvbmcxMkB6dGUuY29t
LmNuPg0KPg0KPiBVcGRhdGUgemhfQ04vYWNjb3VudGluZy9kZWxheS1hY2NvdW50aW5nLnJzdC4N
Cj4gVGhlIGRvY3VtZW50IG1vZGlmaWNhdGlvbiBoYXMgYmVlbiBtZXJnZWQgd2hpY2ggcmVmZXJz
IHRvIHRoZSBmb2xsb3dpbmcgbGluazoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzE2
Mzk1ODMwMjEtOTI5NzctMS1naXQtc2VuZC1lbWFpbC13YW5nLnlvbmcxMkB6dGUuY29tLmNuLw0K
VGhlIG5vcm1hbCB3YXkgdG8gaGFuZGxlIHRoaXMgaXMgdG8gYWRkIGFuIGFwcHJvcHJpYXRlIEZp
eGVzIHRhZy4NCg0KQnkgdGhlIHdheSwgdGhpcyBwYXRjaCBzaG91bGQgYmUgc3VibWl0dGVkIHRv
Z2V0aGVyIGFzIHBhcnQgb2YgdGhhdA0KcGF0Y2ggc2VyaWVzIHdoZXJlIHlvdSBtb2RpZmllZCB0
aGUgb3JpZ2luYWwgZG9jdW1lbnRhdGlvbi4gQWxzbyBjaGVjaw0Kb3V0IHRoZSBkb2N1bWVudGF0
aW9uIGZvciBvdGhlciBsYW5ndWFnZXMgYW5kIHNlbmQgaXQgaW4gdGhlIHNhbWUgd2F5Lg0KSWYg
eW91IGdldCBzdHVjaywgc2ltcGx5IC0tQ0MgdGhlIG1haW50YWluZXIgaXMgYW4gZWxlZ2FudCB3
YXkgdG8NCmhhbmRsZSBpdC4gPl88DQoNCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiB3YW5neW9uZyA8
d2FuZy55b25nMTJAenRlLmNvbS5jbj4NCj4gUmV2aWV3ZWQtYnk6IFlhbmcgWWFuZyA8eWFuZy55
YW5nMjlAenRlLmNvbS5jbj4NClRoaXMgbG9va3MgbGlrZSB0aGUgZmlyc3QgdmVyc2lvbiBvZiB0
aGUgcGF0Y2ggYW5kIGRvZXNuJ3Qgc2VlbSB0bw0KaGF2ZSBiZWVuIHJldmlld2VkIGJ5IGFueW9u
ZSB5ZXQsIHNvIHlvdSBjYW4ndCBzaWduIGl0IGluc3RlYWQgb2YNCnNvbWVvbmUgZWxzZS4NCg0K
VGhhbmtzLA0KWWFudGVuZw0KPiAtLS0NCj4gIC4uLi96aF9DTi9hY2NvdW50aW5nL2RlbGF5LWFj
Y291bnRpbmcucnN0ICAgICAgICAgIHwgNjIgKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWNjb3VudGluZy9kZWxh
eS1hY2NvdW50aW5nLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2FjY291
bnRpbmcvZGVsYXktYWNjb3VudGluZy5yc3QNCj4gaW5kZXggNjdkNTYwNi4uZjE4NDk0MSAxMDA2
NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWNjb3VudGluZy9k
ZWxheS1hY2NvdW50aW5nLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96
aF9DTi9hY2NvdW50aW5nL2RlbGF5LWFjY291bnRpbmcucnN0DQo+IEBAIC0xNyw2ICsxNyw4IEBA
IGEpIOetieW+heS4gOS4qkNQVe+8iOS7u+WKoeS4uuWPr+i/kOihjO+8iQ0KPiAgYikg5a6M5oiQ
55Sx6K+l5Lu75Yqh5Y+R6LW355qE5Z2XSS9P5ZCM5q2l6K+35rGCDQo+ICBjKSDpobXpnaLkuqTm
jaINCj4gIGQpIOWGheWtmOWbnuaUtg0KPiArZSkg6aG157yT5a2Y5oqW5YqoDQo+ICtmKSDnm7Tm
jqXop4TmlbQNCj4NCj4gIOW5tuWwhui/meS6m+e7n+iuoeS/oeaBr+mAmui/h3Rhc2tzdGF0c+aO
peWPo+aPkOS+m+e7meeUqOaIt+epuumXtOOAgg0KPg0KPiBAQCAtMzcsMTAgKzM5LDEwIEBAIGQp
IOWGheWtmOWbnuaUtg0KPiAg5ZCR55So5oi35oCB6L+U5Zue5LiA5Liq6YCa55So5pWw5o2u57uT
5p6E77yM5a+55bqU5q+PcGlk5oiW5q+PdGdpZOeahOe7n+iuoeS/oeaBr+OAguW7tuaXtuiuoeaV
sOWKn+iDveWhq+WGmQ0KPiAg6K+l5pWw5o2u57uT5p6E55qE54m55a6a5a2X5q6144CC6KeBDQo+
DQo+IC0gICAgIGluY2x1ZGUvbGludXgvdGFza3N0YXRzLmgNCj4gKyAgICAgaW5jbHVkZS91YXBp
L2xpbnV4L3Rhc2tzdGF0cy5oDQo+DQo+ICDlhbbmj4/ov7Dkuoblu7bml7borqHmlbDnm7jlhbPl
rZfmrrXjgILns7vnu5/pgJrluLjku6XorqHmlbDlmajlvaLlvI/ov5Tlm54gQ1BV44CB5ZCM5q2l
5Z2XIEkvT+OAgeS6pOaNouOAgeWGheWtmA0KPiAt5Zue5pS2562J55qE57Sv56ev5bu25pe244CC
DQo+ICvlm57mlLbjgIHpobXnvJPlrZjmipbliqjjgIHnm7TmjqXop4TmlbTnrYnnmoTntK/np6/l
u7bml7bjgIINCj4NCj4gIOWPluS7u+WKoeafkOiuoeaVsOWZqOS4pOS4qui/nue7reivu+aVsOea
hOW3ruWAvO+8jOWwhuW+l+WIsOS7u+WKoeWcqOivpeaXtumXtOmXtOmalOWGheetieW+heWvueW6
lOi1hOa6kOeahOaAu+W7tuaXtuOAgg0KPg0KPiBAQCAtNzIsNDAgKzc0LDM2IEBAIGtlcm5lbC50
YXNrX2RlbGF5YWNjdOi/m+ihjOW8gOWFs+OAguazqOaEj++8jOWPquacieWcqOWQr+eUqOW7tuaX
tuiuoeaVsOWQjuWQrw0KPg0KPiAgZ2V0ZGVsYXlz5ZG95Luk55qE5LiA6Iis5qC85byPOjoNCj4N
Cj4gLSAgICAgICBnZXRkZWxheXMgWy10IHRnaWRdIFstcCBwaWRdIFstYyBjbWQuLi5dDQo+ICsg
ICAgICAgZ2V0ZGVsYXlzIFstZGlsdl0gWy10IHRnaWRdIFstcCBwaWRdDQo+DQo+ICDojrflj5Zw
aWTkuLoxMOeahOS7u+WKoeS7juezu+e7n+WQr+WKqOWQjueahOW7tuaXtuS/oeaBrzo6DQo+DQo+
IC0gICAgICAgIyAuL2dldGRlbGF5cyAtcCAxMA0KPiArICAgICAgICMgLi9nZXRkZWxheXMgLWQg
LXAgMTANCj4gICAgICAgICDvvIjovpPlh7rkv6Hmga/lkozkuIvkvovnm7jkvLzvvIkNCj4NCj4g
IOiOt+WPluaJgOaciXRnaWTkuLo155qE5Lu75Yqh5LuO57O757uf5ZCv5Yqo5ZCO55qE5oC75bu2
5pe25L+h5oGvOjoNCj4NCj4gLSAgICAgICAjIC4vZ2V0ZGVsYXlzIC10IDUNCj4gLQ0KPiAtDQo+
IC0gICAgICAgQ1BVICAgICBjb3VudCAgIHJlYWwgdG90YWwgICAgICB2aXJ0dWFsIHRvdGFsICAg
ZGVsYXkgdG90YWwNCj4gLSAgICAgICAgICAgICAgIDc4NzYgICAgOTIwMDU3NTAgICAgICAgIDEw
MDAwMDAwMCAgICAgICAyNDAwMTUwMA0KPiAtICAgICAgIElPICAgICAgY291bnQgICBkZWxheSB0
b3RhbA0KPiAtICAgICAgICAgICAgICAgMCAgICAgICAwDQo+IC0gICAgICAgU1dBUCAgICBjb3Vu
dCAgIGRlbGF5IHRvdGFsDQo+IC0gICAgICAgICAgICAgICAwICAgICAgIDANCj4gLSAgICAgICBS
RUNMQUlNIGNvdW50ICAgZGVsYXkgdG90YWwNCj4gLSAgICAgICAgICAgICAgIDAgICAgICAgMA0K
PiAtDQo+IC3ojrflj5bmjIflrprnroDljZXlkb3ku6Tov5DooYzml7bnmoTlu7bml7bkv6Hmga86
Og0KPiAtDQo+IC0gICMgLi9nZXRkZWxheXMgLWMgbHMgLw0KPiAtDQo+IC0gIGJpbiAgIGRhdGEx
ICBkYXRhMyAgZGF0YTUgIGRldiAgaG9tZSAgbWVkaWEgIG9wdCAgIHJvb3QgIHNydiAgICAgICAg
c3lzICB1c3INCj4gLSAgYm9vdCAgZGF0YTIgIGRhdGE0ICBkYXRhNiAgZXRjICBsaWIgICBtbnQg
ICAgcHJvYyAgc2JpbiAgc3ViZG9tYWluICB0bXAgIHZhcg0KPiAtDQo+IC0NCj4gLSAgQ1BVICBj
b3VudCAgIHJlYWwgdG90YWwgICAgICB2aXJ0dWFsIHRvdGFsICAgZGVsYXkgdG90YWwNCj4gLSAg
ICAgICA2ICAgICAgIDQwMDAyNTAgICAgICAgICA0MDAwMDAwICAgICAgICAgMA0KPiAtICBJTyAg
IGNvdW50ICAgZGVsYXkgdG90YWwNCj4gLSAgICAgICAwICAgICAgIDANCj4gLSAgU1dBUCBjb3Vu
dCAgIGRlbGF5IHRvdGFsDQo+IC0gICAgICAgMCAgICAgICAwDQo+IC0gIFJFQ0xBSU0gICAgICBj
b3VudCAgIGRlbGF5IHRvdGFsDQo+IC0gICAgICAgMCAgICAgICAwDQo+ICsgICAgICAgIyAuL2dl
dGRlbGF5cyAtZCAtdCA1DQo+ICsgICAgICAgcHJpbnQgZGVsYXlhY2N0IHN0YXRzIE9ODQo+ICsg
ICAgICAgVEdJRCAgICA1DQo+ICsNCj4gKw0KPiArICAgICAgIENQVSAgICAgICAgICAgICBjb3Vu
dCAgICAgcmVhbCB0b3RhbCAgdmlydHVhbCB0b3RhbCAgICBkZWxheSB0b3RhbCAgZGVsYXkgYXZl
cmFnZQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgOCAgICAgICAgNzAwMDAwMCAgICAg
ICAgNjg3MjEyMiAgICAgICAgMzM4MjI3NyAgICAgICAgICAwLjQyM21zDQo+ICsgICAgICAgSU8g
ICAgICAgICAgICAgIGNvdW50ICAgIGRlbGF5IHRvdGFsICBkZWxheSBhdmVyYWdlDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAwICAgICAgICAgICAgICAwbXMN
Cj4gKyAgICAgICBTV0FQICAgICAgICAgICAgY291bnQgICAgZGVsYXkgdG90YWwgIGRlbGF5IGF2
ZXJhZ2UNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgIDAgICAg
ICAgICAgICAgIDBtcw0KPiArICAgICAgIFJFQ0xBSU0gICAgICAgICBjb3VudCAgICBkZWxheSB0
b3RhbCAgZGVsYXkgYXZlcmFnZQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgMCAgICAg
ICAgICAgICAgMCAgICAgICAgICAgICAgMG1zDQo+ICsgICAgICAgVEhSQVNISU5HICAgICAgIGNv
dW50ICAgIGRlbGF5IHRvdGFsICBkZWxheSBhdmVyYWdlDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAwICAgICAgICAgICAgICAwICAgICAgICAgICAgICAwbXMNCj4gKyAgICAgICBDT01Q
QUNUICAgICAgICAgY291bnQgICAgZGVsYXkgdG90YWwgIGRlbGF5IGF2ZXJhZ2UNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgIDBtcw0K
PiArDQo+ICvojrflj5ZwaWTkuLox55qESU/orqHmlbDvvIzlroPlj6rlkowtcOS4gOi1t+S9v+eU
qDo6DQo+ICsgICAgICAgIyAuL2dldGRlbGF5cyAtaSAtcCAxDQo+ICsgICAgICAgcHJpbnRpbmcg
SU8gYWNjb3VudGluZw0KPiArICAgICAgIGxpbnV4cmM6IHJlYWQ9NjU1MzYsIHdyaXRlPTAsIGNh
bmNlbGxlZF93cml0ZT0wDQo+ICsNCj4gK+S4iumdoueahOWRveS7pOS4ji125LiA6LW35L2/55So
77yM5Y+v5Lul6I635Y+W5pu05aSa6LCD6K+V5L+h5oGv44CCDQo+IC0tDQo+IDIuNy40DQo+DQo=
