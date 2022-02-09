Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0B4AE72F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiBICpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245355AbiBICdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:33:10 -0500
X-Greylist: delayed 710 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 18:33:09 PST
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEF4C0613CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:33:09 -0800 (PST)
Received: from relay12.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id F1FB4C6BCA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:21:21 +0000 (UTC)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPA id 64ADD200002;
        Wed,  9 Feb 2022 02:21:16 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 08 Feb 2022 18:21:16 -0800
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
In-Reply-To: <202202081541.900F9E1B@keescook>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
Message-ID: <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Note: This feature was already submitted for upstreaming with the
>> llvm-project: https://reviews.llvm.org/D116070
> 
> Ah nice; I see this has been committed now.

Yes, but then some front-end changes also required this fix 
https://reviews.llvm.org/D118052, which is currently under review 
(posting this here in case someone is trying this out).

> 
> Given that IBT will need to work with both Clang and gcc, I suspect the
> objtool approach will still end up needing to do all the verification.
> 
> (And as you say, it has limited visibility into assembly.)

Agreed that at this point objtool provides more coverage. Yet, besides 
being an attempt to relief objtool and improve a bit the compiler 
support as mentioned in the series cover letter, it is still nice to 
reduce the left-over nops and fixups which end-up scattered all around.

FWIIW, https://reviews.llvm.org/D118438 and 
https://reviews.llvm.org/D118355 are also being cooked. Comments and 
ideas for new approaches or improvements in the compiler support for 
this are very welcome :)

Tks,
Joao
