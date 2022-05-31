Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB5539507
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346196AbiEaQjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiEaQjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:39:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74D4994E0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F28FB815DA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87B9C385A9;
        Tue, 31 May 2022 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654015169;
        bh=A/DHL/tNx0HHEWTdHtaMQABpN/kFJ14iw7pqcuvysUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nFYoRZeVc5MGDgAeAunzGOeED0NPZTkckOgSemM9vpUjLxbU01GPCuod8QAKc92Mo
         Wy2+FFdCxZ3ojIQxaHGqfd07nBzIiTMyd5gXa+AmyTFFidn3tb+mEfskdK8R7i8PCN
         JO98Kmzd+xho+J1qVGiQGQytm66aGgcraYoFngiE=
Date:   Tue, 31 May 2022 09:39:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Diederik de Haas <didi.debian@cknow.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        970639@bugs.debian.org, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: Re: ZSWAP still considered experimental?
Message-Id: <20220531093927.2292b3defaf9b8cf431ca369@linux-foundation.org>
In-Reply-To: <10087857.nUPlyArG6x@bagend>
References: <10087857.nUPlyArG6x@bagend>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 10:41:05 +0200 Diederik de Haas <didi.debian@cknow.org> wrote:

> In https://bugs.debian.org/970639 the request was made to enable ZSWAP.
> 
> Upon it was (rightly) noted that zswap.rst contained this:
> > Zswap is a new feature as of v3.11 and interacts heavily with memory
> > reclaim.  This interaction has not been fully explored on the large set
> > of potential configurations and workloads that exist.  For this reason,
> > zswap is a work in progress and should be considered experimental.
> 
> Furthermore the mm/Kconfig contains this on the ZSWAP option:
> > Compressed cache for swap pages (EXPERIMENTAL)
> 
> But the contents of that zswap.rst hasn't changed since the initial commit  
> 61b0d76017a50c263c303fa263b295b04e0c68f6 from 2013-07-11.
> 
> Similarly, that line in Kconfig hasn't changed either since the initial commit
> 2b2811178e85553405b86e3fe78357b9b95889ce from 2013-07-11.
> 
> Should ZSWAP should still be considered experimental or not?

I'd say "not".
