Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC203573D92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiGMUHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiGMUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:07:21 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205930F4E;
        Wed, 13 Jul 2022 13:07:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8189B2DC;
        Wed, 13 Jul 2022 20:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8189B2DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657742839; bh=Gg0x3XgAR86RJogBY3e5HKNUB7GioqlXEzqUCv/sLD0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UkhcQCwhctMMn34ABbQ1G8480kJFTNxxxaZGGoMgkxYzyXxOS+43URD4cQq6CrkHA
         R/JJETgcITMmYuPke++8blkcmRfdTxdQZ/q1CnDvYfqjwYBQvsW7FGZk3a+i6+yHbu
         n9368RxHfv9M5SkU98wnsiAN4//KX1bmoGELObpMMgY4Eh3qWly52JjkdDILb9pCtp
         gzGOX1rYFd2U90NggiEOLHZayfxad9fc3TJgrlxnKHza1gEeDgzZaJMDJyrAup6EN4
         TKAJxDMGmcKXVs6paq78O2gRLWNn+v6SKkFZfnTKjhC0JRs0WErXkmIAd5dXVU6G7s
         LRYItmm3+LoUA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH 1/5] docs: sysctl: remove references to inode-max
In-Reply-To: <20220712172619.359052-1-steve@sk2.org>
References: <20220712172619.359052-1-steve@sk2.org>
Date:   Wed, 13 Jul 2022 14:07:18 -0600
Message-ID: <87y1ww3hft.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Kitt <steve@sk2.org> writes:

> inode-max was removed in 2.3.20pre1, remove references to it in the
> sysctl documentation.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

These patches look good to me, but I'd feel better if you would post the
set, with a proper cover letter, to linux-fsdevel to get the attention
of folks who know this stuff a bit better.

Thanks,

jon
