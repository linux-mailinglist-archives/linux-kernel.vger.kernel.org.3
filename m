Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B441450660F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349463AbiDSHki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349460AbiDSHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:40:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CF923155
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vjOnXjNPEqRmHx/BeXVW6346i3KEjyA9mSSIl0BRIaU=; b=P7lbS84w0PHNRblktdOPrgpRCo
        rd1P4AnGxndKibk7wYydSXu65UqO1XhLTvbfIdNPPv/717lqErU7EG4v9RJdgtoxHb9HF+7E+CG1/
        vB0k3zVCigrIRTx6mdFT37tRTvIxdQqSiY0UkjmNI23r1CTXLNKORuVRd6cKwLdqOyyhn1JCuXDUN
        hoROoKKVoxggMmTvGRHboIyYIN9IuNE8LwPRoMFZCvMoS1ropYg/HC7RLD8vmZ78DCNhtUwEyMxBG
        xDK6l+B4KEeNCNc87YZRg4Jh6CgBzASCyNO2YkZXnEZZAV2S602yMNEyllsUKqqQLZ0nEC2A32GWE
        HfMLtnnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngiQY-006khl-LL; Tue, 19 Apr 2022 07:37:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9703298618A; Tue, 19 Apr 2022 09:37:32 +0200 (CEST)
Date:   Tue, 19 Apr 2022 09:37:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     liqiong <liqiong@nfschina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH] arch/x86: use 'NULL' insteadof '0' as null pointer
Message-ID: <20220419073732.GJ2731@worktop.programming.kicks-ass.net>
References: <20220417154148.541485-1-liqiong@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417154148.541485-1-liqiong@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 11:41:48PM +0800, liqiong wrote:
> Sparse warns: "Using plain integer as NULL pointer".

What's wrong with that?
