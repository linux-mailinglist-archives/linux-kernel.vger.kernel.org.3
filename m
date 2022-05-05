Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2444551CA76
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385782AbiEEUWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiEEUW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:22:28 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522E59976
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:18:46 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso61197257b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Ynjl7JlPMSHmbJMjczUFzsZQ9/4l7WVQkkKscRYy4qw=;
        b=TRZ6TufAPzf/Q7YgpopR29WbyuCkSjeZLc7nmexr5iX2Lhb/cYC2RCqWPjlcWxqg2q
         FuIncD29ZnAb++06M5ln2MsT3QG5rA6l2ttPbXBbWo+uoUYgcEUX80Wj5QtrAg75Bd0e
         v03A5Lw0jGvEO9GVT8eNz8zkmD6XGYzXMIqZa0tqDZ9SJgClMDZNqkyaEq4/PcI0n0tT
         lcjaS0jjLjWiioxrGAJf7RXzq4LgrEwbZJoyDBWodLnw8/dHGFASWBh7dTtvUQByfUW6
         y6WFqTAxmRYJTMduoiRk5Kj1J1vTcKKHBoJTfwjgKHmp/TL/224f9neYsehkjMbeOUkI
         PAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Ynjl7JlPMSHmbJMjczUFzsZQ9/4l7WVQkkKscRYy4qw=;
        b=RVqdGM22GY0kuO8J0k0OF+Ix/63C7FSTtB6IE5/IzpzgzHpN9XiXIX2Letyd8fbu4w
         aOb3d52x+I8KlvyAHXxWo0S/VjvjYlFaCjpw1WiShkm5n7YaJqNv9ZiLuxChq8Auvmf1
         h0pIEo52fQcU3yFMA9fxxu66NLaxfRldP/goVSSYb6gFw6xeEzblaznxjHnnT51+lUjx
         DG0C3AmQRDZfa+E71JTXdkcngnsl/yqZGpYrZ4P8Wg0giarSzuGtF1SjsdnxvcBqjahF
         dCaI04ZcqUw67Ge2eqig3Q3FCB5MEqPwTwOW65kmOu8EQT19sCxi6ccd1cc4iNd/8ANW
         rwQw==
X-Gm-Message-State: AOAM531yKhvDVoDn8qtJIyBkQelUxLP45Q0PuEKbPJsZDqSd32mJsc+O
        QlbLpCRmRkDWGD472B4utInKepkU04NPzd7McHs=
X-Google-Smtp-Source: ABdhPJwZJc79hbC5G+G08pAtxTO2mwzkptfpejXFNvpIqkuh8DcbJ+xQ0Y4VyVGnC8l5UKOXFY+C4fndTf9tyKa5R44=
X-Received: by 2002:a81:1b54:0:b0:2fa:f842:bd7b with SMTP id
 b81-20020a811b54000000b002faf842bd7bmr11692800ywb.170.1651781925937; Thu, 05
 May 2022 13:18:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3cd:b0:28b:e76d:8ab with HTTP; Thu, 5 May 2022
 13:18:45 -0700 (PDT)
Reply-To: biiioqq@gmail.com
From:   Rev Sister Grace <kiasskiww@gmail.com>
Date:   Fri, 6 May 2022 01:48:45 +0530
Message-ID: <CAOWny3P1eNnXfYkUbH8RSgzmcBp0wGfwQwKJbO+hyEJ6PVMrRA@mail.gmail.com>
Subject: Charity Donation.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1141 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5282]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kiasskiww[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
My Name Is Rev Sister Grace, Contact me for a Charity donation of $2.2
MILLION family support to you. Send Your Full Name & Your Phone No At:
biiioqq@gmail.com
