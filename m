Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC52F4F202D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiDDXUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243165AbiDDXTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:19:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E8F114C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:16:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11FC661703
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B03C2BBE4;
        Mon,  4 Apr 2022 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649114215;
        bh=nC8+YbTUoOmPSkw7RKzlGgDxRKiW5/PdfrojCeSw5aA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=udNUYnHFr9nDw20CoXQqr1PRs6jAcZiVdfNQF4bByaqM9vD0g7iQS/9GPQFL7Ty3V
         bYqJwgVcx+CmslGHHyj0XTNSIaZMAG6d//W3JILmvlIDKHJF2oWU/H32hjax6LIwwM
         wCeQ7uKKwcoBYPfKJzeEaYQiWzPL6mbu9C+Vb4mOmG9MR8strLwMD4Em25VrqeJSRk
         8w6h/KeP339ZLGgGm5UHK8TytFmEADLTq7uphmX8xMAcM9sMOBN1/AhJuIyKGf0rMn
         9sn/4Ch09ZcCa+FN1RbaqsTYYaMyi0JLguUh2b6yx0O4HRUqGB+oSkGBAJ1CeDEifP
         Su4FnlB5YXHHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E74195C0245; Mon,  4 Apr 2022 16:16:54 -0700 (PDT)
Date:   Mon, 4 Apr 2022 16:16:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     bigeasy@linutronix.de, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: Typical PREEMPT_RT .config?
Message-ID: <20220404231654.GA3445712@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

OK, now that PREEMPT_RT is mostly into mainline, I should probably create
an rcutorture scenario more closely reflecting it.  The closest at the
moment is probably tools/testing/selftests/rcutorture/configs/rcu/TREE03,
but I figured that before beating on it I should check to see if you
already have a PREEMPT_RT rcutorture scenario file.

Thoughts?

							Thanx, Paul
