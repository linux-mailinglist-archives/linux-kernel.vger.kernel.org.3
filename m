Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D5954E0D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376942AbiFPMbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376785AbiFPMbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:31:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7415C4D68E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:31:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bo5so1395161pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=MkSDs2I0Xm1wrVH+wDYRRDbT9A/tqna+cXYvG03fjJU=;
        b=KoxUHbyaPfAZznA3LVqvvL7cq4KzZChpLKfICejkWcuEPbrSiFn7V4M+tf1pmgMCpl
         p548ZOgjVkOU3PehDamQj9ACkC5kucxxCIwcgr6wJLwiNpc5oTb6flzoJmNThKWoAvNc
         pL41VXI6wzh3zeXleP82Sj8UtMCxzPbH+L8RuYkZv0CfVDPgT4VXsrcujsapEHSJrxgj
         d8uW4xU2+pC18uJslJNpr8/N/rwwnJ6MWnrv2ibvGDe14RejobdYSL2750NdT6oF0VmS
         1vGvfv9iT6A1Ki/sNAUYGXwMfiPnVlmIDQb/SDpYg9bY66ok+/P1wOnBjFAVRRfKL9qa
         CyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=MkSDs2I0Xm1wrVH+wDYRRDbT9A/tqna+cXYvG03fjJU=;
        b=CyLb7MkHNjtY/3E2Sx3sW5YdKlzsbyzJmbmn1xjBHAI/kxnzjU0UpSN/j4vQJDM6YE
         ZKgrlVAmybvJK6KDZ9+OpLGsU1m2Nw0DIgy9C3qQIR6bXUqxW4oIVqg14dMBNEsQ6b6J
         ovJeTcfxpA0GZ8n7UwjhRpqpLYteDCWvmeX9pjCdMh5HyJ4IDCY1mqONrwIuR956HjF+
         axDiPKL7TTG+o0MVSV3b/Z8aAzSkByJ43NvzVOeRZe2EuxL5ptwfzu4e0nKbnBRpmuwD
         UwhIdXt/XZ6Xuu+P6fK8l43DhRhcywuR7+Kz1tR/7x3Qrniz6RdlRKuC4BychcrN3HeT
         8ytw==
X-Gm-Message-State: AJIora9TPfTz4nFsmSOfJqLgXHexdh5WgvmxBZIO2KMIlhJ8DOznLtVF
        zdT3ig94U3Dw+OFsWZH7nT38gtMLj2FJsXnl+FM=
X-Google-Smtp-Source: AGRyM1sknR+hRACo6emim15nFbn1PChV7jQmSbtAQqevwKRLbKyscYCC7ExzYumjmlFFZHnQqpeS5+XT/cjdU2TtPE8=
X-Received: by 2002:a62:1dc7:0:b0:51b:a56e:35c3 with SMTP id
 d190-20020a621dc7000000b0051ba56e35c3mr4701580pfd.45.1655382673934; Thu, 16
 Jun 2022 05:31:13 -0700 (PDT)
MIME-Version: 1.0
Reply-To: waete2@aol.com
Sender: aisha.a.algadaffi@gmail.com
Received: by 2002:a05:7022:4299:b0:40:ebaa:95dc with HTTP; Thu, 16 Jun 2022
 05:31:13 -0700 (PDT)
From:   Miss Lorita George <missloritageorge@gmail.com>
Date:   Thu, 16 Jun 2022 05:31:13 -0700
X-Google-Sender-Auth: 2cS5WMzF2cCJi6H0zFbEeOieATw
Message-ID: <CAPhrBv2_YRq7aO+JWLk+NnVxOF9AFEXD4YdsgJNvkGfmb4E4sw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_USD,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42c listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6167]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [missloritageorge[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [waete2[at]aol.com]
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am with tears and sorrow in my eyes, I know this message will come
To you as a surprised but permit me of my desire to go into business
Relationship with you. My name is Miss Lorita George, 21 years old Girl
From South Sudan, My father and I escaped from our country to Burkina
Faso. At the heat of the civil war after losing my mother and two of
My senior brothers in the war.
I am here in seeking for avenue to transfer my inheritance fund of
$15.5Million United State Dollar to your position,
This fund was deposited in Turkey in Europe but I am in Africa at the
moment. Where me and my father escape to because of the heat of the
war in my country I will be waiting to hear from you for more
explanation about this transfer thanks

Miss Lorita George
