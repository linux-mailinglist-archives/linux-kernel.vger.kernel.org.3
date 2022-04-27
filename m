Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CBC51170C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiD0MBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiD0MBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:01:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7396C34B81
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xWBQDOMsDvcvRBIfRq97FuFoMmO767+6v9ExW2x3pNY=;
        t=1651060714; x=1652270314; b=pNTjbjzvIowXkZPCgjPWidbqkJa6NXzQ4tibYg5MRnINs1y
        c66YhtmYz4Qo/rVNsRWdLs0cwE0oGVYs9aPv9n9et4jU/YDidAG2oIVJSFgx8u8mJxpcqgnERWcqi
        Zl3MKaGPtVWCUPnITbYWbboXrOlXxLNz9nHb4X+YQsE34eUfbxbRqFIqysKIU5Re+DrlcHasCvGNY
        u3s4OJfs3rSzJd8lyfE824TjcHUAUveXhiFGMilnqrtthKEZZJRt1R5TOyVWmSX+4RA/RYidug5MA
        QSr5kOCWsVB2tiQXm3YfVFugfbxt+Umywcza+gNjRH0tD7CG4xul9BAQZBRsLQzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1njgJO-00FslB-VA;
        Wed, 27 Apr 2022 13:58:27 +0200
Message-ID: <b3afca400cb3c822164daa9f839eeb443675a4da.camel@sipsolutions.net>
Subject: Re: [PATCH v2 ] devcoredump : Serialize devcd_del work
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kees Cook <keescook@chromium.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org
Date:   Wed, 27 Apr 2022 13:58:25 +0200
In-Reply-To: <202204261421.A58121A53E@keescook>
References: <87levt14kn.ffs@tglx>
         <8186de033c87f0cdec296ae272a72c5b9a2880a3.camel@sipsolutions.net>
         <878rrt0xa2.ffs@tglx> <13df1664-fc52-4772-afa1-4f75019b7830@quicinc.com>
         <202204261421.A58121A53E@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 14:25 -0700, Kees Cook wrote:
> > 
> > https://lore.kernel.org/lkml/1650981343-11739-1-git-send-email-quic_mojha@quicinc.com/
> > 
> > While, we would like to hear from Kees about reason of immediate flush from
> > disabled_store().
> 
> This is lost to ancient history in my brain right now. Do you have any
> references to past threads on this? The only thing I remember about
> device memory dumping was just to make sure that lockdown's
> CONFIDENTIALITY mode would block it.
> 

Hm, no, I don't, sorry. I don't even have an email record of it now,
perhaps it went to my @intel.com and has long expired?

Anyway, I seem to remember you asking to have a disable bit and I
implemented it in commit d45333294da8, which you reviewed, but I have no
record of you asking for it even though I think you did :)

johannes
