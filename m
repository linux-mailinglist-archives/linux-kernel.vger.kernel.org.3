Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20064B54E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355926AbiBNPfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:35:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355898AbiBNPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:35:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ECB4AE3C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:35:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0FD61328
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223E5C340E9;
        Mon, 14 Feb 2022 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644852933;
        bh=GKW1O/9iEU6PCo4adC0DG5ixQw/23hNkDvK3MXbEU/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivNsmiPS4Tf+UY9vbDcZjF34lCS0o63Mbho96U/7CiTc5r6c69kGgDsPQZ0HxW5sU
         peK/+DXnIKlPzS3kY76K+q4SLK3IjgRWmWpEBpOToELnM8+y628Nxgg3ikqgM7trRD
         SudH1CrRFJX05een+/BoKb2kHwcZ6q+mGL6r7v7ZzLI5AW8ys/LpU1yQKVpN+eB2dA
         Dvgm6/p7pZw2zUiASzvNiF8tXFr2dolpvzbQccoRGA9XQZF4ryN28Ds07K1QyaNtHk
         RWQurZTHGXanZvVFav8d4rfPKjc7/EuP3oC/+iBVr7W1LD8SgRCoWQDrrclKiZPwDP
         h/9ebHsGuy/hQ==
Date:   Mon, 14 Feb 2022 08:35:29 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: arm64: clang-nightly: net/ipv4/tcp_input.c: clang: error: clang
 frontend command failed with exit code 139
Message-ID: <Ygp2wVo8JfWh5iOk@dev-arch.archlinux-ax161>
References: <CA+G9fYtR+E52X-ucmvXYG5-9v0q2UEXQsML=nkQRnSf7TwXYqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtR+E52X-ucmvXYG5-9v0q2UEXQsML=nkQRnSf7TwXYqw@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Mon, Feb 14, 2022 at 12:27:17PM +0530, Naresh Kamboju wrote:
> On Linux mainline master branch with arm64 clang-nightly build failed
> due to following errors and warnings.
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/current LLVM=1 LLVM_IAS=1
> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- HOSTCC=clang CC=clang
> PLEASE submit a bug report to
> https://github.com/llvm/llvm-project/issues/ and include the crash
> backtrace, preprocessed source, and associated run script.
> Stack dump:

<snip>

> 1. <eof> parser at end of file
> 2. Code generation
> 3. Running pass 'Function Pass Manager' on module
> '/builds/linux/net/ipv4/tcp_input.c'.

<snip>

> I have reported this a new issues on github,
> https://github.com/llvm/llvm-project/issues/53811

Thank you for the report! I found this over the weekend myself and
reverted the problematic commit in LLVM and I will make sure that if it
lands again, it can build a kernel without any issues.

https://github.com/llvm/llvm-project/commit/22eb1dae3fb20ca8ada865de1d95baab0e08a060

For the future, you may consider only sending reports of compiler
crashes to Nick, myself, and llvm@lists.linux.dev; a compiler crash is
pretty much never the fault of the source code so CC'ing Linux
maintainers is just noise.

Cheers,
Nathan
