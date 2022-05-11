Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE6E523B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbiEKReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345615AbiEKReP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:34:15 -0400
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5DC2317E0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:34:13 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Kz28M3JKMzMq1PY;
        Wed, 11 May 2022 19:34:11 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Kz28L0d0vzljsVB;
        Wed, 11 May 2022 19:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1652290451;
        bh=G0hs62nfpGjWlOuhAXhBiuFTtxkNwrbiWL50GjtiUpg=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=H1xdyS6uzExUVTleMkgRO/LnlzqZH0UkHhcSUl/P7DycKdX3FBXmhmiMpe98X8JWp
         rOpuHAD34t4L7thf6KiYS++C91oc+jvZR6orUtn3xDhnQikA8a97nKW9DHAF2xsCA6
         ESoYTb3ST4n7MF/bcjlDug8kdiKGaNebcfcFcI+8=
Message-ID: <d519b20b-694a-d8a7-66ed-1c5961590d4b@digikod.net>
Date:   Wed, 11 May 2022 19:34:09 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>
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
References: <20220506160106.522341-1-mic@digikod.net>
 <20220506160106.522341-6-mic@digikod.net>
 <e40f779c7de2f9abe5fdd76d0a77477e4bf1fe32.camel@perches.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v2 5/5] clang-format: Fix space after for_each macros
In-Reply-To: <e40f779c7de2f9abe5fdd76d0a77477e4bf1fe32.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/05/2022 17:40, Joe Perches wrote:
> On Fri, 2022-05-06 at 18:01 +0200, Mickaël Salaün wrote:
>> Set SpaceBeforeParens to ControlStatementsExceptForEachMacros to not add
>> space between a for_each macro and the following parenthesis.  This
>> option is available since clang-format-11 [1] and is in line with the
>> checkpatch.pl rules [2].
> 
> If this is applied, could the .clang_format ForEachMacros:
> block be removed?

The ForEachMacros block is still required to not put the " {" on the 
next line.
