Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC14AE936
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiBIFYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:24:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiBIFSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:18:45 -0500
X-Greylist: delayed 10646 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 21:18:48 PST
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202FFC03FEEE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:18:47 -0800 (PST)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 5123B1C0002;
        Wed,  9 Feb 2022 05:18:44 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 08 Feb 2022 21:18:44 -0800
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
In-Reply-To: <202202082003.FA77867@keescook>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
Message-ID: <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, excellent, thanks for the pointers. There's also this in the works:
> https://reviews.llvm.org/D119296 (a new CFI mode, designed to play nice
> to objtool, IBT, etc.)

Oh, great! Thanks for pointing it out. I guess I saw something with a 
similar name before ;) 
https://www.blackhat.com/docs/asia-17/materials/asia-17-Moreira-Drop-The-Rop-Fine-Grained-Control-Flow-Integrity-For-The-Linux-Kernel.pdf

Jokes aside (and perhaps questions more targeted to Sami), from a 
diagonal look it seems that this follows the good old tag approach 
proposed by PaX/grsecurity, right? If this is the case, should I assume 
it could also benefit from features like -mibt-seal? Also are you 
considering that perhaps we can use alternatives to flip different CFI 
instrumentation as suggested by PeterZ in another thread?

Tks,
Joao
