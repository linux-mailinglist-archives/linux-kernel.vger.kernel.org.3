Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E546A51D77A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391814AbiEFMYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359058AbiEFMYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:24:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E7718E30
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b84/BHbo0wHgyCwxM2AZUcMMFYF7zdy8aClhuFJsWD8=; b=aMzOvGU5ad9q+TfAxi7SAS9GSu
        5K7PNSI91KXcnM7wcM/5QfIybJQ7FhklN0Y++uitouGxHx5PaOIW5yK96k5F7x0lnK3vxJYBBI04E
        cgJBLLYRoykxcq1lZWnbk2SM6C43+b51Gp95qx7epCLKuxWOqYeaGGpouUvuqQEXJ3q5ufm9V39B/
        ocI7qLnSpHxjC5Glql5vU+F+LJ0k5EL8K5uLdwG5TWDNQpAvcFSKbtv3idsn8WpArgWY5RQZPRK1U
        Jndf2wD9PoAk2O33CAhQVuXCjritKKrdtdMkuBpPXO7MIpZLYXouEH4HRTP8GYA49YIOci/2VfrLk
        nsy4CTxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmwwU-000vKs-AS; Fri, 06 May 2022 12:20:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EC4C3005B7;
        Fri,  6 May 2022 14:20:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DE45620299B70; Fri,  6 May 2022 14:20:15 +0200 (CEST)
Message-ID: <20220506121431.563656641@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 06 May 2022 14:14:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com
Subject: [PATCH 0/6] x86: Various cleanups and fixes
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some few (mostly entry) cleanups.

Please consider.

