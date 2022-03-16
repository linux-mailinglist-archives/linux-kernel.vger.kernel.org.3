Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F074DAD18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354697AbiCPJCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbiCPJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:02:49 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0516A65169
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:01:33 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220316090130epoutp03a6fdb257cd9fc7445b7a02734b5e358f~c0O_HnnqX2183921839epoutp03x
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:01:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220316090130epoutp03a6fdb257cd9fc7445b7a02734b5e358f~c0O_HnnqX2183921839epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647421290;
        bh=vKa+InXtFk9RtGasOYJjM/SZT2fiu8V+ixm4StA/cHA=;
        h=Date:Subject:Reply-To:From:To:CC:In-Reply-To:References:From;
        b=qBQ9g40H/wGc/BCW6PSSfCSylRxDHDfsGPwGrLtk9z/UzvtvAZfXFAglxSTUAogNd
         CXZ+n65pW8HF1t9N6A6Hy9S2vvnmIkeej5ddzCGbVeaaf+4FbA+EYj4wyTEsZYD8tC
         tQsA37i6GEpzErAURhsfMhRQnXhDMsKhQXLmNCRw=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220316090130epcas5p4d91b92015479d685f5d323e8febf3942~c0O9ZWEAJ0295602956epcas5p4z;
        Wed, 16 Mar 2022 09:01:30 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-46-6231a769ae14
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.88.05590.967A1326; Wed, 16 Mar 2022 18:01:30 +0900 (KST)
Date:   Wed, 16 Mar 2022 14:31:21 +0530
Message-ID: <385836468.3982590.1647421281746@mail-kr5-2>
Mime-Version: 1.0
Subject: RE: [PATCH v3] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
CC:     "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>,
        "atomlin@redhat.com" <atomlin@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YjGe961XL8GW7Qeh@bombadil.infradead.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20220316090121epcms5p1f24091165187c825e039c426dcd65c24
Content-Type: multipart/mixed;
        boundary="----=_Part_3982589_2041055906.1647421281746"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjH856enh7ISk5LJ6/IRRpZqEzAMPWwLc7ELTtuycKSTZSYaBlH
        RKDFloKbXwrC2oGVy7x0FVok3FYIZZVKLXKxiE7GTKviAMuGVVY2U0ARGeLGWtpm+/Lm9/yf
        +5MXZ3C1WDieLSqgJSJhLh8LRi8PCgRbjrZszUiqbwRkraEdI1Ul5xHyuq6dSU5d+4VFOmpc
        LPKupRYj5ReWmOQjjRYjx6qmAfltfweL/F7XAsjVR4tMsk85hZA9PzRg5E3HNEJab9UBsnjh
        N7CLQ12Q21Fqcfw2Ql3RTLKo0r4Jz3PdzaSM+m8w6kf1Ckppb31K2cpzqLm+UYw63aUHlKFr
        FKUu/XSCWjBGpYakB7+bSedmF9KSxJ2Hgo/UaDLypzcet7s7UDlwRJWDIBwSb0G73s4sB8E4
        l+gBsKl/iOF1oEQsXB1WsrzMJkh4+fGSJwj3MAf+bQ71yqFEGrzWfxv1MpeIgTZ1O/CGhBJJ
        8KUpzitjRALUW66i3vI84hyAF//sZXgNBuFiwrm6r1m+IdhQrZhGfbwBdreYgJeDiO2wsnSS
        6dNfh+NtblaA527ogI95sOzXnxk+5sCp5R6/HgHbLqnWOkOiAkDDbK/fUAN4ynnOn7EDGhr1
        /qrvw9HZmTWd4VntgXsQ8+mR8OxwB+LTQ6Bq5TESmNqsDXAsLB3vZAY2WHj61L8NBU/ecfrP
        W43A3upuVhWI1vx3Sc3/2vk4HjZffMLwhjAIATRYEn3yG/BM5XN/yHYoV5xFfRwDz1Q8ZNUD
        lh6sp/OleVm0dFt+soguSpAK86QyUVbCF+I8I1j7tps/NgPn1HyCFSA4sIJNnnRnZ5sNhKMi
        sYjm89gjM4kZXHam8MuvaIn4oESWS0utYAOO8sPYw1mdQi6RJSygc2g6n5YEvAgeFC5HdLmN
        SN26P+obZnNcnxEO1/7XftfPDzj/6ruzN+x4SavySkqnaILdfK/1xFxj9calD2beOYqpd8vT
        8RdNkmdDluaXRbsdorHTYUnr4pej8fZCnt19qMp288355Kgc8oZLQX3+yfoDuojI/Ttq73ff
        W97nTD42lhpmmbn/YlD1bHX2OedA6OG2+MqGgU2HremxRQLjP2kOk7iA5gzsvTtStxAzsGWE
        fjtuIttkEbdG2lJXdu3MnC98KNyn4h8rcm8z8dKUS9EPRhuGQpomzUZZyqlBhnLxPUWNrPiV
        WYaLSmJPVnSJypCPyhQR+j3ffaiJq++ucadf1RbvsQteHUx5EsRHpUeEWzczJFLhvxoiN/Ux
        BAAA
