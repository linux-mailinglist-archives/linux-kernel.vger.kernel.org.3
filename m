Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FD35B2E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiIIFbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIIFbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:31:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B9811EA53;
        Thu,  8 Sep 2022 22:31:00 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq23so863148lfb.7;
        Thu, 08 Sep 2022 22:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=dzFYcSV0AZC8OzcF88d2UgzTXJbjZS/keSWnAO017vc=;
        b=ayMIV5wahl/SjJ3e3f7rrK6sAK/+YMEpQETXQCHN61xyvTiKoB2O05IiZLhgmk3BUm
         QQQAKCdBA4w5SCVhYsWAyAZAwyAakmg2hOHINUhT8a8H66KjJRHNAZ8X6gpy+EBWMifE
         RjjwwPnnwsplYxykdCdu9VI3s6NEvqizeqEJze5lKqtXcz/HBzmL9G3PU/Np5od0yXqm
         A5ycPWPT/HHUOkZoDj5PdWUaiVvu9Iyt1CWjVgKnkAPthfGfsZMhDFSzUxk3avaE0j+C
         WOfNQSE5QUu8xRTDlQ4O0mU4euj+80lbK+i1fxPgROAdjspcT7QI1JHJ/xIQa/ugrHB2
         uHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dzFYcSV0AZC8OzcF88d2UgzTXJbjZS/keSWnAO017vc=;
        b=8K6CNLhpgrPJ/Rnh4MSDVnf1B+njI2JUiFEoI8Uoa/dNJkNJ3eUyntsNsZRgbqkLld
         LfKKlXk2JXAifI3P9kX5ZituaSwS7SnvT9BvjcAgBipXGZwaNKQwcrOhmJuqaYgQzpia
         QdbMtGAjwOxOSYpa/Ece37Z9W/WgKnIS/WxeAPFZprkEijBYnwbTRSvcejtiDgBFbD1C
         X+AG9xbO2H3OKZ5ZQXomD4foymUFYo9Pa7PeHru3lATjfVCIPoxJvIfyQzpuTBVnbsAA
         hGEQyD5gLXyIz8o8UCTSDw2nzkX99lY4zmDITvxkzJmB+yZggI/oKP/xYI+yFYTi36HT
         rjyg==
X-Gm-Message-State: ACgBeo3uHv5joHffEQEHVcxzapi0qUZJ4bGU0DWIdxgQzIrrNvgcEpkI
        PxB58LuNp65f42dAGGSaHLhrda4MsSZWpDz8DAc=
X-Google-Smtp-Source: AA6agR4TIPzG58nzTztaGfpSg9qEpzrjSJU9Kd6zH4PWlBDT6gbBxiQXsOzE4CyQoWh/iSb3F2zeVl0OLQRZi3IF2J8=
X-Received: by 2002:ac2:4e0f:0:b0:48b:7a5f:91c8 with SMTP id
 e15-20020ac24e0f000000b0048b7a5f91c8mr4143120lfr.430.1662701458885; Thu, 08
 Sep 2022 22:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR20MB433769C4E2C73207CC9B1F15E9439@SJ0PR20MB4337.namprd20.prod.outlook.com>
