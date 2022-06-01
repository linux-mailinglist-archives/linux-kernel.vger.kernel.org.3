Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88C553AFCF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiFAVYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiFAVYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEE1121CE4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D35646133B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92C9C385A5;
        Wed,  1 Jun 2022 21:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654118639;
        bh=51+biqQGliRkdr5X8QvsCd+LKtg1hqhG9zWddLsNgGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ofpVJbE5PyVeNrTon+JwNoybViMg72GORyaNaXSz/O/GMTR2YlzBPA8qqXpfei8g7
         B9NgYNrl/pwELh+BN2K52EgL6AH+IFTYna1+F8kMTjUiWQLrexRHI2bJTaqG/8DdaQ
         8imL4cS5xyTS/L2lXEVOE8xxi9PFxt+RSTLpu6uQ=
Date:   Wed, 1 Jun 2022 14:23:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v5 2/6] mm: shrinkers: introduce debugfs interface for
 memory shrinkers
Message-Id: <20220601142358.75a6c9c5d4a988bd58667717@linux-foundation.org>
In-Reply-To: <20220601032227.4076670-3-roman.gushchin@linux.dev>
References: <20220601032227.4076670-1-roman.gushchin@linux.dev>
        <20220601032227.4076670-3-roman.gushchin@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 20:22:23 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> This commit introduces the /sys/kernel/debug/shrinker debugfs
> interface

Should it be at the top level?  Maybe /sys/kernel/debug/vm/shrinker
would be more future-safe. (or .../mm/...)

