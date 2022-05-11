Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5318A523DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347098AbiEKTlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbiEKTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:41:48 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E0580EC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:41:47 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id 3so2152884ily.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6i5T44uBpL6AH4I/98oODY9bH1Is0dBLxkQo/1EB5I=;
        b=NV45U4dimIdg5fnEMlw5FkUkyo9qiI0LoJ4np3NyKvcVdzH/miMO0UrvorTqwMt75m
         XQasmnHC9+eLUC5853ttxRBCuP24I2ACx2h7f1nsmBqXZGiuMf588DkRZk1PNNOYZm8j
         RSetA5ZB4qojthI02mobgxfll0xfzcX6xoLHBtntk5nwufJd5Cn4l/nXUnjVHK/BauX2
         b3Z4xtnuFSCJp/kP0p0R79lf2VgBAnqr5OFi+T5S/h7xGNWsVHkHHCQ2Cx8anmjqVG9m
         gpJmOvo96vnRLjWAiA4CffOv/v4FMa9atWfIoZRMd7B+IS4/7RFbjYkDIHuuUpTlex7A
         ODNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6i5T44uBpL6AH4I/98oODY9bH1Is0dBLxkQo/1EB5I=;
        b=Wkz6+YSUv26Tk/OAODRPohHGOp9s2Hcouc+y3CgoHJVPlZhKpUBCbEwhkDEcYMbyqy
         SrVaL+1bA45dS5EuNxUusA1QzWHXaLhONlqRRa1PN8wyZEN9eAU7/p+TTPkE6mRdKa+A
         9GZ9CpFOjy4H8HDYKRKczrk3vLmfnoWVo8ms52eDtDmxFRtXEM6HHox2I7UUpJqmtUIN
         nvQPbc+6/gzQ4ijYkmOJktL4k3l2U0foYxYd4GoiWxwU3rYugZJNkIUiMyL36oud2/ej
         BacL5WPXzyatd6RdG9f+ffUHWBQshj58pbEjniPcf6X3r3DpDQslhF3cfogM+UgDU4S+
         EFOw==
X-Gm-Message-State: AOAM532JYacwy3zZ0NIWcdNLndG67RLDvpZjaTvxvmHqS8SV+yYHD99f
        ufFhd+UXh7fiTlXLfM+7r1QSI9uSbkqD6ckfDh4=
X-Google-Smtp-Source: ABdhPJwOL6t+Fg41y5fXBvxfCHaA9Qa/Z1pcr3eNcSRB5Zy7KsO6KaLemRJdrQZqW75WrQx7i2lxkjR2M6MSe7YEL+E=
X-Received: by 2002:a05:6e02:1c82:b0:2cf:1836:2579 with SMTP id
 w2-20020a056e021c8200b002cf18362579mr12843180ill.237.1652298107403; Wed, 11
 May 2022 12:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220511072747.3960-1-jiangshanlai@gmail.com> <20220511072747.3960-2-jiangshanlai@gmail.com>
 <CAKwvOdmF_5KudQbC8j5hJT1CqxvYtMneZxb1Si3A2uNxopk3yQ@mail.gmail.com>
 <CANiq72kc02DbgVdKusDUeCkxVoQoOGMLnEJnzf-Gn=BiQUggLw@mail.gmail.com> <CAKwvOdmVj006evgychajuUV4DqL4QXohHmYiE6To9traPKcr5w@mail.gmail.com>
In-Reply-To: <CAKwvOdmVj006evgychajuUV4DqL4QXohHmYiE6To9traPKcr5w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 11 May 2022 21:41:36 +0200
Message-ID: <CANiq72n8ccBSSt5N2EDZTGf6PoZxUmf3ESK0-zdMaDsY6BJ-6Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] x86/entry: Introduce __entry_text for entry code
 written in C
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Marco Elver <elver@google.com>, Hao Luo <haoluo@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 9:34 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Yeah, nvm, I missed the bottom #define for some reason.

No worries, I got worried there could be a change of behavior I did
not know about the order of those... (in which case we should really
document it! :)

Cheers,
Miguel
