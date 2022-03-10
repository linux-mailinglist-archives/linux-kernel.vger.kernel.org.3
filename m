Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC04D54B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbiCJWmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbiCJWmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:42:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BACC182BF0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:41:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0D5FCE243A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9227C340E8;
        Thu, 10 Mar 2022 22:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646952066;
        bh=8czA8393wMVTet7FIuzrOkrClOiMXavz/UUyUoeIubc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNtMXi4pxdPlWc3meutQS1I+pNe9ek12x6LcyczB/7UBOXyOAVluWs0XNXvoy8CN0
         BV5HB/NxSmNoIhuj1UD1Xfzsvzz0dlWGVJ8v6FDB3NbOkz9xapcmfJoSX7nBizGJmD
         QArMpplLdqB2mf78pOkl1GpyKUje9iv70FEbeIV7iz2dvffnk759k9A2C33m+E8Iin
         gR838woZBVEGvUn6CF5DxCTRfn5ld1P7NtlK2yKoSORabwHfc4uyqgp+XX8SyeC6sg
         nuTgOdYz3qk63qdCm9y7JLWa2gZjsQOOYFWPAajemepwYoEJ6WNAbnM00SjWEoTm7j
         HXc7TntjNupkw==
Date:   Thu, 10 Mar 2022 23:41:03 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scenario TREE07 with CONFIG_PREEMPT_DYNAMIC=n?
Message-ID: <20220310224103.GA94994@lothringen>
References: <20220310215630.GA3490034@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310215630.GA3490034@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:56:30PM -0800, Paul E. McKenney wrote:
> Hello, Frederic,
> 
> I recently added CONFIG_PREEMPT_DYNAMIC=n to the TREE07 file, and since
> then am getting roughly one RCU CPU stall warning (or silent hang)
> per few tens of hours of rcutorture testing on dual-socket systems.
> The stall warnings feature starvation of RCU grace-period kthread.
> 
> Any advice on debugging this?

Oh, I'm testing that!
