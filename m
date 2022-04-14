Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F80501D72
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbiDNVau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiDNVas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:30:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E5E6C50
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:28:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq30so11278114lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FQiaDvmcGWvBYzNP/sv5XVpDNfZwbnu3qaY+4ovDXMc=;
        b=C7aHsnt1H2h49DEHHYgqBMFF+WGxqu+705H2dVftIWwgXuiCL3hJ7NH1e0K+vHvMxt
         aNSH/xiPvQKQMKMe/8cRQVV6NBoV8vPqH6P8rUw+Vs6q4Ny+hEbMG2v2nzuB+GgJrD/G
         hlCWritHYdEbbg/OEoSlbuSU337KxUTi8oQgXhMWcWSpeeTOxr5vnzBY6xGjWqXdVhLk
         SAOGk883kmirAiOwMji7NKSNvuNbKMOtMJnkowcOrtmhNxZOFe1AKowHsOMitydyniKA
         MqRQl2sUW2zst6zGH9aUeNKOynXpXVaNpsG2WdZDhorBkmQN3927HE9ZzUBzk8zxK07I
         Pqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FQiaDvmcGWvBYzNP/sv5XVpDNfZwbnu3qaY+4ovDXMc=;
        b=djEw/dosDKZbyklyJrGJZ7PgxRmlOb/ml8BLmQRPHxHp9HFmNb7iwevbiEvnmpDff7
         LFppsLCuhpAm/d9g+F9cgMH4KrygpitsElXpv7NtS5vNM6bmZpB0NkoxjVsNkF89p19i
         38TPfyVVIEl8ISNLHIjtdFaWaeKCZFvNQ4/XiitUh5sxTLAyPHiUnsROxXe1P3tfk3yc
         qnRvPGXA8lA/kMT6Xs0gLazuPouwRPatcmNBXndM58X9IK5lU/IsSSj+ZduEhgAUkIqc
         HzLp5x1ar0hASwiOSaF7lux7vqsDsU6D1JlnwLw7aV7g7NW59+VE94aCnn87er0LU5Og
         /5zA==
X-Gm-Message-State: AOAM533y9p7I891xmIJMHOOjP3LDQMUpNqR/L0tlS5FI48o+UEUJ8Zsa
        7A0qISMDp+ig+nZ+itXAII8C539ZNlnhOKO5HBNoOA==
X-Google-Smtp-Source: ABdhPJyo/O8Nf/66ydSQVcloRuCUj1c7JI9uSISejiO9S/fIcqjiMS7lTKzxtLRuKsSF2dnMt3+mEIXx3q/QJjaKGqY=
X-Received: by 2002:ac2:4e66:0:b0:46b:c3d3:e203 with SMTP id
 y6-20020ac24e66000000b0046bc3d3e203mr3188846lfs.380.1649971700332; Thu, 14
 Apr 2022 14:28:20 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Apr 2022 14:28:08 -0700
Message-ID: <CAKwvOdkyMyE0ZRUU9Rh4qTxpOseD=fydo-FB9kdd7zRo7nVreg@mail.gmail.com>
Subject: plumbers talk on kCFI, BTI, & IBT?
To:     Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

Hi Sami, Peter, Joao, and Mark,
Jose and I are currently in the planning process to put together a
Kernel+Toolchain microconference track at Linux Plumbers Conference
this year (Sept 12-14) in Dublin, Ireland.  Would you all be
interested in a session on Control Flow Integrity in the kernel?
Mitigations in hardware, software, or both might be of interest to
discuss more in person?
-- 
Thanks,
~Nick Desaulniers
