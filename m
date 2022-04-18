Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7CA505F42
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiDRVYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiDRVX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3906529CAD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD58160FEA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28742C385AB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650316876;
        bh=KAav+VCFSYr91LEhdYGTPh0+hHoGFkG2lJeNL06UyDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qeqbaJuAD+RFOY8cE/lIYy/P4cy7ZmPjKqgvDxKSiajfesnctZFuC99HiJ8TUqLF7
         cwaTqCxi5qNdoLluehUu9gPAFFWUUoSn+NWOmhsyhr0bbxwH26MWYKM0wfq/nX9oWZ
         dvjfxuOKeYJhK/wd9UrIwes34158zGoN4V+7DsNtsSiDtWxxnT/vNGemhHMFOnm8M9
         bpeyfhDMzr2GNr6CQRT6b1UIl3ArxUuAgPR4yq9a/2b3Wg4v82UrWAIOeZ/0Zu0zDl
         RYvDD69q6w7VUlXtzoVwoR7MCMhTfUi4fhTgqEtC2gaWC1NpYeAPF6fZbY8CrtCuL7
         5PCtNSXapgeoQ==
Received: by mail-wr1-f42.google.com with SMTP id e21so19942932wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:21:16 -0700 (PDT)
X-Gm-Message-State: AOAM531uEPlFiEQPnt/jzpKAybfcW9wvqbQvp0TkpgXDtOo3uKO3s6Q2
        6CpyQfzs3CMlXkNMUBt7/P3yU6WJwPVReuYf0NM=
X-Google-Smtp-Source: ABdhPJxkncmo4ORlw7zomxpWYmpYkP0uGqq0sLEjKNrhhFTmoEv/ShhDQl+AGPgqziemJBJ2yBx/M531Aq661utXpH8=
X-Received: by 2002:a5d:64a3:0:b0:20a:7931:5b84 with SMTP id
 m3-20020a5d64a3000000b0020a79315b84mr9825822wrp.407.1650316874305; Mon, 18
 Apr 2022 14:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmumch3vnv_qL7m+h1szDgbFZj-ATrufvKKR8i-8jdkAQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmumch3vnv_qL7m+h1szDgbFZj-ATrufvKKR8i-8jdkAQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Apr 2022 23:20:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3A9s3m1zRh3cp0Y2k6DpXBU=1vXtSOPCkMZkZWzO2GZg@mail.gmail.com>
Message-ID: <CAK8P3a3A9s3m1zRh3cp0Y2k6DpXBU=1vXtSOPCkMZkZWzO2GZg@mail.gmail.com>
Subject: Re: kernel.org binaries and sysroots
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Saleem Abdulrasool <compnerd@compnerd.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:44 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Hi Arnd,
> Jose and I are currently in the planning process to put together a
> Kernel+Toolchain microconference track at Linux Plumbers Conference
> this year (Sept 12-14) in Dublin, Ireland.
>
> I was curious if you (or others) would find it worthwhile to carve out
> time to discuss further kernel.org binaries (and potentially even
> sysroots) at such a Kernel+Toolchain MC?

I'm still undecided about attending Plumbers myself. If that topic ends up
on the list and I'm in Dublin, I would obviously attend, but there might not
actually be that much to discuss other than who would do the work.

I inherited the scripts from Tony Breeds who did it before. If you or someone
else wants to add clang binaries, I can help you get it onto the kernel.org
server as well, same for building more complete toolchains.

My build environment at the moment is on my old workstation running
an older Ubuntu 16.04 chroot, to allow building binaries for a large variety
of distros. As I'm moving to working purely on an arm64 workstation that
doesn't have this yet, I will likely have to revisit the way I'm building these
anyway for future releases.

      Arnd
