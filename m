Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D025A9311
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiIAJ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:26:18 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524D312AE1F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:26:17 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b128so13510718vsc.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=lSK2Psj9elc1lSMOhcFg17TXysE+aTBO+i5mVz4IQ+E=;
        b=VyLhJgEaa7U76nGC1qqM/vuyFurpkj+zHOdimq+dQYoW+rKt0uJUzd0Ve433sJ0yCZ
         ODuDIzCQCOHC95lngiz8cDflhbKLfG7JEFzhQ7cogPvKEAp4ACgkberh2Du1+BkSDLSI
         xviStqh0tOwXbKBuj1J93DgfM6n14PLZBOU58sdig6ZwL7534IPUlQF+yCkWpoLxdgzb
         sgo+kdjFy2UKw41AgvUa1Ru7ako9pGHiolQNLq0xJB15XEt8bQEDlOJyIVAYTz4NmHIh
         5I8R6oTAg6DX5d+wifLg5SPNaSmkFBf0virEyuIUg3vc3LOd1DxhfnBol5Ni9aPTfxH6
         5yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lSK2Psj9elc1lSMOhcFg17TXysE+aTBO+i5mVz4IQ+E=;
        b=FNSam/wBEkdmkNTbo2N3PbsF/7ET87QUxhRwbo+lqnPjfcN2Y1Z4EyacIXGdqvPRh/
         tDSbuIoLlJ6f40RwMbKDLNjXjXQrxNqY3o83so0q/dci+aN2qKkcmRN4ra2STiAgl3h2
         jtD1Pka6z+sf5TPP/YHHLBQ7ER8bbGFLuRxULxmpKozlrob+0mVLtMIPQ9o/Lt/9+Zkf
         ck6UXrZdTcYZpqqqxfLzzPctefTXyfu1pwD4gUHfK+pvLQfQLv7rNwtiZ4/+0Sa26Gbq
         SU8uhBOsMa3mlkkFI5nSB1PkV3yE4q5t5hQS1r9/pVc60D/GfxTDckZ1vEnTeUES5q1V
         1ysA==
X-Gm-Message-State: ACgBeo3NrZuzGOYLsmzJzCep7AwuSqNI2xdmxLCCJTLQ/rhRePvaEghi
        0w4Tjxja4i9YXg1+z5knv52vbA4rVr9iyYoBkh8=
X-Google-Smtp-Source: AA6agR4j9q1TXf1zGs+pzyexpWBL0n1e+m6Yv/+A6q//1FA50I07aBkArh4H6/Nj4BZsalgubb3WBUd8RSOOM3b4AMg=
X-Received: by 2002:a05:6102:1da:b0:390:e9ad:2b05 with SMTP id
 s26-20020a05610201da00b00390e9ad2b05mr5772267vsq.28.1662024376507; Thu, 01
 Sep 2022 02:26:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:b8c3:0:b0:2de:d5df:173a with HTTP; Thu, 1 Sep 2022
 02:26:16 -0700 (PDT)
Reply-To: vb6832716@gmail.com
From:   victoria benson <barristeralexandrakojo2987@gmail.com>
Date:   Thu, 1 Sep 2022 09:26:16 +0000
Message-ID: <CAKM58LUeMiyrdLM8KOOayjUH0mOqYebNeJvm_kRBCxQi4Aj7RA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e43 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4897]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [barristeralexandrakojo2987[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barristeralexandrakojo2987[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [vb6832716[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i am still waiting for your last message regarding my message to you.
please get back to me and tell me your interest.

Regards

 victoria
