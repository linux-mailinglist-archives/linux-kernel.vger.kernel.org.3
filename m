Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B552A85B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351099AbiEQQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351114AbiEQQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1381D403FF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 654CB6130C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4DAC385B8;
        Tue, 17 May 2022 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652805751;
        bh=40QgoKo6FsbvUbi5QdZQ8LuhD5fRy9TTvAullSg1NJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwWIlS2PIiYyBVnn4Mwh5gpkaGvjZ9XXs6xAfg/B47Nwbmbxt1jD4gbBJqWNjqdMQ
         9HsczaMvfd1/rGWYbOOfRQQ8ljqODK0+cJuySkUlONzKGxTAf8vwfrIVpXgVVx8uEs
         2wEIDbBj2r6oEJ8Bg+f36Z7hiv1BLcfQOKNiXlvcmlPA51l29SkqrSaHJPFlCkSIOv
         ZO+9XIU4/ifqWs5xRjRbqYPsENsylbITKTx1dz0Y7FgDcqk5osLy4ZTnejsI+dxtEZ
         bmhi2bch/bLTXyegzpR1TlkIA84eFyb3Od9vzJccH13ypTlfBkZZJB3euhFYap4q4G
         St6J2fKtLWqSA==
Date:   Tue, 17 May 2022 09:42:29 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: xen: remove STACK_FRAME_NON_STANDARD from xen_cpuid
Message-ID: <20220517164229.ixz7fqxwrxwmiizn@treble>
References: <20220517162425.100567-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517162425.100567-1-mheyne@amazon.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 04:24:25PM +0000, Maximilian Heyne wrote:
> Since commit 4d65adfcd119 ("x86: xen: insn: Decode Xen and KVM
> emulate-prefix signature"), objtool is able to correctly parse the
> prefixed instruction in xen_cpuid and emit correct orc unwind
> information. Hence, marking the function as STACKFRAME_NON_STANDARD is
> no longer needed.
> 
> This commit is basically a revert of commit 983bb6d254c7 ("x86/xen: Mark
> xen_cpuid() stack frame as non-standard").
> 
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> CC: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> cr: https://code.amazon.com/reviews/CR-69645080
      ^^^^^

This looks like an internal amazon link and should be removed.
Otherwise, looks good to me.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
