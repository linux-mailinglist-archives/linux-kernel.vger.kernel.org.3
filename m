Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF85819E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbiGZSpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiGZSpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E5B5FDA;
        Tue, 26 Jul 2022 11:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0CBF614E8;
        Tue, 26 Jul 2022 18:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC97FC433C1;
        Tue, 26 Jul 2022 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658861115;
        bh=XNiVCrSehIFI0PdwBcwOkLGtkl6DYPMnCOCRi3ZD5lc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WFQ4nfwCsOLHy5sDbXEKwzxEZFC2ZrJ7GWTvzs/ltIuZDMoB4G0OwA5HhY8oA07h+
         yBYTBowHQzn+231tEeBHwl8w8VmV9obSwBx1CgtgfRSMFi3aqOI5A4E8gMOe2Nny8k
         PfUKjVHtm5EvQ++jRMFo9VJe/RjAwyPjI+oPaqsM=
Date:   Tue, 26 Jul 2022 11:45:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: run time warning after merge of the mm tree
Message-Id: <20220726114513.88a691eae4ce4305ad9fead8@linux-foundation.org>
In-Reply-To: <20220726212340.72499268@canb.auug.org.au>
References: <20220726212340.72499268@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 21:23:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> I am wondering if maybe the -unstable parts of the mm tree should be
> dropped in the last week before the merge window opens on the
> understanding that those changes may be too late for this release?

Yes, we've been discussing that.  I'll temporarily drop mapletree
today, along with some other series which are significantly dependent
upon it.

