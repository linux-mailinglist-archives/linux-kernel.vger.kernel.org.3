Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC35A59B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiH3DDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiH3DDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:03:01 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A809D113
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:03:00 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id b21-20020a5d8915000000b0068aaf634432so5926020ion.20
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=2XaZZETii+6PIf9IdmpIQGt4a+rcs/HHiKkWECCIB48=;
        b=fVhkee5EruLHw0LuUU8nVIUn3apOeMRuR8SY0+hDJXdTMaqwvdegea/UoD2cRiVLNO
         t6aDgCyXGOlhyi4qDRp21TyoA228FyeP/ois6XWeqkpUIDsxaXIjk8Gvt2uSoUEF4oda
         uCtjAnZd60hT7i/QH64FDXTXLCCWeZw/TIRSktNN9nd6ioibWwPNDo5tUHgMgpH16jTA
         G0yDyCz//JyWqG2tXO9ITBiIYZK8odAOUlw/klgGoIrs0BG4caQsdm2EyaCwZgHOE1H5
         dFjrJ38bOMRFY5fyn0y1xygNZWzhe9Qqb3BgivjIZFuimahoaodu3iqX3abexciV4XZH
         ly6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=2XaZZETii+6PIf9IdmpIQGt4a+rcs/HHiKkWECCIB48=;
        b=sONbMT+ShetjlLOhIt1J2fl/DJBl39RFXcWkYpYlFEuJ6ZcopeCA4+UFP5mnV48tRd
         z9EshbEAYx3RPy41OAOqGDfeNApFtZO9k/OrEVOl3X1oGfdJUy8mqq0UpmkTp+S5UElF
         Hyp13qGMX8xPayGsCgnn6JS4o5sSp20Qus9iSreI6gySja6p5glhGyCcRIXtAokgyE3c
         UKt6yJolmDF5Vb+UCopje9sxPmB2E78b0n5/Y+jihYBZSw/1XwM8ERpmrTW2gtI4n/1M
         8i89J2SESlAPKOc3q9AqtQDnjSo1CmgrVKO2fXlutN1kpQ9TelejH2iyuU9DoNDXF7Kf
         iKyA==
X-Gm-Message-State: ACgBeo3nvzCtjuRu7AxVPoSitOB0AjJPrXJzIrq0S8e6KiLrKeKl6pQ2
        sRQyvxPNELDEd4vJ1KsXEAqZXTqyMAA=
X-Google-Smtp-Source: AA6agR4Q1pBH1awKjioD9X7zEwd1kxWatig/+Lk+rvnUkBqPRrClpJvtSPWcXgWc+2IALshWGb51jxjpTno=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:3049:2153:3017:38c9])
 (user=yuzhao job=sendgmr) by 2002:a05:6638:3805:b0:349:ffd0:9a86 with SMTP id
 i5-20020a056638380500b00349ffd09a86mr11183833jav.227.1661828580358; Mon, 29
 Aug 2022 20:03:00 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:02:59 -0600
In-Reply-To: <20220725091740.28188-2-alexander.sverdlin@nokia.com>
Message-Id: <20220830030259.3503212-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20220725091740.28188-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: Re: [PATCH 1/2] MIPS: Introduce CAVIUM_RESERVE32 Kconfig option
From:   Yu Zhao <yuzhao@google.com>
To:     alexander.sverdlin@nokia.com
Cc:     cminyard@mvista.com, joe@perches.com, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This commit produces a bogus error message on systems that use the
default value. Please take a look.

Thanks.

  Linux version 6.0.0-rc1 (builder@buildhost) (mips64-openwrt-linux-musl-gcc (OpenWrt GCC 11.2.0 r19590-042d558536) 11.2.0, GNU ld (GNU Binutils) 2.37) #0 SMP Sun Jul 31 15:12:47 2022
  Failed to allocate CAVIUM_RESERVE32 memory area  <<<===
  Skipping L2 locking due to reduced L2 cache size
  CVMSEG size: 0 cache lines (0 bytes)
  printk: bootconsole [early0] enabled
  CPU0 revision is: 000d9301 (Cavium Octeon II)
