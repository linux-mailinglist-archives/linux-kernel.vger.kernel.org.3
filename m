Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2959571F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiHPJwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiHPJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:52:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D66B150;
        Tue, 16 Aug 2022 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jJXEgeaJgW7E5rB/ZAtJ1t8ALHPRvklP1BF3O1zV+CQ=; b=DwPb9TQYje+3EXZb/buozWluyT
        C5h0P+Qnt6B3GaSdNEkuJAN0xQqQxafG7KXJCDu+xW1nssPeuZ6NP+qFSYeVV7jbS8jJR2VyusssH
        D9HJuouRI47ahhNx6DYn9o4fxad2L07UAex24+n7ULGhRjU7KE6M8hTTK+DPwKyjaiC9O6myqSQWX
        ZY6wMlHyrIdibAw2BoWIMwinf/yNTQ9DCYa05Xt7DwvPhVeU9l0YGraOS1vMpo4wU3fwJuKz7LdRe
        BZuNPT+wxmp9PSkF8JRfgaoWp031E1Jf9bX9if+CK2MevaDW5LsBR1a+06UV4QV7gzbp22/aAveh8
        /JZFH+Ow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNruj-002uJo-OA; Tue, 16 Aug 2022 08:27:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A572980264; Tue, 16 Aug 2022 10:27:05 +0200 (CEST)
Date:   Tue, 16 Aug 2022 10:27:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Subject: Re: [PATCH V2 1/8] perf/x86/intel/P4: Fix smp_num_siblings usage
Message-ID: <YvtU2VKtpGCIOes4@worktop.programming.kicks-ass.net>
References: <20220816051633.17775-1-rui.zhang@intel.com>
 <20220816051633.17775-2-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816051633.17775-2-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 01:16:26PM +0800, Zhang Rui wrote:
> smp_num_siblings can be larger than 2.
> 
> Any value larger than 1 suggests HT is supported.

Subject and Changelog are still utterly insane.
