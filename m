Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDA64BBE1A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiBRRPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:15:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbiBRRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24774BFEF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pyvxPRZyt26EwEMKAm8loAn5iB1mv9+LHpNxsWKi0FY=; b=pwsJlWueBmNsfvhnFRaR9wvtB9
        y2nyYCbTr0E3ZJbXZLplWs68OlIHqv0LxDo0+XKbzotL3VbZycMiBrxzgfa4tFdyKBroBt7En4vZS
        r0to+AUcl1aZO7qVzX+xuvmbuV3UnMJ4UrOPew+m3bk0l5Ka+kv5dYY/UmASH5IApqvC8il3+/VJP
        G8buSeY1b6JM1N8VTfwQRWO6Z95vqvpOzrPkD4E17KtFWW7tKS7sygvuG58yDF8a2yqgFQVzVQKAj
        4YRSeNLGBTW6BhjFEHLoHV96OUbO3nvjxgZPjlwV+7lGzv8CnRqotWKy7SM0E/ARBNf9u2tJ4mN1I
        a77BiY/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6q9-00AsBN-4z; Fri, 18 Feb 2022 17:14:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B8AD300912;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 004142024465B; Fri, 18 Feb 2022 18:14:38 +0100 (CET)
Message-ID: <20220218164902.008644515@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 00/29] x86: Kernel IBT
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an (almost!) complete Kernel IBT implementation. It's been self-hosting
for a few days now. That is, it runs on IBT enabled hardware (Tigerlake) and is
capable of building the next kernel.

It is also almost clean on allmodconfig using GCC-11.2.

The biggest TODO item at this point is Clang, I've not yet looked at that.

Patches are also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt

This series is on top of tip/master along with the linkage patches from Mark:

  https://lore.kernel.org/all/20220216162229.1076788-1-mark.rutland@arm.com/

Enjoy!

