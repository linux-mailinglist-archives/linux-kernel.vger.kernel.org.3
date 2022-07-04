Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FED8564B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiGDBtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGDBtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:49:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8102261B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:49:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id g7so2879413pfb.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 18:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=XxBZA59So0r/h/Go65thHlllfBhn0L6kg84VpITqqgg=;
        b=kaRnvBkrr/i+tbKfMfIr7Rsh2faNg1PujdTfruswBkT7QbkrbmvXp+eR2kP1f4OeBx
         2OmOo+j8yVHgHbq43Z4OG7E987Ehp0+rnn9zxjZftRJkuKYMB+gDn7/205z8B5RbHy8s
         GHDPKvwj5MSrSuTjUaLBSeqXjdTy3Vcg8D4LA8gYSOQKtU/jQzRDpO/R8MQMlLlR/7JA
         eOfEmPMTczS37bYKB/D+l9Uq1RD5qaFM3IuByBt+MPlQ/rCddaGzSRz/CUCWHJIV9dlI
         5RyJdazX+GDRcA9F61MApKbxWJKjCk8wxyaT2D+7xa9Ss3EwGuaVmwjs2Fc5z2llQTLT
         st0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=XxBZA59So0r/h/Go65thHlllfBhn0L6kg84VpITqqgg=;
        b=Y58RKpGU+N0j30pybayMox0cHkvk6lmfVczUGqTtNEVxgb5G53SbXf4NIRyKBGph2b
         jvVOss0W9fyWg1STXxrW+qbtILjwevgx9jE4lqXU+GV0fb9NojJb04PAOoim50Qd+N8Q
         LOA8fduK/f6JrUAxA7wKIWq7i46kFPA9EIyZjlVQDRce6bsyaGPKpcndCqekoGHPmSY4
         KLUMf75rFMQf5eHIgNcBtyav7Ji8Mo9HHehnA2hCosRI6ItiwXshfEYcAh3Mpe8qxGK7
         FKcOauI1fNcfKb4c856PVLkjSxKP1pCtys6p8QWGi4Dz/rLnBq57DHJUiDq4Lmf5Qw6a
         MMZg==
X-Gm-Message-State: AJIora8nybBVMERrlS5egg5T89tgW3Bgd7IF3q8kLcqtriD9zZjqQQgy
        1qmeUd3nu17tNdbPNyAi4wCQBceUKPi47C4FCUg=
X-Google-Smtp-Source: AGRyM1vPoUkE+7yNTQvO5wAWyIL0GNuYWCfwmkGVRSAVnlSy4SSY3r5F9FEQ8PtXZGOqL8AoqaEN+2SaaFlHZ38vqlk=
X-Received: by 2002:a63:80c8:0:b0:411:73dd:809b with SMTP id
 j191-20020a6380c8000000b0041173dd809bmr22891207pgd.441.1656899377727; Sun, 03
 Jul 2022 18:49:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:b586:b0:16b:ca79:894f with HTTP; Sun, 3 Jul 2022
 18:49:37 -0700 (PDT)
Reply-To: si1470267@gmail.com
From:   Svetlana Ivanovna <diaz22233@gmail.com>
Date:   Sun, 3 Jul 2022 18:49:37 -0700
Message-ID: <CA+ZjDkwoDuM=NZ8SxnsjLenvECQF6X29cchhZA_4Ew+6f1Cc0Q@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [diaz22233[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [diaz22233[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [si1470267[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings
I wish you a great week ahead. My name is Mrs. Svetlana I want to
donate the sum 3.9m U.S to you, I wish through you it will get to the
indigents. confirm if you received my email for more details.
Regards
Svetlana
