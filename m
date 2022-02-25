Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CC04C3ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiBYHMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiBYHMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:12:14 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AB83B548
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:11:42 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso7731216pjk.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uGhzlt2t6o+8i2zqg3MDSAcgIvp80HsaumhqEr+aVuA=;
        b=bCTCvwdprbUmaWGdjK2w4AhRfj51ARiwdd5jRHELW89c5ufQFPe+Ax0dd3j9/XEN+E
         TqcKvwJ2AEpW+jIORqrZbYaU74ZDGkbIVKq4d6uS7zi7mJzsdztlLgtjwuuuJIVkTVHV
         EulqOmjKu6uXVnZvJioPVMEilEiqQId0rcI0T90PYht5e7IY4PsdSa49eikYXAZgprv8
         si8AJ6vSJQY4G0oTOQuva39YNN0UpGDZViVu1IeV6jt9EQRfDZchpDLWu2GrLURL0HXh
         3ZrSdATtMsR0Hjff1Ii7ypCl+q/uSBT3KPJQC9zLctcorhVh8spx9JYsraBjcp4aC1UV
         z/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=uGhzlt2t6o+8i2zqg3MDSAcgIvp80HsaumhqEr+aVuA=;
        b=4HZr40HYrVZy0CHXFK1MVssLVIkfImfAvGRTYl12Xu3vBMFFGL5JsuFdFb08nDLCMq
         DIVFubYP7wnAOIk7EAepRmSgEvR24kAP2lB5HF7e5oooUIOnNs9Io6nto5BkhrVp3Gy5
         gVb9qRR5wcHZ/C7FioWCWdi/tOOSQf9JohIi5YipZRSrGREZEOaVj432XzmymotyCcic
         mgTZiZKcGb7bKIhl5dmv1qwqz69kZCk+Ukdszx/Go2pPiiB70a7YMt3twjrmc9RwdE9p
         iiaNLnRvNCQwOnjZNQSktjenT1wAtD4/m5//dI6kIZiNnYpE2CfnGf0VD+s20qMdz5ja
         T2Cg==
X-Gm-Message-State: AOAM530+a/J+ufo/cZ6PMuskxhcmjBJNOpwUp7NEhbpIkqOjd4SE96MJ
        SQu76d96kuK3QKMr5SCIkUYZ92oZLVxNBCM6crs=
X-Google-Smtp-Source: ABdhPJwsHNYsMyE00iRtoqsgp1WpP4CM7ELQPxCrJYar+r/apzNsZLMLdvLe5Q2CnDDye58EWhJaPxqZsdxkcgLE0Lk=
X-Received: by 2002:a17:90b:fc7:b0:1bc:4fc0:6fbd with SMTP id
 gd7-20020a17090b0fc700b001bc4fc06fbdmr1869825pjb.198.1645773101686; Thu, 24
 Feb 2022 23:11:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:c58b:0:0:0:0 with HTTP; Thu, 24 Feb 2022 23:11:41
 -0800 (PST)
Reply-To: canadabell84@gmail.com
From:   Bell-CANADA Entreprises <jacquesgeorgesguichard@gmail.com>
Date:   Fri, 25 Feb 2022 08:11:41 +0100
Message-ID: <CADq6x7dHCgcbaRqk7_zJ1udsM=HOn4gmFrHEM7HuC9G3ju7ZvQ@mail.gmail.com>
Subject: SESSION DE RECRUTEMENT 2022
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1042 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jacquesgeorgesguichard[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [canadabell84[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A votre Attention !!!
Cadres et Jeunes dipl=C3=B4m=C3=A9s Bienvenus, Dans le souci de lutter cont=
re le
voyage clandestin, la pauvret=C3=A9, de promouvoir l'emploi et =C3=A0
l'int=C3=A9gration Africaine au processus de la mondialisation, La
Compagnie BELL-CANADA en collaboration avec le service de Citoyennet=C3=A9
et Immigration au Canada lance une grande session de Recrutement
2022.En effet nous recherchons avant tout des personnes capables sans
distinction de sexe qui pourront s'adapter =C3=A0 notre environnement de
travail.

CONDITION A REMPLIR POUR TOUTE PERSONNE INT=C3=89RESS=C3=89E

1- =C3=8Atre =C3=A2g=C3=A9(e) entre 18 et 65 ans

2- =C3=8Atre titulaire au moins du BEPC BAC ou autres Dipl=C3=B4mes

Professionnels

3- Savoir parler le fran=C3=A7ais ou l'anglais

4- Avoir de bonnes qualit=C3=A9s relationnelles

5- Avoir une bonne moralit=C3=A9

PS: Pour plus d'informations et le retrait du formulaire, veuillez
nous envoyer vos coordonn=C3=A9es Si vous =C3=AAtes int=C3=A9ress=C3=A9s ve=
uillez nous
envoyer: NOM; PR=C3=89NOMS; =C3=82GE; PAYS;NATIONALIT=C3=89,PROFESSION,SEXE=
,NUM=C3=89RO
T=C3=89L=C3=89PHONE,ADRESSE: =C3=A0 l'adresse de la direction par =C3=89mai=
l qui est la
suivant : canadabell84@gmail.com

pour confirmation de votre inscription et pour plus d'informations sur
les conditions =C3=A0 remplir et les pi=C3=A8ces =C3=A0 fournir pour votre =
dossier de
candidature.

Le charg=C3=A9 de l'information
