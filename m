Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A86470509
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhLJQBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhLJQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:01:50 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA618C061746;
        Fri, 10 Dec 2021 07:58:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e3so32031290edu.4;
        Fri, 10 Dec 2021 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/YB5lvZuq9sVqrD8nsVmKmkoxaMlGZ8UQBbomagpHwM=;
        b=UMNtayrX2T8/J1mAZ+1zRRvCUIxZeabQLC9nc2qdMAmj04toju8KtKLWnjbUZKuHDK
         U8GUQF6cHitnMXWDMU7n1s87mWIwXJCe9X9jpVPqhXMXY5cJcwdMI2uFipwT9dvUqdFC
         lo0kzx1GGoXx7WjwIdB30YuU6QtCuLHBnuCR2JEE5Zrk4yBJvghfPffKIe3i1NfkuKvI
         /eSxQDbYxdZ+Touoi/kSGvp94z9ecNEYg16Dqupz9tp45ZhmMnIH3mcz3b8rauqzO1FJ
         w1m7vSczJAyYoyeZaWvYTPCWApfpThRHV+C1lzx3pMeeH6Nx7ZYksHw377cY3Jqj8qMB
         AMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/YB5lvZuq9sVqrD8nsVmKmkoxaMlGZ8UQBbomagpHwM=;
        b=FmXaebxryFcQEzbDCFue/9F/tbAOq95MUpUuAeqmXXnDW/wrilqumnl9AUwqRtgJZz
         0//c9b01QibKiPMWkXgl5PAPn6/A/72YpvbjqXwlEHVimuZpamaQjm2YLJy7c9dPsEog
         UzhD4jN67VjFD2pDoGwChs8XiS2kUugfsE7H22YBEfayQipUFOW2+HBqclZY9d+qDXVt
         Nb8pJGpN0M7wHawnHpCnOiOM5pPtSHH2JmRffbXseDqYjIrQkkm10KeWS2psAeJH2QN/
         X6CodQFwEU/sI9xtcoFfN/dwn+NcBTZK5xyQ6S51d3V2bUKQZkH6b3I0bJIxO28HC/qx
         iEBA==
X-Gm-Message-State: AOAM530G0yLm5/mtCoWl/bN5RPSCa6gNzKCa9+eLGXLr3JsN44TlkPAp
        cOiRn+88/hsiMzbUkXmfX5gf2QiZUcyUUm1JBoPpgwZ7LflW4sXP
X-Google-Smtp-Source: ABdhPJxt/WPd77YNjDCLL1W1pqp2C0GZsFWVIG3auGsdw6BQ74O08SHsEOzZLQCdUYcF8LutpULLp9JlrfcxbIJg0S4=
X-Received: by 2002:a17:906:5501:: with SMTP id r1mr24960938ejp.212.1639151894192;
 Fri, 10 Dec 2021 07:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20211209095528.68875-1-alexs@kernel.org>
In-Reply-To: <20211209095528.68875-1-alexs@kernel.org>
From:   Yeechou Tang <tangyeechou@gmail.com>
Date:   Fri, 10 Dec 2021 23:58:03 +0800
Message-ID: <CAOB9oOaB+ZbzMKNVYGkCYHtsrA6yB-sxvn9o_s6DynO5UZ=_RA@mail.gmail.com>
Subject: Re: [PATCH] doc/zh_CN: add Chinese document coding style reminder
To:     Alex Shi <alexs@kernel.org>
Cc:     Yanteng Si <siyanteng01@gmail.com>,
        Tang Yizhou <tangyizhou@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PGFsZXhzQGtlcm5lbC5vcmc+IOS6jjIwMjHlubQxMuaciDnml6Xlkajlm5sgMjA6MzPlhpnpgZPv
