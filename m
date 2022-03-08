Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1534D111B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbiCHHhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiCHHhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:37:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232903DDCD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:36:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1490B8165F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7841BC340EB;
        Tue,  8 Mar 2022 07:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646724964;
        bh=xKfgDxtalAdHsX4uwNuW8jni1gTmi1k3960oPdqc3Bw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tjrsTD2bR62ZjLEMJj3QR1GlnmCatbhTHEfv3fuBz7WZoKLrDGzqjCfDMbidfkRHk
         aBaQ8Av2uybwZNZ+B5CBNxjY2T4+qptCscUPf3/FRE8+7ni9XxVs+0ePwWwPBGgZjl
         4/axYiqzkVBhAIrtMD8ic+5lqwugg+gzTl+VIatltmM60xZU0AXWoxMqFEA0+dY5yn
         W8h3TgdETjv5oUaKFJ+N7woF5VJ3eY13xXqk07AYv3Z7/6foDZhtWPlY31rcZzhkHr
         n4xisXmVvq020xsHghOmtHu2hx0UvtOiA5wZ7z91dGOQ008R+Vg1+AytkpB6FsIat9
         vop0IVL3JInJw==
Date:   Tue, 8 Mar 2022 16:36:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: tracing : bootconfig : Early boot config for non intrd systems
Message-Id: <20220308163600.3109f19854c7b051924f262b@kernel.org>
In-Reply-To: <20220307184011.GA2570@pswork>
References: <20220307184011.GA2570@pswork>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Padmanabha,

On Mon, 7 Mar 2022 19:40:11 +0100
Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:

> Hello Masami Hiramatsu,
> 
> Thanks for detailed explanation on boot time tracing using early boot configuration file.
> https://linuxfoundation.org/wp-content/uploads/boottrace-LF-live-2021-update.pdf
> 
> Also for https://lwn.net/Articles/806002/.
> 
> Latter link also states we can embed boot config into the kernel image for non intrd based system.

Ah, that was an original plan, but since no one interested in, I didn't implement it.
So we still need the initrd for bootconfig.

> 
> I tried searching mailing lists not able to find pointer for same.
> 
> A hint/pointer on how-to will be very helpful. 

BTW, what is your problem, could you share your use-case?

Thank you,

> 
> Thanks and Regards,
> Padmanabha.S
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
