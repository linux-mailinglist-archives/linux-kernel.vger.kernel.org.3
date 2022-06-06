Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EAA53E668
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiFFKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiFFKU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:20:28 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F51760EB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:20:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id q14so13281538vsr.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CrA4YBm/C0o/d7+8DPi9KXWYpOuSBuqwF7Z6o0fXbnA=;
        b=IPAyvlkDNeODQC1CMhAZeQwaxudOWV93r9AQBEvBvz3FnaErE1m6NNowI3oHnI/aAD
         HPpM4iNd8xfcR2rfj3oVi01r+5Sa8bU2KZeOfYUcgWvms9ZY/tqmI18F8LoLP7N2NWRr
         i13rtuY47qz/V5FIZ/zp3vRbhj3IWOeGv5cMUDGgFju1eI3J0+P7/Lp1Fye8SwL2jTj4
         ksrYutpv0Q231TyhaEqDzEdaK64Kq05r4Fb+Rh3SHqJ8NKzQJAZXr5AD4M2OwtarXC86
         QHLJNcyYVzHt09R+TXkjptEH2PEOjS8OuJWv5yeEogtA6RPaoPnwctvEYazTHAulWTvx
         Hgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=CrA4YBm/C0o/d7+8DPi9KXWYpOuSBuqwF7Z6o0fXbnA=;
        b=CiChsFXp44mgG5/NkejuQZrmTOJCNAHqKenfk+3ItelYU4s95ElxhdySR2GP+rGcgz
         1yDHUonbB7PgqtvVZiGgM9gAiDjkDOqP4OCPQhIXbe2CetCXI5t3C4pnD1GsRG673/gO
         YLiz5HdfTG+2bOXZGFU96dDyuj4FwgwKxFB7qnwREUIeUBFvzM8/9gMfeAKO4IQxKFh+
         4Rdsk/faqNb7NPANCIDMhEkLCt1iwJCYJb5lj3SxQtuOa+pwfVylRrEvVei6+7LP9M9G
         ULA0ClwbH8tDHBFKKgRgSzVi1OEOCFt+r8cAn80NcKdCAM9PyhtOPPUmTgui+3+9vxXn
         JsuQ==
X-Gm-Message-State: AOAM533demeAzPpQ0Zgmp9fZyypCgnTLPtrYivE4cG4gxlqksKukgMT1
        7t2a3Nf5kY3vPVQG9eCOXOZlAFBvbl0NpYhB34A=
X-Google-Smtp-Source: ABdhPJyxbKLcTqZpv9jc4BDD9lwLT1HQue1JJnDM5Drgco0I1kc0QCpkl4iV6W/1NMt9AMHzoXlTvczN2pwykzsX7H0=
X-Received: by 2002:a05:6102:208:b0:34b:b645:a5c2 with SMTP id
 z8-20020a056102020800b0034bb645a5c2mr1706553vsp.9.1654510826357; Mon, 06 Jun
 2022 03:20:26 -0700 (PDT)
MIME-Version: 1.0
Sender: agaddafi752@gmail.com
Received: by 2002:a05:6102:827:0:0:0:0 with HTTP; Mon, 6 Jun 2022 03:20:25
 -0700 (PDT)
From:   agaddafi752 <madamisha00@gmail.com>
Date:   Mon, 6 Jun 2022 11:20:25 +0100
X-Google-Sender-Auth: dMN0HjL98Nrgz_NGTd3kJkpe_E0
Message-ID: <CABwDasOXiNhhf=A_xrnyUTWH+KEse+ziYZPftaG4KjcoQHbOHw@mail.gmail.com>
Subject: =?UTF-8?B?15HXkden16nXlCDXkNeg15kg16bXqNeZ15og15DXqiDXoteW16jXqtea?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_50,
        BODY_EMAIL_419_FRAUD_GM,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15HXkden16nXlCDXkNeg15kg16bXqNeZ15og15DXqiDXoteW16jXqteaDQrXkNeg15kg16nXldec
