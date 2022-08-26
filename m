Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254E95A1D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 02:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbiHZABp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 20:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiHZABl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 20:01:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9C9C6CFB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 17:01:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s1so27460850lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc;
        bh=8nrVz3lTqqO4PD6Okgzxo8eLNO0a1VPRhWoHYRPbHnY=;
        b=fTb1DWq5db2El7VAcl9FhVGYgZvh6/1ZHZ4OPVXUMpkM/Xx1mvEsxJnPqmH9GKQMh8
         wBNlIA63POV8aj5BS7xvhBVDUaVaRtspCgFGN13D70gGQecH6eQTJZMZp+4wZyyoGmtF
         HMdQaQylfx3bqrPtkTNErOYKfCzzF6Hmtu74qlKPZ9TS8guKg4S6g3VAC1vlwq8sz3wd
         JSCUUXrs5c1pZVICFd4zvwc+awzzuf3Hivbdes/xSkKEBVykcanT42QqTXKsRJHvCB56
         LWr4F0ea8d/H5kuWXXeF+101270Y5xpYzptmHVnR48Hn8/s24ox8EDhQvq2GI3+v8FsV
         ntcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8nrVz3lTqqO4PD6Okgzxo8eLNO0a1VPRhWoHYRPbHnY=;
        b=GzrvCysvCa5cAOEXvmePLq3JXbuyRO+hOH5a2ZpK7xSCr4ldo0dHg0+wNPWeQv5oku
         ynvuK8FRMK7XsEqScWkCa0dHnvD+UA7A7Qn5cUG+sDA075XlgUBGfmuB6InqYHTwzhvX
         b+yu0Roc+R7jGfD2MrV9UIh0LQ5v+zMKohu5DR2/o3itBElEF/aBPxAXeF8PAdBKYIxN
         5DAmVutdo4HPIGxwV28NFrPwvWQqw6VwWfAIl2xdiC5HZAwv0Jbi75YuNjXXqJninCpW
         UZN9tOmV9MqGnCAyBEjuTYYDwpKaMRk6+I5xW747X+ti9c+pSOLHcjihesM6E3B0teSn
         voTQ==
X-Gm-Message-State: ACgBeo1lquNGhguzvPelKCBJ3G5QsxsT5129dDGP71KzQsFJf/eERzk3
        Vdtw0I4AhCvSy9qyEzc8gLhIaOcl7n5NPZtQkuA=
X-Google-Smtp-Source: AA6agR6cwoPxJeYclsvcwr1OuHfTj2WyrRDiL7qlav5v1oISygNMkynxxXaEi73dYlnrOcWn/00rOgwQ2lM/D9K4zDU=
X-Received: by 2002:a05:6512:1045:b0:491:f371:ad5d with SMTP id
 c5-20020a056512104500b00491f371ad5dmr1651588lfb.425.1661472098799; Thu, 25
 Aug 2022 17:01:38 -0700 (PDT)
MIME-Version: 1.0
Sender: edwardcarlos536@gmail.com
Received: by 2002:ac2:4f03:0:0:0:0:0 with HTTP; Thu, 25 Aug 2022 17:01:38
 -0700 (PDT)
From:   Hannah Wilson <hannahdavid147@gmail.com>
Date:   Fri, 26 Aug 2022 00:01:38 +0000
X-Google-Sender-Auth: L74KHt_q8ZDi6rn2giYoHCX6zn0
Message-ID: <CAFyj9jzxF4XqYrZYtgEh0MA++HPraAyt2Q2q=pvyRBqX8n-PqA@mail.gmail.com>
Subject: please i really need your urgent assistance.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5164]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hannahdavid147[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [edwardcarlos536[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please i really need your urgent assistance.

Please do not feel disturbed for contacting =C2=A0you in this regards, It
was based on the critical health condition I find mine self. =C2=A0My names
 are Mrs.Hannah Wilson David, a widow and I=E2=80=99m suffering from brain
tumor disease and this illness has gotten to a very bad stage, I
 married my husband for Ten years without any family members and no
child. =C2=A0My husband died after a brief illness that lasted for few
days.
Since the death of my husband, I decided not to remarry again, When my
late husband was alive he deposited the sum of =C2=A0($12.000.000 Million
Dollars.) with the Bank. Presently this money is still in bank. And My
 Doctor told me that I don't have much time to live because my illness
has gotten to a very bad stage, Having known my condition I  decided
to entrust over the deposited fund under your custody to take care of
the less-privileged ones therein your country or position,
which i believe that you will utilize this money the way I am going to
instruct herein.
However all I need and required from you is your sincerity and ability
to carry out the transaction successfully and fulfill my final wish in
implementing the charitable project as it requires absolute trust and
devotion without any failure and I will be glad to see that the bank
finally release and transfer the fund into your bank account in your
country even before I die here in the hospital, because my present
health condition is very critical at the moment everything needs to be
process rapidly as soon as possible.
It will be my pleasure to compensate you as my Investment
Manager/Partner with 35 % percent of the total fund for your effort in
 handling the transaction, 5 % percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country
for the mutual benefit of the orphans and the less privileges ones.
Meanwhile I am waiting for your prompt respond, if only you are
interested for further details of the transaction and execution of
this  humanitarian project for the glory and honor of God the merciful
compassionate.
May God bless you and your family.
Regards,
Mrs. Hannah Wilson David.
written from Hospital.
