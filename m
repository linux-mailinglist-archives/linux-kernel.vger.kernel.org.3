Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746BB4FF74C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiDMNCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiDMNCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:02:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F85DA61
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:00:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649854801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fbisw7tCq4YFTRISV+GbDt4JTSQHfgqeVr7xyZsEj4c=;
        b=zAjDwoZLMUc3od9CbrGF/JyIa7N+WpCWAmqxDAh1zkaxIWk+oOG5bqZ4wpqg4qMMhqNA+k
        dgaOW/iQjpLmFsLPM6HYRCiJTT84b+BxyLmZvZRbK5a0dLV9GfCzrNNPYZU67xOnWtd1jF
        IM7d5tn6EBKTWVW9DTCl4yVxc5sC/6dk8Cz7BvGDY5/z/LxXDy06Pu+W5lcsC/ptterDtC
        K9zHa9MOmDL3PDriaGnQGaZNFD1+HbwevqqEAr1H2vaVMz1GKbgxXHFZltw15KFyVIgbY/
        raBRiflo/O7ccx3Wmgv/iBDNaefI5ZpjY/kGp3W3HWqaW4Hb/9tIzdg+8WhP7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649854801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fbisw7tCq4YFTRISV+GbDt4JTSQHfgqeVr7xyZsEj4c=;
        b=nfWK1Y9NBd5GY6Qc3DPQuCu/yaVAXk4SQbwvK+o7OGd0s1Hn1d1KKYI7T3fTuqcL51cKi8
        04nBSlFPN5001bDA==
To:     kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V4 1/2] smp: Rename flush_smp_call_function_from_idle()
In-Reply-To: <202204131011.m9M80Uip-lkp@intel.com>
References: <20220412204353.655068649@linutronix.de>
 <202204131011.m9M80Uip-lkp@intel.com>
Date:   Wed, 13 Apr 2022 15:00:00 +0200
Message-ID: <878rs9f8a7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13 2022 at 10:52, kernel test robot wrote:
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> kernel/smp.c:697:6: warning: no previous prototype for 'flush_smp_call_function_queue' [-Wmissing-prototypes]
>      697 | void flush_smp_call_function_queue(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is not really new. It's "new" because the function was renamed.

I'll fix the whole pile of preexisting warnings which are related to
kernel/sched/*.

Thanks,

        tglx
