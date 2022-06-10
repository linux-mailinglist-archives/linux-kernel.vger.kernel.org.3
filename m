Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A5546CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350284AbiFJSsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350143AbiFJSsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:48:11 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB2B13F5A;
        Fri, 10 Jun 2022 11:48:10 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r82so61392ybc.13;
        Fri, 10 Jun 2022 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mdwxCbMVnUflD8KqY3kvmp5JENjUtJq9naYDesB5/DY=;
        b=MvjwXoFsiuuQnlfXAYcYyza3/fwOC6AA64ivCYSLtbU8kmqA16SxwFNwMqdW87Ww6/
         1H9KvCXqdxg3RX6GUQ9gNtceejYMUnkOeVoRXbQlnSANnag9/Pouk1A9nL5rEDnor1Ds
         AR9IwXVIhSEGJccp1EHgGrGEGSjbyDuaH5rxMVoTxZE2jFLqd5Rpmn20yZ/2aWnVxOMN
         YpXzxTl743OD5nlwTCIa3/tTA8IvPZO/3Wp8/7+F9B/fUWrKqNbXq5vBDO0+ZLFrOCF5
         VFlV820CAyUgTCQc0vqgLTDFhY7PczTzabanhhUT8dw6zEDEWGdzQoDsyeJBhoj1/g4O
         keKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mdwxCbMVnUflD8KqY3kvmp5JENjUtJq9naYDesB5/DY=;
        b=lBThHXOxzSf8SOSZqmn+cOZVNTTyDNeLKXZ89Nh3Zy7wmjTaLKS+JSZtfSfXRPYOAG
         gq9b5Zg2w5dLHQoBE/nan6AQqrpZdMqTeSq7r1i0q1W9VWhUSci75rJZ+8UkJh1p45CJ
         LFcqiDdM0iG4UYOD732MkX9LIE/e3D1hhYHZWzzNRHBxuzw2QuY79WwWH7lKhaoa3LIh
         hhwqqCsWJ9SIp6jPC3rMYTJ7MX6MV20k9lXSyMeoLiFyfEICzjlT5vhOoeUuWubgV0w3
         2s4bzGXAotxzcsC5w0PbQ6tXlxhi8BOfAnYClWSypUZ4pClegg4YBhqjH8zrKrEoK344
         ifvA==
X-Gm-Message-State: AOAM532Kp1xhVbgmLDDOEASFqbiHRJ3i6VN8QrDGzj+wgBzLOwdJ0dTQ
        QZtmfFk+I+a68+/gU6yJRe3llPRmPOcmG2/LxqxlCT6PMcI=
X-Google-Smtp-Source: ABdhPJwO2Yi8dQo4+Rvzo1c8dwfE1RnzUaj5Xk434lx3wveFj8YtiQSWwQ5kjzjpPjEzQcqR9PjrPXQbm0DFwhjR7Ks=
X-Received: by 2002:a25:76d5:0:b0:663:ad77:8d48 with SMTP id
 r204-20020a2576d5000000b00663ad778d48mr22667425ybc.633.1654886889941; Fri, 10
 Jun 2022 11:48:09 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Date:   Fri, 10 Jun 2022 20:47:58 +0200
Message-ID: <CAJZ5v0j0YHi9XURA8pU=+zAyCB7kDFCJQ9G=PhfcVMygyWaV=A@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.19-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.19-rc2

with top-most commit 67e59f8d019fb097f35c82533cc9b27bb392e5b1

 Merge branch 'pm-sysoff'

on top of commit f2906aa863381afb0015a9eb7fefad885d4e5a56

 Linux 5.19-rc1

to receive power management fixes for 5.19-rc2.

These fix an intel_idle issue introduced during the 5.16 development
cycle and two recent regressions in the system reboot/poweroff code.

Specifics:

 - Fix CPUIDLE_FLAG_IRQ_ENABLE handling in intel_idle (Peter Zijlstra).

 - Allow all platforms to use the global poweroff handler and make
   non-syscall poweroff code paths work again (Dmitry Osipenko).

Thanks!


---------------

Dmitry Osipenko (2):
      kernel/reboot: Use static handler for register_platform_power_off()
      kernel/reboot: Fix powering off using a non-syscall code paths

Peter Zijlstra (1):
      cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE

---------------

 drivers/idle/intel_idle.c | 32 +++++++++++++----
 kernel/reboot.c           | 87 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 87 insertions(+), 32 deletions(-)
