Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84253592F59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiHONFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiHONE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:04:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A213F14
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JBsYsHNQOPaZ948dk66lvAF/aD4bnqX0dYrshuXzMVA=; b=HFoFOXpraaKL8DZh8t+ujOscao
        J8fazQPV8Q6Vs/+JtUi9aWpnC8DKoy5oc1BT5uiumbyGpFI1gzdk2h5WPkozB3ExFbD7b3h7zTRSW
        a4MDaqrv+H32CPir2aOEM4s4+KhsCFoTZHBn51xjyBnk/+sl4qXHzGpNU/4dRXzFarm/zOh246Di4
        8bdIQSbvKLNvEkHClVNyvSWiAZExWw0FhIKbcuEwIFsiUsAuvJ9Uy/UedQgN1ogeMh81ZS7cToDWw
        eYe2HMEnnWhvryinjhv+3nWSx0zMcq7NCERV4QNYB0MigFpRnyk5b6cz2TJrmrqqfO2YuYe+/wW+x
        0RCccUig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNZlv-005jfn-40; Mon, 15 Aug 2022 13:04:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78D9C980153; Mon, 15 Aug 2022 15:04:45 +0200 (CEST)
Date:   Mon, 15 Aug 2022 15:04:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/5] x86/microcode/intel: Allow a late-load only if a min
 rev is specified
Message-ID: <YvpEbby2yp78Br9E@worktop.programming.kicks-ass.net>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-4-ashok.raj@intel.com>
 <Yvn5vBRNz9z8Y4A9@worktop.programming.kicks-ass.net>
 <Yvo+4odYjQEkvmRr@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvo+4odYjQEkvmRr@araj-dh-work>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:41:06PM +0000, Ashok Raj wrote:

> OR
> 
> The release missed specifying a min-rev before release, accidently even
> though its actually removing a feature? That would be in the bug category.
> 
> Release should have validation tests to cover all known feature bits and
> such and check for any misses after an update as part of the qual process.

This; it would be very unfortunate if this ever happened.
