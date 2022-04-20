Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5C50862F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377769AbiDTKn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377765AbiDTKnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:43:53 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0558A3FD8E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:41:08 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-2ec04a2ebadso13018027b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YK8d4EMuEODqdmfPJIFq9OHVJcoCq6qOs0w9Koxiy5U=;
        b=iVsf/xS3UZ/ZcBCtBrBc+9WNXlpC+kgiEsfvY6+rTDIz5sbjzatQP+6gWz3Xj2lTxb
         y2uK4H7Yq0PJNrXKYwz4nqZM5B3ogRTEYEiYQapeyeP2oifaIC7Ehwh4hLDQRxnTQeDJ
         QZWtN3ErKdnlps0tTkvdt0J8BkQTT8g3MfIuy4bCual3y4/Q9xIvuYmyzGkCjVNr09D2
         Z4YUGUzDPD16Sc3xFBbSQJirgtyr8x3a48WTF1lif4L+SnY6CnjqmjX6FL9tFZhqNb7Q
         71nDGe81SGOMx/ei8WaVzIod/sE1HFEdsFyRTRfADIpX08xjI0U94ub6LhsLZjV6Hwz+
         0RNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=YK8d4EMuEODqdmfPJIFq9OHVJcoCq6qOs0w9Koxiy5U=;
        b=brVh62Gs/NN6K7z4gDpS/fgBLXR0oETddn4PqIi5eNke4udpkq+gV3B48gtSGBpIU6
         Q3hJQv4CuRJev/uG7H0AzJoo+3WfHF+72ld6Mec+mQJ7uhmN6E9yVORBa7QPMiJN7UCa
         0mFMf095k/Xhwkr3HVqIhPF8dCsDeYWk23jH9ifwVdGeixcdZGa55fNNZ+40KbvZ+Zuo
         ZlUAMophDK7y065GZgGY1JBbpcWqVfUivVaJNG7bRfdtoGvKNoYxri4QIjtISHZx38Z7
         zNbFAHYA3t2VJWcep5Ax+rmcoZegrfOYifW1crVn8eFVfSHgJU9RfVzqisNbIBw4UBr5
         Pp9Q==
X-Gm-Message-State: AOAM531nGXuWjIhNk0rzdm/OKgV2eFEBe2uUK0tQTODbZKrBp2s/njf9
        ZtXFvcTBMA9uG18O15yJV/Rbds5RXrFjyDeCg3U=
X-Google-Smtp-Source: ABdhPJzwcjuJSbEaUb5l3GRMJl3Ll+Ocnt4VPnNh6TEE4BeVg79znpY+2GYGDmiKJI7ezvpeyEXon7VPlgkVXJWvFpA=
X-Received: by 2002:a81:a188:0:b0:2ec:4293:6c84 with SMTP id
 y130-20020a81a188000000b002ec42936c84mr20034441ywg.342.1650451267037; Wed, 20
 Apr 2022 03:41:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5411:b0:24c:9ef1:c018 with HTTP; Wed, 20 Apr 2022
 03:41:06 -0700 (PDT)
