Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653855221DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347741AbiEJRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244449AbiEJRAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:00:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532220AE61;
        Tue, 10 May 2022 09:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE494B81DB8;
        Tue, 10 May 2022 16:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F1C385C2;
        Tue, 10 May 2022 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652201769;
        bh=mh83TmFelz80HL/8GhIxyJ2MziolbRRFueVF+q7tiss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0DJVOD2cOR0AEYQ86fvh4bRorcZVPqyLmvyGS7zqdaTZcx4OIZv+DW09+3qLivvC6
         u07Gw1ZJh/1YilnkZOyv3/oz+fi92Zjszm4l5vMD0R3cU7I802JqayFGOZ2rWn8vvr
         NKgd6zC7fRh82mLFAvchsHxazJ19QMmbFEq3+NNk=
Date:   Tue, 10 May 2022 09:56:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm tree with the mm-hotfixes
 tree
Message-Id: <20220510095608.41b0f63a41a5e7f76c1fa187@linux-foundation.org>
In-Reply-To: <20220510223530.67d9a27f@canb.auug.org.au>
References: <20220510223530.67d9a27f@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 22:35:30 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Today's linux-next merge of the akpm tree got a conflict in:
> 
>   tools/testing/selftests/vm/Makefile
> 
> between commit:
> 
>   e33ebf536f3e ("selftests: vm: Makefile: rename TARGETS to VMTARGETS")
> 
> from the mm-hotfixes tree and patch:
> 
>   "kselftest/vm: override TARGETS from arguments"
> 
> from the akpm tree.

Thanks.  Let's just drop
kselftest-vm-override-targets-from-arguments.patch for now - a new
version is in the works.

