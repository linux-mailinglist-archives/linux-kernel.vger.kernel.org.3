Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094AE4FAAC9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243131AbiDIUfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiDIUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:35:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0067A2DE165;
        Sat,  9 Apr 2022 13:33:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649536421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egZmKDvg6IRVw/Q4fbq2Nw60bz2xjHTKvAkA97n7N+4=;
        b=NGY1H4dnAwCJ4qZb8u40PFBPokOeS3YqbS9AVQc+A1Prl8/4LnSMXnqdV2tpJPnZNq5jxr
        7ZLf6fbx7XmmjsJiUY+8/9Fbyzjg2GdVTbBL+gIfixNCx+U+bnSEwhbaW2oqMW4Yg1xFbf
        +Gt8UyEMRLodq0oiyWV7cMjS7pexjU787bUDGjrAJBPTJFfeM45rU/eo9GIoTU/Gx9vNOd
        4xBoLM7VQUfi8Qy199sdcDPymo2ckW+t3C/jezMaFUIAHgHAz+jP/hpw0Z3a/0VFJkT6yb
        azviHQztC/llOT4ujEnJBlBDsYEqxJlT0Ss8+O505GApDV/h8vwlo/CiEkgp8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649536421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egZmKDvg6IRVw/Q4fbq2Nw60bz2xjHTKvAkA97n7N+4=;
        b=zHQKboNzYXSe51WOgP/xmlrWs55gY+k4csQAhZkEKmrJyLxAlPU9Z0j6oxlHtDzIxB2V9W
        fv+mmcS1k/rbvcCg==
To:     Steven Rostedt <rostedt@goodmis.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] timekeeping: Introduce fast accessor to clock tai
In-Reply-To: <20220409093727.7dda6371@rorschach.local.home>
References: <20220409081300.4762-1-kurt@linutronix.de>
 <20220409081300.4762-2-kurt@linutronix.de>
 <20220409093727.7dda6371@rorschach.local.home>
Date:   Sat, 09 Apr 2022 22:33:41 +0200
Message-ID: <871qy6hu8q.ffs@tglx>
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

On Sat, Apr 09 2022 at 09:37, Steven Rostedt wrote:
> On Sat,  9 Apr 2022 10:12:58 +0200
> Kurt Kanzenbach <kurt@linutronix.de> wrote:
>
>> ---
>>  include/linux/timekeeping.h |  1 +
>>  kernel/time/timekeeping.c   | 17 +++++++++++++++++
>>  2 files changed, 18 insertions(+)
>
> If the time keeping folks are OK with this and ack it, I'm happy to
> take this through my tree.

Go ahead. I just sent a Reviewed-by and I don't see conflicting changes
in that area. Famous last words :)

Thanks,

        tglx
