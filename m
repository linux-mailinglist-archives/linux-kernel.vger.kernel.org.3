Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468D7519384
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbiEDBee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbiEDBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:34:32 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580F920BE9
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:30:58 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f7bb893309so1054567b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 18:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dHwaVxq93hYLQygfvs2cv0JNSxw4/sjH10kGM95wEsY=;
        b=eQcBP0/2I03phLuCUByQDweNItowsdpSaXNxKGuKdb91LF5j7x23v8zrBjK6wIK3aI
         0sBMfpZxE/Y1UkQfFuiVy+KnuZKyJ5FWuW9Lq6ttWMg4Yi3OQHLh1kMQ7qGheyyzFaL5
         QVpAB/r4P0d7bBCbWDGsNYrrohInqSC14r2NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dHwaVxq93hYLQygfvs2cv0JNSxw4/sjH10kGM95wEsY=;
        b=L8vC5hgjPPG+yHswElOOY++9JJfVlcaFocDttguNzKaQ5pv7W++Zl+e98Lvsp6MWMr
         E5/Wyi2B74AD2dVmQ+pheY1EX0VX22ZslgtCBeEhmNm+Bg9oOC/RMS6zAdTnQfxsN1+S
         FH3IBp5EHF8VUiUKipI9vshDgrc0QO7WL/BoRok97rSCLwgLjeXIeY57vMLG5uQIcZZO
         mAY3T4y86isam6XjqdXqcSnHNHHBu5TQW1ww/ur48XHEMU0tSrYvFP3npOt5QQAWvoG1
         54UykAyWC42QHVWOLb6UDny6MRC0hAMthiNi82Og9pP9JUhq8mk//0a3B9TldOvhVatU
         ezpg==
X-Gm-Message-State: AOAM532keP9+yMaBQ13C9x+9Hmcvjq/gizDZZxdD9IX0EoDCNPebj1/m
        BTutt0rSJufmSNUBLtCN0v5NrIsXXz4Niq4VMBOU
X-Google-Smtp-Source: ABdhPJyTcJFbo6EqmJfVav7wCRmm1DyV/+4PX8ja/HUIDWGMqn4lxaz9XK9GiB/9KwaqmhUZx02p1Tt1nsUpSm/QaJA=
X-Received: by 2002:a81:20c1:0:b0:2f8:5dcd:91d4 with SMTP id
 g184-20020a8120c1000000b002f85dcd91d4mr17895820ywg.443.1651627857321; Tue, 03
 May 2022 18:30:57 -0700 (PDT)
MIME-Version: 1.0
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 3 May 2022 18:30:46 -0700
Message-ID: <CAOnJCUKjSCrRNT4841MzO3vWmYszX5CSmvtPoRLydzG7FFm7kA@mail.gmail.com>
Subject: CFP open for RISC-V MC at Linux Plumbers Conference 2022
To:     linux-riscv <linux-riscv@lists.infradead.org>,
        OpenSBI <opensbi@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        RISC-V SW Dev <sw-dev@groups.riscv.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CFP for topic proposals for the RISC-V micro conference[1] is open now.
Please submit your proposal before it's too late!

Here is the announcement[2].
https://lpc.events/blog/2022/index.php/2022/02/04/cfp-open-microconferences/

The Linux plumbers event will be both in person and remote
(hybrid)virtual this year. More details can be found here [3].

[1] https://lpc.events/event/16/contributions/1148/
[2] https://lpc.events/blog/2022/index.php/2022/02/04/cfp-open-microconferences/
[3] https://lpc.events/

-- 
Regards,
Atish
