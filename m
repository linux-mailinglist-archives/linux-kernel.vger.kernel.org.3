Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1BD4FAE89
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbiDJPiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiDJPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:38:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DC3FBF5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:36:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t4so12062241pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=uM+FGcsj8toEe5e+GV8hGulxG9f/x9ohvcn77yjffaQ=;
        b=IKJJyjEZHl3bVxk0jspnRGpBLwJcMEDvxw9p01KtOhjV3uVW/91ThdiWoL2WyUXa3l
         qFMlCiuuSuKmV166246C6lZRD9PF04FdvO4142uySQd5btr+MXd4bo9OWZTZ0tff2Q6w
         Fw/O6Nfr2iNOLfDV4YXXuCnSANQVL2imaCwur3qzxUeGKUgaseuDq/2aiPBRIsI2hiKN
         3w9RbgApCXk8NVFZ8J0ocWssAXQ11x9jLjeHQmDOB4jqBxZaeCShqyKqgmKmKWet3ebW
         S26xQhMfFVeDf9VXzHDoGUr8/RkMNwOTI34j5N5VKAg+CY6o68miQUZGFbwpvk6WQcE4
         jFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=uM+FGcsj8toEe5e+GV8hGulxG9f/x9ohvcn77yjffaQ=;
        b=zikunmr/13x6cqdAP1i7UoWEOZogN5cep+VMDsCh6q30NIAHx+G0ceoZ3dOlxM+uUL
         wdEuurVEK5z5c3IJT9YoeQppT4deOn5JmMXbWuH3eoryO/ncvXni+p6U8uWoxFtty7Mr
         sFUDpQNgJdA9ePU52+03ova2+7zkRQuEW5FrBFKyvSvkrmzoH/xXiDgsx1FZzrGPUvvA
         cP9hWbLPc6JsuyGhJ4ynquJagy3i6Y/aUq7tw/6CJ60ykJlluXx+vipLLY5gt5NlYTpm
         Rq79swTKawliEdA40wjNkE/JjPA5hWAxoTyLDrQJ2lsarpMM5SqLQOADyOSNM37gnYJC
         Q4Vw==
X-Gm-Message-State: AOAM531qaa6vc3T0ZR0nySnXbrqP9qlZxVwFfeYH910quWfsmZGadqX4
        P00Ntmw3LFQPomxEshIXiJMjgpJm9RrPmFGdXAg=
X-Google-Smtp-Source: ABdhPJw4mhvD16o4U2G5dpoaC1qapOF18r8ewGH9BxGr5mvbhYp02gw/4dcImzOYgkLxdvbpN5WWkH0i47R68Qk0gV8=
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id
 p15-20020a056a0026cf00b004f6fc527b6amr28738522pfw.39.1649604971887; Sun, 10
 Apr 2022 08:36:11 -0700 (PDT)
MIME-Version: 1.0
Sender: ds7410159@gmail.com
Received: by 2002:a05:7300:6411:b0:5a:fe51:f2f8 with HTTP; Sun, 10 Apr 2022
 08:36:11 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Sun, 10 Apr 2022 16:36:11 +0100
X-Google-Sender-Auth: k4oxpmZOCz8pBqFoVSfmb9RQbKA
Message-ID: <CABb8RiyC7RT4oWmQaU7P71RRT2Ap0izgJS__+ma6G0Lsj1f25w@mail.gmail.com>
Subject: OVERDUE COMPENSATION.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,LOTTO_DEPT,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ds7410159[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ds7410159[at]gmail.com]
        *  1.4 MILLION_USD BODY: Talks about millions of dollars
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.2 HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTTO_DEPT Claims Department
        *  2.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT:$10.5 MILLION USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation funds.

You are receiving this correspondence because we have finally reached
a consensus with UN, IRS and IMF that your total fund worth $10.5
Million Dollars of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$12,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $12,000 levy after you
have receive your Covid-19 Compensation total sum of $10.5 Million. We
shall proceed with the payment of your bailout grant only if you agree
to the terms and conditions stated.

Contact Dr. Mustafa Ali for more information by email on:(
mustafa.ali@rahroco.com ) Your consent in this regard would be highly
appreciated.

Regards,
Mr. Jimmy Moore.
Undersecretary General United Nations
Office of Internal Oversight-UNIOS
UN making the world a better place
http://www.un.org/sg/
