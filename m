Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF464EA469
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiC2BHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiC2BHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:07:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3546E215
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:05:20 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c62so18932755edf.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ut6/8hZdrXD6w/oKBdhI6ASQdLFjjPrfHdMT0KxbqNc=;
        b=Q9DxsFzTxtnXUjJcNfoqSwU9EeguB7NnHpw5VATApO+dkF19Zp4ihOwcB2UAo/1JFU
         XBS5X/KlGH1I3Nd3ZFGi/X10/Th52J3+oVVGrnMvIhGTM+BF+3QPVzD3oIm27UlbYZ/F
         VmkULRI8mIf2dwmCmyugT7/pDgy3Y7iwKY+iiR3oHFjXvmDzrnFC0fJTmRQR+c+hIuOS
         wtMw+/vPD+gh1Yb5LnAMspiO7NMQVyhSnaIDD/sqf4MnH5KjpWnKS/r346A1hN7PQeh+
         dnv+3P7n1xkUY9wBdhCpL2SYJne6+/V78bhQ9yGHSSzOlm8Cc+hvDZSsf/T0srxieAmy
         KQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ut6/8hZdrXD6w/oKBdhI6ASQdLFjjPrfHdMT0KxbqNc=;
        b=xnmKAewKRky4ovVcyYj6rAytYovQsFUqSUIvFjr1pTXn4HlRHORV+e1u0FQPqAfwIN
         q7al6DNKor/OgM77PzDSWxEHJ0t8bizdWn/rOdE1jRRw6wVJh38rFK2airmqi1pm3HRJ
         NFUjLSwxnexk698VYva9J+QFG+hq8zCLP3cERhcMlJ7oBjxtUsiJg9fFq7nF5UtwGDXW
         Zw4kkjdczLzPVir192mH08O3Dx2KqDIsm7yycvvHoDxqA5K4kpytOi/Er7jyaglbe/Iz
         98LXf+4Jabckdg1ckjwX+dVDAVrBq69kfwApyJy4Fkyv9ZeHDoNk14Sxg/u9hL53wjzM
         BqUQ==
X-Gm-Message-State: AOAM533rs5+9N/MFD/v57DJ9tleNhInta0dglx4xLHkWOVfS9od0CFYD
        2x2IZ46dFZVcRbKa9nZuGGKAnyQxMdf3Kt8tufsqOo5XCk8oeA==
X-Google-Smtp-Source: ABdhPJxvJ3d/GmuzRjeOdM7wmWKMWpuGrDsteCLwFbaB+W4h9FhrTLk/XgrM3ri9JSdHR5ndo3Qxh74Ui2FQy3NPFA8=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr31129973ejc.636.1648515475429; Mon, 28
 Mar 2022 17:57:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:76b9:b0:6df:8386:dfcb with HTTP; Mon, 28 Mar 2022
 17:57:54 -0700 (PDT)
From:   TORGNY LEBENBERG <torgnylebenberg35@gmail.com>
Date:   Tue, 29 Mar 2022 01:57:54 +0100
Message-ID: <CACyUgj+ToDpgEhLK7JgEFYiYTfj_P7wgCscPQ7cQp+QK2MG8xQ@mail.gmail.com>
Subject: CONFIDENTIAL
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DEAR_FRIEND,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [torgnylebenberg35[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [torgnylebenberg35[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        *  0.0 T_US_DOLLARS_3 BODY: Mentions millions of $ ($NN,NNN,NNN.NN)
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,


I'm Dr. Torgny Lebenberg. Contacting you in regards to a Claim of
(Eighteen Million Two Hundred Thousand Dollars) $18,200,000.00
connecting you to my late client.


Kindly respond swiftly.


DR. TORGNY LEBENBERG

LEBENBERG ADVOKATBYR=C3=85 AB.

Attorney at Law; LL.M.; Partner

Address: Grev Turegatan 44, 114 38

Stockholm,Sweden.
