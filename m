Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762E15874EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiHBAzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHBAzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:55:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5714F3FA10
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:55:50 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id c185so9648393iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 17:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JGCuWmOop3mmxgAGuaGNB0A9b4vB2eoTdcnOF1g4R4=;
        b=jcTsEI7oKAZcN9sOUb4NpydTCu40ETk7u/knaJ1R+oIp48zEQzO5pykpNIkqStdzKl
         Y5eJMGB746B+c5gSiUiDkFWviosB+8aTeg7cgUltiQeL/q7sHPgvsTsjLT6/kccyWWdZ
         +3iJzhF7mwF/nDQeegLnOlbNUWXmCjEF1U37t4grdIMeEF6I36H2pRoNO4woLG2TnpZR
         UBYOrCnYQtTlWXY0Y/wXV7NGX11m2U+it8a712c4Xi6yOotkPwH3UVwiQ2iwd+MHAfXq
         C5WIxdPo49q4bFXjyL8yG/o41bfyTRzNAWlEFUs2LRa5TgjZi3b6nTk/ZWt09svp92El
         Mv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JGCuWmOop3mmxgAGuaGNB0A9b4vB2eoTdcnOF1g4R4=;
        b=GRminvC4ApY/BAEgZTrXs3oGGqSqlkq9WCCPHxAx324tUuZjRwg7J0Yc8SsnNt3iHu
         r0W8Qlv4jsipmyvYlC5ldNIssDLuZ70V74ObjPTmSGVqT167PfnZeapwP1zrroqhhuLc
         qaMoPuQWL+CPHoOpGDnzEeI5sbzHAoezSE9jvnQmxWKcv4/DX5sLSJG2BtvyvRrF2mSt
         +FP6Oh5NVzMX8awv+MkB1r7Px5+mACHDQTlO/0Dj7WJ3Psgs4idv8439C79VDRB9nYqs
         8f3EzO04MnZQPoFlPncQDe1eh+9QCl5qPniBXKWAz+lPw2/ZVCJpsGxGu1gARYXbESFd
         UsZw==
X-Gm-Message-State: ACgBeo0ltYyTZnscUf+QshrLg2Zd2r9Dw+/L/s+aSgee8U84pJSqNrbQ
        xN3/L/BdKP5RBwMn6V7HHNUTLBA2nP2I3J4bMWc=
X-Google-Smtp-Source: AA6agR6O6O9FfhWxfiO1CVvMbKhcpg3/mFZPtKkuzYW3f+3vmyu7REUfDD/UJty6PwqRDb4Ie1qltiIBg4yyz29dabc=
X-Received: by 2002:a6b:e511:0:b0:67f:9ef6:5779 with SMTP id
 y17-20020a6be511000000b0067f9ef65779mr2540143ioc.177.1659401749771; Mon, 01
 Aug 2022 17:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <202207280541.fIGx210Q-lkp@intel.com> <e5c7aa10-590d-0d20-dd3b-385bee2377e7@intel.com>
In-Reply-To: <e5c7aa10-590d-0d20-dd3b-385bee2377e7@intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Aug 2022 02:55:38 +0200
Message-ID: <CANiq72=cgQ7c7+d32iNajrJwZth8=+cSWji8q6npPhhdN4kgjg@mail.gmail.com>
Subject: Re: [linux-next:master 13092/13104] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 3:31 AM kernel test robot <yujie.liu@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   9250d2f72dc46a808b6aa23bf50dd670f1f52ddc
> commit: 475dd867241716f1b6ab12cc188c221bfadacc40 [13092/13104] Merge branch 'rust-next' of https://github.com/Rust-for-Linux/linux.git
> config: x86_64-rhel-8.3-rust (attached as .config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <yujie.liu@intel.com>

Fixed in rust-next (and v8 of the Rust patch series):
https://github.com/Rust-for-Linux/linux/pull/849

Thanks!

Cheers,
Miguel
