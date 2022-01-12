Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7749448C419
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353190AbiALMgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbiALMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:36:41 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E25C06173F;
        Wed, 12 Jan 2022 04:36:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id pj2so4551492pjb.2;
        Wed, 12 Jan 2022 04:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dTdx34ZZeRaeKwd1b1TqTtRAH4imkfT/DQ48sZ7WTRY=;
        b=DTlZ7S8XLd6sxAPt72i/NybjQozu2ZvDeF0hPUMHHaxtDR5kbnv3k9QjrHD7DBTJ7u
         0vk18wU8nNGFtLghmCiRgehaPaINg6+72MXXjuFQF8Q2EIiGKCI88taHuy378gz2fuMi
         hr3ewrNomUcNGySVQG6ypfbrj3hZ479H/LWbq6DmKZqejCohzKEKxnz17gS6en+brqLk
         F/fAgrhNkSmyZ8MeKrZLNuDdGWR22zfLs42zn6z+8YCXU0ZwKOP0i3izxzM6Wut1oaQn
         2VER0fPL9P8yN1ndlv6JzewOo4yPuGBD/ZnVqCffewO7Ip8cACqxVPGPuBCvYa/DDuPu
         CCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dTdx34ZZeRaeKwd1b1TqTtRAH4imkfT/DQ48sZ7WTRY=;
        b=KTWCCdXgZPBHvjXYuy/mHgnMvmbEy9xTY2pwQmlnpdxZPCOpNa3b+wtazZrbIx8XMG
         OGfo/crqb32sbMG1zCZfwwnctVkrGJAK2gTbwF3iFX/IIiiteR0REoConkq3+7ZaT7lV
         /ri1ZZDjeCwP5/0ZKOyZdNXB7Du8yNYcrApl16K+BaHXhZufSF5pA7z4576gDuwAsr5R
         NblZRiLZM1KYs7tAk4XXJE3dyb5i5dXwRdA3LzEu30s2HY7Yj+tHGmoaRHAm7lp19+rp
         /nxKmdoIGcggALdfPgKMRjcVRu9Cuqvr9/USu46uVLipRTok4VmuCFilIW4tdtyfr+6u
         FWVQ==
X-Gm-Message-State: AOAM533bs8T1c+ha/vpL8zpTtS6WPHi5+TpyGbkM103CO1BEtrRoLgoG
        rqYCSzEWC8YC0sE1lNI9YgY63H9XGI7bJX72AXA=
X-Google-Smtp-Source: ABdhPJyNNGjAwrYlzsNZxomnpAqlDtVjDzcBzWv7zXtzKJeGWMXHGfFnBGq0oEJ9bFzKCHeiKTmyHSrB5OYuxCPOnP0=
X-Received: by 2002:aa7:8043:0:b0:4bc:1e18:466e with SMTP id
 y3-20020aa78043000000b004bc1e18466emr9307032pfm.49.1641991000339; Wed, 12 Jan
 2022 04:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20220110122929.647573-1-xu.xin16@zte.com.cn> <20220110123221.647693-1-xu.xin16@zte.com.cn>
