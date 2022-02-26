Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73A54C5627
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiBZNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiBZNcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:32:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66865D39
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 05:31:31 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q17so11068431edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 05:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vFTjJiHGJM/FRxpTUAc+ZEjBxdNeuAkjjy0Iu6vBYo8=;
        b=KX92MCr9ks85Ff0eYqPso+nM2TCbxXZbm9e3Y5G87Qw3JzHI4R+/D/7wXcw4Wpq9bX
         r0yD2UtYGBDBY5DCONqaFaRHM3MC18EGUr6S77NPoIl2TgONFwCUwrVO0adY4WiEVSYS
         jHz8b9DqtiHb64vVD+hW2pDh2aL8Y/MapZdCx+AqWYEujD2f7dSUkyg98U8Pfzas1srm
         B92y089s8w1NvbWia57RXESjv3dWCcqPdram+tdn9cSsezLlvH0ieRHjRZ5gKPTtUNJa
         5Yjm36o7NTrVc9U+XiM9L9tiuduBNp/kiOgugHw0Ru/0fwWGeRhAINyTqT7R2wD1xGRk
         dHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=vFTjJiHGJM/FRxpTUAc+ZEjBxdNeuAkjjy0Iu6vBYo8=;
        b=NuyJ0X4l460AHWHrJNrR6dBlrIg/3BH6SDoooV9sUj4EV5axxR0O/Ige+1azd1YZCM
         YciMByc/+8CARlf6BkxTxutaqV3KtQUiEKLgQ/uBIoc20nlBFH4ykHS/8CjDci5DW4EL
         /kfYHhLzmHmrHO8Tqf4LPFQBVTkXZuvKM1M5DmFCotS9Q8A819ime7nltcc5IVkCqBaJ
         i6tp9s+FIfDJG6ITcCX10jqiVpJOb15pbuIeyf1L9tAFiGYschYh/Rt6G0dgt/pVooX5
         UhSC6ETj9jFqLW+3xcFPDcBxXl7qx18o/EQ2cMtobW0wsE3zq3H5UPCYgxrPIuuPz3iS
         qPeQ==
X-Gm-Message-State: AOAM531gRuPndWMD42xBtDyjZBfteMiMA/JdmzmEXWMmuPcnwNOn/ZLf
        AENoPyV0EJuBbIyuZQs+NffD0q0Wy234ZeCSnyg=
X-Google-Smtp-Source: ABdhPJyVruIzyl5laUhDiYEEFI2rXup7xukvDhuenZuzSGOPs4W3oYM2EBI7WHzXA6b+HWGeZEHEbl2JeLLnwRG3xE4=
X-Received: by 2002:aa7:d694:0:b0:410:d89a:656e with SMTP id
 d20-20020aa7d694000000b00410d89a656emr11733587edr.402.1645882289988; Sat, 26
 Feb 2022 05:31:29 -0800 (PST)
MIME-Version: 1.0
Sender: groupcompanyltd2001@gmail.com
Received: by 2002:a17:906:505:b0:6d0:8c9d:7ab4 with HTTP; Sat, 26 Feb 2022
 05:31:29 -0800 (PST)
From:   Ministere Desfinances <ministeredesfinances405@gmail.com>
Date:   Sat, 26 Feb 2022 05:31:29 -0800
X-Google-Sender-Auth: Q7t2PWPgKsJeRp6kJaFrTcw86Ao
Message-ID: <CAFkacvSQRj62M_vhj0BsCeqzX1OpfxPGWTtRMLcy_QNwKJ1fsQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORM_FRAUD_5,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FORM_SHORT,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_FRAUD_PHISH,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:531 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [groupcompanyltd2001[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [groupcompanyltd2001[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 T_FILL_THIS_FORM_FRAUD_PHISH Answer suspicious question(s)
        *  1.1 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.3 MONEY_FRAUD_5 Lots of money and many fraud phrases
        *  0.5 FORM_FRAUD_5 Fill a form and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attention Dear Beneficially


Nations (UN), European Union (EU) and FBI.We have been able to track
down. Information from Nations (UN), European Union (EU) and FBI.We
have been able to track down some scam artist in various parts of
African countries which includes (Nigeria, Ghana and Senegal, cote
d'ivoire Cotonou-Burkina Faso, South Korea and China - Burkina Faso)



They are all in Government custody now, they will appear at the
International Criminal Court (ICC) soon for Justice. During the course
of investigation, they were able to recover some funds from these scam
artists and the IMF organization has ordered the funds recovered to be
shared among the 100 Lucky people listed around the World as a
compensation.



This notice has been directed to you because your email address was
found in one of the scam Artists file and computer hard-disk during
the investigation, maybe you have been scammed.



You are therefore being compensated with a sum of $ 2.2 Million US
Dollars valid into an (ATM Visa Card). Even if you are now dealing
with these nonofficial directors of the bank or any department always
requesting money from you, you should STOP your communication with
them and forward the details to our office so that we will help and
recover your funds peacefully and illegally.



Since your email address is among the lucky beneficiaries who will
receive a compensation funds, we have arranged your payment to be paid
to you through ATM VISA CARD and deliver to your postal address, as to
enable you withdrawal maximum of $4,000 on each withdrawal from any
Bank ATM Machine of your choice, until all the funds are exhausted.



The package is coming from Ouagadougou, Burkina Faso. Don=E2=80=99t forget =
to
reconfirm your following information.



1. Your Full Name:

2. Address Where You want us to Send Your ATM Card

3. Cell/Mobile Number

4. Copy of your passport





Yours in Services

Mr. Jean Laurent Bonnafe

MINISTERE DES FINANCES

ET DE L=E2=80=99ECONOMIE (M.F.E)

BURKINA FASO
