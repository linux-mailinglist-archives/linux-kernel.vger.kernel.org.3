Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD1462275
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhK2Uu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhK2UsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:48:24 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E067FC08EC1F;
        Mon, 29 Nov 2021 09:27:39 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w22so22582554ioa.1;
        Mon, 29 Nov 2021 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrGFhL5nOtXhmiJzkqjUxe8GF1wNu9qcRKkCoZjMWXQ=;
        b=DCJXCOwVOX664MqyL5+MD32jM9hvaUge59YYsU99LvkkBA7Smxq6v8nJb4QwmE/GBT
         CStijYOqpNxckcXejJVl6W/xXcZ0bRPHuU7+/IpBFpDAhJ+67z8MoeJY2chHKK3SASnI
         uZkZCHYEzgKtKWYW6jy2rCio1X/PuJt1qf8EbUzOBCEg7NVPByVWiLXgv0vFKkoUIU6f
         RpywVmgTo+V8ncY7PL9OhJBoAw7+bnjk36ICZClclFlhUg8bPTFsIzA6Y7b/U3r56Sn0
         /M6CTNlBaLRQ8WJjeBe96dSktIyk3r6ZnCNZ2hwg6hLrfxRaTxXoGJ1GBRd0PlfE69O4
         pDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrGFhL5nOtXhmiJzkqjUxe8GF1wNu9qcRKkCoZjMWXQ=;
        b=U5whWEMrC4GV2KrjeJAcsDctKLxjWAF9fAzWy8aYbSaBlOEpLIsEFB9LOdwEwdrZ0h
         59F9PTR4kUil4GBj9bcuZ75A9G5y75YMr5OphihxYI/ju/2JsVm/Ko9uWNDCVhdTwnZn
         c6KyM2iehmUBTYfw2XWjTxnza0iANHTUPq6Bqj3FWFmVg2zobcgyfHiUm2RE98dVIF+W
         3KjusyvYuLb6mZnUNpIUv7vch/Z5Ki8tbxYz41DPglnzvOp13V7fdOPno8YsyrTkzfRR
         67hzCbQkn0IhIt6L1Xlt5Co9JeaEogmZtigim9y5Jsq6RRLXnXDDkBPaohqj6VmHE9LU
         aykg==
X-Gm-Message-State: AOAM531ya0nyBXjI6TjSzzB/pNI+jt+SY4YvZ+7OhfW9ae+qubKX9IGL
        f2PG3lAv/Kvpb8Z/xSgwvF+/wzPS5BOxeuG+Ov8=
X-Google-Smtp-Source: ABdhPJwbIuxigybLWCK3iRwGHDf3f9obH4Ajtc2RJYfTi2iTkZPNYjc22hORdU2OiXk1YcRoLM/ZHngHZyOaMDcDmYg=
X-Received: by 2002:a02:cb8f:: with SMTP id u15mr76513020jap.131.1638206859331;
 Mon, 29 Nov 2021 09:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20211129165803.470795-1-nathan@kernel.org>
In-Reply-To: <20211129165803.470795-1-nathan@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 29 Nov 2021 18:27:28 +0100
Message-ID: <CANiq72msbRw12Rv=tXJf4r0gjWfMvKqMCkjEU_2XcyJUmVHG_w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Bump minimum supported version of LLVM to 11.0.0
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tom Stellard <tstellar@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        CKI Project <cki-project@redhat.com>, kernelci@groups.io,
        llvm@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 6:01 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> tree. If that is not true, scream so that we can see what can be done

The patches themselves look good to me. Let's see if somebody screams! :)

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
