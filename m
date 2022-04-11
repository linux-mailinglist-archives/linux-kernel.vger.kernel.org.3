Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2614F4FBBF3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346018AbiDKMYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343792AbiDKMYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:24:39 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981B3E6B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:22:25 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id t4so11247776ilo.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ywdQKX9T0UMNHIPjKCFbN7Ga7fiGoMB9jGg55mIKzSE=;
        b=kH9WDLIE4UQaty7mI9jfkWsT6BN7sffVtSv3dp8RvbzW4Dgp/9VY8r/kLg3BoxaZtx
         bVG9FrhgB+8P7VbK7kUqTtyKQToQwfslSst3n39gt6RZCmepDY+d4yPO/72BLC9v4Bvh
         Kiz/WEtG84v67TNqrXs/HM6jcvcklsBvXeLxzn4aOZgtlCQIxa078u99IlpSqW8iiFI2
         lrQHJJvX6DNXrwofYPkKusGgWj7Xu0KXnd4DzOq8Fdt9XGE0jJHgd55bP7pSXAkaW7Jm
         MXe2wQvQK/MHhDsRKQSsJRfCq1e1J+Tyd/Z1YeJlJLeanBNyLU6ZeJTJ1rjoamqyawGj
         apig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ywdQKX9T0UMNHIPjKCFbN7Ga7fiGoMB9jGg55mIKzSE=;
        b=zaZO1a4pmC1Q25v7wCKN6Wo3sJhS+lfwNFbudR1GsLJrQmRQ0UiDvkdgSAqsSu8skD
         6N7EeEUqECkKe0HeHNXbU3WGQSaRZh/XDLrrhOMKRS7cTjPwH5mLrCjNbqQh8oOHfOQ7
         dkWvp5qdoyBhqRFyRhj+YPiZ/mfxOZAwOtrrijm1wmckGc1BHLA26ByBCxv86Byqi56u
         77SRAPaAGIwattcuKitRD2yectgoLVphH/CcU+bfVSGhw/gBLYMiXyCzYTJk5X0Otmm/
         bpc5lw4bM5fd3rOikMcZxN+4P/NsvMgQMj5o0K1vRWmXdvwjIaveRj+FX0GwfJWIhxcs
         PAtQ==
X-Gm-Message-State: AOAM530CzmwzPPsvAGOICyYKssZC9OTQlEctN/69BbMiwnX96mkmlNRV
        FwoIww61SVJ0cBm0Pqo5q2ONvCF+2f6XG6FWrKQ=
X-Google-Smtp-Source: ABdhPJxwLc9d4J/VfjvXlB5WB0XbvVCneReYUiRUm4+ad6LTlVtye0aB9HxjfVrP5omgsaOEeWSvYcJLGvK0OZ3WyLc=
X-Received: by 2002:a05:6e02:19c7:b0:2ca:117e:aebd with SMTP id
 r7-20020a056e0219c700b002ca117eaebdmr14370205ill.42.1649679744548; Mon, 11
 Apr 2022 05:22:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6622:cd3:0:0:0:0 with HTTP; Mon, 11 Apr 2022 05:22:23
 -0700 (PDT)
Reply-To: rgicompanyltd1@gmail.com
From:   RGI COMPANY LTD <mgu44376@gmail.com>
Date:   Mon, 11 Apr 2022 20:22:23 +0800
Message-ID: <CAO-w0m+zGV91X9aWT530TtaPpVkRnFXjmBwrUaFWrxOLpav_TQ@mail.gmail.com>
Subject: ATTENTION REPLY URGENCY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,SUBJ_ATTENTION,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:12f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mgu44376[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rgicompanyltd1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mgu44376[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.5 SUBJ_ATTENTION ATTENTION in Subject
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attention;
RGI Genealogical investigators specializes in probate research to locate
missing funds, inherited funds and consignment around the world, we can
also help you find wills, obtain copies of certificate Recenity  a woman
from Rothschild family one of richest and famous family in the city of
Hesse Kassel Frankfurt Germany that has been suffering from(hepatocellular
of the liver) and unstable heath challenges contacted our company that we
should  contact a trustworthy business minded person who is capable to
invest her funds in alucrative business.

Our service fee  is 2% of the funds and we will be paid after you received
the funds. the funds transfer process should take just a matter of days as
we have the mechanism and expertise to get this delivery quickly,Please if
you find this letter offensive ignore it and accept our apologies,CONTACT
ME THROUGH

MY MAIL FOR MORE INFORMATION warmest Regards,
Dr Ryan1 CEO.
