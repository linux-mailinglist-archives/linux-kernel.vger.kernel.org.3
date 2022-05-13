Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390F0526772
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382491AbiEMQtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiEMQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86452B1C2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C90C61EC1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7542EC34100;
        Fri, 13 May 2022 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652460584;
        bh=mUX0Xcwwx67LlSBLq+jKjiwyAlTMM655BwwpJuB/BSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g9fEy3Gu9ZIv+ASzdpfuwVItlSUvaEhaXC0wziffu9YtmFtW1db0QpRQTbfkf6NfV
         KhFxftSXMH4XiuIUnGqW8NtCNN87vhr9ABYozsecsvSjwm7t+Q8AsKOTW9o9UlbmvI
         nkK/e4TNnjnquzKnJaTRkroUALQoYZ+SilcTmtSk=
Date:   Fri, 13 May 2022 09:49:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mapletree-vs-khugepaged
Message-Id: <20220513094943.dc1b1da5f9edb0b66e61cf2d@linux-foundation.org>
In-Reply-To: <yt9dk0apbicu.fsf@linux.ibm.com>
References: <20220428172040.GA3623323@roeck-us.net>
        <YmvVkKXJWBoGqWFx@osiris>
        <yt9dk0apbicu.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 16:46:41 +0200 Sven Schnelle <svens@linux.ibm.com> wrote:

> IS that issue supposed to be fixed? git bisect pointed me to
> 
> # bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
>   'mm-everything' of
>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> which isn't really helpful.
> 
> Anything we could help with debugging this?

git-bisect is still doing that?  There's a way of nudging it, but I
forget.

Perhaps you could grab the mm-unstable branch from
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm and bisect that?