X-CMS-RootMailID: 20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c
References: <YjGe961XL8GW7Qeh@bombadil.infradead.org>
        <20220315155100.516107-1-maninder1.s@samsung.com>
        <YjDScHjMUbqYV4s4@bombadil.infradead.org>
        <62c74547-deb0-539a-c1cc-64b2ac334c94@csgroup.eu>
        <CGME20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c@epcms5p1>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3982589_2041055906.1647421281746
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

> Yes sorry about that, modules-testing is what had Aaron's code. And
> Aaron noted that from his series 13/14 and 14/14 from his series
> had their Message-Id modified accidently via git-send-email. Given
> *current events* and since I use b4 am to verify KSIM signatures
> I asked Aaron to wait and post a v12 to aggregate further reviews
> and acked-by's. The reason being that if his v11 series has issues
> I rather start from a very clean patchset.
> =20
> Yes I am paranoid :)
> =20
> Anyway so Aaron, let's give it a few more days, and please then post a
> v12 collecing all new tags, then I'll apply your changes and then try to
> apply Christophe's.
> =20
> There was some work by Michal Such=C3=A1nek=20which=20would=20go=20after,=
=20but=0D=0A>=20its=20unclear=20if=20that's=20yet=20vetted=20by=20their=20o=
ther=20respective=20maintainers.=0D=0A>=20Michal?=0D=0A>=20=20=0D=0A>=20Any=
way,=20your=20stuff=20is=20at=20the=20end=20of=20the=20train=20after=20Mich=
al's=20if=20that=0D=0A>=20stuff=20is=20really=20ready.=20So=20please=20don'=
t=20be=20surprised=20if=20you=20later=20have=0D=0A>=20to=20rebase=20once=20=
again,=20or=20two=20or=203=20times=20more.=20Thanks=20for=20your=20patience=
.=0D=0A=20=0D=0ANo=20Worries=20:)=0D=0A=0D=0ALet=20me=20know=20when=20it=20=
has=20to=20be=20done.=0D=0AWe=20will=20prepare=20and=20verify=20on=20new=20=
rebase.=0D=0A=0D=0AThanks,=0D=0AManinder=20Singh
------=_Part_3982589_2041055906.1647421281746
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBSZTogW1BBVENIIHYzXSBr
YWxsc3ltczogZW5oYW5jZSAlcFMvcy9iIHByaW50aW5nIHdoZW4gS0FMTFNZU01TIGlzIGRpc2Fi
bGVkDQogICAgICBGcm9tICAgICAgIDogbnVsbA0KICAgICAgU2VudCBEYXRlICA6IDIwMjItMDMt
MTYgMTM6NTUgIEdNVCs1OjMwDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgICAgICAgICAgICAg
IE5hbWUgICAgICAgICAgICAgICAgVHlwZSAgICAgICAgICBKb2IgVGl0bGUgICAgICAgICAgICAg
ICAgICAgICAgIERlcHQuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENvbXBhbnkgICAg
ICAgICAgICAgICAgDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIGNocmlzdG9waGUubGVyb3lA
Y3Nncm91cC5ldSAgICBUTw0KICAgICAgbXN1Y2hhbmVrQHN1c2UuZGUgICAgICAgICAgICAgIFRP
DQogICAgICBNYW5pbmRlciBTaW5naCAgICAgICAgICAgICAgICAgQ0MgICAgICAgICBTdGFmZiBF
bmdpbmVlciAgICAgICAgICAgICBTeXN0ZW0gUy9XIEdyb3VwIC9TUkktRGVsaGkgICAgICAgICAg
ICAgICBTYW1zdW5nwqBFbGVjdHJvbmljc8KgDQogICAgICBwbWxhZGVrQHN1c2UuY29tICAgICAg
ICAgICAgICAgQ0MNCiAgICAgIHJvc3RlZHRAZ29vZG1pcy5vcmcgICAgICAgICAgICBDQw0KICAg
ICAgc2Vub3poYXRza3lAY2hyb21pdW0ub3JnICAgICAgIENDDQogICAgICBhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pLi4uICAgQ0MNCiAgICAgIGxpbnV4QHJhc211c3ZpbGxlbW9lcy5kayAgICAg
ICBDQw0KICAgICAgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZyAgICAgIENDDQogICAgICB3YW5n
a2VmZW5nLndhbmdAaHVhd2VpLmNvbSAgICAgQ0MNCiAgICAgIFZhbmVldCBOYXJhbmcgICAgICAg
ICAgICAgICAgICBDQyAgICAgICAgIEFzc29jaWF0ZSBBcmNoaXRlY3QgICAgICAgIFN5c3RlbSBT
L1cgR3JvdXAgL1NSSS1EZWxoaSAgICAgICAgICAgICAgIFNhbXN1bmcgRWxlY3Ryb25pY3MNCiAg
ICAgIHN3Ym95ZEBjaHJvbWl1bS5vcmcgICAgICAgICAgICBDQw0KICAgICAgb2plZGFAa2VybmVs
Lm9yZyAgICAgICAgICAgICAgIENDDQogICAgICBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
ICAgQ0MNCiAgICAgIGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwuLi4gICBDQw0KICAgICAgYXZp
bWFsaW5AZ21haWwuY29tICAgICAgICAgICAgIENDDQogICAgICBhdG9tbGluQHJlZGhhdC5jb20g
ICAgICAgICAgICAgQ0MNCiAgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K

------=_Part_3982589_2041055906.1647421281746--