In-Reply-To: <SJ0PR20MB433769C4E2C73207CC9B1F15E9439@SJ0PR20MB4337.namprd20.prod.outlook.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Fri, 9 Sep 2022 13:30:22 +0800
Message-ID: <CAJy-Amnx92Fbm5XT1LwAZ73ENharwTF70scYDkw8J9FA4j6Qww@mail.gmail.com>
Subject: Re: [PATCH] docs: zh_CN: fix several inapproriate terms
To:     Whye <whye314@outlook.com>
Cc:     Alex Shi <alexs@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBTZXAgOSwgMjAyMiBhdCAxMToxNiBBTSBXaHllIDx3aHllMzE0QG91dGxvb2suY29t
PiB3cm90ZToNCj4NCj4gQ29ycmVjdCBzZXZlcmFsIGluYXBwcm9yaWF0ZSB0ZXJtcyBhbWQgbWFy
a3MNCj4NCj4gU2lnbmVkLW9mZi1ieTogV2h5ZSA8d2h5ZTMxNEBvdXRsb29rLmNvbT4NCj4gLS0t
DQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNzLzEuSW50cm8ucnN0
ICAgfCAyICstDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNzLzIu
UHJvY2Vzcy5yc3QgfCA0ICsrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xh
dGlvbnMvemhfQ04vcHJvY2Vzcy8xLkludHJvLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL3poX0NOL3Byb2Nlc3MvMS5JbnRyby5yc3QNCj4gaW5kZXggNGY5Mjg0Y2JlMzNiLi41YjAy
ZTc0YWRhNzIgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L3Byb2Nlc3MvMS5JbnRyby5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMv
emhfQ04vcHJvY2Vzcy8xLkludHJvLnJzdA0KPiBAQCAtMTg1LDcgKzE4NSw3IEBAIEFuZHJldyBN
b3J0b24sIEFuZHJldyBQcmljZSwgVHN1Z2lrYXp1IFNoaWJhdGEg5ZKMIEpvY2hlbiBWb8OfIOOA
gg0KPiAg5omA5pyJ6LSh54yu57uZ5YaF5qC455qE5Luj56CB6YO95b+F6aG75piv5ZCI5rOV55qE
5YWN6LS56L2v5Lu244CC5Zug5q2k77yM5LiN5o6l5Y+X5Yy/5ZCN77yI5oiW5YyW5ZCN77yJ6LSh
54yuDQo+ICDogIXnmoTku6PnoIHjgILmiYDmnInotKHnjK7ogIXpg73pnIDopoHlnKjku5bku6zn
moTku6PnoIHkuIrigJxzaWduIG9mZu+8iOetvuWPke+8ieKAne+8jOWjsOaYjuS7o+eggeWPr+S7
pQ0KPiAg5ZyoR1BM5LiL5LiO5YaF5qC45LiA6LW35YiG5Y+R44CC5peg5rOV5o+Q5L6b5pyq6KKr
5YW25omA5pyJ6ICF6K645Y+v5Li65YWN6LS56L2v5Lu255qE5Luj56CB77yM5oiW5Y+v6IO95Li6
DQo+IC3lhoXmoLjpgKDmiJDniYjmnYPnm7jlhbPpl67popjnmoTku6PnoIHvvIjkvovlpoLvvIzn
lLHnvLrkuY/pgILlvZPkv53miqTnmoTlj43lkJHlt6XnqIvlt6XkvZzmtL7nlJ/nmoTku6PnoIHv
vIkNCj4gK+WGheaguOmAoOaIkOeJiOadg+ebuOWFs+mXrumimOeahOS7o+egge+8iOS+i+Wmgu+8
jOeUsee8uuS5j+mAguW9k+S/neaKpOeahOmAhuWQkeW3peeoi+W3peS9nOa0vueUn+eahOS7o+eg
ge+8iQ0KDQpXZSB0YWxrZWQgYWJvdXQgdGhlIGRpZmZlcmVudCwgYW5kIGJvdGggb2YgdGhlbSBo
YXZlIHN1cHBvcnRlciBhbmQNCm9wcG9uZW50cy4gQ2hhbmdlIGlzIHVubmVzc2FyeS4NCg0KRm9y
IG90aGVycw0KDQpSZXZpZXdlZC1ieTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQoNCj4g
IOS4jeiDveiiq+aOpeWPl+OAgg0KPg0KPiAg5pyJ5YWz54mI5p2D6Zeu6aKY55qE5o+Q6Zeu5Zyo
TGludXjlvIDlj5Hpgq7ku7bliJfooajkuK3lvojluLjop4HjgILov5nmoLfnmoTpl67popjpgJrl
uLjkvJrlvpfliLDkuI3lsJHnrZTmoYjvvIwNCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
dHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3MvMi5Qcm9jZXNzLnJzdCBiL0RvY3VtZW50YXRpb24v
dHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3MvMi5Qcm9jZXNzLnJzdA0KPiBpbmRleCA0YTZlZDAy
MTk0OTQuLjA0NGU5OThiMjlhYSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xh
dGlvbnMvemhfQ04vcHJvY2Vzcy8yLlByb2Nlc3MucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24v
dHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3MvMi5Qcm9jZXNzLnJzdA0KPiBAQCAtMzI3LDcgKzMy
Nyw3IEBAIHJlZGhhdC5jb20vbWFpbG1hbi9saXN0aW5mb+OAgg0KPiAgICDlrZDns7vnu5/lvIDl
j5HkurrlkZjnmoTmnIDkvbPlnLrmiYDjgIINCj4NCj4gIOacgOWQjuS4gOeCueKAlOKAlOaJvuWI
sOato+ehrueahOmCruS7tuWIl+ihqOKAlOKAlOaYr+W8gOWPkeS6uuWRmOW4uOWHuumUmeeahOWc
sOaWueOAguWcqGxpbnV4LWtlcm5lbOS4ig0KPiAt5o+Q5Ye65LiO572R57uc55u45YWz55qE6Zeu
6aKY55qE5Lq65Yeg5LmO6IKv5a6a5Lya5pS25Yiw5LiA5Liq56S86LKM55qE5bu66K6u77yM6L2s
5YiwbmV0ZGV25YiX6KGo5LiK5o+Q5Ye677yMDQo+ICvmj5Dlh7rkuI7nvZHnu5znm7jlhbPnmoTp
l67popjnmoTkurrlh6DkuY7ogq/lrprkvJrmlLbliLDkuIDkuKrnpLzosoznmoTlu7rorq7vvJro
vazliLBuZXRkZXbliJfooajkuIrmj5Dlh7rvvIwNCj4gIOWboOS4uui/meaYr+Wkp+WkmuaVsOe9
kee7nOW8gOWPkeS6uuWRmOe7j+W4uOWHuueOsOeahOWIl+ihqOOAgui/mOacieWFtuS7luWIl+ih
qOWPr+eUqOS6jnNjc2njgIF2aWRlbzRsaW51eOOAgQ0KPiAgaWRl44CBZmlsZXN5c3RlbeetieWt
kOezu+e7n+OAguafpeaJvumCruS7tuWIl+ihqOeahOacgOS9s+S9jee9ruaYr+S4juWGheaguOa6
kOS7o+eggeS4gOi1t+aJk+WMheeahA0KPiAgTUFJTlRBSU5FUlPmlofku7bjgIINCj4gQEAgLTMz
OCw3ICszMzgsNyBAQCBNQUlOVEFJTkVSU+aWh+S7tuOAgg0KPiAg5YWz5LqO5aaC5L2V5byA5aeL
5YaF5qC45byA5Y+R6L+H56iL55qE6Zeu6aKY5b6I5bi46KeB4oCU4oCU5Liq5Lq65ZKM5YWs5Y+4
55qG54S244CC5ZCM5qC35bi46KeB55qE5piv5aSx6K+v77yM6L+ZDQo+ICDkvb/lvpflhbPns7vn
moTlvIDlp4vmr5TmnKzlupTnmoTmm7Tlm7Dpmr7jgIINCj4NCj4gLeWFrOWPuOmAmuW4uOW4jOac
m+iBmOivt+efpeWQjeeahOW8gOWPkeS6uuWRmOadpeWQr+WKqOW8gOWPkeWboumYn+OAguWunumZ
heS4iu+8jOi/meaYr+S4gOenjeacieaViOeahOaKgOacr+OAgg0KPiAr5YWs5Y+46YCa5bi45biM
5pyb6IGY6K+355+l5ZCN55qE5byA5Y+R5Lq65ZGY5p2l5ZCv5Yqo5byA5Y+R5Zui6Zif44CC5a6e
6ZmF5LiK77yM6L+Z5piv5LiA56eN5pyJ5pWI55qE5pa55byP44CCDQo+ICDkvYblroPkuZ/lvoDl
voDmmK/mmILotLXnmoTvvIzogIzkuJTlr7nlop7liqDmnInnu4/pqoznmoTlhoXmoLjlvIDlj5Hk
urrlkZjnmoTmlbDph4/msqHmnInlpJrlpKfluK7liqnjgILogIMNCj4gIOiZkeWIsOaXtumXtOaK
leWFpe+8jOWPr+S7peiuqeWGhemDqOW8gOWPkeS6uuWRmOWKoOW/q0xpbnV45YaF5qC455qE5byA
5Y+R6YCf5bqm44CC5Yip55So6L+Z5q615pe26Ze05Y+v5LulDQo+ICDorqnpm4fkuLvmi6XmnInk
uIDmibnml6Lkuobop6PlhoXmoLjlj4jkuobop6Plhazlj7jnmoTlvIDlj5HkurrlkZjvvIzov5jl
j6/ku6XluK7liqnln7norq3lhbbku5bkurrjgILku47kuK3mnJ8NCj4gLS0NCj4gMi4yNS4xDQo+
DQo=
