Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09D052F142
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352000AbiETRIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbiETRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:08:08 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32757179093
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:08:04 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e194so9320695iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i9RUNA8HR+3LMt6aSWi5aaLx+ys609H8mKFKAqfMPg0=;
        b=fi8Mi0svNJsbGMxAZlv113yYTnugqYauhfAsCUjx6xSentLsfoGMTD6TThGnvsRwTo
         5V85jyeVzRrM2JRDguntsgHeUP2UvmuQarXoztfrsWUfLf0fu/+Yut87wQdMj0CyN/7G
         HXNmvNoRXKz8IzDmIU92PtZsvMCvhczDbMzl/QLZReCMgfhD7hM8t0es/DethhdUDKvR
         NBPyDA4bGLJmiV7+8vuF2ELVeeUhiFgiPYYWhUbW66GBc78jExJkY1RBZF3tmlaCfXVY
         eKw73WLuhZaNHsFn+5E/EY+FQH0fLLcu3F9aovWsHm5DWAUdvto/9V1Vhv0r86IEy4Kg
         RrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i9RUNA8HR+3LMt6aSWi5aaLx+ys609H8mKFKAqfMPg0=;
        b=UhL6QWV914LbTjMHCDBKcMistyG2CHwwhtCjmEIMQTsD6lVNFVYYGFU4INOcGJRicz
         9RDTwEOEM4bE03h4aR55Kag09sznhf+TP/W/cGrtrQtxPC+NAAX+UVV88aErRz/Q55jK
         MFQsJj/dG1b1t2VqJ6qAfV53I+XcP9NzVz9oNp8ccJGMH5M/nPyxQdsxCZW4wzDaxb/m
         xLlk/a7X1ahF/SFRW7W3uZlHuRSQvcu8mgJA37U6Ve/iR0zYh7CfsfOGEMcOBCHf7oSC
         I6rwKiUfqYLWJGEZq99CS+iW3TyJmYHXHkE2S/L2tmMJfirYqj09BcXO8AY4rt8VeQ+g
         LV3g==
X-Gm-Message-State: AOAM531bdJIKFUgzE9sRT7+mGCe20iYZt2qZzKc5GvxNh9sCVCbxiqII
        KdpdXrPt6bjZ3JgB0gL5SrLg+fYfYeSqWLEjIIY=
X-Google-Smtp-Source: ABdhPJx0Wxbb+MrHMlPDahkSrsVbBco0rEU7ibhFy6N5zjeUlbIkyQBb+iddFyu3mMBkraqNHFu1vga1jEp2stAeLiw=
X-Received: by 2002:a05:6638:f89:b0:32e:89f4:e150 with SMTP id
 h9-20020a0566380f8900b0032e89f4e150mr4780556jal.308.1653066483631; Fri, 20
 May 2022 10:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160106.522341-1-mic@digikod.net> <20220506160106.522341-4-mic@digikod.net>
In-Reply-To: <20220506160106.522341-4-mic@digikod.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 20 May 2022 19:07:52 +0200
Message-ID: <CANiq72=75oefMG_GFO5scHZQ1Swk+oBLST83VWM6pvUuf-R-4g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] clang-format: Fix goto labels indentation
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
> Thanks to IndentGotoLabels introduced with clang-format-10 [1], we can
> avoid goto labels identation.  This follows the current coding style and
> it is then in line with the checkpatch.pl rules [2].

To be consistent, this should increase the minimum to clang-format-10
-- I will fix it on my side.

Cheers,
Miguel
