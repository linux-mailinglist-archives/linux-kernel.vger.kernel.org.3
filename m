Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6E75A8568
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiHaSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiHaSWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:22:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12C26392;
        Wed, 31 Aug 2022 11:18:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 216CEB82274;
        Wed, 31 Aug 2022 18:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8880C433C1;
        Wed, 31 Aug 2022 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969820;
        bh=0sDnYptc08FWB8kG7eorPS+nmpd5VtGv81FjBwB21Gc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ozp3AS+ZkjdKwGA24ZQ8R9QNRXdsOwTLJnsgOqKSYN6fuFNb9EJns9XX+pg+PAD9o
         eK/zvdssnccifhbkuNrxuFL+MxQ8UWk8IM4ltdf3gX6Df4ATwbvhBYUVAR8ZVJlBBj
         6FX16rhi2wGsXoULEmQZ52bLfoHsMABqL4Kl9RsugO6Q3tYPEZPXAxpqpIn51E3GjM
         VccVTRMTFB+0MnLFPZw1DDSu3VYaGfdbdo+6JVlUaqTIPM/0LFkwcD+soUjPkHY+GR
         P5psz5RsU6kdAAKJR5mW3XXVv1Li9XFX4CpbnjWkGnvor4dmniGZKaRLknRF0uNmHC
         V87E8AtrSxVdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7AA8F5C015D; Wed, 31 Aug 2022 11:17:00 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:17:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] Torture-test updates for v6.1
Message-ID: <20220831181700.GA2696707@paulmck-ThinkPad-P17-Gen-1>
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

This series provides a couple of torture-test updates:

1.	Optionally flush printk() buffers before powering off.

2.	Use the barrier operation specified by cur_ops, courtesy of
	Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    6 ++++++
 kernel/rcu/rcutorture.c                         |    4 ++--
 kernel/torture.c                                |    7 +++++++
 3 files changed, 15 insertions(+), 2 deletions(-)
