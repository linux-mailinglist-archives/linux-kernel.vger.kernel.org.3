Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D080B4CD861
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbiCDP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiCDP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:56:36 -0500
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930BF1BD04D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1646409336;
        bh=64ZefWM5dwMmiNlcoKhgsp/mQ1Q5iCEwT0OzjB//AQY=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date;
        b=HWydGXzFtUVR7T7c6iQEKtnnxVLkAXQiL+fkzIpokfQJkgGDXlFb3G4lb2f48tlOa
         W0s5ejGfgfNrVd3y+2Hl1i/mGDx3w9aT89BSf5zFbHZckbJPaIJ4P5k7FOHZ2BJ9Kl
         b7aPCC0cQWXHZ+H/YOkQzdGkw1uJEtM1Q0HFUiPY=
X-QQ-FEAT: oHWrrGTW1dDsKNFxPRHuucU0bvjgjO7B
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: N46sULEd9DYDcUHZOTEFVVjF+Czl8cDVCiMmgxSp8pp4tYRZjkiPZ9bQ1AElxJ
         dET+wEQAjcpk+R+gVCl2bpECJnOJuOqdiJoz9I/ah5WYguWj5ALiRfPR0gEOG62liToV4DgLLz6J+
         Rzze/PlyoB2uOFnLu61Gg0iAbn90zKBH6gC/Ce47+KxZaALZAorzEQgh7GOMIodJOnmdg8VkAj8pX
         +qmvmXtr6incxKAunCfx2zh7MvnW9VsJTvnWG7Viz0sNmm8cpguosl4wgaaCJAA6S6ySEj3ddu3dO
         5/Xtjo9rthH/cj43aVMEeGgoHkb/WKm8yVvwFURd0E6GpEhFhVjSxN8gcTCHBp99DaNXPSeNVdu1x
         v3tw3emgcSDZKSXM+wVpxFd1UaYELWmAF47doVmLf9d7g+E7R+GCxd7RgUvAFrI4ZCpZFqpWqWdzG
         ov1aevipHHtgPOhnVP+cbNEHwhRUnSb7N2Xzp57m6lJCqAHX+7ENCwiEk0l0Bglxqtg+F+hxn4/65
         rEHaUPitBjxf8PTFIOOhKTOLugZRfd23yB9Ub7uWdg1TnRAlGHSXWFIQGp+7e9ZrXgY+zGflyL56M
         bvcsrO5VlZCk9MQHvtlRllcPEY+XfZBRDuJK+gd6Ds3n7TIV5NCW9+efzXzdl2HRLJD1ylfrLBNEw
         Wg8W6PaQGNkCeTJWOy0Rgp9dEmBG3KGLI/30OgdENwrtPycA5hK0KfRcButOb/wAEmph8dbIjiRxE
         IHJqRLqv5v8TkzfTl2mkfzoZLvwmpBuevgpfLGjVPNZ2TG796BbJKQfyOIZ0GfR0tI+5rYyM2SHd4
         Nj65j3YBBs2ZWwbujWnM5sc3Sxj7jI2+WkZMSZGr40icrYKUPrEXXK/eo7Hkece0TQYg/xlAgQTTe
         /bxA6VE899mjOU5A4tArB366G9q6QPgT1MBtAfHWqM=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 111.47.122.156
In-Reply-To: <YiIesoVGiVm2KcUD@kroah.com>
References: <tencent_DE1C3D1422E1DD4A35FFDE2048CC48B94E08@qq.com>
        <YiIesoVGiVm2KcUD@kroah.com>
X-QQ-STYLE: 
X-QQ-mid: webmail813t1646409336t1400708
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc:     "=?ISO-8859-1?B?bGludXg=?=" <linux@dominikbrodowski.net>,
        "=?ISO-8859-1?B?YWtwbQ==?=" <akpm@linux-foundation.org>,
        "=?ISO-8859-1?B?cG9tYnJlZGFubmU=?=" <pombredanne@nexb.com>,
        "=?ISO-8859-1?B?YXJuZA==?=" <arnd@arndb.de>,
        "=?ISO-8859-1?B?bHVjLnZhbm9vc3RlbnJ5Y2s=?=" 
        <luc.vanoostenryck@gmail.com>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] init/initramfs.c: check the return value of kstrdup()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Fri, 4 Mar 2022 23:55:35 +0800
X-Priority: 3
Message-ID: <tencent_72848F2829FCD381DC30F3E7DA737050880A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_EXCESS_BASE64,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAwNCBNYXIgMjAyMiAyMjoxNDoyMSArMDgwMCwgR3JlZyBLSCA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+PiBzdHJ1Y3QgZGlyX2VudHJ5ICpkZSA9IGtt
YWxsb2Moc2l6ZW9mKHN0cnVjdCBkaXJfZW50cnkpLCBHRlBfS0VSTkVMKTsKPj4gaWYgKCFk
ZSkKPj4gIHBhbmljX3Nob3dfbWVtKCJjYW4ndCBhbGxvY2F0ZSBkaXJfZW50cnkgYnVmZmVy
Iik7Cj4+IC0gSU5JVF9MSVNUX0hFQUQoJmRlLT5saXN0KTsKPj4gZGUtPm5hbWUgPSBrc3Ry
ZHVwKG5hbWUsIEdGUF9LRVJORUwpOwo+PiArIGlmICghZGUtPm5hbWUpIHsKPgo+IEhvdyBj
YW4gdGhpcyBmYWlsPyAgSGF2ZSB5b3UgZXZlciBoaXQgdGhpcyBpbiByZWFsIGxpZmU/Cj4K
Pj4gK2tmcmVlKGRlKTsKPj4gK3BhbmljX3Nob3dfbWVtKCJjYW4ndCBkdXBsaWNhdGUgZGly
IG5hbWUiKTsKPgo+IFdoeSBhcmUgeW91IGZyZWVpbmcgbWVtb3J5IGlmIHlvdSBhcmUgcGFu
aWNpbmc/Cj4KPiBIb3cgd2FzIHRoaXMgdGVzdGVkPwoKVGhhbmsgeW91IGZvciB0YWtpbmcg
dGhlIHRpbWUuCkkgZm91bmQgdGhpcyB3aXRoIGEgc3RhdGljIHRvb2wsIHdpdGhvdXQgZHlu
YW1pYyB0ZXN0aW5nLgprc3RyZHVwKCkgYWxsb2NhdGVzIG1lbW9yeSBmb3IgY29weWluZyB0
aGUgc3RyaW5nIGFuZCBJIG5vdGljZWQgYWxsIHRoZQpvdGhlciBhbGxvY2F0aW9uIGZ1bmN0
aW9ucyBpbiB0aGlzIGZpbGUgaGF2ZSB0aGUgY2hlY2sgZm9yIHRoZWlyIHJldHVybgp2YWx1
ZSBzdWNoIGFzIGBkZWAgb24gdGhlIGFib3ZlIGNvZGUuIFNvIEkgc3VwcG9zZSB0aGlzIGlz
IGFsc28gbmVlZGVkCnRvIGJlIGNoZWNrZWQgYW5kIEkgaW50dWl0aXZlbHkgYWRkIGtmcmVl
KCkgb24gdGhlIGVycm9yIHBhdGguCkknbSBzb3JyeSB0byBib3RoZXIgeW91IGlmIHRoaXMg
aXMgYWN0dWFsbHkgdW5uZWNlc3NhcnkuCgpSZWdhcmRzLApYaWFva2UgV2FuZw==

