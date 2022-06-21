Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E3A553E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354715AbiFUWfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354582AbiFUWfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:35:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955A531DD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:35:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id fd6so18578059edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qr6sJy5vBRC+dq0sR4qT1WgXSzVq4kiMxqFhXn4CM8Y=;
        b=S49UqMPn0yi/PCD1TUNgwyC/9NCBw58IbuYy9mCU8ousAQPWKLIEymbuU7A/gkwWsF
         73ha1IZSvK2v49VjpFQXVGU6ggbizc2/480lkR+b48UsdlNKKs7T7st9OW70gp6c0Yd5
         N0PKH7VmR9ec+HfYuaWWPm671yeX1BvoRX6MTjGhf7S8ewHVSsUm3Edb4AA7F4Oy60QI
         cW1EVfLaGhFbvTFPC0VLUn16U1Cc6xoSmQeXIwqO4lXNBoYRf73uiWnzWjwfFZo2shwE
         HUDelhxlBfbswsVMzJ4tbQtdN//KOvsdAW7ayQy3OOsQWHz2sFW33Z3AA+iSMbMYPCnt
         vrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=qr6sJy5vBRC+dq0sR4qT1WgXSzVq4kiMxqFhXn4CM8Y=;
        b=xUT4IZMWk7zUKSo2GF2Efi1iM9O/rhjdpQq+wRnJIAF9mT0KyIwJ2jvyEE4tNbvwRx
         XEqvit6KmVmLKF3anhmk9qaW59AFOXbU7H7xfm9IQH35eBNHaYr1dsZ6YFkVe2+r4zXa
         npf7uERaheufwCOmWM3aoFulNf0n9kd0LqOFUdOW1uHXt/HgZNIYZk7ajXUd8PjMNAHs
         nt3q/f943CIm8YIiI0TeUIBQl0Q05h8euRmpHhWdWDxwHiOFL23cb9svlkpHzIwshRhw
         pUjbL70F/F8mJdvzicUdKAeH8+Fq8a2FEMnlwvmtRDkv22Ehw2DSMr/OwHuc+OPXxLLJ
         l8WQ==
X-Gm-Message-State: AJIora8Oz11HNLZ4eYMHuTy8E5gWbblpl/hdxt0jT7AHN9OUBdNDyFUJ
        XNMoDscpLeGwgHuAYfTR3CJ2ZYePDrSpM6DCSg==
X-Google-Smtp-Source: AGRyM1vLlnOfci7BdcswtrPu1enA7i4vWR1V8+sxutHrDxc1NUb/Puc3RtGCGrVkyFrGRTdrO24m2I+bfwsNI66xdbw=
X-Received: by 2002:a05:6402:2741:b0:434:fe8a:1f96 with SMTP id
 z1-20020a056402274100b00434fe8a1f96mr406474edd.331.1655850947205; Tue, 21 Jun
 2022 15:35:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2d0b:0:0:0:0:0 with HTTP; Tue, 21 Jun 2022 15:35:46
 -0700 (PDT)
Reply-To: mrskristalinageorgieva74@gmail.com
From:   post office <anoumou63@gmail.com>
Date:   Tue, 21 Jun 2022 22:35:46 +0000
Message-ID: <CANF9qczrR4_Ytp5jh2vhmg2VDA+-UY4iznwv7G-ytB_uveJYRA@mail.gmail.com>
Subject: =?UTF-8?B?QVRFTsWiSUU=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FOND MONETAR INTERNA=C8=9AIONAL (HQ1)
700 19th Street, N.W., Washington, D.C. 20431.

Stimate proprietar de e-mail al beneficiarului, v-am trimis un e-mail
=C3=AEn urm=C4=83 cu c=C3=A2teva s=C4=83pt=C4=83m=C3=A2ni despre fondul dvs=
. f=C4=83r=C4=83 niciun r=C4=83spuns din
partea dvs.
A=C8=99 dori s=C4=83 =C8=99tiu dac=C4=83 a=C8=9Bi primit e-mailul meu anter=
ior referitor la
fondul dvs. nerevendicat, f=C4=83r=C4=83 niciun r=C4=83spuns.
A=C8=99tept=C4=83m cu ner=C4=83bdare cooperarea dumneavoastr=C4=83 urgent=
=C4=83 pentru mai multe detalii.
Felicit=C4=83ri, contact
Doamna Kristalina Georgieva pentru mai multe detalii
(mrskristalinageorgieva74@gmail.com)
(I.M.F) (601) ofi=C8=9Ber 601
