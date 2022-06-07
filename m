Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DA153F3FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiFGCkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiFGCka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:40:30 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45431C0470;
        Mon,  6 Jun 2022 19:40:29 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31332df12a6so13529827b3.4;
        Mon, 06 Jun 2022 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ONTIA4PsDsUBidqsfJUuQENY/gI8+qK8mmrvpc3J7Ok=;
        b=bni0Ej2XgU5chmZ+DfFG2JnbZw115iY+Dv/MJh8jD+A3ZZDmoH8Kives8cOUvrread
         d6blOrbTL9BfZVTW9X9I/Ki4IyyhzsoY2U5Ea2nT1hQg8H/LANH4GLo33ksSZk0ySFap
         Iacw4ppxidywynSpz/vOzBb2h+g+kRsZHYAbAbqeT91fRChvHrLvtwwFmxsqwYdHEz16
         psHULs4RS9pebX78swKVRSw2Luoy7UIDJrzWVXZLC/xh9VY9t3CPWIZsgvAWPXNhGjnQ
         7eySd8HmKe2pOMGkeW7qAEfpNxTw4ZC1MOZ9IlGmh07msivxP5lhsSL/3LkttPi68Zda
         Rl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ONTIA4PsDsUBidqsfJUuQENY/gI8+qK8mmrvpc3J7Ok=;
        b=LZVxnokgN1omsXJLrnZcvByCpCdlKMTtkuP6zoLQRHdwAzNdawq1O9fyzL1/yrc6ry
         xc1AN0gBfzjtpeqKb8isSaxowUsyyHz714qPVKnzzJtaJAWjP3201DSUxnWUb1l6VZoN
         5N08ShR1SutAlTTbBNkbqft6UF5TRuedmncNl6HRMbl+yq/A9So6bmXB8wspsJPstDOC
         QsMx4xjYcqvpLhY8vtjAPsve/YMTb0zzhozpSQQaSzXFrdPeCWocxAtY9F4ht44rsf7n
         2Bh7qEDysE7vegNGiNOpgpQu5Dcl8LWNe91q3fpE53EV7841DTbvrKaXEpizs5yZww+R
         rSyA==
X-Gm-Message-State: AOAM530Q3rjF6fum0l3kbGtGNuToZUgk65OgTeJq6/c+7P90/I7Tn8Tw
        xymkKlxeJQrEIPYq/fhbPxyJOjftlcOlC+U74RA75qZCATePEA==
X-Google-Smtp-Source: ABdhPJyP9cPS7hXMybe1ucNoOzY5NjauDggeOhTRDW9dhTzQbnExAHKXQvMsJqZjN04ylGNYb90AA8Cq8a9Se4C80QM=
X-Received: by 2002:a81:3956:0:b0:2f8:db28:2e87 with SMTP id
 g83-20020a813956000000b002f8db282e87mr29576080ywa.134.1654569628463; Mon, 06
 Jun 2022 19:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <Yp41+eTjoPRa4hrl@bobwxc.mipc>
