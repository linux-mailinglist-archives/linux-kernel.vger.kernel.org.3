Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D82534B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344267AbiEZIJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiEZIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:09:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3A1D338;
        Thu, 26 May 2022 01:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yec29r6iuyhGesHESyxdhnNXq6N6JjRsk9N/Wv7l00o=; b=u6Ow4nOeNjW8OGrhg5lgwiep2A
        FbV45WI7PTDQkJnFEfPSjKVtMP1pJDBC1dyQ3UiHuQpaNUeg2JirZdicWr8HDTT2dkiRW66EAljry
        45A3KBC3mw1smx3U2xY/vG0GK8TQPzpGWSrQcyMWB10Gc3C8he4yYw25SASRVowKHdKgv+OzJudj9
        Os2N8lWhhZVXvjqVXPIyCBHNEA8UolMKNm4aeUs6qstbo/0vCKzbJxc0yW/ZesWJqHdhuMZlpqygW
        FwhBCmw1x/exNAi2gKMyRGqbRs3W5eZh9/LPIa3Z+ZPysp60iEdgZGxWWTmRKlMWzInR9QbFni93i
        wpGyZOWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nu8Y7-0014YU-Oh; Thu, 26 May 2022 08:08:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E4E2980E04; Thu, 26 May 2022 10:08:49 +0200 (CEST)
Date:   Thu, 26 May 2022 10:08:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: objtool warning, branch, patch, and .config (GCC bug)
Message-ID: <20220526080849.GF6479@worktop.programming.kicks-ass.net>
References: <20220525173332.GA4008581@paulmck-ThinkPad-P17-Gen-1>
 <20220525173444.GA4010526@paulmck-ThinkPad-P17-Gen-1>
 <20220526080313.GM2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526080313.GM2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:03:13AM +0200, Peter Zijlstra wrote:

> Which is just bloody weird/broken if you ask me. What's worse, GCC-10
> does the same. Only when I use GCC-11 do I get sensible code again:

Just to clarify, I can reproduce using:

gcc-9 (Debian 9.4.0-5) 9.4.0
gcc-10 (Debian 10.3.0-15) 10.3.0

The good compiler is:

gcc-11 (Debian 11.3.0-1) 11.3.0


