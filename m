Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D1052F1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352386AbiETSAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbiETSAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:00:08 -0400
Received: from relay4.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A74185CBA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:00:07 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 4061733D16;
        Fri, 20 May 2022 18:00:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 022D720032;
        Fri, 20 May 2022 18:00:01 +0000 (UTC)
Message-ID: <b49d037c38715c3fd82c07309e32aad70c97890b.camel@perches.com>
Subject: Re: [PATCH v2 4/5] clang-format: Fix empty curly braces
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Date:   Fri, 20 May 2022 11:00:00 -0700
In-Reply-To: <CANiq72=e9LMujmsk-mh8YHcGoKuLAnBttNz7JbiXH_2-hpvUvw@mail.gmail.com>
References: <20220506160106.522341-1-mic@digikod.net>
         <20220506160106.522341-5-mic@digikod.net>
         <CANiq72kbp3xTpj-L2BfLQ1Ecx-2Ki0W3e5YLERx8-T9bjb96=g@mail.gmail.com>
         <5be32ddf7688db38408466315a80e03e9af7ac40.camel@perches.com>
         <CANiq72=e9LMujmsk-mh8YHcGoKuLAnBttNz7JbiXH_2-hpvUvw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 022D720032
X-Stat-Signature: uyp44sgdrwfz49gbd36ydzok3tbmcndf
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX182117J8M64PyKDQx46EsFXLJslc2PgjkA=
X-HE-Tag: 1653069601-77227
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 19:50 +0200, Miguel Ojeda wrote:
> Hi Joe,
> 
> On Fri, May 20, 2022 at 7:24 PM Joe Perches <joe@perches.com> wrote:
> > 
> > static inline void foo1(...) {}
> > static inline void foo2(...) {}
> > ...
> > static inline void fooN(...) {}
> 
> Those are the non-wrapped-from-signature case, which are handled
> before this option takes place, i.e. this option is about:
> 
>     void f()
>     {}
> 
> vs.
> 
>     void f()
>     {
>     }
> 
> For putting everything on the same line, we could adjust
> `AllowShortFunctionsOnASingleLine` from `None` to `Empty`, though.

As you wish.

I think it's more that there's no "one true style" issue than anything.