In-Reply-To: <Yp41+eTjoPRa4hrl@bobwxc.mipc>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Tue, 7 Jun 2022 10:40:16 +0800
Message-ID: <CAMU9jJqKQQGD73_ZXTL1NxwihPtun7D2i4e2_RaZe=5HMbz5xA@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Update zh_CN/kernel-hacking/hacking.rst to 5.19-rc1
To:     Wu XiangCheng <bobwxc@email.cn>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Li Feng <felixlee868@icloud.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3UgWGlhbmdDaGVuZyA8Ym9id3hjQGVtYWlsLmNuPiDkuo4yMDIy5bm0NuaciDfml6Xlkajkuowg
MDE6MjDlhpnpgZPvvJoNCj4NCj4gKiB1cGRhdGUgdG8gY29tbWl0IGYzNWNmMWE1OWU5YSAoIkRv
Y3VtZW50YXRpb246IGtlcm5lbC1oYWNraW5nOiBtaW5vcg0KPiAgIGVkaXRzIGZvciBzdHlsZSIp
DQo+DQo+ICogZml4IGEgaG9tb3Bob25lIHR5cG8gcmVwb3J0ZWQgYnkgTGkgRmVuZw0KPg0KPiBS
ZXBvcnRlZC1ieTogTGkgRmVuZyA8ZmVsaXhsZWU4NjhAaWNsb3VkLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogV3UgWGlhbmdDaGVuZyA8Ym9id3hjQGVtYWlsLmNuPg0KUmV2aWV3ZWQtYnk6IFlhbnRl
bmcgU2kgPHNpeWFudGVuZ0Bsb29uZ3Nvbi5jbj4NCg0KQlRXLA0KYjQgZG9lc24ndCBzZWVtIHRv
IHdvcmsgZm9yIHRoaXMgcGF0Y2gsIGJ1dCBJIG1hbnVhbGx5IGRvd25sb2FkZWQgdGhlDQplbWFp
bCBmb3IgYSBidWlsZCB0ZXN0IGFuZCBpdCB3YXMgZmluZS4gOikNCg0KbG9nOg0KJC4uL2I0L2I0
LnNoIGFtIFlwNDErZVRqb1BSYTRocmxAYm9id3hjLm1pcGMNCkxvb2tpbmcgdXAgaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci9ZcDQxJTJCZVRqb1BSYTRocmwlNDBib2J3eGMubWlwYw0KR3JhYmJp
bmcgdGhyZWFkIGZyb20NCmxvcmUua2VybmVsLm9yZy9hbGwvWXA0MSUyQmVUam9QUmE0aHJsJTQw
Ym9id3hjLm1pcGMvdC5tYm94Lmd6DQpBbmFseXppbmcgMSBtZXNzYWdlcyBpbiB0aGUgdGhyZWFk
DQpDaGVja2luZyBhdHRlc3RhdGlvbiBvbiBhbGwgbWVzc2FnZXMsIG1heSB0YWtlIGEgbW9tZW50
Li4uDQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6DQogIEZpbGUgIi9ob21lL3Np
eWFudGVuZy9iNC9iNC9jb21tYW5kLnB5IiwgbGluZSAyNjMsIGluIDxtb2R1bGU+DQouLi4uLi4N
Cg0KVGhhbmtzLA0KWWFudGVuZw0KPiAtLS0NCj4gIC4uLi96aF9DTi9rZXJuZWwtaGFja2luZy9o
YWNraW5nLnJzdCAgICAgICAgICB8IDIyICsrKysrKysrKy0tLS0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2tlcm5lbC1oYWNraW5nL2hhY2tp
bmcucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04va2VybmVsLWhhY2tpbmcv
aGFja2luZy5yc3QNCj4gaW5kZXggZjJiYzE1NGM1YmNjLi5iZGE3OTY0NmJiMWUgMTAwNjQ0DQo+
IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2tlcm5lbC1oYWNraW5nL2hh
Y2tpbmcucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2tlcm5l
bC1oYWNraW5nL2hhY2tpbmcucnN0DQo+IEBAIC04MSw3ICs4MSw3IEBADQo+ICDov4fnoazku7bk
uK3mlq3vvInnmoTigJzova/ku7bkuK3mlq3igJ3lsIbov5DooYzvvIggYGBrZXJuZWwvc29mdGly
cS5jYGAg77yJ44CCDQo+DQo+ICDmraTlpITlrozmiJDkuoborrjlpJrnnJ/mraPnmoTkuK3mlq3l
pITnkIblt6XkvZzjgILlnKjlkJFTTVDov4fmuKHnmoTml6nmnJ/vvIzlj6rmnInigJxib3R0b20g
aGFsdmVz5LiL5Y2KDQo+IC3pg6jigJ3vvIhCSHPvvInmnLrliLbvvIzml6Dms5XliKnnlKjlpJrk
uKpDUFXnmoTkvJjlir/jgILlnKjku47pgqPkupvkuIDlm6Lns5/nmoTlsLHnlLXohJHliIfmjaLo
v4fmnaXlkI7kuI3kuYXvvIwNCj4gK+mDqOKAne+8iEJIc++8ieacuuWItu+8jOaXoOazleWIqeeU
qOWkmuS4qkNQVeeahOS8mOWKv+OAguWcqOS7jumCo+S6m+S4gOWbouezn+eahOaXp+eUteiEkeWI
h+aNoui/h+adpeWQjuS4jeS5he+8jA0KPiAg5oiR5Lus5pS+5byD5LqG6L+Z5Liq6ZmQ5Yi277yM
6L2s6ICM5L2/55So4oCc6L2v5Lit5pat4oCd44CCDQo+DQo+ICBgYGluY2x1ZGUvbGludXgvaW50
ZXJydXB0LmhgYCDliJflh7rkuobkuI3lkIznmoTova/kuK3mlq3jgILlrprml7blmajova/kuK3m
lq3mmK/kuIDkuKrpnZ7luLjph43opoENCj4gQEAgLTk1LDggKzk1LDcgQEANCj4NCj4gIC4uIHdh
cm5pbmc6Og0KPg0KPiAtICAgIOKAnHRhc2tsZXTigJ3ov5nkuKrlkI3lrZfmmK/or6/lr7zmgKfn
moTvvJrlroPku6zkuI7igJzku7vliqHigJ3ml6DlhbPvvIzlj6/og73mm7TlpJrkuI7lvZPml7YN
Cj4gLSAgICDpmL/liJflhYvosKLCt+W6k+WFuea2heS9kOWkq+S6q+eUqOeahOezn+ezleS8j+eJ
ueWKoOacieWFs+OAgg0KPiArICAgIOKAnHRhc2tsZXTigJ3ov5nkuKrlkI3lrZfmmK/or6/lr7zm
gKfnmoTvvJrlroPku6zkuI7igJzku7vliqHigJ3ml6DlhbPjgIINCj4NCj4gIOS9oOWPr+S7peS9
v+eUqCA6YzpmdW5jOmBpbl9zb2Z0aXJxKClgIOWuj++8iCBgYGluY2x1ZGUvbGludXgvcHJlZW1w
dC5oYGAg77yJ5p2l56Gu6K6kDQo+ICDmmK/lkKblpITkuo7ova/kuK3mlq3vvIjmiJblrZDku7vl
iqHvvInkuK3jgIINCj4gQEAgLTI0Nyw3ICsyNDYsNyBAQCBQcm92aWRlIG1lY2hhbmlzbSBub3Qg
cG9saWN54oCd44CCDQo+ICAgICAg5LiOIDpjOmZ1bmM6YHB1dF91c2VyKClgIOWSjCA6YzpmdW5j
OmBnZXRfdXNlcigpYCDkuI3lkIzvvIzlroPku6zov5Tlm57mnKrlpI3liLbnmoQNCj4gICAgICDm
lbDmja7ph4/vvIjljbMw5LuN54S25oSP5ZGz552A5oiQ5Yqf77yJ44CCDQo+DQo+IC3jgJDmmK/n
moTvvIzov5nkuKrmhJrooKLnmoTmjqXlj6PnnJ/lv4PorqnmiJHlsLTlsKzjgILngavniIbnmoTl
j6PmsLTku5flpKfmpoLmr4/lubTpg73kvJrlj5HnlJ/jgIINCj4gK+OAkOaYr+eahO+8jOi/meS4
quiuqOWOjOeahOaOpeWPo+ecn+W/g+iuqeaIkeWwtOWwrOOAgueBq+eIhueahOWPo+awtOS7l+Wk
p+amguavj+W5tOmDveS8muWPkeeUn+OAgg0KPiAg4oCU4oCUIFJ1c3R5IFJ1c3NlbGzjgJENCj4N
Cj4gIOi/meS6m+WHveaVsOWPr+S7pemakOW8j+edoeecoOOAguWug+S4jeW6lOivpeWcqOeUqOaI
t+S4iuS4i+aWh+S5i+Wkluiwg+eUqO+8iOayoeacieaEj+S5ie+8ieOAgeiwg+eUqOaXtuemgeeU
qOS4reaWrQ0KPiBAQCAtNTM4LDkgKzUzNyw5IEBAIERvY3VtZW50YXRpb24vY29yZS1hcGkvc3lt
Ym9sLW5hbWVzcGFjZXMucnN0IOOAgg0KPg0KPiAgTGludXPlkozlhbbku5blvIDlj5HkurrlkZjm
nInml7bkvJrmm7TmlLnlvIDlj5HlhoXmoLjkuK3nmoTlh73mlbDmiJbnu5PmnoTkvZPlkI3np7Dv
vJvov5nmoLflgZrkuI3ku4XmmK/kuLrkuoYNCj4gIOiuqeavj+S4quS6uumDveS/neaMgeitpuaD
le+8jOi/mOWPjeaYoOS6huS4gOS4qumHjeWkp+eahOabtOaUue+8iOS+i+Wmgu+8jOS4jeiDveWG
jeWcqOaJk+W8gOS4reaWreeahOaDheWGteS4iw0KPiAt6LCD55So77yM5oiW6ICF5omn6KGM6aKd
5aSW55qE5qOA5p+l77yM5oiW6ICF5LiN5omn6KGM5Lul5YmN5o2V6I6355qE5qOA5p+l77yJ44CC
6YCa5bi46L+Z5Lya6ZmE5bim5LiA5LiqbGludXgNCj4gLeWGheaguOmCruS7tuWIl+ihqOS4reeb
uOW9k+WFqOmdoueahOazqOmHiu+8m+ivt+aQnOe0ouWtmOaho+S7peafpeeci+OAgueugOWNleWc
sOWvueaWh+S7tui/m+ihjOWFqOWxgOabv+aNoumAmuW4uA0KPiAt5Lya6K6p5LqL5oOF5Y+Y5b6X
ICoq5pu057OfKiog44CCDQo+ICvosIPnlKjvvIzmiJbogIXmiafooYzpop3lpJbnmoTmo4Dmn6Xv
vIzmiJbogIXkuI3miafooYzku6XliY3mjZXojrfnmoTmo4Dmn6XvvInjgILpgJrluLjov5nkvJrp
mYTluKblj5HpgIHkuIDkuKoNCj4gK+ebuOW9k+WFqOmdoueahOazqOmHiuWIsOebuOW6lOeahOWG
heaguOmCruS7tuWIl+ihqOS4re+8m+ivt+aQnOe0ouWtmOaho+S7peafpeeci+OAgueugOWNleWc
sOWvueaWh+S7tui/m+ihjOWFqOWxgA0KPiAr5pu/5o2i6YCa5bi45Y+q5Lya6K6p5LqL5oOF5Y+Y
5b6XICoq5pu057OfKiog44CCDQo+DQo+ICDliJ3lp4vljJbnu5PmnoTkvZPmiJDlkZgNCj4gIC0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiBAQCAtNjEwLDcgKzYwOSw3IEBAIEMrKw0KPg0KPiAg5Li65LqG
6K6p5L2g55qE5Lic6KW/5pu05q2j5byP44CB6KGl5LiB5pu05pW05rSB77yM6L+Y5pyJ5LiA5Lqb
5bel5L2c6KaB5YGa77yaDQo+DQo+IC0tICDmkJ7muIXmpZrkvaDlnKjosIHnmoTlnLDnlYzlhL/k
uIrlubLmtLvjgILmn6XnnIvmupDmlofku7bnmoTpobbpg6jjgIEgYGBNQUlOVEFJTkVSU2BgIOaW
h+S7tuS7peWPig0KPiArLSAg5pCe5riF5qWa5L2g5L+u5pS555qE5Luj56CB5bGe5LqO6LCB44CC
5p+l55yL5rqQ5paH5Lu255qE5qC555uu5b2V44CBIGBgTUFJTlRBSU5FUlNgYCDmlofku7bku6Xl
j4oNCj4gICAgIGBgQ1JFRElUU2BgIOaWh+S7tueahOacgOWQjuS4gOmDqOWIhuOAguS9oOW6lOiv
peWSjOatpOS6uuWNj+iwg++8jOehruS/neS9oOayoeaciemHjeaWsOWPkeaYjui9ruWtkO+8jA0K
PiAgICAg5oiW6ICF5bCd6K+V5LiA5Lqb5bey57uP6KKr5ouS57ud55qE5Lic6KW/44CCDQo+DQo+
IEBAIC02MjksOSArNjI4LDEwIEBAIEMrKw0KPiAgICAg4oCcb2JqLSQoQ09ORklHX3h4eCkgKz0g
eHh4Lm/igJ3jgILor63ms5XorrDlvZXlnKgNCj4gICAgIERvY3VtZW50YXRpb24va2J1aWxkL21h
a2VmaWxlcy5yc3Qg44CCDQo+DQo+IC0tICDlpoLmnpzkvaDlgZrkuobkuIDkupvmnInmhI/kuYnn
moTkuovmg4XvvIzpgqPlj6/ku6Xmioroh6rlt7HmlL7ov5sgYGBDUkVESVRTYGAg77yM6YCa5bi4
5LiN5q2i5LiA5LiqDQo+IC0gICDmlofku7bvvIjml6DorrrlpoLkvZXkvaDnmoTlkI3lrZfpg73l
upTor6XlnKjmupDmlofku7bnmoTpobbpg6jvvInjgILnu7TmiqTkurrlkZjmhI/lkbPnnYDmgqjl
uIzmnJvlnKjlr7kNCj4gLSAgIOWtkOezu+e7n+i/m+ihjOabtOaUueaXtuW+l+WIsOivoumXru+8
jOW5tuS6huino+e8uumZt++8m+i/meaEj+WRs+edgOWvueafkOmDqOWIhuS7o+eggeWBmuWHuuab
tOWkmuaJv+ivuuOAgg0KPiArLSAg5aaC5p6c5L2g6K6k5Li66Ieq5bex5YGa5LqG5LiA5Lqb5pyJ
5oSP5LmJ55qE5LqL5oOF77yM5Y+v5Lul5oqK6Ieq5bex5pS+6L+bIGBgQ1JFRElUU2BgIO+8jOmA
muW4uOS4jQ0KPiArICAg5q2i5LiA5Liq5paH5Lu277yI5peg6K665aaC5L2V5L2g55qE5ZCN5a2X
6YO95bqU6K+l5Zyo5rqQ5paH5Lu255qE6aG26YOo77yJ44CCICBgYE1BSU5UQUlORVJTYGANCj4g
KyAgIOaEj+WRs+edgOaCqOW4jOacm+WcqOWvueWtkOezu+e7n+i/m+ihjOabtOaUueaXtuW+l+WI
sOivoumXru+8jOW5tuS6huino+e8uumZt++8m+i/meaEj+WRs+edgOWvueafkOmDqOWIhg0KPiAr
ICAg5Luj56CB5YGa5Ye65pu05aSa5om/6K+644CCDQo+DQo+ICAtICDmnIDlkI7vvIzliKvlv5jo
rrDljrvpmIXor7sgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Qg
77yMDQo+ICAgICDkuZ/orrjov5jmnIkgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmct
ZHJpdmVycy5yc3Qg44CCDQo+IC0tDQo+IDIuMzAuMg0KPg0K
