Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D664DAFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355616AbiCPMc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiCPMc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:32:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C05242EFB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:31:13 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF1951EC03C9;
        Wed, 16 Mar 2022 13:31:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647433867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qMIjVS8BeT+tVF68txhAOz+wyR0Q9rCb1N6DeL44fX0=;
        b=hL0xJN5AWUiB2PAVXFw1YkEWFmhukb/TpUgO2lR32MjopasaopsK8BWvfEiqAnpqHlpNlT
        KVpOSumQqvKMydhvt4nWfk49njmZk0JCFOCdpV1AmuwUM416Kb+vsYPEfilGn/bOc6Gxwu
        miHQY35kWjsX1AjAwhPrdVAMgVPwnpE=
Date:   Wed, 16 Mar 2022 13:31:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jamie Heilman <jamie@audible.transient.net>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: system locks up with CONFIG_SLS=Y; 5.17.0-rc
Message-ID: <YjHYh3XRbHwrlLbR@zn.tnic>
References: <YjGzJwjrvxg5YZ0Z@audible.transient.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjGzJwjrvxg5YZ0Z@audible.transient.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 09:51:35AM +0000, Jamie Heilman wrote:
> I've been (somewhat unsuccessfully) trying to bisect a hard lock-up
> of my workstation that occurs when I'm running 5.17 rc kernels a few
> seconds after I start a kvm guest instance.  There is no output to
> any log, everything locks up completely, sysrq doesn't even work
> anymore.

Any chance you can connect that box with a serial cable, get serial
console working and see if you can catch dmesg with it this way?

https://www.kernel.org/doc/html/latest/admin-guide/serial-console.html

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
