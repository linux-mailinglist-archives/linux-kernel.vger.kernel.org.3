Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE27355D611
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344170AbiF1KYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbiF1KYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:24:44 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD730F6C;
        Tue, 28 Jun 2022 03:24:43 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id q132so21387296ybg.10;
        Tue, 28 Jun 2022 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dk3qCncJZhuJL7oIz+/IJyOkd8/HlsDLi3zlYk8e4WM=;
        b=oU7q6TpB5dCpRCh4m7N6CKCcPE3pV/9korBsXlXRimcU9S0tA6EwEE0ZI/yU2CWfji
         TNwtymdgIJtdph7OftkXCnGzRWDHlg7d2kaTZv+3dvGNApQPskMLtdyc1xukdt6PMlFt
         jaNhWdocWW0lSAWpZSRSKGYr/pp+ftjRlPizrqjqlHJntGhvjiZiVJYABzuDH//GOEgf
         X1oqMbU/vZETDmwJGmserZywaDRF5t/L6kigxbxb2AXrejG7YfNH7UeY7vNMZar3vJRJ
         nNyV2TyDhvAcwIlrsLvCZlSsWc3wB3wn1c614C44g18dmdYkkQa63AljcDPkXe09d4HA
         EUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dk3qCncJZhuJL7oIz+/IJyOkd8/HlsDLi3zlYk8e4WM=;
        b=lDGVr2Co/x0cBnUCFF6vvqysHurNN3U4DtFX3OGgF/w2f+yAJzqo598V1LsRz6Dm+k
         vhTHXscKUCjnaxdQppChF01slz7ZrBzJKlmdHc3/GBm0l3Hdzek/LngeVBn4zxZef+xl
         ust+xRKZqmGn3XJgmNbg/XRED0U1uc563jO5zCTpjnJAje5Ab90oeXB/EtXsW9hQZstM
         wuxPBhjw8RbT0F+J2tfTIE/t2b4Ns7lct8D5gJSTANPJl22E1DrW8VuXw5qhSmDNq021
         MvWSR46X3E3p0ok9YKPukt+ZYuTc8kCRr7oUT3BLKuhChnuldXWAOlvW49Jp0dGBei+q
         aY0g==
X-Gm-Message-State: AJIora9+r48zh9ywv/2YRpR6Bu6zf23CHMBBQUNJPdefeRd2n2IW/BtW
        aOuSOM7vGJSK4KEEoWqCXhmStxoNDY73c+QxX2Y=
X-Google-Smtp-Source: AGRyM1vmOvgu7oijx9AstcWTEZa+a3X5YHhRA1OL2Gu/Fv/D3ynLy6H1a6HwX3LtDWi7cyQmeOl779bVlwIEy5tg278=
X-Received: by 2002:a25:5809:0:b0:66c:8709:3611 with SMTP id
 m9-20020a255809000000b0066c87093611mr17054115ybb.608.1656411882606; Tue, 28
 Jun 2022 03:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220627151819.22694-9-lukas.bulwahn@gmail.com> <a2be48e5-e559-17d7-5ae7-d1205a737ea4@gmail.com>
