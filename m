Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F3523793
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244945AbiEKPlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343966AbiEKPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:41:09 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493E44D9F2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:41:06 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 65AD681BB5;
        Wed, 11 May 2022 15:41:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 3C7BD2002C;
        Wed, 11 May 2022 15:41:01 +0000 (UTC)
Message-ID: <e40f779c7de2f9abe5fdd76d0a77477e4bf1fe32.camel@perches.com>
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
Date:   Wed, 11 May 2022 08:40:59 -0700
In-Reply-To: <20220506160106.522341-6-mic@digikod.net>
References: <20220506160106.522341-1-mic@digikod.net>
         <20220506160106.522341-6-mic@digikod.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 8kumfz8y6hktaiyao8dktthgs9c8gdp3
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3C7BD2002C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19QUncDomXjqcJxWxSLRvMhUCb8dD0BNIs=
X-HE-Tag: 1652283661-184094
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-06 at 18:01 +0200, Mickaël Salaün wrote:
> Set SpaceBeforeParens to ControlStatementsExceptForEachMacros to not add
> space between a for_each macro and the following parenthesis.  This
> option is available since clang-format-11 [1] and is in line with the
> checkpatch.pl rules [2].

If this is applied, could the .clang_format ForEachMacros:
block be removed?


