Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD7C52AECA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiEQXms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiEQXmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71B35DF3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEFB6614B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DB7C385B8;
        Tue, 17 May 2022 23:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652830961;
        bh=JIFpaexDSOP6MSf1uMpLxe1DziVdxW90GuJ4lwjZg7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D41bkAcEOmRLDkDINahNAudDMV9+YWKvganpvtNe6yy46Nbd+x2NdGWAgSAlvT7EC
         ycdiW0vmYM83ng5SeE7FY7epDlZDgM2zc027PxtHUVEiIflo85q2OcJhPRqbaYDt0A
         u5RGqYY2ZGq/4DJwNtaiDWJED9RokqxUmR6d69R8=
Date:   Tue, 17 May 2022 16:42:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/15] A few cleanup patches for swap
Message-Id: <20220517164239.d4e81d6f637afce5c304ec05@linux-foundation.org>
In-Reply-To: <20220509131416.17553-1-linmiaohe@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 21:14:01 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> This series contains a few patches to fix the comment, remove unneeded
> return value, use some helpers and so on. More details can be found in
> the respective changelogs. 

After dropping [10/14] and with the four fixlets I just sent out, I
believe this series is ready to be moved into mm-stable.  Is there
anything outstanding?


