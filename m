Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF929591BEF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiHMQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiHMQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:11:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4CDE033
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:11:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bv3so4193328wrb.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=t6OYJHm7dEyPfeg2YDBcfa2L/+S6vBgF8Q5R1bDfTgo=;
        b=AmZ65knTsxX57Yk6FuljpTeAej2f8Etqub75x1SEFz2DE7YyJzO7Ldlt+uJGvpdDTf
         yyo3YVbt3WXdJggvdG+aE9zRKDG9UL0Dn0TmhD3CEc72DCVVyYnq8OSsnE9rqHYV2fws
         ws9Ei5wuTNw9e2wandAMG+15vz9o5kf2UL5xITKoxoIcicGEH4L7uYPUSmn4OWJSjCco
         8xO2dBbGvs+sYbZOVrwNFb0wbeDNG5GCoFbmbhub3PnTcFwXSaLrGxle4/JLDXYkkpVh
         QW21CY84Ch888QQ0cq2fh49gdTevJBOhkVZnDfswMMQcU50wO9Ww4yz2iqnS9NHjnFyB
         QsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=t6OYJHm7dEyPfeg2YDBcfa2L/+S6vBgF8Q5R1bDfTgo=;
        b=b5eVjn6lIsIxlgGbqJHso7xHvc1p6Pz2vXUUbhJaOWg4wwOVHj8AKORVEVczY6D7K8
         0IKMDSL5J+OZ9XdSawhgP7UeJKsFsyCwsi9BRw+KShTqle/ICiAwmdpI7iRuiGdKHWrF
         x/0MBmK1j95PD+glmEW8llEgK+J5ggqtI0IwOaR3lXFrwXdDJzLQlxLwPG3EmiBWeoLP
         lXJkUT1uVwwagAPTntVHJI3gRyNaUbhhViKHxfMxzPOYt/5c+5l/EowQoMHqeLPZxlME
         wUQD8c0p13pVU7Hgyv+fGc+bnAAhhy57T+83ZhvCrw28+MG2Y4BP/q6W9PaLFIm3dTff
         zB/A==
X-Gm-Message-State: ACgBeo0lCPvYGkvj6Wzqau+SNtqvk4AScIxp4NaAM6wBNfZzmnOx6Oct
        UU0+NuHxvums1oj0fsyQ7+dB4ZaAUYJoxfxtois=
X-Google-Smtp-Source: AA6agR6R9LZHnff2ry9kQ84amXruwmFKAE9IXPJ3BvZT/amy1aisH+nKKkh43fL5h3xIcmAvaLxH037NEkt22CrepwI=
X-Received: by 2002:a5d:64e4:0:b0:222:d4da:c2e1 with SMTP id
 g4-20020a5d64e4000000b00222d4dac2e1mr4805977wri.15.1660407076032; Sat, 13 Aug
 2022 09:11:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:50c6:0:0:0:0:0 with HTTP; Sat, 13 Aug 2022 09:11:15
 -0700 (PDT)
From:   Sulley Mohammed <sulleym1979@gmail.com>
Date:   Sat, 13 Aug 2022 18:11:15 +0200
Message-ID: <CAFHUsO8K5ZVCAYighwmp+LyAM83AnRLGr1xOJ0yxjysx8bkKFw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,HK_SCAM,
        LOTS_OF_MONEY,LOTTO_DEPT,MONEY_FRAUD_3,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:433 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sulleym1979[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sulleym1979[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 HK_SCAM No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 LOTTO_DEPT Claims Department
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.7 MONEY_FRAUD_3 Lots of money and several fraud phrases
        *  0.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SANTANDER BANK COMPENSATION UNIT, IN AFFILIATION WITH THE UNITED NATION.
Your compensation fund of 1.1 million dollars is ready for payment
contact me on my private email for more details. (
david.harden.chantal@gmail.com ) Thanks
