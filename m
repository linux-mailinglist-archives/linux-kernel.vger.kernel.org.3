Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DB150A895
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391658AbiDUTCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiDUTCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:02:01 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8177125C0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:59:10 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2ebf3746f87so62359177b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KzZsSXn7FlULeV03LQ3NYKJHdvNHM67q0UAA8k1Tlfo=;
        b=nyTikQ+tLP0DYj0Iy6qstWgr08Lu33BuKay2G0mvorNyFwwqtf2ENCgv+greH3kRiN
         ugEmk1vt7sXZ7S1FicMpyUNppXpZ008HLFyk69RUTXpIkdm6jfRxfvl5LyqqFCOyBmr7
         YQT5IDFCJfm8nBMZoso+oXSxDYxzkwpKfTJ9Wvd+Nd1Qv1VCk3XEe8z2xy6aCWLQdjNz
         x4G2jNQneKxTGY5EHE5XPIdiJNn/PypCv8U6SQHEttcusKAWwMlE+Sv9I7eBtuAX1qet
         Cim/QVoI/gbsUmwATDaBqBOgRGlsJacP898el+tgZc9OmjGUVeXhIYQPQkyi07dmbQz0
         jjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KzZsSXn7FlULeV03LQ3NYKJHdvNHM67q0UAA8k1Tlfo=;
        b=dma8e+gZNC2HiqA5d2oOgSC5RG3e1mR9+gOd8IBKGVsdZvn5NNVOhTHTYAvjVtYpT9
         EAK0pnp6rxCcfZqGKSz1wkIPryGY02JZohc/fHtrkGDVkVBnda3KlBPM7vIdf8AcxEdj
         8fTEo4iQKgwJaToa3NXZZl+ahosHSIbz/PwvI9c34pPX9g6cDVNYnQGXxmk67cAmo4Io
         8lIHdKQxWABxVwxvwF7ht5ctPNAd8CbTrI/tGwnlCj/0skAmQrd+hJLA9kbAaSaqtw7l
         g6nW0IbsY147tcahqqM2ofoBB1XnkMbRgMncodAbdzgv7VL8QNrKr28/oLU5igtyC/7u
         d/vA==
X-Gm-Message-State: AOAM530Bl98LOydrP193JoRO3vKcS6/uiDS3JUm8GzELYvxTkbO60S+U
        Sgc5XvsQ3fZiyXoZE6m16fe4EBTbGlo4mJn7OCu8ks+xRSq772Ce
X-Google-Smtp-Source: ABdhPJxe1Mx8FVwju0PAzvx4JPW9Y8I82lsnHam/y1BiR9LsvcCTNTquCUds19m/50KX20dmG2FlDXDIRW/Pmwl7+YQ=
X-Received: by 2002:a81:6dc7:0:b0:2f1:c5bf:8f64 with SMTP id
 i190-20020a816dc7000000b002f1c5bf8f64mr1259969ywc.120.1650567549657; Thu, 21
 Apr 2022 11:59:09 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Apr 2022 00:28:58 +0530
Message-ID: <CA+G9fYsqcfs12PH+bykYUmEAmW3K3ONTX8ac0u1ffYhnNCPMXA@mail.gmail.com>
Subject: include/linux/compiler_types.h:352:38: error: call to
 '__compiletime_assert_483' declared with attribute error: FIELD_PREP: mask is
 not constant
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux mainline x86 and i386 builds failed with gcc-7.3.x on jenkins build.
I do have noticed on Linux next builds.

drivers/gpu/drm/i915/gt/uc/intel_guc.c: In function 'intel_guc_send_mmio':
include/linux/compiler_types.h:352:38: error: call to
'__compiletime_assert_483' declared with attribute error: FIELD_PREP:
mask is not constant
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

[1] https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-mainline/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-buster-lkft/4259/consoleText
