Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3819E5112C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359089AbiD0HtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359083AbiD0HtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:49:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91CC6374
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:45:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651045555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CwFSpHzC/37utT58X2vFf5aHMrzUY1DO3qP+1uCKYwc=;
        b=uVJVenC63QCIkQbyxJCYiaSso9e98ycRKxdpKTQJNxMsC+E0mff9YgjJc+t0AkmB8UPlqc
        Cx7aBkAYBL3GWAoLzZ5SHwnLOuui/Wj/wqaxRIf4FBB9eMpAZRIMWtf8UkvBIWeXd2vC/7
        OokxXo0yfRb9CtorZRlPEyUg05N9dQuL7hDtVNO8SEiG6y3ndgJi2rOKMzmTy+VhcCqlkj
        YjXXfN7fLCDTmqEKi20ViGTi4I9xuzzYhop3fubJYWjbx+USWlpAEzEB+txvWzSSghHD87
        CODedVp44xUtIyaF2pxSNrjSgLCqkXONMRO5U5ikDrlCgKeZKlFOT/v8akMU6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651045555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CwFSpHzC/37utT58X2vFf5aHMrzUY1DO3qP+1uCKYwc=;
        b=qqmca3rNtejjGrnXlgFZ54+7dbaLMKzjC7041bXSXJcep3isFu/30mF6kJmNFhW72AVR8Y
        G2KvndwSOID52dAQ==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch v12 13/13] task isolation: only TIF_TASK_ISOL if task
 isolation is enabled
In-Reply-To: <20220315153314.333646565@fedora.localdomain>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.333646565@fedora.localdomain>
Date:   Wed, 27 Apr 2022 09:45:54 +0200
Message-ID: <87zgk7x93h.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:

$Subject does not qualify as a parseable sentence.

> This avoids processing of TIF_TASK_ISOL, when returning to userspace,
> for tasks which do not have task isolation configured.

That's how kernel development works, right:

   1) Add half baken stuff
   2) Apply duct tape on top

You know exactly, that this is _not_ the way it works.

This whole thing is half thought out tinkerware with [ill|un]defined
semantics.

Thanks,

        tglx




