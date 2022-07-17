Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B845776A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiGQOUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGQOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:20:12 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD31513F1C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:20:11 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 75so16663622ybf.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BpeVJlbaPF1GO1c3GKSNMLxfJp7/vvzgIVz48ed0jbo=;
        b=LRZo5dNvWXxaKlp2R9CM31oQQNY9ZSVMnxFz1lfYLwuYebbi2W3f2Ntm6bvzFT/8GN
         9xS68uUSEPvI164QZ9mTkXTPONFyix475vs/T0ZOM0nHGY+yZ9sLT5Gh+fccLxOkhYIL
         b6HwvT9gNQ+7bpF7yDZYFeE1a10WSmnIGd+zOpPa+y8D+nXV7gCk5p/zAU7pxii+pkXT
         jgYHw2TxhNuv1X0MhBNDgz9+/e+oBtnM5ANu+LJ3LhExxv2Faw2bVvz25I2TkHANY/U5
         ntCw/kXHhgHzTLfETsVKXPGSF3KfadXao9qW9xVD7gpr0DBDqlPGJ4DKJ8V6EUvBeszo
         02LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=BpeVJlbaPF1GO1c3GKSNMLxfJp7/vvzgIVz48ed0jbo=;
        b=ESgDxWgIXC+7BRYsvDiQahHPMWx1ZFEQHg2APw6o0o0Zi45I/e/d+UXJFudMyEvvvE
         YinkbuVPWcNWX/ZTsvoyG6e5vv7AfHueaMeTuGl488/73yG0vnLkJod3ig/hn0LvTlJR
         zZWnSLW0M7Y0k+dJhbTLYi+CAn6cIY1r7Y855xuNyM7rdWn3IFO62EH2wTYOX4gPVQRw
         SwV/pMMXgVqk7893kAfMa0AD++jtXc143lU84YmnWovXf7gWUHr0jidooQ2IFMDcCVyr
         iM+WPkkmx2AUtwADVTdbmPuP89Z6B41GAkb8xce/0bt7ekezHZcwidcSjf42H6O67FPy
         IR2g==
X-Gm-Message-State: AJIora8F6fLmNtaN+W9iri+2NNXddPYo+n4d5p+WgZbCETVTA4154Fnp
        +BzIFGMnsjWSmstvryeFwlAuZL9wADxNLv8KneOijFV1+kin7g==
X-Google-Smtp-Source: AGRyM1tQsDYRdcyDZq0S1jyZa+uMlAFiLPBKvWU+HQtkcyekT2jEKOivqFAO/n5YV7qV62I4UVv+CwakIra7UlpP7dE=
X-Received: by 2002:a4a:ba12:0:b0:435:8a39:2197 with SMTP id
 b18-20020a4aba12000000b004358a392197mr2697124oop.35.1658067600540; Sun, 17
 Jul 2022 07:20:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:a081:b0:ad:bc01:40fd with HTTP; Sun, 17 Jul 2022
 07:20:00 -0700 (PDT)
