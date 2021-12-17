Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9F47810C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhLQACF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhLQACE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:02:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FFEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:02:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gj24so666057pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HoEmWCeaV3+JcZpzugEikDN9T8oUBh6SfZbRgdgaEYk=;
        b=fffocz+mBU4q15x8ponObDiesttbNrB3XEh07FGCXOYNdoR8YfnPlHIgRaV8tJ1cKb
         W/ECtvrhp2XlqqG7n9f+iVL86+JLB3yAZO15D/sKO9WHnXIZIktw94TEX4gSKUpXuj4j
         bpeiAwKO6PSwTdQ42aNKno5Dokq0mzA6MjhsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HoEmWCeaV3+JcZpzugEikDN9T8oUBh6SfZbRgdgaEYk=;
        b=4mngsb1rJdCEWryy1vWuvGODoSPOpDCAh8OMW1KO1BoZAVyK7UM875myjC9+NAbyKs
         Z0pzOXO6GhDrheAuVxlGrB9vE7rpGqJGYWwUIMStiFSwkorBGURO55yux5tNwmTQ7G1A
         dnW0gLo5877k9n4oqr1zbqkCZu/qsQe54uNiHmhV4FKM5N8yFMBzWkrHaLBtpGrPiG1u
         MpQXqyKp1ijfarg+z+sp3Vrm64wX4BIvbe2e+Tu79eihnOmqByS/+xKKu29aPNxQmIIY
         Q55kJ8D9LxCPZZ9rxFeZO21cHqYmAQSiHPSv/Z3xhHbkcWa+qjo2TnXSzhy4YjxcWiDG
         UdNQ==
X-Gm-Message-State: AOAM530gg2JBFPkVviGq/DSi/AcfWUp8SXIBcESMLEO4rJwDUfddmQvN
        VODSWH/OXZCihuxVxPvV10Bv6Q==
X-Google-Smtp-Source: ABdhPJwcif+T721FsMDsb4elEnf+kcz4eQkumBbLqFTCQrzCJ2bKzmhB3EIC8j+LyG5EBuK/CHGC9g==
X-Received: by 2002:a17:902:6904:b0:148:a2e7:fb6b with SMTP id j4-20020a170902690400b00148a2e7fb6bmr252490plk.172.1639699324155;
        Thu, 16 Dec 2021 16:02:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p188sm7067547pfg.102.2021.12.16.16.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:02:03 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:02:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] lkdtm updates for -next
Message-ID: <202112161601.DB11DD9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull these lkdtm updates for -next.

Thanks!

-Kees

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lkdtm-v5.17-rc1

for you to fetch changes up to 90091c367e74d5b58d9ebe979cc363f7468f58d3:

  selftest/lkdtm: Skip stack-entropy test if lkdtm is not available (2021-12-16 15:54:38 -0800)

----------------------------------------------------------------
lkdtm updates for v5.17-rc1

- Fix printk() usage during recursion (Ard Biesheuvel)
- Fix rodata section to actually have contents (Christophe Leroy)
- Add notes about lkdtm_kernel_info usage (Kees Cook)
- Avoid stack-entropy selftest when LKDTM is disabled (Misono Tomohiro)

----------------------------------------------------------------
Ard Biesheuvel (1):
      lkdtm: avoid printk() in recursive_loop()

Christophe Leroy (1):
      lkdtm: Fix content of section containing lkdtm_rodata_do_nothing()

Kees Cook (1):
      lkdtm: Note that lkdtm_kernel_info should be removed in the future

Misono Tomohiro (1):
      selftest/lkdtm: Skip stack-entropy test if lkdtm is not available

 drivers/misc/lkdtm/Makefile                    |  2 +-
 drivers/misc/lkdtm/bugs.c                      | 16 +++++++++-------
 drivers/misc/lkdtm/core.c                      |  6 +++++-
 tools/testing/selftests/lkdtm/stack-entropy.sh | 16 +++++++++++++++-
 4 files changed, 30 insertions(+), 10 deletions(-)

-- 
Kees Cook