15cg15zXmiDXkNeqINeR16jXm9eq15kg157XodeV15zXmNeg15XXqiDXoteV157XkNefLCDXkdei
15nXqCDXlNeR15nXqNeUINee15XXoden15guDQrXlNeQ150g15DXldeb15wg15zXlNep16rXntep
INeR157Xk9eZ15XXnSDXlNeW15Qg15vXk9eZINec16TXqteV15cg15DXmdeq15og16rXp9ep15XX
qNeqINeU15PXk9eZ16osINeV15zXl9ek16kg15DXqiDXp9eR15zXqteaDQrXnNeU16nXp9ei15Qg
15HXnteT15nXoNeUINep15zXmiDXkdeg15nXlNeV15zXmiDXm9ep15XXqtek15Qg16nXnNeZLCDX
qdee15kg16LXmdeZ16nXlCDXp9eT15DXpNeZINeV157XqteS15XXqNeo16og15vXmdeV150NCteR
16LXldee15DXnywg15DXoNeZINeQ15zXnteg15Qg15XXkNedINeX15Mg15TXldeo15nXqiDXoted
INep15zXldep15Qg15nXnNeT15nXnSAsINeR16rXlSDXlNeR15nXldec15XXkteZ16og15TXmdeX
15nXk9eUDQrXqdecINeg16nXmdeQINec15XXkSDXlNee16DXldeXICjXp9eV15zXldeg15wg15TX
nteg15XXlyDXnteV16LXnteoINen15PXkNek15kpINeV15vXqNeS16Ig15DXoNeZINeg157XpteQ
16og16rXl9eqINeU15LXoNeqDQrXnten15zXmCDXnteT15nXoNeZINei15wg15nXk9eZINee157X
qdec16og16LXldee16DXmS4NCteZ16kg15zXmSDXm9eh16TXmdedINeR16nXldeV15kgItei16nX
qNeZ150g15XXqdeR16Ig157Xmdec15nXldefINeV15fXntepINee15DXldeqINeQ15zXoyDXk9eV
15zXqCDXkNee16jXmden15DXmSINCi0kMjcuNTAwLjAwMC4wMCDXk9eV15zXqCDXkNee16jXmden
15DXmSDXqdeQ16DXmSDXqNeV16bXlCDXnNeU16TXp9eZ15Mg15HXmdeT15og16LXkdeV16gg16TX
qNeV15nXp9eYINeU16nXp9ei15QNCteR15DXqNem15ouINeQ150g15DXqteUINee15XXm9efINec
15jXpNecINeR16TXqNeV15nXp9eYINeW15Qg15HXqdee15ksINeQ16DXkCDXlNep15Eg15PXl9eV
16Mg15vXk9eZINec15DXpNep16gg15zXmQ0K15zXodek16cg15zXmiDXpNeo15jXmdedINeg15XX
odek15nXnSDXm9eT15kg15zXlNeq15fXmdecINeR16rXlNec15nXmiDXlNeU16LXkdeo15QuDQrX
kNeV15PXlCDXnNeq15LXldeR16rXmiDXlNeT15fXldek15Qg15HXkNee16bXoteV16og15vXqteV
15HXqiDXlNeT15XXkCLXnCDXqdec15kg15zXnteY15Q6IG1hZGFtZ2FkYWZpYWlzaGFAZ21haWwu
Y29tDQrXqteV15PXlA0K16nXnNeaINeR15DXnteqINei15nXmdep15QNCiwsLCwsLCwsLCwsLCws
LCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCws
LCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCws
LA0KUGxlYXNlIGkgbmVlZCB5b3VyIGhlbHANCkkgYW0gc2VuZGluZyBteSBncmVldGluZ3MgdG8g
eW91IGZyb20gdGhlIFN1bHRhbmF0ZSBvZiBPbWFuLCBJbiB0aGUNCmNhcGl0YWwgY2l0eSBvZiBN
dXNjYXQuDQpNYXkgaSB1c2UgdGhpcyBtZWRpdW0gdG8gb3BlbiBhIG11dHVhbCBjb21tdW5pY2F0
aW9uIHdpdGggeW91LCBhbmQNCnNlZWtpbmcgeW91ciBhY2NlcHRhbmNlIHRvd2FyZHMgaW52ZXN0
aW5nIGluIHlvdXIgY291bnRyeSB1bmRlciB5b3VyDQptYW5hZ2VtZW50IGFzIG15IHBhcnRuZXIs
IE15IG5hbWUgaXMgQWlzaGEgR2FkZGFmaSBhbmQgcHJlc2VudGx5DQpsaXZpbmcgaW4gT21hbiwg
aSBhbSBhIFdpZG93IGFuZCBzaW5nbGUgTW90aGVyIHdpdGggdGhyZWUgQ2hpbGRyZW4sDQp0aGUg
b25seSBiaW9sb2dpY2FsIERhdWdodGVyIG9mIGxhdGUgTGlieWFuIFByZXNpZGVudCAoTGF0ZSBD
b2xvbmVsDQpNdWFtbWFyIEdhZGRhZmkpIGFuZCBwcmVzZW50bHkgaSBhbSB1bmRlciBwb2xpdGlj
YWwgYXN5bHVtIHByb3RlY3Rpb24NCmJ5IHRoZSBPbWFuaSBHb3Zlcm5tZW50Lg0KSSBoYXZlIGZ1
bmRzIHdvcnRoIOKAnFR3ZW50eSBTZXZlbiBNaWxsaW9uIEZpdmUgSHVuZHJlZCBUaG91c2FuZCBV
bml0ZWQNClN0YXRlIERvbGxhcnPigJ0gLSQyNy41MDAuMDAwLjAwIFVTIERvbGxhcnMgd2hpY2gg
aSB3YW50IHRvIGVudHJ1c3Qgb24NCnlvdSBmb3IgaW52ZXN0bWVudCBwcm9qZWN0IGluIHlvdXIg
Y291bnRyeS4gSWYgeW91IGFyZSB3aWxsaW5nIHRvDQpoYW5kbGUgdGhpcyBwcm9qZWN0IG9uIG15
IGJlaGFsZiwga2luZGx5IHJlcGx5IHVyZ2VudCB0byBlbmFibGUgbWUNCnByb3ZpZGUgeW91IG1v
cmUgZGV0YWlscyB0byBzdGFydCB0aGUgdHJhbnNmZXIgcHJvY2Vzcy4NCkkgc2hhbGwgYXBwcmVj
aWF0ZSB5b3VyIHVyZ2VudCByZXNwb25zZSB0aHJvdWdoIG15IGVtYWlsIGFkZHJlc3MNCmJlbG93
OiBtYWRhbWdhZGFmaWFpc2hhQGdtYWlsLmNvbQ0KVGhhbmtzDQpZb3VycyBUcnVseSBBaXNoYQ0K
