Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4420D4EC84B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348232AbiC3Pdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345743AbiC3Pdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:33:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1053C29D248
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:32:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o10so42323511ejd.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=k4tOjXwVcjRbwIqO75tPZMywji6NA5bvyUrV2lo9zfU=;
        b=e85UxdKS4BZVnxKxCqVcDoCgzrxm/j+/e/8Dc2W0N3fpHjcVuj50MLhObpBu47jetS
         2BHx2JirObPdfnrJViHa64PprvlhJMLgSWK+dyyH0jKZniUeFNAgVighi1fBp0lxN4ph
         J7WhoCCnotqRuj3Ojq0KQNsRE6y6LWb5J4Px0EhbNTRJpRx8tUUPwIDa29G2LX99XJ4p
         JDTmdSs1bqW02t2e76bXu5jI0jV+dJFFUexDXwNM7WwQQmUgZPhAD9aP73XzeqjcUUYa
         GqGRiAFUt7Flu23doN6YEXstVdJNO5VP67mSjmA/ec30qkEpKSCRkaIMWCQWMH0btOWv
         moXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=k4tOjXwVcjRbwIqO75tPZMywji6NA5bvyUrV2lo9zfU=;
        b=QLvwnNWonDNoPpwTj04gcfKMfquEiPD0kbwmDX23pa71oAtajo5HPru0jD6TBK4/Xa
         CYei+6sKo+xtQoSmQZXl25NNjQ0EnFlRbEDoaa4GYgDvjstScL3gBdPN9M+sRxaG70kE
         Zhe2HTmo2W5GF0TkNndQaKGtmP1Eyulv2MGKIMTXseNKBqNk7sYuBI8ws7nLmdF7JB/0
         q1YdSrMnF45U20j3LR90aRs9cZBq7w+KYDHddbK+vIv53xbo8rCmHiT7MR6m6uDEdEZn
         QnF5G04XtDnE5oDct8ySMhRny/vKcGIkCMStL57Hqem2Q6zv4atXhHozKOX6Z5Y8o46X
         5lHg==
X-Gm-Message-State: AOAM532ZYbvtB+S+Nz/iF7mo/74EoCZ+gpzCE1XaT45Ld9Br45lhIOw+
        Jk8ySjC8Z2DBvH91NBYy8wOSXr/qZPDOp0i8SIQ=
X-Google-Smtp-Source: ABdhPJyAk0LYw90cwfAbYTR5X61rJ+kRVaBDDphWO6qejUShh6096JWI/sYB6II8IToBzYBXb5rp60ruUyQkBxUvoB0=
X-Received: by 2002:a17:907:980d:b0:6d6:f910:513a with SMTP id
 ji13-20020a170907980d00b006d6f910513amr9890ejc.643.1648654322550; Wed, 30 Mar
 2022 08:32:02 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Wed, 30 Mar 2022 16:31:57 +0100
Message-ID: <CAHpNFcPv4_URbVA+TEa2QwarcagX4a56EUpvzrZNeFhE9ScWSw@mail.gmail.com>
Subject: On the subject of PSP processors : Arm features include NEON2! Why
 not use this to our advantage? if safely potentiated! Every SiMD matters
 after all, particularly preparing for the GPU & Audio output! As a driver
 specific the advantages are around 13% improved performance & 20% improved
 code flexibility on SiMD compatibility (signed RS)
To:     "Kramer, Lou" <lou.kramer@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PLING_QUERY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the subject of PSP processors : Arm features include NEON2!
Why not use this to our advantage? if safely potentiated! Every SiMD
matters after all,

Particularly preparing for the GPU & Audio output!
As a driver specific the advantages are around 13% improved
performance & 20% improved code flexibility on SiMD compatibility.

We can also directly utilize for Automated Direct Reactive Secure DMA or ADRSDMA

(signed RS)

ARM Patches 3 arte enabled! https://lkml.org/lkml/2022/3/30/977

*

GPRS for immediate use in all SFR SIM's & SFR Firmware & routers &
boxes including ADSL & Fibre

Cloudflare Kernels & VM linux, I pretty obviously would like to be
able to utilise cloudflare Kernel & Linux & cloudflare is very special
to me

Submissions for review

RS

https://drive.google.com/drive/folders/1X5fUvsXkvBU6td78uq3EdEUJ_S6iUplA?usp=sharing

https://lore.kernel.org/lkml/20220329164117.1449-1-mario.limonciello@amd.com/
