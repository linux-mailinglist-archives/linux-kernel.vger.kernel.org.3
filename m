Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14424523BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbiEKRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345690AbiEKRi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:38:58 -0400
Received: from relay3.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B9F2317F6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:38:58 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id EF410324D4;
        Wed, 11 May 2022 17:38:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id E7B6723;
        Wed, 11 May 2022 17:38:51 +0000 (UTC)
Message-ID: <f8400e5da994b81dda0b90c840afb92489ca0061.camel@perches.com>
Subject: Re: [PATCH v2 5/5] clang-format: Fix space after for_each macros
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date:   Wed, 11 May 2022 10:38:50 -0700
In-Reply-To: <d519b20b-694a-d8a7-66ed-1c5961590d4b@digikod.net>
References: <20220506160106.522341-1-mic@digikod.net>
         <20220506160106.522341-6-mic@digikod.net>
         <e40f779c7de2f9abe5fdd76d0a77477e4bf1fe32.camel@perches.com>
         <d519b20b-694a-d8a7-66ed-1c5961590d4b@digikod.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: xk4rirt9tqcfdijxwq6jsuccg5tji759
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: E7B6723
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18KCf0qJJBiyy4lhCRxjdwXstA6/L23tnk=
X-HE-Tag: 1652290731-601001
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 19:34 +0200, Mickaël Salaün wrote:
> On 11/05/2022 17:40, Joe Perches wrote:
> > On Fri, 2022-05-06 at 18:01 +0200, Mickaël Salaün wrote:
> > > Set SpaceBeforeParens to ControlStatementsExceptForEachMacros to not add
> > > space between a for_each macro and the following parenthesis.  This
> > > option is available since clang-format-11 [1] and is in line with the
> > > checkpatch.pl rules [2].
> > 
> > If this is applied, could the .clang_format ForEachMacros:
> > block be removed?
> 
> The ForEachMacros block is still required to not put the " {" on the 
> next line.

Pity these aren't linked as many for_each macro definitions and uses
exist outside of the grep search paths.


