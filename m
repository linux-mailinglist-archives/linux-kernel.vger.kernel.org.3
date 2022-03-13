Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5FB4D7872
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 22:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiCMVaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 17:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiCMVay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 17:30:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6277A5D661
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 14:29:45 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k125so5951998qkf.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aqwRVou3ZEqbHgCp0ui7E/IKLtOENN+H8FN5ocvbXL8=;
        b=Z+YpcfL47Bh2vNnmxsytQB2Td2LUfIQjzltJ8tuAdRbJ/IuUlCOTg1Bhbv3/4TmR++
         hiL71NlQpCDX6vhMyvdGEMKat7fd9ky+2q4Ch8jHx1u+aH+FumJIGeCk5ONTqsFufYp3
         uDAKxtd+DJZ1YLc7znBXpdbFkKGvlDFeDFt8F2upNOOXVeM05voLfqpQhBOO+2xvncee
         TMzDb+MMkAQITroUh/VTblfayNO5e0jHf8kB1A13aA3sXBbP13NiSoJAGaSQuaotXwbA
         FgWDGg20dRoyGq1yd0vJeAhUGFSeVnO2SbxOPVtdv64GIqyscbKY3cZrVqJKXS7zNxRp
         bc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=aqwRVou3ZEqbHgCp0ui7E/IKLtOENN+H8FN5ocvbXL8=;
        b=zUO77EVqYxrXN1c/pyVkuUoOKEFYSP+asvcqLVefhzN1RJbrfKI66Le60m2HvCPS/V
         25K5oeF3bmbg2KamfMXjuUEorj6QpjqrL5hhx2bs+K9fZiCtUez3Y8BOwvnpic5fNpqf
         BhsrZr2SavHXH4OSSpXHom+nfwJTPxVuMeBWosRoG4WR/P2e6SyuthRmsx2DipZSBE4d
         1BlrldUn1aS5UiVWO4tz26ekYjBLCBXHZ30BtHcrgtyY5RIfBx652I92ccpGn8bQUqMX
         A2hH0ymZL8tRho8C+hJSc1H6KG6trvOijL3tqcEJigXCQEvTneceXMujX/f3M6Z1JVHa
         GV1Q==
X-Gm-Message-State: AOAM530WwCD1GKkGEtMZUeX/hJm5uYENCIoOjZZYajFIFH10icpfm+H5
        rHaS91BiG267d/5E+i+YMNWPW6FEQ7uRxcet9dsPHJzJUhc213U3
X-Google-Smtp-Source: ABdhPJz+FUxoWBFgHLfleQugSvPSwkttfaq5mRMSDT167fhqujfvlMcTf4pCalIxX08WsW1CejxrLVnX4Ue0yGFHZls=
X-Received: by 2002:a05:620a:1181:b0:60d:f3ab:595f with SMTP id
 b1-20020a05620a118100b0060df3ab595fmr12723091qkk.275.1647206984550; Sun, 13
 Mar 2022 14:29:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:620a:d96:0:0:0:0 with HTTP; Sun, 13 Mar 2022 14:29:44
 -0700 (PDT)
Reply-To: susanneklatten210@gmail.com
From:   Susanne Klatten <aminuinuwaauwalu@gmail.com>
Date:   Mon, 14 Mar 2022 00:29:44 +0300
Message-ID: <CAPGf0ucetLyFHSaF-fQf-=UwmGMcKOjbv2XWU_O8AcL4Fq2VGA@mail.gmail.com>
Subject: Darlehensangebot
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM_LOOSE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:729 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5203]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [susanneklatten210[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aminuinuwaauwalu[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.0 REPTO_419_FRAUD_GM_LOOSE Ends-in-digits Reply-To is similar to
        *      known advance fee fraud collector mailbox
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hallo

Ich bin Susanne Klatten und komme aus Deutschland, ich kann Ihre
finanziellen Probleme ohne R=C3=BCckgriff auf Banken im Bereich Kreditgeld
in den Griff bekommen. Wir bieten Privatkredite und Gesch=C3=A4ftskredite
an, ich bin ein zugelassener und zertifizierter Kreditgeber mit
jahrelanger Erfahrung in der Kreditvergabe und wir vergeben besicherte
und nicht besicherte Kreditbetr=C3=A4ge von 10.000,00 =E2=82=AC ($) bis max=
imal
500.000.000,00 =E2=82=AC mit einem festen Zinssatz von 3 % j=C3=A4hrlich. B=
en=C3=B6tigen
Sie einen Kredit? Senden Sie uns eine E-Mail an:
susanneklatten210@gmail.com

Sie k=C3=B6nnen auch meinen Link anzeigen und mehr =C3=BCber mich erfahren.

https://en.wikipedia.org/wiki/Susanne_Klatten
https://www.forbes.com/profile/susanne-klatten

E-Mail: susanneklatten210@gmail.com
Unterschrift,
Vorstandsvorsitzender
Susanne Klatten.