Reply-To: tonyelumelu5501@gmail.com
From:   POST OFFICE <togounionlomewesternoffice@gmail.com>
Date:   Wed, 20 Apr 2022 12:41:06 +0200
Message-ID: <CABY4=WDFRu6Rx=eFoHCZbV2d_SzMbWCKG70MYGpFwFBu5-+O_w@mail.gmail.com>
Subject: =?UTF-8?Q?Spo=C5=A1tovani_lastnik_e=2Dpo=C5=A1te?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1144 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [togounionlomewesternoffice[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [tonyelumelu5501[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DOBRODO=C5=A0LI NA URADNI E-PO=C5=A0TI I.M.F. GOSPA DIREKTOR. KRISTALINA
GEORGIEVA. NA=C5=A0E PORO=C4=8CILO: OD=C5=A0KODNINSKI SKLAD UBT (UNION BANK=
 OF
TOGOLESE) 1.200.000,00 USD.

Lep pozdrav dragi lastnik e-po=C5=A1te!

Sem gospa Kristalina Georgieva, direktorica in predsednica (IMF)
Akodessewa-Togo. Obve=C5=A1=C4=8Damo vas, da je Mednarodni denarni sklad (I=
MF) v
Washingtonu, DC, ZDA obiskal na=C5=A1o dr=C5=BEavo, da bi preu=C4=8Dil prei=
skavo
spletnih goljufij; To informacijo ste prejeli danes, ker je bil va=C5=A1
elektronski naslov najden na seznamu =C5=BErtev goljufij v tej dr=C5=BEavi =
in
=E2=80=8B=E2=80=8BAfriki.

Dodatne informacije (IMF), Washington, DC. od=C5=A1kodnino vsem dr=C5=BEava=
m, ki
so bile goljufi v na=C5=A1i dr=C5=BEavi, in va=C5=A1 elektronski naslov je =
bil najden
na teh seznamih =C5=BErtev. Torej! Na=C5=A1a banka je (IMF) zaupala sprosti=
tev
va=C5=A1ega od=C5=A1kodninskega sklada po metodi ATM CARD.

Opazili smo, da nekateri zlobne=C5=BEi/sleparji uporabljajo ime te banke za
la=C5=BEno predstavljanje, da bi izsilili denar in tudi preusmerili
sredstva na=C5=A1ih strank. V tem primeru vam svetujemo, da ne upo=C5=A1tev=
ate
kakr=C5=A1ne koli komunikacije po e-po=C5=A1ti/telefonu s komer
koli/organizacijo, ki trdi, da biti v lasti svojega sklada.

Va=C5=A1o vlogo za terjatev va=C5=A1ega sklada bomo ustrezno obdelali, pora=
vnave
pa bodo izvedene po potrditvi in =E2=80=8B=E2=80=8Bustrezno preverjanju va=
=C5=A1ih
podatkov, saj imamo v lasti pla=C4=8Dilne instrumente v vi=C5=A1ini 1.200.0=
00,00
$ za vas. Trenutno ne moremo storiti ni=C4=8Desar oprijemljivega, ne da bi
od vas prejeli nekaj potrebnih informacij, kot je dolo=C4=8Deno v na=C5=A1i=
h
ban=C4=8Dnih protokolih poslovanja, zato vam =C5=BEelimo, da pozorno preber=
ete
in izpolnite ustrezne informacije v spodnjih prostorih, da olaj=C5=A1ate
takoj=C5=A1nje ustrezno obdelavo va=C5=A1ih zahtevkov.

SPODNJI OBRAZEC MORA IZPOLNITI PREJEMNIK NAVEDENIH SREDSTEV ZA PREVERJANJE.

TVOJE POLNO IME: ...................................
VA=C5=A0A DR=C5=BDAVA IZVORA: =E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6
VA=C5=A0 MESTNI NASLOV: =E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=
=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6
VA=C5=A0A PO=C5=A0TNA =C5=A0TEVA: ...................
NEOBVEZNI E-po=C5=A1tni NASLOV: ..............
DATUM IN KRAJ ROJSTVA: ...................
TEL. =C5=A0T.: ..................... =C5=A0T. FAKSA: ...................
POKLIC: ................................................
VA=C5=A0A LETNA ALI POTNI LIST N0: ........................

Vendar smo se odlo=C4=8Dili, da vam ta sklad izdamo v vi=C5=A1ini 1.200.000=
,00 $
(milijon dvesto tiso=C4=8D ameri=C5=A1kih dolarjev) z uporabo kartice Visa =
na
bankomatu. Tega pla=C4=8Dila ne bomo mogli izvesti samo z va=C5=A1im e-po=
=C5=A1tnim
naslovom.

Prosimo, da se takoj obrnete na UNITED BANK FOR AFRICA, ker je va=C5=A1
sklad zdaj odobren, se obrnite na izvr=C5=A1nega direktorja UNITED BANK FOR
AFRICA, katerega ime je g. Tony Elumelu. Elektronski naslov:
(tonyelumelu5501@gmail.com)
Telefonska =C5=A1tevilka / WhatsApp: +228 91889773

Kontaktirajte ga zdaj in prejmite svoj skupni sklad v vi=C5=A1ini
1.200.000,00 USD. Preden bo pozno!!.

Odpiralni =C4=8Das od ponedeljka do petka: 07:45 do 17:00 sobota 9:00 - 13:=
00.

Z lepimi pozdravi

GOSPA KRISTALINA GEORGIEVA
(IMF) PREDSEDNIK.
