Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0266D58275A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiG0NEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiG0NEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:04:46 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD622BCB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:04:46 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id x125so16522999vsb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pWru1kOrmOdDwj/NW5CsqDdi/shLqio0EDZEA18dZ7Q=;
        b=fVToOC8ovxsrrBaaRnn+Kj8YC9JmGYQ6tMadFb9uvv7XPkXVQn2HJbx7yj8RBI0Nt9
         XhmAmL+ibh+pf9lPmrSk7eB+E7JAps85ZKVfY7aT5sBmi1X6evwKbeT8awU1Y5mgPnPI
         mWPHPWRqX2Lz/ndyGWIbVrJgxc6j3imoySyLLvAfrbsEoRIgF5bxqND2/YsiMgIk4tv0
         DiABPjF9elIjbKQz+AT7SIrladHVk1CKbsK1Ij2qFmg29+epzj0UBFVg5KDylW2yRa1l
         24aXZNM5RNyllnRu2Lj70duquL5jZC2x8DgBa9rBBIJR67LTtfJ59Hlf4IpHtOY0or8p
         FhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pWru1kOrmOdDwj/NW5CsqDdi/shLqio0EDZEA18dZ7Q=;
        b=iK0tYcCMrTYKmYCafE8ar01H7tUhWpQr8rxYnxW/2v47fupb8bHtNfVFxwu6jqdDTj
         dE9PYacr2N0xBx7FD9fmY9KuarqraxD9fEzdIKuPPGAgat7yoUu3oFHlSk9l5+dlpOE0
         hvV6gkp6g/8UKW/4sTPSEbtnfDQzjm0dljkC4V1nMjOu5kpOZm25YMWQjz+icLR57M07
         ShDSJU5XUFBtU6aWsCE/gdoTcSzAwxpeYOysU/1katZWkgDb+Y6DKxJ9RTsEU6pXBoLU
         nBmyGgnw0YYMhEoJdx6M8JWqM6iXfEuDQa44ESUMYAwOYOhv5LSuBreDgEfys5aqL0RJ
         1lHg==
X-Gm-Message-State: AJIora/xf3gnA2gbYmWf8HTtCRN/1AQ+QlHTDhdKNS6Vya2T2c2sLeGQ
        IuNd0woYmk+OUePYqV/rvmhr9l5q4IEYNAbQUds=
X-Google-Smtp-Source: AGRyM1tYVY61S/ETb/IvXUEsG/yIkzQzP0f58Ln39w2Bb4t7HSfFs/ITURFOeiJELPB4ZzvvZheGqGa1MHRkSMswNbk=
X-Received: by 2002:a67:e15c:0:b0:358:4555:fcd0 with SMTP id
 o28-20020a67e15c000000b003584555fcd0mr6965161vsl.77.1658927079726; Wed, 27
 Jul 2022 06:04:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:a726:0:b0:2d5:c8e7:a572 with HTTP; Wed, 27 Jul 2022
 06:04:39 -0700 (PDT)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <lawyerokonesq@gmail.com>
Date:   Wed, 27 Jul 2022 13:04:39 +0000
Message-ID: <CAHuN8_Rrr_XOfWqek+yLpFnTN8+jtCc=M03mGzkyYnbpVMkr=Q@mail.gmail.com>
Subject: Please response back to me.................
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,YOU_INHERIT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e33 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lawyerokonesq[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kl145177[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.5 YOU_INHERIT Discussing your inheritance
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My greetings, best wishes to you and your family. I am still surprised
why you decided to abandon your family inheritance fund I just want to
inform you that the bank authority is not happy about it.

Yours sincerely,
L. Ken
