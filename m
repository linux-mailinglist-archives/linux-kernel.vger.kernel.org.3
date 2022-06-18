Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8255076A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 01:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiFRXKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 19:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiFRXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 19:10:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B02211808
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 16:10:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h23so11955397lfe.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 16:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kL1PhX7sXeKhW4fetJZNIIwt2YUz+cHdR+yLTna0v7s=;
        b=QgucBOmFB0BxyAk7T1uBPQ16vjAlqj7uaULlXjWop8tzUCCaFN2USaOTqC3Dj3HBUu
         0EOHZHPxcZcqEfUX4eVHR5XmRxc5Z2Vq4jYYauAia2EGe6h946k8DyYjkhaBErtjYNx7
         APyH35J0HuHQyMctgyFhxeLZHdBXRcaT2egSreMEUdUWXpOZzhbyHm0u2GNXdmftCTAV
         WGr8KavKPY1Q35tlJ9JaAp/vHlzQJQJD4DN7agDnED/AEu7kLJVYI8FGH1n1/XbgVox2
         t944evf+5ZUKYkQcJs3a+WAKs2cTOkq46ETKITlpqmpVACB0zdqdp5gnpEqRVypimhxD
         ehIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=kL1PhX7sXeKhW4fetJZNIIwt2YUz+cHdR+yLTna0v7s=;
        b=I5jr8u2IeMQz+j0cfOeVW2tfuECHb4SE658cy337OIC0eiMzUSOlYH89uyOaxlfano
         TI0Y6zss4PHEg/E8uPV3hHonrWtxg3Rqzoa7y8IhsPM+oI9SGEhyS77N5zdFMvvQgpx3
         IiQ5Imlarv1UwyYQJHoJnIK1myPLtTNzwtNtiTVg566qVHW7Ml8kBhquEE3NGjE3W25L
         LMUZZn9Xlxuc/Oz2AqnTF84OTI6T7EtwiF9iN+bhrgb1VcTcOcaTGCDAVdjDg8faPy5X
         08+WLpdgx737ePohuEL8UmiDqfXHyMpQMEyb+65jjTxgsAqtzutVFxz3cQQgTAvlPN7A
         a8PQ==
X-Gm-Message-State: AJIora9Y+8qLsQ6/cIk9NAdCGRgIk7BjC0Pa3+FKIJYSSALI1mtyxIHB
        bd2vdtg1f/6+aXFVr60N12+wCm9Zi/3sUG2Wv84=
X-Google-Smtp-Source: AGRyM1vJKw/yP9C5iKd7pkjN3VDgsdZWKkvwP7IhLLajlnP2hqEBTSTdi+oEeefZDx825EHdVPMap1oE6Mlwu0QNnjs=
X-Received: by 2002:a05:6512:11cb:b0:47f:6906:6b94 with SMTP id
 h11-20020a05651211cb00b0047f69066b94mr377102lfr.497.1655593842288; Sat, 18
 Jun 2022 16:10:42 -0700 (PDT)
MIME-Version: 1.0
Sender: janetibrahim250@gmail.com
Received: by 2002:a05:6504:a16:0:0:0:0 with HTTP; Sat, 18 Jun 2022 16:10:41
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Sun, 19 Jun 2022 01:10:41 +0200
X-Google-Sender-Auth: 2lvlPs5IEhkgFbLgXdPwmyKKuuk
Message-ID: <CANUF9+qEOXft4zVPzFsSm7C1iKfRP97n33Z_1rsgTNs8YUseBA@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 FROM_LOCAL_NOVOWEL From: localpart has series of non-vowel
        *      letters
        *  1.0 HK_RANDOM_FROM From username looks random
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:136 listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [janetibrahim250[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [janetibrahim250[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am glad to know you, but God knows you better and he knows why he
has directed me to you at this point in time so do not be surprised at
all. My name is Mrs.Sophia Erick, a widow, i have been suffering from
ovarian cancer disease. At this moment i am about to end the race like
this because the illness has gotten to a very bad stage, without any
family members and no child. I hope that you will not expose or betray
this trust and confidence that I am about to entrust to you for the
mutual benefit of the orphans and the less privileged ones. I have
some funds I inherited from my late husband,the sum of ($11.000.000
Eleven million dollars.) deposited in the Bank. Having known my
present health status, I decided to entrust this fund to you believing
that you will utilize it the way i am going to instruct
herein.Therefore I need you to assist me and reclaim this money and
use it for Charity works, for orphanages and giving justice and help
to the poor, needy and to promote the words of God and the effort that
the house of God will be maintained says The Lord." Jeremiah
22:15-16.=E2=80=9C

It will be my great pleasure to compensate you with 35 % percent of
the total money for your personal use, 5 % percent for any expenses
that may occur during the international transfer process while 60% of
the money will go to the charity project. All I require from you is
sincerity and the ability to complete God's task without any failure.
It will be my pleasure to see that the bank has finally released and
transferred the fund into your bank account therein your country even
before I die here in the hospital, because of my present health status
everything needs to be processed rapidly as soon as possible. Please
kindly respond quickly. Thanks and God bless you,

Yours sincerely sister Mrs. Sophia Erick.
