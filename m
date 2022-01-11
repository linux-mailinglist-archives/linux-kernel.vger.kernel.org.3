Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37648ADCD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiAKMq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbiAKMq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:46:57 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B059FC06173F;
        Tue, 11 Jan 2022 04:46:57 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id l3so22166513iol.10;
        Tue, 11 Jan 2022 04:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aNXCOtsAv1WQs+7mymNx1LZ8JZ+GZuDdSGb+4Lm8cH8=;
        b=fItsyLyZxi/GAAuUlls7hEN1h+wGc2omSg7VP7gxuubu7vMaGniAjzpKSFwwm55ixg
         ManUqjISwxDoFOmJt8g4KrFE34/+pgt2oo5uE2jJFVOk4AlgfsSEPFOD/bnO3GSj5BGH
         Rp8qr6rMkcfefhCQTp0N4kMrsrku/1kH2Qzs6wiT0xw0PH6bv/ZxxvS/hPxoHS6RCezE
         PapgKISPCxamJg/zsNqjARdL4XlfRgNvilk7y/O3KY9AVclZAcBzhQ0XwLDGQdzaKra5
         JrgeS5b2Z1LL7SApsNH/cbWZpYUvAyoeGJjzfDiwJK3J7vHCEegnYZYQFcbJNKCZ0Jn4
         gv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aNXCOtsAv1WQs+7mymNx1LZ8JZ+GZuDdSGb+4Lm8cH8=;
        b=0YHY/OTSwV0dZIyE79ntO4vOs4sjymnIbo6bRkiAeGD8jFLjTcSNciadoaXLfS+Wsa
         qt1GGzlW5kDczI+TxyRV3UbAtP0OSeq5dB6aLVivdKsHQKps5+BpoFtDFH7wO+18+QZ+
         MAzynFWZaMLQSQatti0Wf86lk4kB3C6qbVt8DAETBx661OpspiNzpMbOvW6dApxvt7Dp
         0LtDAHqxjSdvo7MtPq9Y+KGn5EOuN+3shjbWgdJtWUPHyCQ6h2GDLe22IiiN23v+CdZO
         vkuK3M7b1dLYl4mdeEHZ0XXjDPgYJj3+n3Nxm2N5KabyVkg2XRTh/Wj7jyzsIi7eG5EW
         59Xw==
X-Gm-Message-State: AOAM53058ebrdlMqfKS4nArVI8yxlVOQPJBywF3X6oHW1qF2RNADAnZs
        srf6vZwxtuCDTGJs8xrT/v4hLBRQr8g6JVxH7tE=
X-Google-Smtp-Source: ABdhPJxNVApQtceCVp0dANt14OGYZT6tYQ8vXmysL9uj1mIYqifgtsS2fvtbkbo3rbM8Hnqsi47H+l1N6A8Rg0KdH5Q=
X-Received: by 2002:a02:ad11:: with SMTP id s17mr2080475jan.209.1641905216780;
 Tue, 11 Jan 2022 04:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20220110122929.647573-1-xu.xin16@zte.com.cn> <20220110123221.647693-1-xu.xin16@zte.com.cn>
In-Reply-To: <20220110123221.647693-1-xu.xin16@zte.com.cn>
From:   Alex Shi <seakeel@gmail.com>
Date:   Tue, 11 Jan 2022 20:46:20 +0800
Message-ID: <CAJy-AmnPXUUneu4WnbKBHe9g=gPTDyJBsP0eZmbgPxnLQZyYxg@mail.gmail.com>
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

