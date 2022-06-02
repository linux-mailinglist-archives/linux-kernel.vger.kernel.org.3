Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0753BB46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiFBO6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiFBO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:58:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DEE2B7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:58:33 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 2so5030829iou.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NCpzoj+0l36fkrjHX3S+lurr6Rzg3xie2enwLhIR/28=;
        b=RqJnmigpciPdLSSKdzV8NIDkGYcoKapCr1+yDnbfdslNBGswdDQaXCkI6dlZI+EKqY
         fkOuadfFHAEyuvohbxPt9EpeYmLiMJ9qAad5TFi4gKXkEGBPU+GFnlwk+7I5cPAMSpIf
         HfBNQYS1ebRogp6QxW2gIlu5AgywtHIqsKK1oUVMJPx8q7Et+6DB2pVvJgpX68rFJh6v
         wBobL0O42vlXlBm9yrmQj81w4vwJo4nJ7ASx9AAymA9XR+zmPy2kKK1j/TE2bqblr5mz
         8Z/ZjNnLpdaLWyiGV1ABfFFAr7wf8GQUXo321fIAs9PQ65IAdguR1CpQOQ6L/CmLBd55
         w/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=NCpzoj+0l36fkrjHX3S+lurr6Rzg3xie2enwLhIR/28=;
        b=dT6BOO2ZZRIuMmB1aiADUgznBCKnpw4CcN4DieB2FjJRLR7JuzrVADD9W0GhGMLJxW
         TcDXRKdRgmUXI+rW0dtvfdTn1qtu+9bTAU7u+bX4w7FwhONnmzcX9IjOWbcPJ2bk3vr0
         V4Mu3qy4QzcEUdruGI8IdMMbyY7kgN/Kz5M1Fi/0h9UW8++zMAjFNr1nRRFkJ7D72mfJ
         SqyQ79H5QGSSBxJ2EB9hxwFepE2n7xqoLW3S/9MwBDLg/SU5meWWj4/nzqAq0Fow2+D+
         3I15ma2ojJmvRwL8w0RWbjoZ7YZVdKtm0+JSv7Y4ye7btewmFtm4gAx1VvsMDLCD4Hwk
         F82g==
X-Gm-Message-State: AOAM532P3SfqfYJV3LhlHZbNlzWfOsUI19fLr6q26wlinKnPon6cY+G4
        1Z3T6v6nGuFpXSLHkKu52PqOvchGQEVqBnPeujA=
X-Google-Smtp-Source: ABdhPJy/5DIw/+9nm61RcAAlCu73iuZmuyUK5b+i5E0sTIwiRwmqFkVon1TezJj7h1acGp4BgO0A2wfjt6RCsoB8+qc=
X-Received: by 2002:a05:6638:d4b:b0:330:f5f8:2521 with SMTP id
 d11-20020a0566380d4b00b00330f5f82521mr3290134jak.149.1654181913032; Thu, 02
 Jun 2022 07:58:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:e96:b0:307:1ade:80f6 with HTTP; Thu, 2 Jun 2022
 07:58:32 -0700 (PDT)
Reply-To: alifseibou@gmail.com
From:   Mrs Judy <mrsjoychichi2@gmail.com>
Date:   Thu, 2 Jun 2022 07:58:32 -0700
Message-ID: <CAJyntBwi4XxFmfFMqi6hjOQgz56RnQykV9SsuF_=_RzEoxx1hA@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsjoychichi2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrsjoychichi2[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PREMIO GANADOR DE LOTER=C3=8DA.

Su correo electr=C3=B3nico gan=C3=B3 2.600.000 millones de d=C3=B3lares, co=
mun=C3=ADquese
con el abogado Marcel Cremer a trav=C3=A9s de su correo electr=C3=B3nico aq=
u=C3=AD
(edahgator@gmail.com) para reclamar su fondo ganador con sus datos de
la siguiente manera. tu nombre completo, tu pa=C3=ADs. la direcci=C3=B3n de=
 su
casa y su n=C3=BAmero de tel=C3=A9fono.

Saludos..
Sr. Malick Samba