vJoNCj4NCj4gRnJvbTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+DQo+IFRoZSBjb2Rp
bmcgc3R5bGUgcmVxdWlyZW1lbnQgZm9yIENoaW5lc2UgZG9jdW1lbnQgaXMgZWFzeSB0byBiZSBv
dmVybG9va2VkLg0KPiBBZGQgdGhlIHJlcXVlc3QgYXMgYSByZW1kaW5lci4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+IENjOiBZYW50ZW5nIFNpIDxz
aXlhbnRlbmcwMUBnbWFpbC5jb20+DQo+IENjOiBUYW5nIFlpemhvdSA8dGFuZ3lpemhvdUBodWF3
ZWkuY29tPg0KPiBDYzogSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCj4gQ2M6IGxp
bnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3Qg
fCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3QgYi9Eb2N1
bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3QNCj4gaW5kZXggYTM0ZTU4NzMz
YWM4Li5iMDFjMDQyMjdkOGEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL3poX0NOL2luZGV4LnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96
aF9DTi9pbmRleC5yc3QNCj4gQEAgLTIzLDYgKzIzLDExIEBADQo+ICDlj6blpJbvvIzpmo/ml7bm
rKLov47mgqjlr7nlhoXmoLjmlofmoaPov5vooYzmlLnov5vvvJvlpoLmnpzmgqjmg7Pmj5Dkvpvl
uK7liqnvvIzor7fliqDlhaV2Z2VyLmtlcm5lbC5vcmcNCj4gIOS4iueahGxpbnV4LWRvY+mCruS7
tuWIl+ihqOOAgg0KPg0KPiAr6aG65L6/6K+05LiL77yM5Lit5paH5paH5qGj5Lmf6ZyA6KaB6YG1
5a6I5YaF5qC457yW56CB6aOO5qC877yM6aOO5qC85Lit5Lit5paH5ZKM6Iux5paH55qE5Li76KaB
5LiN5ZCM5bCx5piv5Lit5paHDQo+ICvnmoTlrZfnrKbmoIfngrnljaDnlKjkuKTkuKroi7Hmlofl
rZfnrKblrr3luqbvvIwg5omA5Lul77yM5b2T6Iux5paH6KaB5rGC5LiN6KaB6LaF6L+H5q+P6KGM
MTAw5Liq5a2X56ym5pe277yMDQo+ICvkuK3mloflsLHkuI3opoHotoXov4c1MOS4quWtl+espuOA
guWPpuWklu+8jOS5n+imgeazqOaEjyctJ++8jCc9JyDnrYnnrKblj7fkuI7nm7jlhbPmoIfpopjn
moTlr7npvZDjgILlnKjlsIYNCj4gK+ihpeS4geaPkOS6pOWIsOekvuWMuuS5i+WJje+8jOS4gOWu
muimgei/m+ihjOW/heimgeeahGNoZWNrcGF0Y2gucGzmo4Dmn6XlkoznvJbor5HmtYvor5XjgIIN
Cj4gKw0KDQrlj6/og73pnIDopoHnu4bljJbkuIDkuIvvvJoNCuW9k+WHuueOsOS4reiLseaWh+a3
t+aOkuaXtu+8jOaIkeS7rOS7peWvuem9kOS8mOWFiO+8jOatpOaXtuaWh+acrOe8lui+keWZqOaY
vuekuueahOWIl+aVsOS7heS+m+WPguiAg++8jOWboOS4uuWcqOe8lui+keWZqA0K55yL5p2l77yM
MeS4quiLseaWh+Wtl+espuaIluiAhTHkuKrmsYnlrZfvvIzpg73nrpcx5YiX44CC5oiR5Lus56Gu
5L+d5a6e6ZmF5YiX5a695rKh5pyJ6LaF6L+H5rGJ5a2X55qENTDkuKrlrZfnrKbljbPlj6/jgIIN
Cg0KVGhhbmtzLA0KVGFuZw0KDQo+DQo+ICDorrjlj6/or4HmlofmoaMNCj4gIC0tLS0tLS0tLS0N
Cj4NCj4gLS0NCj4gMi4yNS4xDQo+DQo=
