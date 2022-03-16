Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689B34DBA39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356056AbiCPVim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345373AbiCPVii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:38:38 -0400
Received: from audible.transient.net (audible.transient.net [24.143.126.66])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7253236E26
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:37:20 -0700 (PDT)
Received: (qmail 16229 invoked from network); 16 Mar 2022 21:37:19 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 16 Mar 2022 21:37:19 -0000
Received: (nullmailer pid 3664 invoked by uid 1000);
        Wed, 16 Mar 2022 21:37:19 -0000
Date:   Wed, 16 Mar 2022 21:37:19 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: system locks up with CONFIG_SLS=Y; 5.17.0-rc
Message-ID: <YjJYj9q96EoH0h/d@audible.transient.net>
Mail-Followup-To: Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
References: <YjGzJwjrvxg5YZ0Z@audible.transient.net>
 <YjHYh3XRbHwrlLbR@zn.tnic>
 <YjIwRR5UsTd3W4Bj@audible.transient.net>
 <YjI69aUseN/IuzTj@zn.tnic>
 <YjJFb02Fc0jeoIW4@audible.transient.net>
 <YjJVWYzHQDbI6nZM@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjJVWYzHQDbI6nZM@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov wrote:
> + kvm folks.
> 
> On Wed, Mar 16, 2022 at 08:15:43PM +0000, Jamie Heilman wrote:
> > It does indeed!
> 
> Thanks, here's a proper patch. I've added your Reported-by and Tested-by
> tags - I hope that's ok.

Yeah, absolutely.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
