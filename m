Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A561501D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346931AbiDNVo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiDNVov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:44:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D26D3BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:42:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o2so11240551lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tcBZgcin2Qyz/lpER3nOUcqk5oo+6NLHp21dTPe5XSI=;
        b=qr0NB//CO+T6ov9HWJAjA7QrzZwDVcVTEJCMfcqFTiHPOyq/M9Yiq7SAXiZ7PyrfrI
         iVIqF8xNnQm4BzAXLPX2wEZrAPGS/Yz12lackQllkmoX/eJ2pGARERTH9lc31ZAsk1be
         SsSTw5+s70/B4BoSErVc2CeOVArFf0Js9vxOh3Cd/LKXWiPbdfN4CNTRGEtObJaKuoam
         BFWuU2DzpbVcy5HnuauliH11YNi30vHfmu1uptVLWZ+I1KdDu6i4CPK6NDRUemnWx+Ac
         0xMHrFqdsIyPo8W+31mrroZnED/c2Vm0LSYjKhQYw/9KBbRlJio1SZVunj0v98iF5Bpg
         mvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tcBZgcin2Qyz/lpER3nOUcqk5oo+6NLHp21dTPe5XSI=;
        b=ewpZNezn91OvIdtdrf2bY7D4hBuEB3krF0ktBe/Q/ZfYyO1vgNDhhN2qqT4u03gUBs
         PXXUOAQ8+fnhJuTuCJq6J9Rqex/1zkantPlms5jP+7Yb4iyuKeUMknYtGGKLPneNjUMr
         NKYnNzWnDDe7KLIQQkg7TeQNSKCLea8uEkJ9/Ifm67/IPDu+IhwRNlJSKsIEIOlKg387
         bTqextc11IRKn57Y+oosdyfF0MgCSxNpCiLgLusGPX2C9ZTofe5ysb+SfOMza1rGoS+m
         1BZ8tIIL0QYqWTLGj+j32TKD0gX3AJHknuADbR6XDWBagbyZ9jZxO00JD278Sse2QVNd
         T9qA==
X-Gm-Message-State: AOAM5335GeG1+vUWga9ih1Dkd4149rfwtW542k7rA6EvUmLJpVYEPPB3
        jCd/wbfmuCM25Dj1t0v4AKkRAwmkl3PlzDLq1dZIdQ==
X-Google-Smtp-Source: ABdhPJyZTsFVcgmSTJ6yKli834hTErha0MggV+ytWjbk/HkHWABtMkkLdxNE86W8Tsx/mX0eglCRmLLZpuu294lTrdc=
X-Received: by 2002:a19:505d:0:b0:46d:167e:b9df with SMTP id
 z29-20020a19505d000000b0046d167eb9dfmr2612287lfj.184.1649972540744; Thu, 14
 Apr 2022 14:42:20 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Apr 2022 14:42:09 -0700
Message-ID: <CAKwvOdnb-DiAnq4bT7XiJpFtqyJYpWNw1shEp8gWYpVmUpRBaA@mail.gmail.com>
Subject: Plumbers conf presentation on -fanalyze?
To:     dmalcolm@redhat.com
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
Jose and I are currently in the planning process to put together a
Kernel+Toolchain microconference track at Linux Plumbers Conference
this year (Sept 12-14) in Dublin, Ireland.

We had seen
https://developers.redhat.com/articles/2022/04/12/state-static-analysis-gcc-12-compiler#scaling_up_the_analyzer
particularly the section on The Linux kernel and were wondering if
you'd be interested in presenting more information about -fanalyze to
kernel and toolchain developers there?
-- 
Thanks,
~Nick Desaulniers
