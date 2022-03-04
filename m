Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213F54CD79B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbiCDPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbiCDPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:23:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E0DE86;
        Fri,  4 Mar 2022 07:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dl8wl3s8uRpHzhQQfk/gl5rjAM9mzFpqmF+8WWSj6sg=; b=s7QFCnEGuW7j6YzO8nA9TUYcfB
        odgJKNIv5d4Bo6gtlaAMZMkEbkaMXIK7J3sbbBaS6IJcZRGavKQ4v0iNju7oNTuQRDm8StLMrpyy/
        +hFpBhm0n1/ZOkZX0/1WBjIu28q6/TGqYizGOJbQ7gmPdqWBWzBXhVNr6eXFUXHVL5sL/qSvt+Vni
        bUgttbO7u+5aI0I+vsLzUMvGsCf3xue2tlJn/vgtAmP56y8TiN40NWaQjL4tdLYw9gH2Mivqncw5A
        D1jwbELLDg9UDgxxFbALAL3UyEIx1Gdwb3U9osSNA1/aUAXYZc3lQBeXi4xWL7HGKWJPsvAIkHLhm
        +7HOujqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQ9l3-00Cjne-Vg; Fri, 04 Mar 2022 15:22:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C5AE30026F;
        Fri,  4 Mar 2022 16:22:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 66D482012A02A; Fri,  4 Mar 2022 16:22:17 +0100 (CET)
Message-ID: <20220304151953.830111479@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 04 Mar 2022 16:19:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, mathias.nyman@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH 0/3] x86: Make XDBC work
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These are the patches I needed to make XDBC go on my tigerlake NUC.

