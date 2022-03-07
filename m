Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26B64D06BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244836AbiCGSmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244678AbiCGSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:42:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34D89CCA;
        Mon,  7 Mar 2022 10:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AnQpy+CDKfDtY4QQZudHQdpgeWrJtSKsYjnfkkVUmUQ=; b=OO/hEqLDWwxPlC95pqlQZRFCKh
        yC1wlErdu65jOMRInajFRCqiXc3pN00nExJK+R3nB8qTCT5odXNhXv5bXcArfEXG7zL+bNT++GA45
        sKlJ/YxnlmK8l6BBVZfagTCra9BD2pHYeGHu4tbrukFRAh3SUnh1irfNi/DuoJMyzZB9zddx7Z021
        uzLfTex2y2YAEJ3ZCpMCbulb+91ftc211mOvWI6WXeImsLaCLVQjT444zpNTQyM6z2Zonb6ePYArJ
        XN4no0NRN6HxY/DLyN5tSKC8CHkkNzmwgMv98qtrE1r3ivOnhfRENq7HVhmohmAPrODz1v3eHPxys
        zhHUspWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRIHz-00FSw3-KI; Mon, 07 Mar 2022 18:40:59 +0000
Date:   Mon, 7 Mar 2022 18:40:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Clayton Whitelaw <cawhitelaw@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, rostedt@goodmis.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation/process: Replace broken link with snapshot
Message-ID: <YiZRu4P79EGHCisu@casper.infradead.org>
References: <20220307174301.1852106-1-cawhitelaw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307174301.1852106-1-cawhitelaw@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 10:43:01AM -0700, Clayton Whitelaw wrote:
> The link is for the reference article, "The perfect patch":
> https://www.ozlabs.org/~akpm/stuff/tpp.txt
> 
> This link is down currently and apparently since at least 2022 Jan:
> https://web.archive.org/web/20220112192643/https://www.ozlabs.org/~akpm/stuff/tpp.txt

The directory is still there:
https://ozlabs.org/~akpm/stuff/

but the file is gone.  Andrew, any reason you deleted it?
