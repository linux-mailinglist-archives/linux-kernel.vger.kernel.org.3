Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD0B492526
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbiARLqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbiARLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:46:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6D3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 03:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vqnZ5mGKPfst5rNIar7RHcY3kxPBaXqs26CfjQk8N90=; b=mOuBVcdZi8JRU0cyh/XNAe0MFu
        QjiB+M0BIRXFYwLrfpl+I2XjqATqMOD6SZjqCXHRaK4rfIOJnRdF2mXkJk5GbD1KFPUDtlD7PzwT2
        kDaXFnj3ROgQ3HDQME4O7o4H5Y5O35JJDxMJJcU+oYCMPCiEjWnYEqR4qB1Rqf4Dgztm4pj6o8Tfc
        TlN5pX8pG4YkGh3wFOl6iQojVmOhiPnUhpv2r43AEboRd94VuCnV/kL0ApcSO2JMX8cmii4pkdv8L
        MsupIpsmLKOxdo4cPVhebvtQtKxFgpB5grJWPfwquHwT464m/RSoFfTI8zlub4tz399WrcAXCtWrL
        T7pwKELw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9mw6-009B9Z-18; Tue, 18 Jan 2022 11:46:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A86D300222;
        Tue, 18 Jan 2022 12:46:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C879B203C2D6E; Tue, 18 Jan 2022 12:46:01 +0100 (CET)
Date:   Tue, 18 Jan 2022 12:46:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Suren as psi co-maintainer
Message-ID: <YeaoeQlAoj06qlNa@hirez.programming.kicks-ass.net>
References: <20220117120317.1581315-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117120317.1581315-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 07:03:17AM -0500, Johannes Weiner wrote:
> Suren wrote the poll() interface, which is a significant part of the
> psi code and represents a large user of psi itself (Android). It's a
> good idea to have him look at psi patches as well, and it's good to
> have two people following things in case one of us is traveling.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
