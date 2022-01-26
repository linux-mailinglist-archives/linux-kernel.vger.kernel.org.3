Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F049D467
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiAZVVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiAZVVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:21:10 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46113C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:21:10 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id o12so1216840eju.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sfddJG8Ne5pbCi0QrdlrjT/b50oZdx4/kvMtR32BLbo=;
        b=QIsyaeJL52rp+3sMUQ/8G9bavcWiwWOAPwduuNQzSJTmaE0wmWzJTUXcd6yb7OAw9N
         /LvLL61/LhqDvVMoD6KM2ou8xCPrVa4xBjQssw+d+82eO2Oa0qqbrJ92xIiA/Fe297Qa
         zq4y15SlqILN9HRRaHpiVKB2ZQcL2wllShwZl6avz7sIF7hIAEJBO1Mf/xbt3/Q2WHVV
         LhorNt5gACpE8aU7l7t6YWYZI5IwvludQu6R+YzDS910gZAbgs8gXHu0RWtMcnwX7JqA
         TFXPJsCamc9Sfz1aGZ8MmF8L77Hu24LMstwIWZb9AZfC9/6hX88Z9s7yMEg0Ird5Rcfi
         3oDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sfddJG8Ne5pbCi0QrdlrjT/b50oZdx4/kvMtR32BLbo=;
        b=TH2cuwnVpWubZxZRvnxkWPhtyRwulfhpcwl8WRex+dQgicZqgB5YxaBBA32h+KmfyO
         pqOKgro0EDToMWLKm4uZ19BOsvIPwVf9X9qZc5tixyXR5Cwyc2UwNkEHbqDAzOspzPsE
         EfCxn0eLn+zRVC/TKQvUAV1z+qfGnDJgWzswDq6fND+PB6Sm5GlbVX/q6X40RTKXgvD5
         Ioa6TxDUF/onRNHixquigR5E/Zwwd8OSTz9PNBO2BZGJj7houvs20MXJlfl5lsyWa2IZ
         4Co8/4Uq3mWzmiRDWHjfkaIRAIrba16nR2tm36wCGP3lpaDRshMznMSH4kuzKW5NgOsT
         KLbA==
X-Gm-Message-State: AOAM533BmF8EjfgYiRjspgzk6G9wAhHaDNED9n40Ca1Va35Z4tpdeF76
        btb4OrwZgRXhxIU1IPLEpe/GPGWJk922uMVd5Loj
X-Google-Smtp-Source: ABdhPJxw3d5mnv3wPnmpUUVOKLaEA0jO8ZEylbqwXDPVekdv65G/G9q1/pcNh+v3zqOWTeUCasC3T9p1EGRX/t+n1iA=
X-Received: by 2002:a17:907:3e1d:: with SMTP id hp29mr414495ejc.701.1643232068672;
 Wed, 26 Jan 2022 13:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-8-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-8-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 16:20:57 -0500
Message-ID: <CAHC9VhSQW3E=K+nDF8tdTi2AxxN91b9Ufk-FSE7XpXimHTA4tA@mail.gmail.com>
Subject: Re: [PATCH 9/9] selinux: drop unused macro
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:15 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The macro _DEBUG_HASHES is nowhere used. The configuration DEBUG_HASHES
> enables debugging of the SELinux hash tables, but the with an underscore
> prefixed macro definition has no direct impact or any documentation.
>
> Reported by clang [-Wunused-macros]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 2 --
>  1 file changed, 2 deletions(-)

Merged into selinux/next, thanks Christian.  This macro definition
predates the move to git so there is no quick answer to "why is this
here?", but my best guess is that it is an artifact of a developer
"disabling" the DEBUG_HASHES macro by adding an underscore to the
front.  Regardless of the reason behind it, I agree it should be
removed.

--=20
paul-moore.com
