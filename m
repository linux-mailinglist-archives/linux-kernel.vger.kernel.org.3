Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00256515AB1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 07:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379384AbiD3FsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 01:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbiD3FsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 01:48:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D3460A80
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 22:44:45 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so8943313pjm.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 22:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nMDKk7f5M2tgu0ZP+aeUDb0bQnhlCJAR66AvIm0h2wY=;
        b=CVpsBq8XB9ZJCpjyhhHCHXvR6itZF3NzbTvqunb2cjGkHEjhyCUtqbdNFM7wrX4ah6
         KHtxOKjNdlUB02TgJB59fmHOq0Dx3OMosOD1YRTJqZLr/P6CBoppq+8eNCi9n9005+nL
         fUTlLCmV4EQ5dhOwB5qtczv9NeQXHVTo2NK3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nMDKk7f5M2tgu0ZP+aeUDb0bQnhlCJAR66AvIm0h2wY=;
        b=l8yfSkTdlKT9KWUoU/K7ZmSNgbo1Cc5rx7GOa72rPRYwOvhwjrie6IczafB0KyI260
         pS5rvU541KHBF6XmLKYy/1SXZh86LKQ1RIVyEPK9SgftBc+WMV05StsrQW+0WA+yUa9p
         NvkL1CR3uK3aK1UB8RGTijmFYlizpVLBLXLBhUnqCDDroTDXk2zCxurXiXGCgA8E4hs8
         0qtVsl12m65UmFht7P4k8w8voME8AOwD2n1XzUVGAlVMHpJMQ6vRZ+hcFL1hfNr17m7G
         uRGOxk0xTTtAUa2vO1bNbSRaNPDUlWuttBARwoJ1fzoSv1hZKYTxRgX2NOvVZKV4eNM5
         LEfA==
X-Gm-Message-State: AOAM532uUPHt/8TafOMB8ySFepF9/y8TcRGg9BFqUrbP37gB23YYCC6T
        KBqZ92DYvMp6FgdSu1MekckcBzzAh63uDSffLP0eNA==
X-Google-Smtp-Source: ABdhPJw2QIJIWitYOoFtC6x8j5Cv00SwGPReTPEBu/QJvYbrFHLlet+hLnaBYeHoK52gPmjz2Q/uKHz6jhjYA5V1qKI=
X-Received: by 2002:a17:90a:4417:b0:1ca:a861:3fbf with SMTP id
 s23-20020a17090a441700b001caa8613fbfmr7714140pjg.80.1651297484488; Fri, 29
 Apr 2022 22:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220429230001.6124-1-fujimotokosuke0@gmail.com>
In-Reply-To: <20220429230001.6124-1-fujimotokosuke0@gmail.com>
From:   Tsugikazu Shibata <shibata@linuxfoundation.org>
Date:   Sat, 30 Apr 2022 14:44:33 +0900
Message-ID: <CAO+cJp0T-OrC1x+pTezPqWdkOKcSXutLF6yb=YO7TCVMh7BxwQ@mail.gmail.com>
Subject: Re: [PATCH v4] docs/trans/ja_JP/howto: Don't mention specific kernel versions
To:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc:     corbet@lwn.net, Akira Yokosawa <akiyks@gmail.com>,
        skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gRnVqaW1vdG8tc2FuLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NClVuZm9ydHVuYXRl
