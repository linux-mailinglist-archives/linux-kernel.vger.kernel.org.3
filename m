Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E8C4D03A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243998AbiCGQDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243977AbiCGQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:03:49 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C9E366B6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:02:54 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id f38so31942908ybi.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oUiS8St9u6jfbDcvn7O2xYzrVRnsblDuTr18hd0OKbY=;
        b=yknKkgg36doSZGb9bSrwwPi/ng2twjs+DjuXJ4ZenpwNzMJFZMROdi7E2liiIp8hkC
         hq/qjT6U0AvPIiqaIt7whbyh+wcdM0THyTzYXufY6GJxLvGfV00FKniLs+SqodA6XZpA
         f7bKXe9DI+xE45O8Gfy2alVuKydBPoffnPLCgCnVhc3CWDq6sGTbN/fc+93eWr42yJVC
         2aqQQ33rGSVAIbwH2LkMXG+QNoeEZNiAF0xNRCugNtWLXqubaXYFxG/kyTT3G959o/tH
         d+s1k0ob4NbaGm0Oo6R+WRup6oSu1xmNmnWDFkrV1huVhJ7cyMvXPZIJhYU6B8AzMRp6
         7FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oUiS8St9u6jfbDcvn7O2xYzrVRnsblDuTr18hd0OKbY=;
        b=BEyosr3nyJpSI0i0C1k8GQA8/QLJxlmOGv4rkFdwljPcjYqwaaoCLl+nPrdic7mrVd
         TpjtRx5R0u3hRFavAvxHXXMr145fKBJjUqcTu4to/heuBfLU7kIkODr4ookLBCJ/XMPD
         eI1PKv+g75/r5mSueBaO1I2TEJ7YZErO/YuY0aDRt6deMI5L5+zau3zyWu9qQfhODCvd
         xIngacer/RkigxsJAzVPj+8UavskCGfONjmPBBn3soiJ3fGzAiVGV36mjLMxf71AGhZF
         LQ7sLMtSbCzf6K1/M+U0Ze0Z/5cRCJ20gVGCU6Rd8/y+SCpaqsyohVqlfCx67N/Vm+ya
         6TCQ==
X-Gm-Message-State: AOAM533PYZBUepTgEHqbwm+GFYh/lthKExvLg9kvICUuJWBkvx9hb9IE
        MB0BNuIEKEQZqWwFpkSY/ww5suxIJtn4now4mAwFuw==
X-Google-Smtp-Source: ABdhPJyqM5A9UkFfdBHih/0XUOqLmHjU2A+XzqehBH1mnkInSaZgB3rPF8qGTvQxZ/UiC/DWz9MJ7QkmOYnkHHZ/gQ0=
X-Received: by 2002:a25:be05:0:b0:629:1f49:b782 with SMTP id
 h5-20020a25be05000000b006291f49b782mr6723180ybk.88.1646668972845; Mon, 07 Mar
 2022 08:02:52 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 7 Mar 2022 21:32:41 +0530
Message-ID: <CA+G9fYtGP6Mj3P4fbzTVQdtMrdN-6un+HBSXQCnkGFhpOSBLQw@mail.gmail.com>
Subject: [next] LTP mm thp04 timeouted after 15 minutes
To:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Cyril Hrubis <chrubis@suse.cz>,
        Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>
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

LTP mm thp04 timeouted after 15 minutes on Linux next-20220307 on all the
available devices.

Following two tests regressed.
    - LTP mm: thp04 (timed out after 15 minutes)
    - LTP cve : cve-2017-1000405 (timed out after 5 minutes)

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 519dd6c19986696f59847ff8bf930436ccffd9a1
  git_describe: next-20220307
  kernel-config: https://builds.tuxbuild.com/2639Ukfjo4gbqTYIT0qtQgX1a5J/config


tst_test.c:1433: TINFO: Timeout per run is 0h 15m 00s
thp03.c:76: TPASS: system didn't crash, pass.
Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
tst_test.c:1433: TINFO: Timeout per run is 0h 15m 00s
[  989.498742] kworker/dying (36) used greatest stack depth: 11352 bytes left
Test timeouted, sending SIGKILL!
tst_test.c:1479: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1480: TBROK: Test killed! (timeout?)
Summary:
passed   0
failed   0
broken   1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log [1].
LKFT test results comparision [2] & [3].

--
Linaro LKFT
https://lkft.linaro.org
[1] https://lkft.validation.linaro.org/scheduler/job/4664637#L22900
[2] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220307/testrun/8280389/suite/ltp-mm-tests/test/thp04/history/
[3] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220307/testrun/8285821/suite/ltp-cve-tests/test/cve-2017-1000405/history/