In-Reply-To: <20220110123221.647693-1-xu.xin16@zte.com.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Wed, 12 Jan 2022 20:36:20 +0800
Message-ID: <CAMU9jJpREP_ULhEgxUtbU9E+Ywopumi9eY4TLC6u1BGqDjGFmg@mail.gmail.com>
Subject: Re: [PATCH 2/4] docs/zh_CN: Add zh_CN/admin-guide/mm/index.rst
To:     CGEL <cgel.zte@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, xu.xin16@zte.com.cn,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PGNnZWwuenRlQGdtYWlsLmNvbT4g5LqOMjAyMuW5tDHmnIgxMeaXpeWRqOS6jCAxMTowN+WGmemB
k++8mg0KPg0KPiBGcm9tOiB4dSB4aW4gPHh1LnhpbjE2QHp0ZS5jb20uY24+DQo+DQo+IFRoaXMg
cGF0Y2ggYWRkcyB6aF9DTi9hZG1pbi1ndWlkZS9tbS9pbmRleC5yc3QuDQpXZSBkbyBub3QgcmVj
b21tZW5kIHVzaW5nIGEgY29tbWFuZGluZyB0b25lLiA6LSkNCg0KU2ltcGx5IGRvIHRoaXPvvJo+
XzwNCg0KY2QgbGludXgtbmV4dA0KdmltIERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdCAgKzEzMA0KDQo+DQo+IFJlcG9ydGVkLWJ5
OiBaZWFsIFJvYm90IDx6ZWFsY2lAenRlLmNvbS5jbj4NCj4gU2lnbmVkLW9mZi1ieTogeHUgeGlu
IDx4dS54aW4xNkB6dGUuY29tLmNuPg0KPiAtLS0NCj4gIC4uLi90cmFuc2xhdGlvbnMvemhfQ04v
YWRtaW4tZ3VpZGUvbW0vaW5kZXgucnN0ICAgIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9hZG1pbi1ndWlkZS9tbS9pbmRleC5y
c3QNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2Fk
bWluLWd1aWRlL21tL2luZGV4LnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L2FkbWluLWd1aWRlL21tL2luZGV4LnJzdA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRl
eCAwMDAwMDAwLi5jMTE5NzZiDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi90cmFuc2xhdGlvbnMvemhfQ04vYWRtaW4tZ3VpZGUvbW0vaW5kZXgucnN0DQo+IEBAIC0wLDAg
KzEsNDcgQEANCj4gKy4uIGluY2x1ZGU6OiAuLi9kaXNjbGFpbWVyLXpoX0NOLnJzdA0KPiArDQo+
ICs65Y6f5paHT3JpZ2luYWw6ICAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS9pbmRleC5y
c3QNCj4gKw0KPiArOuivkeiAhVRyYW5zbGF0b3I6IOW+kOmRqyB4dSB4aW4gPHh1LnhpbjE2QHp0
ZS5jb20uY24+DQo+ICsNCj4gKw0KPiArPT09PT09PT0NCj4gK+WGheWtmOeuoeeQhg0KPiArPT09
PT09PT0NCj4gKw0KPiArTGludXjlhoXlrZjnrqHnkIblrZDns7vnu5/vvIzpob7lkI3mgJ3kuYnv
vIzmmK/otJ/otKPns7vnu5/kuK3nmoTlhoXlrZjnrqHnkIbjgILlroPljIXmi6zkuobomZrmi5/l
hoXlrZjkuI7or7fmsYINCj4gK+WIhumhteeahOWunueOsO+8jOWGheaguOWGhemDqOe7k+aehOWS
jOeUqOaIt+epuumXtOeoi+W6j+eahOWGheWtmOWIhumFjeOAgeWwhuaWh+S7tuaYoOWwhOWIsOi/
m+eoi+WcsOWdgOepuumXtOS7pQ0KPiAr5Y+K6K645aSa5YW25LuW5b6I6YW355qE5LqL5oOF44CC
DQo+ICsNCj4gK0xpbnV45YaF5a2Y566h55CG5piv5LiA5Liq5YW35pyJ6K645aSa5Y+v6YWN572u
6K6+572u55qE5aSN5p2C57O757ufLCDkuJTov5nkupvorr7nva7kuK3nmoTlpKflpJrmlbDpg73l
j6/ku6XpgJoNCj4gK+i/h2BgL3Byb2NgYOaWh+S7tuezu+e7n+iOt+W+l++8jOW5tuS4lOWPr+S7
peS9v+eUqGBgc3lzY3RsYGDov5vooYzmn6Xor6LlkozosIPmlbTjgILov5nkuptBUEnmjqXlj6Po
oqsNCj4gK+aPj+i/sOWcqERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvc3lzY3RsL3ZtLnJzdOaW
h+S7tuWSjGBtYW4gNSBwcm9jYOS4reOAgg0KPiArDQo+ICsuLiBfbWFuIDUgcHJvYzogaHR0cDov
L21hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW41L3Byb2MuNS5odG1sDQo+ICsNCj4gK0xpbnV4
5YaF5a2Y566h55CG5pyJ5a6D6Ieq5bex55qE5pyv6K+t77yM5aaC5p6c5L2g6L+Y5LiN54af5oKJ
5a6D77yM6K+36ICD6JmR6ZiF6K+75LiL6Z2i5Y+C6ICD77yaDQo+ICs6cmVmOmBEb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL21tL2NvbmNlcHRzLnJzdCA8bW1fY29uY2VwdHM+YC4NCj4gKw0KPiAr
5Zyo5q2k55uu5b2V5LiL77yM5oiR5Lus6K+m57uG5o+P6L+w5LqG5aaC5L2V5LiOTGludXjlhoXl
rZjnrqHnkIbkuK3nmoTlkITnp43mnLrliLbkuqTkupLjgIINCj4gKw0KPiArLi4gdG9jdHJlZTo6
DQo+ICsgICA6bWF4ZGVwdGg6IDENCj4gKw0KPiArICAga3NtDQo+ICsNCj4gK1RvZG9saXN0Og0K
PiArICAgY29uY2VwdHMNCj4gKyAgIGNtYV9kZWJ1Z2ZzDQo+ICsgICBkYW1vbi9pbmRleA0KPiAr
ICAgaHVnZXRsYnBhZ2UNCj4gKyAgIGlkbGVfcGFnZV90cmFja2luZw0KPiArICAgbWVtb3J5LWhv
dHBsdWcNCj4gKyAgIG5vbW11LW1tYXANCj4gKyAgIG51bWFfbWVtb3J5X3BvbGljeQ0KPiArICAg
bnVtYXBlcmYNCj4gKyAgIHBhZ2VtYXANCj4gKyAgIHNvZnQtZGlydHkNCj4gKyAgIHN3YXBfbnVt
YQ0KPiArICAgdHJhbnNodWdlDQo+ICsgICB1c2VyZmF1bHRmZA0KPiArICAgenN3YXANClJlZmFj
dG9yaW5nIHRoZXNl44CCDQoNClRoYW5rcywNCllhbnRlbmcNCj4gLS0NCj4gMi4xNS4yDQo+DQo+
DQo=
