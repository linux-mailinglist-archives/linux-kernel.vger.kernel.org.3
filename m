Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CBB57A0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbiGSONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiGSOMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:12:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538FD5C372
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:35:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658237730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnYq6kN6bZRw+gZhQTcxVE6Zaw22X085XwpGGsnc0LI=;
        b=CyQEYGGv+AFbgFIFSVpPcaxfJX/ngoVpor7h4qInTeMHbdY8wjllGC2ysdiEZclzyA+6QX
        Elao6wEKx4pcSrnnbacxDhULrLTPELo6o/9D+IPZ4dIuoBg+8/UCE+mphJPAM19IAjy3Bc
        al78C74Y4QHVf+JMdKgaOklGX+GP3OEtG/gPT4EutfX7KFHDdtsxo0n7y4j9zAMty0P5CE
        +nfmz8TLMWlIcd0c401mUO9uyZueho9zQCd5yVim691NlfKgmW2qVdTn4At8sdzxN4H30i
        ccv9F1G2/Mr71Ih6WdAqPBp5rNbWCs0tslowBgtqijlsLmWVUdkTP3Nd1GAb8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658237730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnYq6kN6bZRw+gZhQTcxVE6Zaw22X085XwpGGsnc0LI=;
        b=Hvbtsovu3CPZLdEdwIuCVOFYPLOXESjdnVO+pH3Y64lU7v6N4Qr3K9QNomxJsuJ7WDer8p
        qkq2+myhCwm4f7Cg==
To:     Petr Mladek <pmladek@suse.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] scripts/gdb: fix 'lx-dmesg' on 32 bits arch
In-Reply-To: <20220719122831.19890-1-pmladek@suse.com>
References: <20220719122831.19890-1-pmladek@suse.com>
Date:   Tue, 19 Jul 2022 15:41:30 +0206
Message-ID: <878ropw7h9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-19, Petr Mladek <pmladek@suse.com> wrote:
> From: Antonio Borneo <antonio.borneo@foss.st.com>
>
...
>
> Query the really used atomic_long_t counter type size.
>
> Fixes: e60768311af8 ("scripts/gdb: update for lockless printk ringbuffer")
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> [pmladek@suse.com: Query the really used atomic_long_t counter type size]
> Tested-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Link: https://lore.kernel.org/r/20220617143758.137307-1-antonio.borneo@foss.st.com

Reviewed-by: John Ogness <john.ogness@linutronix.de>
