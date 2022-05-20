Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2018B52EB54
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348840AbiETL5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348824AbiETL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:57:35 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBAD3EF11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:57:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o190so8451011iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xSDHFbgdsSPbf0MQcrePk45f2WGTqnruAEuBaXBpzKA=;
        b=B2W0j5tIxiAxooxUdifLAH3iuLu/2+GTfJhhWSoj+xtGW+KT9lF3br3LVTsKGfOCCR
         4fHcH/10CIn9T1xSM9QY/XZFZGXTDrzWnMG0DCMzK8xO1wSiicnqMlY01wsU6k9Fok2J
         9nQtNdnh+p2VBSmRLTl61vWsRIAuk0WqP4Idx01vGXIZRLITduJGc3gYuOV6FFZROXGG
         WGl6HU+Emv5W9epNdu/2KBQpMsmmQtAGv22bQg5es1Sym9rzC74DqZbyVnYJPpV1piJP
         /qt4gMice+2SXrPZ9TtMt6mQbLVRln1jxn6YIV/KpWP/OOTjvhEWE7/Pcy0nXieBdCKo
         7jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xSDHFbgdsSPbf0MQcrePk45f2WGTqnruAEuBaXBpzKA=;
        b=fg1WdLIsP2LRAi+OFkrzpk30gfokZktuORc19+apGx/ltENJtqNMCfXmYhFIm7NtGV
         tSDjXY15TKbyIEgO5u5x88HUgUhvVj6BtrIZ7CCmrS0X9tg+3Fcc1XhhVUVe0OjVq8kH
         3hg+7mhgabu2i/GH/xrV/n2ufIOERpCC52SxDsgRqAoUcwWpknQ7wBR4g0qsEV0s1bXK
         Tb8nbUVJLtV8oMSXlfPhLKMIH/+NWc8CT29tlqPColrcD94VEHpQPJxdWHbPfoX8EXAO
         Zr9Ar+ARV/RSDm6mjLET43S2ssA6ktrC4YWfIonm2IHAsZL/yYtMyZUxVud++BMqZZBq
         P2eA==
X-Gm-Message-State: AOAM532gqCUgIJU0JOsmVxXASyuH8iPBmdhgdjVS3lEEbRTnV4QXln8z
        M1tfAAfDp8fP05vS9DEEN+q2MjvlL86JV0BNzBA=
X-Google-Smtp-Source: ABdhPJzlM3XOaQTokHXRBQYrE3tYxTLdfXrA1F77E84cCyB66NzP84IycHtapU+ti/oH6PPe2Ic3sqht7R64Tgj/H9Q=
X-Received: by 2002:a05:6638:16cf:b0:32b:6ee7:8d7d with SMTP id
 g15-20020a05663816cf00b0032b6ee78d7dmr5118144jat.256.1653047848596; Fri, 20
 May 2022 04:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160106.522341-1-mic@digikod.net> <20220506160106.522341-2-mic@digikod.net>
In-Reply-To: <20220506160106.522341-2-mic@digikod.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 20 May 2022 13:57:17 +0200
Message-ID: <CANiq72=7=ZpAObWRmposOmnyZ8XR_eNHCBtA3bu3fusmcPUwDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] clang-format: Update and extend the for_each list
 with tools/
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 6:00 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
> +  - '__ata_qc_for_each'
> -  - '__ata_qc_for_each'

This change is likely there due to a locale difference between our
setups -- I will fix this by forcing the POSIX locale and then I will
adjust your commit.

Cheers,
Miguel
