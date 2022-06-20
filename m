Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9160455178C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbiFTLjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241956AbiFTLjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:39:43 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F816591
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:39:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id i16so10781901ioa.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bcMpb0+U8hvu5f8G5pzgTH9T7+XuJBbsNhFi8cJ4160=;
        b=mrZR/lSZcTDMckk22Y2tkaZJhofQz/DI8X1cE1tqyiBq77eXQDeogFKit6BX/xIx35
         s/7r3yfwgQGOdm/INQOSoc8+MMlo/SJ6IbT+8HnTqxMFXdC27KTtBBw1AR9vBm2KVte/
         FrPp4FGNk91dIQB6YSojwpaZ8NTD+OFWvwKNTzHOccgXei63/QEJhv1rJG3BoZ0NRuMv
         MHrJ4f3B2Eo4BVeroLVnCUBavOlZbZBKBVh034FhmoZAl3CBh2qxbw9bfPqWsY+W66mQ
         OOlptESHzqev1O20Vbsi5O0vI6KrXKU5GXouh8KD9jkIVWKmF3yp/M+JdDD2UljVfkDf
         kqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=bcMpb0+U8hvu5f8G5pzgTH9T7+XuJBbsNhFi8cJ4160=;
        b=AqPm1gZB2heM25pNjJwxtX1Gud6EEUfafaTGS7lGozcipLMtnGgMrTLXcd9lpPmBQg
         AObwBYp2X2nX7S6Nd/lNpQMJZVAcCr0awt18xDYcXfdXHkGgIs+6pNW/j3lMVRBDeZJf
         dqVUZRVleMQxehXo4fdgg/PUlu1+GX2UFFBi17idAadXnY7ACs4xNBUuswBLMySsALK7
         nvwU04XYWQRCsBtAa1v8sfgj95Ya9fHnTxBUyVqEoI2A30VCtS4gGsfPSR2P/mlpkPuk
         kXku/lhT2R3X1ufySPzUzC+Uka1AuhqbWaCjm6OlvT00PHlOpj/13qFRl0kfApAkKCq8
         e+rg==
X-Gm-Message-State: AJIora8E9zhjgGyQjpPMTtL+t4wU9KAkSOIOLBoAE5AXWV86HX3U7I48
        xdeLKxsqGCPgMMS+QPQgmmjrRzfRodGpfl82DYI=
X-Google-Smtp-Source: AGRyM1v9IuWNaMJ7RTSTBwcetSwrlweOafVRaIZpdBl7+ZzXGFTJA70niWyJ4mXMtA26ETUSaiOLA6+hTM0ofUfi1dc=
X-Received: by 2002:a05:6602:1682:b0:65d:f539:e30 with SMTP id
 s2-20020a056602168200b0065df5390e30mr11349818iow.81.1655725182104; Mon, 20
 Jun 2022 04:39:42 -0700 (PDT)
MIME-Version: 1.0
Sender: noelinekasse@gmail.com
Received: by 2002:a02:900c:0:0:0:0:0 with HTTP; Mon, 20 Jun 2022 04:39:41
 -0700 (PDT)
From:   Orlando Moris <kelvinedmond612@gmail.com>
Date:   Mon, 20 Jun 2022 11:39:41 +0000
X-Google-Sender-Auth: GYRKow7eu35DgNH3BmnkwjtmSlQ
Message-ID: <CALZWmmxgZHwv2=2k2tQGPe9FM3ySdejKRKWWttr1DMEMEO-nxQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ol=C3=A1, Informamos que este e-mail que chegou =C3=A0 sua caixa de correio=
 n=C3=A3o
=C3=A9 um erro, mas foi especificamente endere=C3=A7ado a voc=C3=AA para su=
a
considera=C3=A7=C3=A3o. Tenho uma proposta de ($ 7.500.000,00) deixada pelo=
 meu
falecido cliente Engenheiro Carlos, que morou e trabalhou aqui em
(Lom=C3=A9 Togo) antes de sua morte prematura em um acidente de carro com
sua fam=C3=ADlia, estou entrando em contato com voc=C3=AA como parente mais
pr=C3=B3ximo de ele para que voc=C3=AA possa receber os fundos mediante
reclama=C3=A7=C3=B5es. em sua resposta r=C3=A1pida, vou inform=C3=A1-lo sob=
re os modos de
execu=C3=A7=C3=A3o deste conv=C3=AAnio., entre em contato comigo neste e-ma=
il
(orlandomoris56@gmail.com)
