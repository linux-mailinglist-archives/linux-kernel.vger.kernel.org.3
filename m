Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C58D5547F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350998AbiFVIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiFVIpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:45:15 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7BE39689
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:45:14 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-101d2e81bceso12817190fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JjOjpc99NDX760QEnCLvwrwveLOaiPRbzlah8sRkfs4=;
        b=bIRVIKGtS7At06O7QDxGNZ0tywiBVFwjvByG+Fikxg7NaXigLjCoh9wWP/B1368Eyc
         qmrIMClNXzMllhFBbghaDuAPMbRf0wPXMnm+65HncKX7iiruA1Ylzw2VYNnAKrKPYjf+
         O61h2Z2JzBE0uBJTpnYvmSMQEHsp48XAbYqaMedYmhWU2ti9Cs3Q/1Hqsjn7RWYAl6un
         QmDba786lzzPGTj6Q2TFHs2WswOjAK7HzJiSiwkcNOdSvdo3O5YoCjLS962wHP7hpJq0
         EG1qAWGYSnW1hcEJtehoRjwCYsh0CuYg21O5ABcGFlLdccWG5wCqSyh/EcIwVAXSfz+e
         BeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JjOjpc99NDX760QEnCLvwrwveLOaiPRbzlah8sRkfs4=;
        b=BZAPuAKn5mT04Bz7fDBaoJ/8uybvEWMILHHQV/agDnPXbAxRQVJLmhbeNM1ZjZXdAP
         Sigj5L2l1QJb4xZvUDOJ0vpbonysrT6k9JjfXw1v7ejIWAG3vY5JXNmGPHVxw0+2aGsZ
         GbqOfWLY0aIXeUhNNcb92HmZrQ++cpnivJm4ThueGAHrgJjX+q0mJXUZk9k6g1bXHMML
         gb3nldAOaKMB1tB7IwbUNLb1l3Uzrbr4S9nW7nJJ6z71I3+/GpPVrr9Y9gWmOw/eZTBO
         jgnH23z7K8eOWIf/y/MVAUzlZgKXqigkXlIB2W2asLbb7yLOIZVw7E7OGX1CKwhg9cUI
         YRjQ==
X-Gm-Message-State: AJIora9gvxqsKnd+ToQFNztzcvc7+Ql2JSsY47ex3TaTa9RzE6YP1b+S
        Loi7B/eM00fSGRnK0Nrc5lqYymdiLu9KLIwysuw=
X-Google-Smtp-Source: AGRyM1vML6WOGR5V390nOqMEtKabzaRacGEsjOjduc/wyDcNXYZKKY+zRw1hgG/2CNvb9wpGC0d1qa7vXySXVAU1HNk=
X-Received: by 2002:a05:6870:4585:b0:fb:5105:76b8 with SMTP id
 y5-20020a056870458500b000fb510576b8mr1323427oao.92.1655887513386; Wed, 22 Jun
 2022 01:45:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:8407:b0:a9:bb5f:e48e with HTTP; Wed, 22 Jun 2022
 01:45:12 -0700 (PDT)
From:   robert anderson <robertandersongood5@gmail.com>
Date:   Wed, 22 Jun 2022 08:45:12 +0000
Message-ID: <CAD7QbCCkEW4cssZpXTRKsjQVe_A83eaVYLqq=VOCuVKZLi43-g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,MONEY_FORM_SHORT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herzliche Gl=C3=BCckw=C3=BCnsche!

Die Vereinten Nationen sind zu dem Schluss gekommen, die Zahlung eines
Entsch=C3=A4digungsfonds in H=C3=B6he von sechs Millionen US-Dollar
(6.000.000,00 USD) an gl=C3=BCckliche Beg=C3=BCnstigte auf der ganzen Welt =
mit
Hilfe des neu gew=C3=A4hlten Pr=C3=A4sidenten aufgrund von Covid-19
(Coronavirus), das zu einem wirtschaftlichen Zusammenbruch gef=C3=BChrt
hat, zu billigen verschiedenen L=C3=A4ndern und globale Gefahr f=C3=BCr so =
viele
Menschenleben.

 Die Vereinten Nationen haben die Schweizerische Weltbank angewiesen,
in Zusammenarbeit mit der IBE Bank in Gro=C3=9Fbritannien die Zahlung des
Entsch=C3=A4digungsfonds freizugeben.

Die Zahlung wird auf eine ATM-Visumkarte ausgestellt und an den
gl=C3=BCcklichen Beg=C3=BCnstigten gesendet, der sie =C3=BCber die IBE-Bank=
 im
Vereinigten K=C3=B6nigreich =C3=BCber ein diplomatisches Kurierdienstuntern=
ehmen
in der N=C3=A4he des beg=C3=BCnstigten Landes beantragt.

Dies sind die Informationen, die das Management des Vereinigten
K=C3=B6nigreichs ben=C3=B6tigt, um die Zahlung des Ausgleichsfonds an die
Haust=C3=BCr des beg=C3=BCnstigten Landes zu liefern.

1. Ihr Name:
2. Heimatadresse:
3. Stadt:
4. Land:
5. Beruf:
6. Geschlecht:
7. Familienstand:
8. Alter:
9. Reisepass / Personalausweis / F=C3=BChrerschein
10. Telefonnummer:
Kontaktieren Sie unsere Agenten-E-Mail-ID:
Name Solomo Brandy

EMIL-ADRESSE (solomonbrandyfiveone@gmail.com) f=C3=BCr Ihre Zahlung ohne Ve=
rz=C3=B6gerung,

Mit bestem Gru=C3=9F
Frau Mary J Robertson.
