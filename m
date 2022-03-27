Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DDE4E8809
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiC0OU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiC0OUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 10:20:53 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C361CB2F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 07:19:15 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b188so13099948oia.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=neuyDQ5zgEB128dTEvbS08LneRx7F0DDjfqxFh3NVTU=;
        b=ERAKJaiTMsrEeDkU22DZw0YCZJhrgwH68ut7YyTHKB9QRLKbP7GAvI5OHe06zZqUOJ
         oWg4JLnh/PWO4lnX4Xs9lOByIBdVXgCrzbxxUnZQlVZBesiMiOGZR9jsF7ojDpscAYbe
         bz5zpBhQytVOjVhQp8xzGTGzOKS8qCVcZRiNglk5jO9EwxlADn8ZFp1zw6cvFw73GAPb
         /kFcqaaEZQ+fy7d8nds77YCcICRI6TNqN4mSG7EaoYEZJGyz/Krxk3RzS2KR30DI0lJi
         4N4fS+/tzoB+1bFdiEb1dYeTlv+YuAW7YYHxOuBY2vDMTeBWO0qxWhFhPdS8xP19rCiN
         eNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=neuyDQ5zgEB128dTEvbS08LneRx7F0DDjfqxFh3NVTU=;
        b=bC8WfS6W9ZtbnZePlDhl/Ol/aR1uFW/g0vRJ1fAFZ48q85JnJjUy6FQ9Qb19hBL2A7
         WgHqF0VfgHCykUjWcFwUAnDnKQVYt8TTlRULB8FMBlaFK3Lt50VJ0RV8YjxuwLbDp9E7
         LKQ1QuDs7VJz7061zGd5XbVFGhzOwENBW+/GyHohhSexAO26DO8lrl8DReoyORD1dPIc
         YuYXreSJiP1hb5b2gFdgW7yCNBlLVGXdQWeiYXxYNfOnNjS15ZzRRmdr5QWzk9yCKW5g
         5W66mBk/nvWTmKHAbhhQr0XTMgHMzU83DmbdynEDwqS32u85YaitYScuhXqZcCs0loYY
         ZH/A==
X-Gm-Message-State: AOAM5318BXnDpCXlH8W/GR/zbsemCbiWKPf/L2SjcN4OiDqCxAD05cvd
        XL4apsy2md0hxogNVWazgXEVWZaa9e01i+a8ux0=
X-Google-Smtp-Source: ABdhPJzAR0AYbuLWNtAaGT52z2XGiP5TRb/X7NZ0SohB6OlsWklC9Il569nv6QIsnivPfNrDA1pkrkC203xR6Ofpy/4=
X-Received: by 2002:aca:90c:0:b0:2ec:f120:c705 with SMTP id
 12-20020aca090c000000b002ecf120c705mr14368675oij.46.1648390755044; Sun, 27
 Mar 2022 07:19:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:d134:0:0:0:0:0 with HTTP; Sun, 27 Mar 2022 07:19:14
 -0700 (PDT)
From:   Frank Hughes <vgcxdd1@gmail.com>
Date:   Sun, 27 Mar 2022 07:19:14 -0700
Message-ID: <CAEXCZNMY7Z5PAZZuvpJYhXspRwUhe2JaiYwQfLNpWO5F8ocOzg@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_US_DOLLARS_3,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5073]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  1.0 HK_RANDOM_FROM From username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [vgcxdd1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [vgcxdd1[at]gmail.com]
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
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm Frank Hughes. a former commander during the United States guard in
Afghanistan. Now that the United States has completed its mission in
Afghanistan, I am currently in Syria for more assignments but will
soon be assigned to the Joint Multinational Readiness Center (JMRC),

During my 6 years here in Afghanistan, I was able to make the sum of
$25,000,000.00 Million Dollars. This money came from oil deals.
Second, I'm a uniformed person and I can't parry with that amount, so
I have to present someone as my foreign partner. I am an American and
an intelligence officer. I have 100% authentic means of shipping the
money through a diplomatic shipping company. I just need your
acceptance and everything is ready.I will give you more details when I
get your reply.
