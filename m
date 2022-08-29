Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DBF5A57AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiH2XhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH2XhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:37:09 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073D880B75
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:37:09 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-11eb8b133fbso8587865fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=iu9zOIfcAiwsap/E8pMtyBJaF8QmCNfsoafx3EaWXyY=;
        b=KcIu4g59E9ps6gEJTRg3MyVDNkvLsqfqRcG3L/YN9XqeFukJvqymakqMwsaZT/tAts
         2YJbqXykkWxUbtba6LEeBy1A+bHtVzyj47QVi0c7P/nwkg9Caz7ENmC5C4qezEBMizye
         Pigx2wAPr7+6gWZC5cwGGz5gLFYhukbSLu/pmm5sh41Fu1GPZjHvbZ8rSKE0vYYFS6bl
         9tjrzTjFNNhbp2r1jPioLuhWrem+Atj4luOIWuc+rR+shfWmHKlQcQU+5TBwBLsFPbhq
         e8xB7+v5ZpPHeiSXTj3Ew9yRto3bhidyUrenKNlIyonUtabZW5HJJ3eH6LjgYRDBRmFi
         i+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=iu9zOIfcAiwsap/E8pMtyBJaF8QmCNfsoafx3EaWXyY=;
        b=Ik4lkguFOraJHJ3ErX45G528VjKamGw3OL8EeROW4jQqQDHz1jYHSJQPA1yWQ0ZTo+
         Z/cMIjRMmEhEaE552aZKpb96JzAsjpGt3bI45sAKcCNILV7F9UPW+TSf3RYF8Qs+/MpS
         LiNWoNzFOOL4I9eK0cd0tRCrYdW1PNaYNT2eA0FB+GQO8xrJj4sU1Ok2+HduhSG4cqFt
         1M9++Hf/qf5htDkOtt2VhwfvfOZhtmQ5hRg4CrSn1ML+08DKJt4stbATDzmXTXFPhydM
         ffSPJ4BUz+CwG6VTEVHq0RXQqWj1fJBeJXAp/5Y75QWxW1bcPmWCXK8LNxa1Zo3+9lFT
         yjKA==
X-Gm-Message-State: ACgBeo0vDZF3iKr3WxguUGVHhZYQjQdkMdXB+9j0JoU7uW4uuaonVQ7X
        wwhkx8fzehYY0w3O05rTclagjZXM0LVpxv8Hzho=
X-Google-Smtp-Source: AA6agR5mApOc6+nFQpVQz3C85IuopKStCRBREcwaUb2G65DzupCoXp6DbINzkurS5d7khOjdNY+DGEZST9sdGm3y7Ms=
X-Received: by 2002:a05:6808:1444:b0:344:f010:27d8 with SMTP id
 x4-20020a056808144400b00344f01027d8mr8183392oiv.33.1661816228236; Mon, 29 Aug
 2022 16:37:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:acd:0:0:0:0:0 with HTTP; Mon, 29 Aug 2022 16:37:07 -0700 (PDT)
Reply-To: fileconlot@gmail.com
From:   Gilbert <filelotcon@gmail.com>
Date:   Tue, 30 Aug 2022 00:37:07 +0100
Message-ID: <CAM-eAnmwMyqOLZVeOO3kbniEaj_m8eUAP5we_d4qg6Pxu0D=HQ@mail.gmail.com>
Subject: Letter of intent! and Please Read!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5649]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [filelotcon[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir/Ma,

Are you in need of a business or personal loan? Or is your business
struggling due to covid 19 pandemic, we are offering easy loans to
meet your needs, our funding and loans have repayment plans of 10 to
25 years' time for new and existing businesses, housing projects, and
individual financing.

We are willing to finance your request no matter where you are
stationed or located, our financing is global once you're willing to
meet the process and conditions. Your request will be processed and
sent to your account within 24 hours after the process is completed.

Kindly contact us in order for us to direct you to our procurement
officer, If you are interested.

Thank you in advance as we hope to meet your demand irrespective of
the volume in need.


Thanks & Regards
Mr. Gilbert.
