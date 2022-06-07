Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9415F53FEDB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbiFGMeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbiFGMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:34:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EE1B043F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:34:39 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a30so12143086ybj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vyN8ntyZhOzXyrs4BOHgtH4z7tLzPTX+RG6GjqghA2I=;
        b=pC+fpMbWzmB1GOezmenpMzqiRR7xCf8fJ4k9o0FHu4zXQaFKkUW0Fm5nuoqRSaZyU7
         FKrNcEZ+289a7dSRR0Mvl06nabMoq+BpryvE4Oqm0O3mZAk+tnPcABbZuqym+nu5J6S9
         p9zn/VyEM/3+Syza36mmeM9h+PMU78uC3Owwu98iOFQ7c7HzbwqLAvE7JOMz7ta5Ud2h
         Vi0rg4zXUf4ADEoFnSBlBlAa/XUQAFtTmyjvW6NgKEhNe8pz5U+olsBrPy7R+UpXDzT4
         5TEhJFc0MTMxyIJzAWRKPjr7EZGimTda9uWCuWMLjnVlCB1LahysdmHgiyU8PW0VqVC9
         DvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=vyN8ntyZhOzXyrs4BOHgtH4z7tLzPTX+RG6GjqghA2I=;
        b=mvegAejmPeNwymyzAeDT7jPb62jyVH5S3WI8+amnIIQ6iwe1G5XVNQAZe87C8UQiaB
         Lt7U/zgkxRODnZjuQ1EqIcBu9or7aCd5xDuUghZLmJQzKOIPTyT6AO3b5n2i6pz1vYkV
         XXiLk01FL/KTrvOwlBCDz0V4R1LPjXcogEYFRiSQlMwq9jy1wi+81IcS0pzoFPtHlNjK
         q68UhpyUIeNV843TSWyqwHRk++UIhUzrhegza8Kaqmjoc3R7xA8IYFpoVDH9kpZn4lKE
         5criUj6QcdnfPMPXKuqaJUs+7NlbWVACg78Mb0ALuxCLZpA8YezbuOr707xh72WHYHzL
         aUVA==
X-Gm-Message-State: AOAM530mt8oj+PYN3HDFb9xkwHeKACbhNMAe5iKnHeYVOmIsg/N7UqMD
        JBt+13B6nNHvzr5OGhUHOOYeb40x+2C0Rlwa990=
X-Google-Smtp-Source: ABdhPJzxewtGZ1KptfE1LbLTampkiRP0S1mMxwWlwkMaN5z782z/CA6ygr5saamuLCOVAanY0PMlZ3OYMTYWri79Zbk=
X-Received: by 2002:a25:2c46:0:b0:661:3c8e:e823 with SMTP id
 s67-20020a252c46000000b006613c8ee823mr15747799ybs.596.1654605278455; Tue, 07
 Jun 2022 05:34:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:741b:b0:2d6:bd3f:75b9 with HTTP; Tue, 7 Jun 2022
 05:34:38 -0700 (PDT)
Reply-To: georgebrown0004@gmail.com
From:   george brown <bbruce539@gmail.com>
Date:   Tue, 7 Jun 2022 14:34:38 +0200
Message-ID: <CADiB6YkFU3ELiVuC36FRFXf_9SKt2eKAzHK8_=eHS1iAgzRhBQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bbruce539[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bbruce539[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [georgebrown0004[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej

Mit navn er George Brown. Jeg er advokat af profession. Jeg vil gerne
tilbyde dig
min klients p=C3=A5r=C3=B8rende. Du vil arve summen af ($8,5 millioner)
dollars, som min klient efterlod i banken f=C3=B8r sin d=C3=B8d.

Min klient er en statsborger i dit land, som d=C3=B8de i en bilulykke med s=
in kone
og eneste s=C3=B8n. Jeg vil v=C3=A6re berettiget til 50% af den samlede fon=
d, mens 50% vil
v=C3=A6re for dig.
Kontakt venligst min private e-mail her for flere detaljer:
georgebrown0004@gmail.com

P=C3=A5 forh=C3=A5nd mange tak,
Mr. George Brown,
