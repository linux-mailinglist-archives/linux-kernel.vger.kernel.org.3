Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9E24C2829
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiBXJeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiBXJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:51 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47D6279912
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:33:21 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d17so1411433pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=uGKq58V3gxYUKFtQZRdwKaWzXyqF0DUlv4Zwkq/SlR8=;
        b=NpJJwHFwezULevW3lMWM2pinE8pk/epL09fjtjQFCsp316hFRgc7pKq3BwEkwTOjG2
         a71B7/eHoW07obcm96PaibgqPHdMwv88l4cjdU2cs4z4xp9VgIBeNwMGP/g7t/DoGKTu
         zlruP47c+RyLrm0YYefpODWVoWoe4eh+hqB+QUOZDwkN3COq/Fllvw2t3IX5PfmG/rA3
         HR6+g5myThA1+1lBR4S85RWQnAsSV1rh8+Nwp7U7o7Ix6EcqkULOlhBNt0QdPripP+Es
         4uShhKwyVVSJIy/AQLrC316UPdvP1yAn9tNJpgu+wZG4Lx9m1vzEYPUKSBxAGMJY8HZ5
         26dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=uGKq58V3gxYUKFtQZRdwKaWzXyqF0DUlv4Zwkq/SlR8=;
        b=jgX3JsuAVtH1s2EIJrLxtes0i5PU9zs1BaJAxIWPgWXu9x2zjgqIYumqzdvw66fWvQ
         gq56gp+nvjWv22NByA0Sz74DzvFo06prICO7CkIg0I4tb5VOQSfSG5Axwil0hazsp3TX
         iPKOFK0FzI5UwW7+nPNG7O0EaAOPClD8t20QjcsH3spkIxkVNm6G+os6ZILmymW4bFK8
         DT1Ra6X2pRf3IGEY12vmEU33tm4Orb7esWEiPCCZn+pDYHfsS+JMwXzasfU0ES7GdRNc
         UDkjiVmtDcYuDeglFHMgPAiCi/bK2vzLiDZ+mjlzCyMsmvhCJEWDmNNPdbb0PEW1SVRL
         dcSw==
X-Gm-Message-State: AOAM532vCe55EQCdFNQTWrz9v9hRuvnbJkbHLrcoTqcRgylAHZLuwi1E
        sYAYJnnvhQ5AudTFpjVv1ZMWvX/pMVxtpaVgVz0=
X-Google-Smtp-Source: ABdhPJwdKDZrVSffdSzEt6BdsONC5042lUxNhhyE0sJ0vgt7foZBqnYaMLWsshBCPkpHGVZvP/Te7eagR6uanPF6h4E=
X-Received: by 2002:a63:5959:0:b0:35e:ae24:7935 with SMTP id
 j25-20020a635959000000b0035eae247935mr1627909pgm.120.1645695201280; Thu, 24
 Feb 2022 01:33:21 -0800 (PST)
MIME-Version: 1.0
Sender: deepakpriyanka54@gmail.com
Received: by 2002:a17:90a:6c62:0:0:0:0 with HTTP; Thu, 24 Feb 2022 01:33:20
 -0800 (PST)
From:   Mrs Aisha Gaddafi <aisha0gaddafix@gmail.com>
Date:   Thu, 24 Feb 2022 01:33:20 -0800
X-Google-Sender-Auth: K7AY5hP7fL0pm26kH2vC_X3kC-E
Message-ID: <CAPakwwmcimOmN61JnENG5HzGjpWpxRxr5N8HuLhKttmxoUSzfg@mail.gmail.com>
Subject: Assalamu Alaikum
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7070]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:442 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [deepakpriyanka54[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aisha0gaddafix[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.3 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assalamu Alaikum Dear Friend,

May i use this medium to open a mutual communication with you seeking
your acceptance towards investing in your country under your
management as my partner, My name is Aisha Al-Qaddafi and presently
living in Oman as a refugee with my three children, i am a Widow and
single Mother with three Children, the only biological Daughter of
late Libyan President (Late Colonel Muammar Al-Qaddafi) and presently
i am under political asylum protection by Omani Government, However, I
have funds worth "Twenty Seven Million Five Hundred Thousand United
State Dollars" $27.500.000.00 US Dollars deposited in the bank which i
want to entrust on you for investment project in your country or your
company.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits, If you are
willing to handle this project on my behalf, kindly reply to me
urgently to enable me to provide you with more information about the
investment funds, I shall appreciate your urgent response.

Warmest regards
Mrs Aisha Al-Qaddafi
