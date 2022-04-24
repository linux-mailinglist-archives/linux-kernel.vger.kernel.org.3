Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB6D50CE13
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 02:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiDXAML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 20:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiDXAMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 20:12:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A8A27FDC
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 17:09:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q20so7200050wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 17:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=k8LTYPAepyAs8B5dkmRqbsi402Tvvuo+l9byhO+DGwg=;
        b=MSWlAm9WaRYd5HBiPCAkLcqnsJjAXK1DMKFah0AZryCvtMzqLtXkFJSQTJEHytlG0D
         94EcTqw7D9F7eE77xWAzvkIju+HJ/ZctXWqS+UQtzRwp4yfwzn6SjY38aWcycXko4ZmS
         QgrHA+bIAZoK+cwsbXVIHc0EzpT7qQEb2Wc3zCB9w68ZWoCS2f4TzudwpeYEyGruoVDu
         shix0FboxHIBEapxIpxYaJM4g8hBfZEg6jw3YNfDN4KBg3Loz+YOZ47OC4GraMbT0O4Q
         nTEOWfYnOQ13IMhV82kKZBKlalsetY1eQwDB7IC8pFM9hASTo21JoglRAruao/dfq70m
         3Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=k8LTYPAepyAs8B5dkmRqbsi402Tvvuo+l9byhO+DGwg=;
        b=s6JCkbIOa6yfWbNvomXIc79Kyy3N+ESJcZckeCSxHwrCxeCCG6ZL0b0C1aI87X8lAJ
         OaPorR9D1hZxt4mIuV1+QnzI1xZWa2MVDnOxrTh3aIJZ3VhPw0UShzbgoHGLyn/+elU8
         OI4Q16pftjBHSYb/hjjY79k65OpjhBh3NzN5o5l22nY1WaHidCLgbucuVOnnG6+KlccJ
         06oAOhBMyaS8JqGSQU8TMmNIUiVHjyoEJ/1iPkO0pMvjR8pqDprI/Y9IGYJUz0bHIjzg
         w5AiRAWtpdKKTf4G+RGUgQjVJIp/q3YiJheV070VIxyUrGcnvE2t7LmpLKKY9RN01++0
         G8zA==
X-Gm-Message-State: AOAM530uBNPwYV671KkXs54lmTZ1/8CHzGPrVCtpYbP+S2IgGVzncuZ7
        PM5CTlgUVRU8kCBkqUjl6UvXm7vpkuAOA0lEarg=
X-Google-Smtp-Source: ABdhPJxIL/99chFshEHH2nqmv0T8e11O6nvDEUDfUkXkQvs/fI4ZUVNmAbO/pzbZKZa4cFCAL4tf5XYuVCKUo67gek8=
X-Received: by 2002:a1c:acc6:0:b0:38e:b184:7721 with SMTP id
 v189-20020a1cacc6000000b0038eb1847721mr10272081wme.94.1650758948080; Sat, 23
 Apr 2022 17:09:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4d10:0:0:0:0:0 with HTTP; Sat, 23 Apr 2022 17:09:07
 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Dr. Irene Lam" <confianzayrentabilidad@gmail.com>
Date:   Sat, 23 Apr 2022 17:09:07 -0700
Message-ID: <CANrrfX6SZ-3Au62P5HSbhH-eSYAsS+XbX3hf=uat71scg6b9gQ@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4637]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [confianzayrentabilidad[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
I'm Dr. Irene Lam, how are you doing hope you are in good health, the
Board director
try to reach you on phone several times Meanwhile, your number was not
connecting. before he ask me to send you an email to hear from you if
you are fine. hope to hear you are in good Health.

Sincerely.
Dr. Irene Lam.
