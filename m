Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A25536C68
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 12:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355915AbiE1Kre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 06:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355438AbiE1Kr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 06:47:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E51C123
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 03:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC333B816FC
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 10:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D341C34116
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 10:47:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eVuGEnTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653734823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yvkMObBvQuESLA3tgiCHwDOneR72VGk01RLTWqPCrPE=;
        b=eVuGEnTz50Yxrpvt4R+sJiw58MkzfBHJi0LvrcE1kbAC7fBLcpjtiBRV4uMcHWHAoDXD7x
        83hvWoDoXVi9k+/xKkdBDfJ5RZxWOUEoGpszpc0izU9pDMSdlfSZiOBYd5+9outKADwy1c
        6CiHVPazpO02XsvnputRGNWGQDWocfs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fd50f0d3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 28 May 2022 10:47:03 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id z186so7463432ybz.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 03:47:03 -0700 (PDT)
X-Gm-Message-State: AOAM532VE0+7Zxqck7o8ljPBAx9BJXg4gPn5dsvnTPBMlVesdEYdHYIO
        2w12J2Fd2g3GfPiAkwxlzcHKExubxUEqKngypy4=
X-Google-Smtp-Source: ABdhPJyixFhRilZFN5H2fag0QpJjlKI3j15XAKBazx0G7U79AaI/W1qBFYBPpv2ari2zWqKUNAsz/nhQz+HgD3RCdKk=
X-Received: by 2002:a25:9389:0:b0:65b:afb6:4295 with SMTP id
 a9-20020a259389000000b0065bafb64295mr5470004ybm.373.1653734822539; Sat, 28
 May 2022 03:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <YpH84wrg4ZxIkkie@debian>
In-Reply-To: <YpH84wrg4ZxIkkie@debian>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 28 May 2022 12:46:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9qHRd-t8mupAG1w0jV-uE5UNrMeRO+8-0b_4N1cCPyM+w@mail.gmail.com>
Message-ID: <CAHmME9qHRd-t8mupAG1w0jV-uE5UNrMeRO+8-0b_4N1cCPyM+w@mail.gmail.com>
Subject: Re: mainline build failure due to 8bdc2a190105 ("crypto: poly1305 -
 cleanup stray CRYPTO_LIB_POLY1305_RSIZE")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip,

On Sat, May 28, 2022 at 12:43 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The latest mainline kernel branch fails to build for:
>
> arm: imx_v6_v7_defconfig and multi_v7_defconfig
> mips: decstation_64_defconfig, decstation_defconfig, decstation_r4k_defconfig
>
> with errors like:
>
> In file included from crypto/chacha20poly1305.c:13:
> ./include/crypto/poly1305.h:56:46: error: 'CONFIG_CRYPTO_LIB_POLY1305_RSIZE' undeclared here (not in a function); did you mean 'CONFIG_CRYPTO_POLY1305_MODULE'?
>    56 |                 struct poly1305_key opaque_r[CONFIG_CRYPTO_LIB_POLY1305_RSIZE];
>       |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> git bisect pointed to 8bdc2a190105 ("crypto: poly1305 - cleanup stray CRYPTO_LIB_POLY1305_RSIZE")
>
> I have checked .config to confirm that it contains:
>
> CONFIG_CRYPTO_CHACHA20POLY1305=m
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
>
> so, CONFIG_CRYPTO_LIB_POLY1305_RSIZE will not be defined as it now
> depends on CONFIG_CRYPTO_LIB_POLY1305.

Indeed. There's this v2:
https://lore.kernel.org/all/20220527201931.63955-1-Jason@zx2c4.com/

I'll send a v1/v2 interdiff shortly.

Jason
