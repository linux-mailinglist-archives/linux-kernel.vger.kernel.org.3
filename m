Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF4C522132
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345151AbiEJQby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbiEJQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:31:53 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C437A19FF44
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:27:55 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y74so17418329vsy.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=boZL8sxWa4d1tSO8Vkf2XAGcnSBFA0JviefhzZinYdg=;
        b=KDF1He1c5sLhvvWUW66vUY3RmoJmmjhK9ElTvjhzRIiqCp2gfzbr153aX9AyqgesJQ
         U/R5M+5pTy5O54PulHsR/QyyzObePMgpIDaIcaEdoxAHVkel91AIligS5Nfffozt3DRT
         q16DIkoXiPUohxsKfHUTdBtX8cjg8ZQm3W2K6KhmOmu2RXNFwk3PutLppyQR+bR/DYO/
         2HFonhrieeFt9pPD8OtkFvNtjsIdrjbn/9BHxN2riXjvOmLnui8l/WyeEj9MEHR2E6U7
         cWhElxdUdOWOvxD8ri1HH8jnIybKsNTeKQKvYiiSuephf3UlJjSonTdpaR6jqzM9+52o
         4evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=boZL8sxWa4d1tSO8Vkf2XAGcnSBFA0JviefhzZinYdg=;
        b=j+5NGV7ZJnie+Qbiw6nqdW+LYqScZvuMMvSa2kioj8aVTFNUjLYSAVgG5p6IzLkO4o
         mWMWfA/T4gseDxC1u1Bo8MRDUlRa4Om02IKdINtBQE6TgF8nXT5mswCjbMFc1p1eACu3
         GlTirAKEZMPP80xSbhH5P26LSZFAa/zw8ka156whFvGYjWpftiVc/ujpW5w0cVuP1LpB
         vKtiYG6NXjfxDUjH9DiTjdGDm80XVJOtoQRx4fSfr6dSEzRAufcKk0tLPEesKcHAOgVU
         3vEZCF33aEWNDBeTIAQDDomVGBA+tKPY5lTpKxtHiWHl1oN0Xv4uw3Bbai5WatSev4At
         4BSg==
X-Gm-Message-State: AOAM530f2Fc8XflSigEs4OZgH6WKDaZoBr8BG9auk4tpgCc4Jnxoq0uo
        PTSjZ2O90bLlMhkR5gcn+nIz71uvOPDFL7s5tu0=
X-Google-Smtp-Source: ABdhPJznGt5Pq4eJVungm/mp21hIFPSZQao4WqYrobvZsHU1JwxAqJpVJBRadOz9tA+UYpGIRlFfCzBbaAARoGp/LLY=
X-Received: by 2002:a05:6102:15a6:b0:331:ea03:69a6 with SMTP id
 g38-20020a05610215a600b00331ea0369a6mr7030126vsv.41.1652200074687; Tue, 10
 May 2022 09:27:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: azzedineguessous1@gmail.com
Sender: princessangelbasham2001@gmail.com
Received: by 2002:a1f:7207:0:0:0:0:0 with HTTP; Tue, 10 May 2022 09:27:53
 -0700 (PDT)
From:   "Mr.Azzedine Guessous" <azzedineguessous1@gmail.com>
Date:   Tue, 10 May 2022 09:27:53 -0700
X-Google-Sender-Auth: MZSB2FDUeWoBkQenB6o-zqQGaIs
Message-ID: <CAA_LgCa3+cZGjBVZX7UhV9ub1xYjvXSjGtqy=pBhD2KVSCepCQ@mail.gmail.com>
Subject: VERY VERY URGENT,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_FM_MR_MRS,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,NA_DOLLARS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5183]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [azzedineguessous1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [princessangelbasham2001[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [princessangelbasham2001[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.5 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good days to you

Please kindly accept my apology for sending you this email without
your consent i am Mr.Azzedine Guessous,The director in charge of
auditing and accounting section of Bank Of Africa Ouagadougou
Burkina-Faso in West Africa, I am writing to request your assistance
to transfer the sum of ( $18.6 Million US DOLLARS) feel free to
contact me here (azzedineguessous1@gmail.com) for more clarifications
if you are really interested in my proposal Have a nice day

Mr.Azzedine Guessous
