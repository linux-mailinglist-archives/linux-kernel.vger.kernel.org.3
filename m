Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E314B302F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353995AbiBKWK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:10:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353972AbiBKWKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:10:54 -0500
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 14:10:52 PST
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DCACF9;
        Fri, 11 Feb 2022 14:10:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id E34C75800E8;
        Fri, 11 Feb 2022 17:01:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Feb 2022 17:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5zf6jVEQjwVSQ5ZFe
        HnTKZGFpRdZHZ64iwTJ9Ju+0KE=; b=LlFvrTcCq1B+2kEzvZkHLSNkaWQr+m3ZZ
        +0eNXDEcpgjZKJLxRPUU7XKWitNaITB5A24lv7mV5wFNdlg0F/oFQoyenr8w1mH/
        tzlG/0nSoAwyu/3ZvJ3nf/TvNmpBOrTo9uwSCv+QOqVFmJo7zB8bXWV8br2jfFt4
        8YpVXRleEQuGoWwUV9YZ0z4iJYJjLa2bSPfcjSbC51AF5Su871F1cf9viY3KmNcN
        QrZMKWh8gPwaTrVWg2hQWLmVHydYnu0E5QTrExMqSyupjRb0QuPAmAMctEZeFKpX
        S0LNElQDEz4zuHSkj2fotjAV8Fx+pSnHiwVFUtso3CkNry6xR44/w==
X-ME-Sender: <xms:q9wGYn48OGhGsL8cJ8uYo8qg0iS1w3eSwpSXUALEMiGOjCSEBUALBw>
    <xme:q9wGYs4RaTaEjtoL8gRFIavTAIMUj78qxHJBIiJxvFpaXQGWETFawyilaAjcFQIqD
    0knvYX5_lf0YHCwd1o>
X-ME-Received: <xmr:q9wGYucABJbEybN1WMgSQFiQJTytRIVIe4hXHpQIYfw7EMTzhwYw6wyAxL6wQixK6o1Do7vysV2iU8rnLzbGl8-WORiwgEX13ME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:q9wGYoJYW-TUBr2EYt8mEOqMinOi3-peDoIC-mAjQGqPgu3cg_MifA>
    <xmx:q9wGYrI_hdzBCJKO34Xz4nTZ6qKmVPEgK_XTo1FkhKRNcrIzELAmKg>
    <xmx:q9wGYhyn9DBmzMoSqb-Wu9VkYGRZW6ipQTjxpRDmB-WJ_kZknYQ0yw>
    <xmx:rdwGYr9J_xCb6W1UqUIVb-n7z5Gv3lAyoRa5bB7MSFahBmLExEQg_Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 17:01:12 -0500 (EST)
Date:   Sat, 12 Feb 2022 09:01:19 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH RFC v0] random: block in /dev/urandom
In-Reply-To: <20220211210757.612595-1-Jason@zx2c4.com>
Message-ID: <a7c12f2-c12-f0ea-ad44-10fb607d86@linux-m68k.org>
References: <20220211210757.612595-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022, Jason A. Donenfeld wrote:

> + * Reading from /dev/random and /dev/urandom both the same effect as
> + * calling getrandom(2) with flags=0. In earlier versions, however,
> + * they each had vastly different semantics and should therefore be
> + * avoided to prevent backwards compatibility issues.

If the end result "should be avoided", then why bother? IOW, how does this 
improve the ABI? I know you said it's a "panacea" but I'm afraid that's 
not clear to me and the patch description doesn't explain it.
