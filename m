Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D9354B442
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355556AbiFNPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbiFNPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:10:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0EA3E5C3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:10:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u18so8005484plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=A6sdBtIDczcYVQC2OZNEb2EKTKTkY5JHvHWUoBduirY=;
        b=Td5sxgkLsXBAHh5s6ax6Kar0E7KRoXD108icx3KWoRpz3iFrYWHdR/BGDh7SluJttP
         u4SXknGrF06j3WaYk1Y4ZKcpP/V7Fuip216dIvKU7Sq8WVPbXiYIkKq660K1m2A0JhM3
         pqMeQw8fU2+4erXrD51hwh1J1GeLe8Ef94alaZ8gcKVaP35kcPpG4stDEDmPDER0Kn71
         8ZsnTRbd8lQJGkliggy2bIuZu7TpGq9lq89rF/OxqWpL+DwcjcaFkQCwImvXboYPwG0T
         UdBz2hj7WtdiZvRFD+LT/P5/JGzoF1Do9fWo+7pXJyauHcGbpx1xQEqtyc761wLaUUcR
         yfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=A6sdBtIDczcYVQC2OZNEb2EKTKTkY5JHvHWUoBduirY=;
        b=0RI9FgrkvB8ZAP/N/4OB348MrqTlGjc9nA3hY7j8dGXA3OQL9ttFzSIKPVQ/A41bYf
         lZID9t6/JmvPD60Ab8onsijl2FQFUVmIoxinfxe8ltfAyhDz8Gtq7H3xybldbFBxR1eh
         AV+6aGGfd9Gc3VdHwsAld7zIhFrpXSuYZLe0vv5N560U3ey2I1HdiQAZyJPjYVyplYEs
         ed4LQlLVwXZFmPEXUIUI27A1F8tKLETZrVWENOy/0p1vOmrc8QSqi1j2bVBSSejjeYhc
         8bvJ+rAvwy26SrXpZdMyYTIj+XdIUdnnlBqmN1+TjEpwA3dzdppCZiQwKsH6ZVjDtZM+
         iOig==
X-Gm-Message-State: AJIora9VwHWqwniKeabXHo8oxXDRgrQx67A0vV26Lsux2551nmZwmzuq
        QgpgUsYIyrDDGRROBhAWpnzZm5p+ebrXxFBySvk=
X-Google-Smtp-Source: AGRyM1uegsP/kss1whRDU7hTRLcrrWnlFz79XXd5CUoJ+vWuso8MEaQSSD1z9mHzYDXfAtnJIymB8RRC7DnG9sXPiSc=
X-Received: by 2002:a17:903:11cc:b0:168:eae:da4a with SMTP id
 q12-20020a17090311cc00b001680eaeda4amr4764988plh.21.1655219444271; Tue, 14
 Jun 2022 08:10:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:4517:0:0:0:0 with HTTP; Tue, 14 Jun 2022 08:10:43
 -0700 (PDT)
Reply-To: orlandomoris56@gmail.com
From:   Orlando Moris <ouroakononassoumanou@gmail.com>
Date:   Tue, 14 Jun 2022 15:10:43 +0000
Message-ID: <CA+X4su0i-aovJs6O5Mukdy_TyZKquARQj8m0a2-ZFgMnHHJNPg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ouroakononassoumanou[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [orlandomoris56[at]gmail.com]
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
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
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
falecido cliente Engenheiro Carlos, que viveu e trabalhou aqui em
(Lom=C3=A9 Togo) antes de sua infeliz morte em um acidente de carro com sua
fam=C3=ADlia, estou entrando em contato com voc=C3=AA como parente mais pr=
=C3=B3ximo
de ele para que voc=C3=AA possa receber os fundos mediante reclama=C3=A7=C3=
=B5es. em
sua resposta r=C3=A1pida, vou inform=C3=A1-lo sobre os modos de
execu=C3=A7=C3=A3o deste conv=C3=AAnio., entre em contato comigo neste e-ma=
il
(orlandomoris56@gmail.com)