T24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgODozMiBQTSA8Y2dlbC56dGVAZ21haWwuY29tPiB3cm90
ZToNCj4NCj4gRnJvbTogeHUgeGluIDx4dS54aW4xNkB6dGUuY29tLmNuPg0KPg0KPiBUaGlzIHBh
dGNoIGFkZHMgemhfQ04vYWRtaW4tZ3VpZGUvbW0vaW5kZXgucnN0Lg0KPg0KPiBSZXBvcnRlZC1i
eTogWmVhbCBSb2JvdCA8emVhbGNpQHp0ZS5jb20uY24+DQo+IFNpZ25lZC1vZmYtYnk6IHh1IHhp
biA8eHUueGluMTZAenRlLmNvbS5jbj4NCj4gLS0tDQo+ICAuLi4vdHJhbnNsYXRpb25zL3poX0NO
L2FkbWluLWd1aWRlL21tL2luZGV4LnJzdCAgICB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWRtaW4tZ3VpZGUvbW0vaW5kZXgu
cnN0DQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9h
ZG1pbi1ndWlkZS9tbS9pbmRleC5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9D
Ti9hZG1pbi1ndWlkZS9tbS9pbmRleC5yc3QNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5k
ZXggMDAwMDAwMC4uYzExOTc2Yg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRp
b24vdHJhbnNsYXRpb25zL3poX0NOL2FkbWluLWd1aWRlL21tL2luZGV4LnJzdA0KPiBAQCAtMCww
ICsxLDQ3IEBADQo+ICsuLiBpbmNsdWRlOjogLi4vZGlzY2xhaW1lci16aF9DTi5yc3QNCj4gKw0K
PiArOuWOn+aWh09yaWdpbmFsOiAgIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vaW5kZXgu
cnN0DQo+ICsNCj4gKzror5HogIVUcmFuc2xhdG9yOiDlvpDpkasgeHUgeGluIDx4dS54aW4xNkB6
dGUuY29tLmNuPg0KDQpGb2xsb3cgdHJhbnNsYXRpb24gc3R5bGUuIDopDQoNCj4gKw0KPiArDQo+
ICs9PT09PT09PQ0KPiAr5YaF5a2Y566h55CGDQo+ICs9PT09PT09PQ0KPiArDQo+ICtMaW51eOWG
heWtmOeuoeeQhuWtkOezu+e7n++8jOmhvuWQjeaAneS5ie+8jOaYr+i0n+i0o+ezu+e7n+S4reea
hOWGheWtmOeuoeeQhuOAguWug+WMheaLrOS6huiZmuaLn+WGheWtmOS4juivt+axgg0KPiAr5YiG
6aG155qE5a6e546w77yM5YaF5qC45YaF6YOo57uT5p6E5ZKM55So5oi356m66Ze056iL5bqP55qE
5YaF5a2Y5YiG6YWN44CB5bCG5paH5Lu25pig5bCE5Yiw6L+b56iL5Zyw5Z2A56m66Ze05LulDQo+
ICvlj4rorrjlpJrlhbbku5blvojphbfnmoTkuovmg4XjgIINCj4gKw0KPiArTGludXjlhoXlrZjn
rqHnkIbmmK/kuIDkuKrlhbfmnInorrjlpJrlj6/phY3nva7orr7nva7nmoTlpI3mnYLns7vnu58s
IOS4lOi/meS6m+iuvue9ruS4reeahOWkp+WkmuaVsOmDveWPr+S7pemAmg0KPiAr6L+HYGAvcHJv
Y2Bg5paH5Lu257O757uf6I635b6X77yM5bm25LiU5Y+v5Lul5L2/55SoYGBzeXNjdGxgYOi/m+ih
jOafpeivouWSjOiwg+aVtOOAgui/meS6m0FQSeaOpeWPo+iiqw0KPiAr5o+P6L+w5ZyoRG9jdW1l
bnRhdGlvbi9hZG1pbi1ndWlkZS9zeXNjdGwvdm0ucnN05paH5Lu25ZKMYG1hbiA1IHByb2Ng5Lit
44CCDQoNClRoZSBvcmlnaW5hbCBkb2MgaGFzIGh5cGVyIGxpbmsgZm9yICdtYW4gNSBwcm9jJywg
YmV0dGVyIHRvIGtlZXAgaXQuDQpBbmQgbWF5IGl0IGhhcw0KQ2hpbmVzZSB2ZXJpb24gbWFuIHBh
Z2U/DQoNCkFsc28gc3MgdGhpcyBwYXRjaCBzaG91bGQgdGhlIGZpcnN0IHBhdGNoIGZvciB0aGlz
IHNlcmllcz8NCg0KVGhhbmtzDQpBbGV4DQoNCj4gKw0KPiArLi4gX21hbiA1IHByb2M6IGh0dHA6
Ly9tYW43Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuNS9wcm9jLjUuaHRtbA0KPiArDQo+ICtMaW51
eOWGheWtmOeuoeeQhuacieWug+iHquW3seeahOacr+ivre+8jOWmguaenOS9oOi/mOS4jeeGn+aC
ieWug++8jOivt+iAg+iZkemYheivu+S4i+mdouWPguiAg++8mg0KPiArOnJlZjpgRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9tbS9jb25jZXB0cy5yc3QgPG1tX2NvbmNlcHRzPmAuDQo+ICsNCj4g
K+WcqOatpOebruW9leS4i++8jOaIkeS7rOivpue7huaPj+i/sOS6huWmguS9leS4jkxpbnV45YaF
5a2Y566h55CG5Lit55qE5ZCE56eN5py65Yi25Lqk5LqS44CCDQo+ICsNCj4gKy4uIHRvY3RyZWU6
Og0KPiArICAgOm1heGRlcHRoOiAxDQo+ICsNCj4gKyAgIGtzbQ0KPiArDQo+ICtUb2RvbGlzdDoN
Cj4gKyAgIGNvbmNlcHRzDQo+ICsgICBjbWFfZGVidWdmcw0KPiArICAgZGFtb24vaW5kZXgNCj4g
KyAgIGh1Z2V0bGJwYWdlDQo+ICsgICBpZGxlX3BhZ2VfdHJhY2tpbmcNCj4gKyAgIG1lbW9yeS1o
b3RwbHVnDQo+ICsgICBub21tdS1tbWFwDQo+ICsgICBudW1hX21lbW9yeV9wb2xpY3kNCj4gKyAg
IG51bWFwZXJmDQo+ICsgICBwYWdlbWFwDQo+ICsgICBzb2Z0LWRpcnR5DQo+ICsgICBzd2FwX251
bWENCj4gKyAgIHRyYW5zaHVnZQ0KPiArICAgdXNlcmZhdWx0ZmQNCj4gKyAgIHpzd2FwDQo+IC0t
DQo+IDIuMTUuMg0KPg0KPg0K
