Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9106751CEFB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiEFC3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiEFC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:29:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882EFB1F3
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 19:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25EDDB831CD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 02:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2007C385AC;
        Fri,  6 May 2022 02:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651803919;
        bh=RS+5nGtbyZAgYQKm1nVh9VQrz6L+6TXFd+TRcYfNxrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R6m5CItEhjzmGEKf6p/Ji3zslsSqh8995tcpaxJKPVBZxPqAYc7JnmoDu89pN1Yv+
         1LGDMUy2PMNXaSIOJljV/y9OZVZxKnmwnLINweoUmoDcJ2/5/W5tEutyEiSPlmztyV
         Jn3/mYTz6aqhIGKQ8gV90E4jJCyedvdCVVUwBQhw=
Date:   Thu, 5 May 2022 19:25:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/69] Maple Tree v9
Message-Id: <20220505192518.72ae9ada349f2880ba90c3e9@linux-foundation.org>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 01:07:38 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> Please merge this patch set into the mm tree.

Well that was kinda confusing ;)

I have it all landed and compiling, thanks.  I'll suppress the usual
added-to-mm emails - an armistice in my war against `d' keys.

