Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741B451DCAD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443261AbiEFQDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiEFQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:03:35 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14906D395
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:59:50 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwHm1JRczMq1Nh;
        Fri,  6 May 2022 17:59:48 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwHk75KxzlhMCD;
        Fri,  6 May 2022 17:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651852788;
        bh=FwUwTwzNw2dY+saQkKbv3eld/gA2PBZH+qVRfKX7BmU=;
        h=From:To:Cc:Subject:Date:From;
        b=Fdc+tWYWQRrB5aMc7U/wG0siD98Nv3TUSDtvtOo4mTLZvot4crKa4jYp5Y4hXOT6c
         7fW0rGzo88MBE/C5vxXLcGAHxemlisMT05anG63iPZbzswiAMI/HpkthTXAVO0+7PK
         PMscO48OTnoQwWmz3X6BLlYyTP1bZsOdkcG6Q8Ds=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 0/5] Fix clang-format configuration according to checkpatch.pl
Date:   Fri,  6 May 2022 18:01:01 +0200
Message-Id: <20220506160106.522341-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series brings some improvements to the clang-format configuration
to make it compatible with the checkpatch.pl rules:
https://lore.kernel.org/r/8b6b252b-47a6-9d52-f0bd-10d3bc4ad244@digikod.net

I also found that the for_each issue has already been talk about here:
https://lore.kernel.org/lkml/CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com/

I use these changes for Landlock.

This is based on v5.18-rc5.

Previous version:
https://lore.kernel.org/r/20220412153906.428179-1-mic@digikod.net

Regards,

Mickaël Salaün (5):
  clang-format: Update and extend the for_each list with tools/
  clang-format: Update to clang-format >= 6
  clang-format: Fix goto labels indentation
  clang-format: Fix empty curly braces
  clang-format: Fix space after for_each macros

 .clang-format | 216 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 169 insertions(+), 47 deletions(-)


base-commit: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a
-- 
2.35.1