Reply-To: mathurin.cecilia@aol.com
From:   Cecilia Mathurin <mathurincecilia719@gmail.com>
Date:   Sun, 17 Jul 2022 15:20:00 +0100
Message-ID: <CAMoFKqQrdp5YhE9FoHEp6FnsN323+jNNA8G50Ct0m9WTwAnytQ@mail.gmail.com>
Subject: =?UTF-8?B?VOG7qyBNcy5DZWNpbGlhIE1hdGh1cmlu?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VOG7qyBNcy5DZWNpbGlhIE1hdGh1cmluDQoNCkLhuqFuIHRow6JuLA0KDQpUw7RpIHLhuqV0IHRp
4bq/YyBraGkgxJHhur9uIHbhu5tpIGLhuqFuDQpC4bqxbmcgY8OhY2ggbsOgeSwgdMO0aSB2aeG6
v3QgdGjGsCBuw6B5IGNobyBi4bqhbiB24bubaSBz4buxIHRpbiB0xrDhu59uZyB2w6AgbmjDom4g
dsSDbg0KdMO0biB0cuG7jW5nLCB0w7RpIGvDqnUgZ+G7jWkgYuG6oW4gaMOjeSBracOqbiBuaOG6
q24gbeG7mXQgY2jDunQgdsOgIMSR4buNYyBo4bq/dCB0aW4gbmjhuq9uDQpj4bunYSB0w7RpLCB0
w7RpIMSRw6MgeGVtIHF1YSBo4buTIHPGoSBj4bunYSBi4bqhbiB2w6AgdGluaCB0aOG6p24gY+G7
p2EgdMO0aSBk4bqrbiB0w7RpIMSR4bq/bg0KbGnDqm4gaOG7hyB24bubaSBi4bqhbiwgdMO0aSB0
aOG7sWMgc+G7sSBUw7RpIGPhuqduIG3hu5l0IG5nxrDhu51pIHRydW5nIHRo4buxYywgY2jDom4g
dGjhuq10DQrEkeG7gyBjaGlhIHPhursgY+G6o20geMO6YyB2w6AgZ8OhbmggbuG6t25nIGPhu6dh
IHTDtGkgduG7m2kgYuG6oW4sIGjDo3kgxJHhu4MgdMO0aSBnaeG7m2kgdGhp4buHdQ0KYuG6o24g
dGjDom4gY+G7p2EgdMO0aSB24bubaSBi4bqhbiwgdMO0aSBsw6AgTXMuQ2VjaWxpYSBNYXRodXJp
biwgMjIgdHXhu5VpLCBjb24gZ8OhaQ0KZHV5IG5o4bqldCBj4bunYSDDtG5nIC8gYsOgIE1hcmsg
TWF0aHVyaW4gcXXDoSBj4buRLiBt4buZdCBuZ8aw4budaSBi4bqjbiDEkeG7i2EgQ290ZQ0KZCdJ
dm9pcmUg4bufIFTDonkgUGhpLiBDaGEgdMO0aSBsw6AgbeG7mXQgZG9hbmggbmjDom4gcuG6pXQg
Z2nDoHUgY8OzIGtoaSBjw7JuDQpz4buRbmcsIMO0bmcga2luaCBkb2FuaCB2aeG7h2Mgbmjhuq1w
IGto4bqpdSDDtCB0w7QgdsOgIMO0bmcgxJHDoyBi4buLIG3hu5l0IHRow6BuaCB2acOqbg0KdHJv
bmcgZ2lhIMSRw6xuaCBjaMO6bmcgdMO0aSBnaeG6v3QgdsOsIHPhu7EgZ2nDoHUgY8OzIGPhu6dh
IG3DrG5oIMSR4buDIMO0bmcgdGEgxJHDsmkgbOG6oWkNCnTDoGkgc+G6o24gY+G7p2EgY2hhIHTD
tGkgbcOgIMO0bmcg4bqleSDEkcOjIGtow7RuZyBjw7MsIG3hurkgdMO0aSDEkcOjIGNo4bq/dCBr
aGkgdMO0aSBjw7JuDQpz4buRbmcuIDYgdHXhu5VpIHbDoCBjaGEgdMO0aSDEkcOjIGNoxINtIHPD
s2MgdMO0aSBy4bqldCBjaHUgxJHDoW8gbmjGsCDEkeG7qWEgY29uIGfDoWkNCmR1eSBuaOG6pXQg
Y+G7p2Egw7RuZywgVHLGsOG7m2Mga2hpIGNoYSB0w7RpIHF1YSDEkeG7nWkgdOG6oWkgbeG7mXQg
YuG7h25oIHZp4buHbiB0xrAgbmjDom4NCuG7nyBDb3RlZCdpdm9pcmUsIG7GoWkgw7RuZyBuaOG6
rXAgdmnhu4duLCDDtG5nIMSRw6MgYsOtIG3huq10IGfhu41pIMSRaeG7h24gY2hvIHTDtGkg4buf
DQpiw6puIGdpxrDhu51uZyBj4bunYSDDtG5nIOG6pXkgdsOgIHRp4bq/dCBs4buZIGNobyB0w7Rp
IHbhu4Egc+G7sSB04buVbmcgY+G7p2EgYuG7kW4NCnRyaeG7h3UgbsSDbSB0csSDbSBVUw0KxJHD
tCBsYSAoNCw1IHRyaeG7h3UgxJHDtCBsYSkgYW5oIHRhIMSR4buDIGzhuqFpIHRyb25nIG3hu5l0
IHTDoGkga2hv4bqjbiB04bqhbSBuZ8awbmcNCnThuqFpIG3hu5l0IHRyb25nIG5o4buvbmcgbmfD
om4gaMOgbmcg4bufIMSRw6J5IOG7nyBBYmlkamFuIENvdGUgZCdpdm9pcmUuIHbDoCBhbmgg4bql
eQ0KY8WpbmcgbsOzaSB24bubaSB0w7RpIG7GoWkgYW5oIOG6pXkgZ2nhu68gdOG6pXQgY+G6oyBj
w6FjIHTDoGkgbGnhu4d1IG3DoCBuZ8OibiBow6BuZyDEkcOjDQpj4bqlcCBjaG8gYW5oIOG6pXkg
a2hpIGFuaCDhuqV5IGfhu61pIHRp4buBbiwgdsOgDQp0w6puIMSRxrDhu6NjIHZp4bq/dCBsw6Ag
Y29uIGfDoWkgZHV5IG5o4bqldCBj4bunYSB2dWEsIHbDrCB24bqteSB0w7RpIMSRYW5nIGxpw6pu
IGjhu4cgduG7m2kNCmLhuqFuIMSR4buDIGdpw7pwIHTDtGkgdsOgIMSR4bupbmcgduG7m2kgdMaw
IGPDoWNoIGzDoCDEkeG7kWkgdMOhYyBuxrDhu5tjIG5nb8OgaSBj4bunYSB0w7RpLA0KbmfGsOG7
nWkgbXXhu5FuIGjhu5cgdHLhu6MgdMO0aSBjaHV54buDbiB0aeG7gW4gdHJvbmcgdMOgaSBraG/h
uqNuIGPhu6dhIGLhuqFuIHNhbmcgxJHDsyDhu58NCsSR4bqldCBuxrDhu5tjIGPhu6dhIGLhuqFu
IHbhu5tpIHTGsCBjw6FjaCBsw6AgY2hhIHTDtGkNCsSRw6MgaMaw4bubbmcgZOG6q24gdMO0aSB0
w6xtIGtp4bq/bSBt4buZdCBuZ8aw4budaSBi4bqhbiDEkeG7nWkgbcOgIHTDtGkgbOG7sWEgY2jh
u41uIMSR4buDIGPhu6l1IGzhuqV5DQpt4bqhbmcgc+G7kW5nIGPhu6dhIHTDtGksIHbDrCB24bqt
eSBzYXUga2hpIHhlbSBo4buTIHPGoSBj4bunYSBi4bqhbiwgdMOibSB0csOtIHTDtGkgxJHDow0K
Y2hvIHBow6lwIHTDtGkgbGnDqm4gaOG7hyB24bubaSBi4bqhbi4NCg0KKDEpIELhuqFuIGPDsyB0
aOG7gyBjaMO6YyBt4burbmcgdMO0aSBraGkgdMO0aSDEkeG6v24gxJHhuqV0IG7GsOG7m2MgY+G7
p2EgYuG6oW4gxJHGsOG7o2Mga2jDtG5nDQooMikgQuG6oW4gY8OzIHRo4buDIMSR4bupbmcgbMOg
IG5nxrDhu51pIHRo4bulIGjGsOG7n25nIGPhu6dhIHF14bu5IHThu6sga2hpIHTDtGkgbeG7m2kg
MjIgdHXhu5VpLg0KKDMpIELhuqFuIGPDsyB0aOG7gyBnacO6cCB0w7RpIHbhu5tpIHTGsCBjw6Fj
aCBsw6AgQ2jhu4sgLyBDb24gZ8OhaSAvIELhuqFuIGPhu6dhIGLhuqFuIMSRxrDhu6NjIGtow7Ru
Zw0KKDQpIELhuqFuIGPDsyB0aOG7gyBz4bqvcCB44bq/cA0KxJHhu4MgdMO0aSDEkeG6v24gxJHh
uqV0IG7GsOG7m2MgY+G7p2EgYuG6oW4gc2F1IGtoaSB0aeG7gW4gxJHGsOG7o2MgY2h1eeG7g24s
IHbDoA0KbsOibmcgY2FvIHRyw6xuaCDEkeG7mSBo4buNYyB24bqlbiBj4bunYSB0w7RpIHbDoCBj
xaluZyDEkeG6p3UgdMawIHRp4buBbiB2w6BvIMSR4bqldCBuxrDhu5tjIGPhu6dhIGLhuqFuLg0K
DQpOZ2F5IGzhuq1wIHThu6ljLCB0w7RpIG5o4bqtbiDEkcaw4bujYyBwaOG6o24gaOG7k2kgdOG7
qyBi4bqhbiB24buBIHnDqnUgY+G6p3UgY+G7p2EgdMO0aSwgdMO0aSBz4bq9DQpjaHV54buDbiBj
aG8gYuG6oW4gdOG6pXQgY+G6oyBjw6FjIHTDoGkgbGnhu4d1IGPhuqduIHRoaeG6v3QgbGnDqm4g
cXVhbiDEkeG6v24ga2hv4bqjbiB0aeG7gW4NCmfhu61pIG7DoHkgduG7m2kgbmfGsOG7nWkgbGnD
qm4gaOG7hyBuZ8OibiBow6BuZyDEkeG7gyBi4bqhbiBsacOqbiBo4buHIHbhu5tpIG5nw6JuIGjD
oG5nIMSR4buDDQpjaHV54buDbiB0aeG7gW4gdsOgbyB0w6BpIGtob+G6o24gY+G7p2EgYuG6oW4u
DQoNCkPhuqNtIMahbiBjaG8gc+G7sSBoaeG7g3UgYmnhur90IGPhu6dhIGLhuqFuLg0KDQpUcsOi
biB0cuG7jW5nDQpNcy5DZWNpbGlhIE1hdGh1cmluDQo=