bHksIEkgZm91bmQgb25lIG1vcmUgaXNzdWUuLg0KDQpPbiBTYXQsIEFwciAzMCwgMjAyMiBhdCA4
OjAwIEFNIEtvc3VrZSBGdWppbW90bw0KPGZ1amltb3Rva29zdWtlMEBnbWFpbC5jb20+IHdyb3Rl
Og0KPg0KPiBUaGlzIGNoYW5nZSBpcyBiYXNlZCBvbiBjb21taXQgZDJiMDA4ZjEzNGI3DQo+ICgi
RG9jdW1lbnRhdGlvbi9wcm9jZXNzL2hvd3RvOiBVcGRhdGUgZm9yIDQueCAtPiA1LnggdmVyc2lv
bmluZyIpLg0KPg0KPiBSZXBsYWNlICI0Lngga2VybmVsIHZlcnNpb24iIHdpdGggZ2VuZXJpYyB0
ZXJtIHN1Y2ggYXMgIm1haW5saW5lIHRyZWUiDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEtvc3VrZSBG
dWppbW90byA8ZnVqaW1vdG9rb3N1a2UwQGdtYWlsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFraXJh
IFlva29zYXdhIDxha2l5a3NAZ21haWwuY29tPg0KPiAtLS0NCj4gVjI6IFJlZm9ybWF0dGVkIGNv
bW1pdCBsb2cgbWVzc2FnYWUgKFlva29zYXdhLXNhbikNCj4gVjM6IFVwZGF0ZWQgc29tZSBleHBy
ZXNzaW9ucyAoU2hpYmF0YS1zYW4pDQo+IC0gYWRkZWQgInZlcnNpb24gbnVtYmVyIiBpbiBtYWlu
bGluZSB0cmVlIHNlY3Rpb24NCj4gLSB1cGRhdGVkIGZyb20gInN0YWJsZSBrZXJuZWwiIHRvICJz
dGFibGUgdHJlZSINCj4gVjQ6IEFkZGVkIHJldmlld2VkIGJ5IHRhZyBhbmQgcmVtb3ZlZCBleHRy
YSBjaGFyYWN0ZXJzIChZb2tvc2F3YS1zYW4pDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMvamFfSlAvaG93dG8ucnN0IHwgNDQgKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0IGIv
RG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0DQo+IGluZGV4IGQ2Njdm
OWQ4YTAyYS4uZGVhYzQxZWIwMzhhIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy9qYV9KUC9ob3d0by5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvamFfSlAvaG93dG8ucnN0DQo+IEBAIC0yNjIsMjEgKzI2MiwyMSBAQCBMaW51eCDjgqvjg7zj
g43jg6vjga7plovnmbrjg5fjg63jgrvjgrnjga/nj77lnKjlub7jgaTjgYvjga7nlbDjgarjgovj
g6HjgqTjg7MNCj4gIOODgeOAjeOBqOWkmuaVsOOBruOCteODluOCt+OCueODhuODoOavjuOBruOC
q+ODvOODjeODq+ODluODqeODs+ODgeOBi+OCieani+aIkOOBleOCjOOBvuOBmeOAguOBk+OCjOOC
ieOBrg0KPiAg44OW44Op44Oz44OB44Go44GvIC0NCj4NCj4gLSAgLSDjg6HjgqTjg7Pjga4gNC54
IOOCq+ODvOODjeODq+ODhOODquODvA0KPiAtICAtIDQueC55IC1zdGFibGUg44Kr44O844ON44Or
44OE44Oq44O8DQo+IC0gIC0g44K144OW44K344K544OG44Og5q+O44Gu44Kr44O844ON44Or44OE
44Oq44O844Go44OR44OD44OBDQo+IC0gIC0g57Wx5ZCI44OG44K544OI44Gu44Gf44KB44GuIDQu
eCAtbmV4dCDjgqvjg7zjg43jg6vjg4Tjg6rjg7wNCj4gKyAgLSBMaW51cyDjga7jg6HjgqTjg7Pj
g6njgqTjg7Pjg4Tjg6rjg7wNCj4gKyAgLSDjg6Hjgrjjg6Pjg7znlarlj7fjgpLjgb7jgZ/jgZDm
lbDmnKzjga7lronlrprniYjjg4Tjg6rjg7wNCj4gKyAgLSDjgrXjg5bjgrfjgrnjg4bjg6Dmr47j
ga7jgqvjg7zjg43jg6vjg4Tjg6rjg7wNCj4gKyAgLSDntbHlkIjjg4bjgrnjg4jjga7jgZ/jgoHj
ga4gbGludXgtbmV4dCDjgqvjg7zjg43jg6vjg4Tjg6rjg7wNCj4NCj4gLTQueCDjgqvjg7zjg43j
g6vjg4Tjg6rjg7wNCj4gK+ODoeOCpOODs+ODqeOCpOODs+ODhOODquODvA0KPiAgfn5+fn5+fn5+
fn5+fn5+fn5+DQo+DQo+IC00Lngg44Kr44O844ON44Or44GvIExpbnVzIFRvcnZhbGRzIOOBq+OC
iOOBo+OBpuODoeODs+ODhuODiuODs+OCueOBleOCjOOAgQ0KPiAtaHR0cHM6Ly9rZXJuZWwub3Jn
IOOBriBwdWIvbGludXgva2VybmVsL3Y0LngvIOODh+OCo+ODrOOCr+ODiOODquOBq+WtmOWcqOOB
l+OBvuOBmeOAgg0KPiAr44Oh44Kk44Oz44Op44Kk44Oz44OE44Oq44O844GvIExpbnVzIFRvcnZh
bGRzIOOBq+OCiOOBo+OBpuODoeODs+ODhuODiuODs+OCueOBleOCjOOAgQ0KPiAraHR0cHM6Ly9r
ZXJuZWwub3JnIOOBruODquODneOCuOODiOODquOBq+WtmOWcqOOBl+OBvuOBmeOAgg0KPiAg44GT
44Gu6ZaL55m644OX44Ot44K744K544Gv5Lul5LiL44Gu44Go44GK44KKIC0NCj4NCj4gICAgLSDm
lrDjgZfjgYTjgqvjg7zjg43jg6vjgYzjg6rjg6rjg7zjgrnjgZXjgozjgZ/nm7TlvozjgavjgIEy
6YCx6ZaT44Gu54m55Yil5pyf6ZaT44GM6Kit44GR44KJ44KM44CBDQo+ICAgICAg44GT44Gu5pyf
6ZaT5Lit44Gr44CB44Oh44Oz44OG44OK6YGU44GvIExpbnVzIOOBq+Wkp+OBjeOBquW3ruWIhuOC
kumAgeOCi+OBk+OBqOOBjOOBp+OBjeOBvuOBmeOAgg0KPiAtICAgIOOBk+OBruOCiOOBhuOBquW3
ruWIhuOBr+mAmuW4uCAtbmV4dCDjgqvjg7zjg43jg6vjgavmlbDpgLHplpPlkKvjgb7jgozjgabj
gY3jgZ/jg5Hjg4Pjg4HjgafjgZnjgIINCj4gKyAgICDjgZPjga7jgojjgYbjgarlt67liIbjga/p
gJrluLggbGludXgtbmV4dCDjgqvjg7zjg43jg6vjgavmlbDpgLHplpPlkKvjgb7jgozjgabjgY3j
gZ/jg5Hjg4Pjg4HjgafjgZnjgIINCj4gICAgICDlpKfjgY3jgarlpInmm7Tjga8gZ2l0KOOCq+OD
vOODjeODq+OBruOCveODvOOCueeuoeeQhuODhOODvOODq+OAgeips+e0sOOBrw0KPiAgICAgIGh0
dHA6Ly9naXQtc2NtLmNvbS8g5Y+C54WnKSDjgpLkvb/jgaPjgabpgIHjgovjga7jgYzlpb3jgb7j
gZfjgYTjgoTjgormlrnjgafjgZnjgYzjgIHjg5Hjg4MNCj4gICAgICDjg4Hjg5XjgqHjgqTjg6vj
ga7lvaLlvI/jga7jgb7jgb7pgIHjgovjga7jgafjgoLljYHliIbjgafjgZnjgIINCj4gQEAgLTMw
MywyMCArMzAzLDE4IEBAIEFuZHJldyBNb3J0b24g44GMIExpbnV4LWtlcm5lbCDjg6Hjg7zjg6rj
g7PjgrDjg6rjgrnjg4jjgavjgqvjg7zjg43jg6vjg6rjg6rjg7wNCj4gICAgICAgICAg5YmN44KC
44Gj44Gm5rG644KB44KJ44KM44Gf6KiI55S744Gr44KI44Gj44Gm44Oq44Oq44O844K544GV44KM
44KL44KC44Gu44Gn44Gv44Gq44GE44GL44KJDQo+ICAgICAgICAgIOOBp+OBmeOAguOAjSoNCj4N
Cj4gLTQueC55IC1zdGFibGUg44Kr44O844ON44Or44OE44Oq44O8DQo+IC1+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+DQo+ICvjg6Hjgrjjg6Pjg7znlarlj7fjgpLjgb7jgZ/jgZDmlbDmnKzj
ga7lronlrprniYjjg4Tjg6rjg7wNCj4gK35+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fg0KPg0KPiAg44OQ44O844K444On44Oz55Wq5Y+344GMM+OBpOOBruaVsOWtl+OBq+WI
huOBi+OCjOOBpuOBhOOCi+OCq+ODvOODjeODq+OBryAtc3RhYmxlIOOCq+ODvOODjeODq+OBp+OB
meOAgg0KPiAt44GT44KM44Gr44Gv44CBNC54IOOCq+ODvOODjeODq+OBp+imi+OBpOOBi+OBo+OB
n+OCu+OCreODpeODquODhuOCo+WVj+mhjOOChOmHjeWkp+OBquW+jOaIu+OCiuOBq+WvvuOBmQ0K
PiAt44KL5q+U6LyD55qE5bCP44GV44GE6YeN6KaB44Gq5L+u5q2j44GM5ZCr44G+44KM44G+44GZ
44CCDQo+ICvjgZPjgozjgavjga/mnIDliJ3jga4y44Gk44Gu44OQ44O844K444On44Oz55Wq5Y+3
44Gu5pWw5a2X44Gr5a++5b+c44GX44Gf44CBDQo+ICvjg6HjgqTjg7Pjg6njgqTjg7Pjg6rjg6rj
g7zjgrnjgafopovjgaTjgYvjgaPjgZ/jgrvjgq3jg6Xjg6rjg4bjgqPllY/poYzjgoQNCj4gK+mH
jeWkp+OBquW+jOaIu+OCiuOBq+WvvuOBmeOCi+avlOi8g+eahOWwj+OBleOBhOmHjeimgeOBquS/
ruato+OBjOWQq+OBvuOCjOOBvuOBmeOAgg0KPg0KPiAg44GT44KM44Gv44CB6ZaL55m6L+Wun+mo
k+eahOODkOODvOOCuOODp+ODs+OBruODhuOCueODiOOBq+WNlOWKm+OBmeOCi+OBk+OBqOOBq+iI
iOWRs+OBjOeEoeOBj+OAgeacgOaWsA0KPiAg44Gu5a6J5a6a44GX44Gf44Kr44O844ON44Or44KS
5L2/44GE44Gf44GE44Om44O844K244Gr5o6o5aWo44GZ44KL44OW44Op44Oz44OB44Gn44GZ44CC
DQo+DQo+IC3jgoLjgZfjgIE0LngueSDjgqvjg7zjg43jg6vjgYzlrZjlnKjjgZfjgarjgYTloLTl
kIjjgavjga/jgIHnlarlj7fjgYzkuIDnlarlpKfjgY3jgYQgNC54IOOBjOacgOaWsA0KPiAt44Gu
5a6J5a6a54mI44Kr44O844ON44Or44Gn44GZ44CCDQo+IC0NCj4gLTQueC55IOOBryAic3RhYmxl
IiDjg4Hjg7zjg6AgPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+IOOBp+ODoeODs+ODhuOBleOCjOOB
puOBiuOCiuOAgQ0KPiAr5a6J5a6a54mI44OE44Oq44O844GvInN0YWJsZSIg44OB44O844OgIDxz
dGFibGVAdmdlci5rZXJuZWwub3JnPiDjgafjg6Hjg7Pjg4bjgZXjgozjgabjgYrjgorjgIENCj4g
IOW/heimgeOBq+W/nOOBmOOBpuODquODquODvOOCueOBleOCjOOBvuOBmeOAgumAmuW4uOOBruOD
quODquODvOOCueacn+mWk+OBryAy6YCx6ZaT5q+O44Gn44GZ44GM44CB5beuDQo+ICDjgZfov6vj
gaPjgZ/llY/poYzjgYzjgarjgZHjgozjgbDjgoLjgYblsJHjgZfplbfjgY/jgarjgovjgZPjgajj
goLjgYLjgorjgb7jgZnjgILjgrvjgq3jg6Xjg6rjg4bjgqPplqINCj4gIOmAo+OBruWVj+mhjOOB
ruWgtOWQiOOBr+OBk+OCjOOBq+WvvuOBl+OBpuOBoOOBhOOBn+OBhOOBruWgtOWQiOOAgeOBmeOB
kOOBq+ODquODquODvOOCueOBjOOBleOCjOOBvuOBmeOAgg0KPiBAQCAtMzI2LDcgKzMyNCw3IEBA
IERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLnJzdCDjg5XjgqHjgqTj
g6vjgavjga/jganjga7jgojjgYbjgaoNCj4gIOmhnuOBruWkieabtOOBjCAtc3RhYmxlIOODhOOD
quODvOOBq+WPl+OBkeWFpeOCjOWPr+iDveOBi+OAgeOBvuOBn+ODquODquODvOOCueODl+ODreOC
u+OCueOBjOOBqeOBhg0KPiAg5YuV44GP44GL44GM6KiY6L+w44GV44KM44Gm44GE44G+44GZ44CC
DQo+DQo+IC3jgrXjg5bjgrfjgrnjg4bjg6Dmr47jga7jgqvjg7zjg43jg6vjg4Tjg6rjg7zjgajj
g5Hjg4Pjg4ENCj4gK+OCteODluOCt+OCueODhuODoOavjuOBruOCq+ODvOODjeODq+ODhOODquOD
vA0KPiAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4NCj4gIOOBneOC
jOOBnuOCjOOBruOCq+ODvOODjeODq+OCteODluOCt+OCueODhuODoOOBruODoeODs+ODhuODiumB
lOOBryAtLS0g44Gd44GX44Gm5aSa44GP44Gu44Kr44O844ON44OrDQo+IEBAIC0zNTEsMTkgKzM0
OSwxOSBAQCBxdWlsdCDjgrfjg6rjg7zjgrrjgajjgZfjgablhazplovjgZXjgozjgabjgYTjgovj
g5Hjg4Pjg4Hjgq3jg6Xjg7zjgoLkvb/jgo/jgowNCj4gIOOBkeOCi+OBk+OBqOOBjOOBp+OBjeOB
vuOBmeOAguWkp+mDqOWIhuOBruOBk+OCjOOCieOBriBwYXRjaHdvcmsg44Gu44K144Kk44OI44Gv
DQo+ICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnLyDjgafjg6rjgrnjg4jjgZXjgozjgabj
gYTjgb7jgZnjgIINCj4NCj4gLee1seWQiOODhuOCueODiOOBruOBn+OCgeOBriA0LnggLW5leHQg
44Kr44O844ON44Or44OE44Oq44O8DQo+IC1+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+ICvntbHlkIjjg4bjgrnjg4jjga7jgZ/jgoHjga4gbGludXgtbmV4dCDj
gqvjg7zjg43jg6vjg4Tjg6rjg7wNCj4gK35+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCj4NCj4gLeOCteODluOCt+OCueODhuODoOODhOODquODvOOBruabtOaW
sOWGheWuueOBjOODoeOCpOODs+ODqeOCpOODs+OBriA0Lngg44OE44Oq44O844Gr44Oe44O844K4
44GV44KM44KLDQo+ICvjgrXjg5bjgrfjgrnjg4bjg6Djg4Tjg6rjg7zjga7mm7TmlrDlhoXlrrnj
gYzjg6HjgqTjg7Pjg6njgqTjg7Pjg4Tjg6rjg7zjgavjg57jg7zjgrjjgZXjgozjgosNCj4gIOWJ
jeOBq+OAgeOBneOCjOOCieOBr+e1seWQiOODhuOCueODiOOBleOCjOOCi+W/heimgeOBjOOBguOC
iuOBvuOBmeOAguOBk+OBruebrueahOOBruOBn+OCgeOAgeWun+izqueahOOBqw0KPiAg5YWo44K1
44OW44K344K544OG44Og44OE44Oq44O844GL44KJ44G744G85q+O5pel44OX44Or44GV44KM44Gm
44Gn44GN44KL54m55Yil44Gq44OG44K544OI55So44Gu44Oq44Od44K4DQo+ICDjg4jjg6rjgYzl
rZjlnKjjgZfjgb7jgZktDQo+DQo+ICAgICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy8/cD1s
aW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQNCj4NCj4gLeOBk+OBruOChOOCiuaW
ueOBq+OCiOOBo+OBpuOAgS1uZXh0IOOCq+ODvOODjeODq+OBr+asoeOBruODnuODvOOCuOapn+S8
muOBp+OBqeOCk+OBquOCguOBruOBjOODoeOCpOODsw0KPiAt44Op44Kk44Oz44Kr44O844ON44Or
44Gr44Oe44O844K444GV44KM44KL44GL44CB44GK44GK44G+44GL44Gq44Gu5bGV5pyb44KS5o+Q
5L6b44GX44G+44GZ44CCLW5leHQg44Kr44O8DQo+IC3jg43jg6vjga7lrp/ooYzjg4bjgrnjg4jj
gpLooYzjgYblhpLpmbrlpb3jgY3jgarjg4bjgrnjgr/jg7zjga/lpKfjgYTjgavmrZPov47jgZXj
gozjgb7jgZnjgIINCj4gK+OBk+OBruOChOOCiuaWueOBq+OCiOOBo+OBpuOAgWxpbnV4LW5leHQg
44Gv5qyh44Gu44Oe44O844K45qmf5Lya44Gn44Gp44KT44Gq44KC44Gu44GM44Oh44Kk44OzDQo+
ICvjg6njgqTjg7Pjgavjg57jg7zjgrjjgZXjgozjgovjgYvjgIHjgYrjgYrjgb7jgYvjgarjga7l
sZXmnJvjgpLmj5DkvpvjgZfjgb7jgZnjgIINCg0KVGhpcyB3b3VsZCBiZToNCuODqeOCpOODs+OB
q+ODnuODvOOCuOOBleOCjOOCi+OBi+OAgeOBiuOBiuOBvuOBi+OBquWxleacm+OCkuaPkOS+m+OB
l+OBvuOBmeOAgg0KDQpUaGFuayB5b3UgZm9yIGZpeGluZyB0aGlzIGRvY3VtZW50Lg0KDQpUc3Vn
aWthenUgU2hpYmF0YQ0K
