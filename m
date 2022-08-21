Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B16559B6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 00:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiHUW7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 18:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiHUW7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 18:59:13 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24FA1EC44
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 15:59:12 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id n125so9496077vsc.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=OSBmu32vO8aIFQ/hG4uWOrgGUsLPqq8FeuPiazd3PBo=;
        b=UrSpcQbHkQE52cZPG9O9TczfQS2tHy0GqpP0OS05tfKCJzpNZyqdvsyuO4iR9oW/cV
         XQ+5sgVludPBrRnirutfoqqwSRc2n5pfBZVdBAv9EA2K/RmSc59lmj0cbgcNoEsFGhVZ
         Xmp1hGOZ3oYT8zCyQNyJsrSi/21a/1aNjZcuxKLlKgtXMpIPJyoijOhEmt1vCVul0xr+
         NtT93sE7SbyZGtGSQkINHd3uxFNATzRXHXbx8qxIzv1n/5eeqosUSLeN2w923G2NMr1u
         pMCYsX2AZHOIBlASN+6iBg5X7Ttsi04aSUsdpHeej/YH7dhhriK4tjXwlxTR2gs18PoE
         fQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OSBmu32vO8aIFQ/hG4uWOrgGUsLPqq8FeuPiazd3PBo=;
        b=Aqw98+qoHkHGkeVzxZlwkzCANXKCG8X0EBUc3zU097MzeQTgCH+1rQf0HObMfaYUHF
         kcYDve9D/7yjvxKKfulRBGup6PZhM/sQQ4fuW4usdznYNuBJnFsN6hrxthviqlzw+zkX
         kAS1FL/zVWj02UnKgFFmwKxHPywQSO8X9Z9FFTQO48g+CihqRCYIKCz4eoZ0T/eOwoSz
         v0YNxSITTO34a0+/ClQ/2o8uHwzxV7ZF/COpFR2RSZVccpi1wAw47rkEp/TKiOpHu8Ug
         LXjitzBruNVUqnfcXOmnoFboIcRGUWQs+E5kkLor/8/SSitimk/dg0xPqJbOm9ZXMi2n
         +dZw==
X-Gm-Message-State: ACgBeo0mi9HsMq8MJ5J6Bj/HdtEowplEKGATmtsz5bo/o0KQnNpilLpx
        Jb2saEHVXOVc56OjAjNizz5Tuxz4YnRL6B2kM0Y=
X-Google-Smtp-Source: AA6agR4WLloXL0x1QNzMdXd9ox+47BUwm1K7n/hZ2EWW4B3Y5owHqr3vhO9DmtPrKuBC0NIhbCcXtPJjnFB+O0rgOLM=
X-Received: by 2002:a67:d70b:0:b0:390:1e0d:b6ba with SMTP id
 p11-20020a67d70b000000b003901e0db6bamr5530136vsj.9.1661122751605; Sun, 21 Aug
 2022 15:59:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:59f:b0:2eb:ac02:6150 with HTTP; Sun, 21 Aug 2022
 15:59:11 -0700 (PDT)
Reply-To: azimprejimighty@gmail.com
From:   Azim Premji <ukpacharlesmikel@gmail.com>
Date:   Sun, 21 Aug 2022 15:59:11 -0700
Message-ID: <CAHJoZEGUKv2fRmMPeQi_O-+ZNBAMd=e7+hNRb2ERtzf80HF4Bg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e35 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9244]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ukpacharlesmikel[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
hiermit m=C3=B6chten wir Ihnen mitteilen, dass Ihnen 500.000,00 $ von der
Azim PremjI Philanthropies Foundation, Azim PremjI Philanthropies
Foundation, zugesprochen wurden. Ihre E-Mail-Adresse wurde w=C3=A4hrend der
Suche zuf=C3=A4llig online ausgew=C3=A4hlt. Bitte kontaktieren Sie uns so b=
ald
wie m=C3=B6glich, damit ich wei=C3=9F, dass Ihre E-Mail-Adresse korrekt ist=
. F=C3=BCr
weitere Informationen kontaktieren Sie uns:

E-Mail: azimprejimighty@gmail.com
HCL Corporation und Azim PremjI Foundation
Azim Premji
Leiter Unternehmenskommunikation
Gr=C3=BC=C3=9Fe...
