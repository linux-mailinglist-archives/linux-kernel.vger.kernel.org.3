Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F694D0A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiCGVog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244662AbiCGVoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:44:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6773555496;
        Mon,  7 Mar 2022 13:43:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2495EB815E0;
        Mon,  7 Mar 2022 21:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD754C340E9;
        Mon,  7 Mar 2022 21:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646689383;
        bh=eRMJgtnDGNNfgUuXduX0onTDj3k2zP2aHDdREvIZkjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YV4optdzdCMwxfSQOm9avBRX0BAhXvUJKhLdEij6AbCi6o5ATS+oqGCmk5nEwWtg1
         H4mpclnkUN+o8tx4quKs3A/4JxUtkuLGqRBXL6l+0ZM5hf/uz99BQqkV9vK0tJVMvm
         euEKO22ONfA9/55r7KHTWuBZLzEDj/kNukYhQPgY=
Date:   Mon, 7 Mar 2022 13:43:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Clayton Whitelaw <cawhitelaw@google.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH] Documentation/process: Replace broken link with
 snapshot
Message-Id: <20220307134302.faaf3149ead4ccf0fb05a703@linux-foundation.org>
In-Reply-To: <87o82hd575.fsf@meer.lwn.net>
References: <20220307174301.1852106-1-cawhitelaw@google.com>
        <87o82hd575.fsf@meer.lwn.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2022 10:48:30 -0700 Jonathan Corbet <corbet@lwn.net> wrote:

> Clayton Whitelaw <cawhitelaw@google.com> writes:
> 
> > The link is for the reference article, "The perfect patch":
> > https://www.ozlabs.org/~akpm/stuff/tpp.txt
> >
> > This link is down currently and apparently since at least 2022 Jan:
> > https://web.archive.org/web/20220112192643/https://www.ozlabs.org/~akpm/stuff/tpp.txt
> >
> > Replace with most recent good snapshot, from 2021 Oct
> 
> We can do that, but first maybe we should ask Andrew (CC'd) whether he
> has a copy up somewhere that we can link to?
> 

Huh, whatever happened to that?

I had a copy and have restored the file on ozlabs, thanks.