In-Reply-To: <a2be48e5-e559-17d7-5ae7-d1205a737ea4@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 28 Jun 2022 12:24:31 +0200
Message-ID: <CAKXUXMwvF=DKZGvECMcfkHv959W-HSZ62Xi3CsjKN_xWGJuUKg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/11] docs: ja_JP: howto: remove reference to removed submitting-drivers
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jean Delvare <jdelvare@suse.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMjgsIDIwMjIgYXQgNzoyNSBBTSBBa2lyYSBZb2tvc2F3YSA8YWtpeWtzQGdt
YWlsLmNvbT4gd3JvdGU6DQo+DQo+IEhpIEx1a2FzLA0KPg0KPiBPbiBNb24sIDI3IEp1biAyMDIy
IDE3OjE4OjE2ICswMjAwLCBMdWthcyBCdWx3YWhuIHdyb3RlOg0KPiA+IFRoZSBkb2N1bWVudCBz
dWJtaXR0aW5nLWRyaXZlcnMucnN0IHdhcyBkZWxldGVkLiBUaGlzIHJlbW92ZXMgdGhlDQo+ID4g
Y29ycmVzcG9uZGluZyByZWZlcmVuY2UgaW4gdGhlIEphcGFuZXNlIHRyYW5zbGF0aW9uIG9mIHRo
ZSBob3d0by4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2FzIEJ1bHdhaG4gPGx1a2FzLmJ1
bHdhaG5AZ21haWwuY29tPg0KPg0KPiBTZWUgYmVsb3cgZm9yIHN1Z2dlc3Rpb24gb2YgcGx1cmFs
IHRvIHNpbmd1bGFyIGNoYW5nZS4NCj4NCg0KVGhhbmtzIGZvciB5b3VyIGhlbHAuDQoNCk9uY2Ug
Sm9uYXRoYW4gaGFzIHJldmlld2VkIGFuZCBwcmluY2lwYWxseSBhY2tub3dsZWRnZWQgdGhpcyBz
ZXJpZXMsIEkNCndpbGwgY29weSBpdCBkaXJlY3RseSBmcm9tIHRoaXMgZW1haWwgaW4gcmF3IGZv
cm0gaW50byB0aGUgLnJzdCBmaWxlLA0KYW1lbmQgdGhlIGNvbW1pdCBhbmQgc2VuZCBvdXQgdGhl
IG5ldyBwYXRjaCBzZXJpZXMuDQoNCkx1a2FzDQoNCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlv
bi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0IHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9KUC9ob3d0by5yc3QgYi9Eb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy9qYV9KUC9ob3d0by5yc3QNCj4gPiBpbmRleCAzOGZlZDZmZTYyZmUuLjAz
YjIwNzllNGQ1ZCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9q
YV9KUC9ob3d0by5yc3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9K
UC9ob3d0by5yc3QNCj4gPiBAQCAtMTI5LDcgKzEyOSw3IEBAIGxpbnV4LWFwaUB2Z2VyLmtlcm5l
bC5vcmcg44Gr6YCB44KL44GT44Go44KS5Yun44KB44G+44GZ44CCDQo+ID4gICAgICDjg6vjgavl
vpPjgaPjgabjgYTjgovjgoLjga7jgaDjgZHjgpLlj5fjgZHku5jjgZHjgIHlpJrjgY/jga7kurrj
ga/mraPjgZfjgYTjgrnjgr/jgqTjg6vjga7jgrPjg7zjg4kNCj4gPiAgICAgIOOBoOOBkeOCkuOD
rOODk+ODpeODvOOBl+OBvuOBmeOAgg0KPiA+DQo+ID4gLSAgOnJlZjpgRG9jdW1lbnRhdGlvbi9w
cm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QgPGNvZGluZ3N0eWxlPmAg44GoIDpyZWY6YERv
Y3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLWRyaXZlcnMucnN0IDxzdWJtaXR0aW5nZHJp
dmVycz5gDQo+ID4gKyAgOnJlZjpgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0
Y2hlcy5yc3QgPGNvZGluZ3N0eWxlPmANCj4gPiAgICAgIOOBk+OCjOOCieOBruODleOCoeOCpOOD
q+OBq+OBr+OAgeOBqeOBhuOChOOBo+OBpuOBhuOBvuOBj+ODkeODg+ODgeOCkuS9nOOBo+OBpuaK
leeov+OBmeOCi+OBi+OBq+OBpA0KPg0KPiAgICAgICAg44GT44Gu44OV44Kh44Kk44Or44Gr44Gv
44CB44Gp44GG44KE44Gj44Gm44GG44G+44GP44OR44OD44OB44KS5L2c44Gj44Gm5oqV56i/44GZ
44KL44GL44Gr44GkDQo+DQo+ID4gICAgICDjgYTjgabpnZ7luLjjgavoqbPjgZfjgY/mm7jjgYvj
gozjgabjgYrjgorjgIHku6XkuIvjgpLlkKvjgb/jgb7jgZkgKOOBk+OCjOOBoOOBkeOBq+mZkOOC
ieOBquOBhA0KPiA+ICAgICAg44GR44KM44Gp44KCKQ0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+DQo+
ICAgICAgICAgVGhhbmtzLCBBa2lyYQ0KPg0K
