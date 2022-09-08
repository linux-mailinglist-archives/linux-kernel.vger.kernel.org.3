Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CC5B2605
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiIHSnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiIHSnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:43:10 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E77E903E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:43:09 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11eab59db71so46680394fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=6zqod/zHQn+N4MgMFRhMmGU9hOwlfJ/mvzIBoWZvy8M=;
        b=PBcQ1FnJLlY3UjCMN/Sd8Ip7bxnlVraO0YMYsj21NVZUk7Q1qKrp4+uUENelubgk2x
         q2+swuq/+T3Ic4QuKa9uE8YR/PYD3XHDeDcKnNoZtxX+QIdxiPFPBFYaI9jmh2M8taxj
         Jgx5N4V6HMFxg7nvut0ZkdRu1vgM3N3pBONJs8Q38tPiiiVY42Ot1+2FlDEyrnXR95yM
         wMYu0thlRPVWxvrXTUGUo5gbwlIpE6AdxuD25fL5Qfs4HdQipOFS5cXu3Iw8fX/BG3uz
         bRZDttGiz8f8Jciwa4iplNlS9/IX8yUj1qWp1PUWtAzSka64iptu4BrEHp0Jaz//PoBv
         6GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6zqod/zHQn+N4MgMFRhMmGU9hOwlfJ/mvzIBoWZvy8M=;
        b=vOK/pu65KJL53wv14QTmAPGKSLX61oxIrKj/Y0Ho1qaL6ymib9uPFP3Je3ZRIFCvRR
         FuN9McCQiz2S/Za79b/sZvhnwQKsuH9n2OiENVhQICz/mhU6GFWp0Plr5tNEcdpFWukv
         QOc2W+qg/8DO1b0DXGyCVarhs7aoqcW6/T8ghwVb35shN6vdb41fGbPnkQrjaoL89cPF
         a2Fvh3L3eu6zi/sbgdyVOIZ4US7I7I2tsUZzuyM4mm9gtuUtdMjcyynr+Amwjw912Oi4
         dYmQbTOOJvWmGHdZeOatYW4aHjQ9aJb0fl48YZQSB/zch/m7PQhNUl7cPk/7dqI7mXoD
         oO4w==
X-Gm-Message-State: ACgBeo1DbWL5HAlo0gUWY1NX+m9xWwJsjkqAZ0vbE+nf2rV+Vx2AO1dP
        1rY6PXtBqyZ1PC6zMFjz7679GPallxeMDnamEgY=
X-Google-Smtp-Source: AA6agR6zeZSZEL7HCwmiJstWsPopBbHt5tHL9okEH43A8WVQvLugmy6GVNHi9LmRuFWBMrqEFvnUdNFXRKmDBj/KLD8=
X-Received: by 2002:a05:6870:462a:b0:127:1a2d:3478 with SMTP id
 z42-20020a056870462a00b001271a2d3478mr2815641oao.124.1662662589417; Thu, 08
 Sep 2022 11:43:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:9143:b0:b9:6343:3b87 with HTTP; Thu, 8 Sep 2022
 11:43:09 -0700 (PDT)
Reply-To: proctorjulius@yahoo.com
From:   Julius Proctor <barcalder50@gmail.com>
Date:   Thu, 8 Sep 2022 18:43:09 +0000
Message-ID: <CAGNWyKz2DRdRKbcVTsy1GhZPubsXPgUwB6hhA1gstOAHxbsL=w@mail.gmail.com>
Subject: Hallo, bitte antworte mir
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5004]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [barcalder50[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barcalder50[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sch=C3=B6nen Tag

Ich bin Julius Proctor, Anwalt der Anwaltskanzlei Proctor. Ich habe
Sie bez=C3=BCglich des Nachlasses des verstorbenen Dr. Edwin in H=C3=B6he v=
on
8,5 Millionen Dollar kontaktiert, der auf Ihr Konto zur=C3=BCckgef=C3=BChrt
werden soll. Dar=C3=BCber hinaus m=C3=B6chte ich, dass Sie bei dieser
Transaktion vertraulich antworten.

Julius Proctor
