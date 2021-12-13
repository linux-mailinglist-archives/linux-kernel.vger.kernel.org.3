Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D426472F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhLMOck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbhLMOcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:32:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6539C061574;
        Mon, 13 Dec 2021 06:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3gP32EIV2oFStmGwYN5WhcnN2qmz98po9WQv+pzygO0=; b=lJ1zms/Vznlgw1yhv4MNArNbCZ
        08TpCGVuZDGwUwmexea4dghLqKmKyfKvykhTyKe4E5vn3ZPTjcj9+B4eOELGG0N06T+yxRyzh+fG9
        DNlGWf2ePZnbqjkg3Ewc4HD43XQNKLyUWof8PIpqc99/3m9isGgPKlHQMoCkFDznuZ7s6mIVLoPCR
        xLvfXAp9JaxzuLF6BB9P3LNDkq1EH/DdvVg+8gEbZiSC8x0bsBYgk0OjNCCaeDxi/zbxkOSoWK2il
        9w4V1TGvYVQa3AS9W4aZu4UzOZ3Z+cSkc7Ko++4VZNF8bFFHEB892IqaeLJ+IbfbynVJ+QHlYWRrz
        vcUgomTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwmNL-0018YB-83; Mon, 13 Dec 2021 14:32:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91A0B3001D0;
        Mon, 13 Dec 2021 15:32:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AA052D57ABA3; Mon, 13 Dec 2021 15:32:22 +0100 (CET)
Date:   Mon, 13 Dec 2021 15:32:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, wangweiyang2@huawei.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH -next] lockdep: Use memset_startat() helper in
 reinit_class()
Message-ID: <YbdZdu0DvPR45EH8@hirez.programming.kicks-ass.net>
References: <20211213132618.105737-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213132618.105737-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:26:18PM +0800, Xiu Jianfeng wrote:
> use memset_startat() helper to simplify the code, there is no functional
> change in this patch.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Thanks!
