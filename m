Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD69525630
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358263AbiELUC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358242AbiELUCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:02:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593DA5E746;
        Thu, 12 May 2022 13:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A9AFB827FB;
        Thu, 12 May 2022 20:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D15C385B8;
        Thu, 12 May 2022 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652385741;
        bh=xG3M7ynp6fXPzsJnjU3A+JFihfWe3iaUA5pquCim2sU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AVcp7CBfdHGYEFvfDESyEdAZ1feYNiZoDWO3vwFtQIfA8ucSKBeZ03Sddmky7z1Om
         0K6odpTnmMUgiz4dfjn1l5XWw438aePX4/39ttywu4ri7NZx3ojjKQICkRBs77wEWx
         +XZSQiynewY0za0DfJ+ENcNlo68HfXxEDzGe46Tk=
Date:   Thu, 12 May 2022 13:02:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: linux-next: manual merge of the mm-nonmm-stable tree with the
 userns tree
Message-Id: <20220512130220.c9ec9b150c9d5f3848ef3389@linux-foundation.org>
In-Reply-To: <20220512182215.2b7c4383@canb.auug.org.au>
References: <20220512182215.2b7c4383@canb.auug.org.au>
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

On Thu, 12 May 2022 18:22:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the mm-nonmm-stable tree got a conflict in:
> 
>   include/linux/ptrace.h
> 
> between commit:
> 
>   c200e4bb44e8 ("ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP")
> 
> from the userns tree and commit:
> 
>   a9866bef5171 ("ptrace: fix wrong comment of PT_DTRACE")
> 
> from the mm-nonmm-stable tree.
> 
> I fixed it up (the former removed the line modified by the latter, so I
> just removed it) and can carry the fix as necessary. This is now fixed
> as far as linux-next is concerned, but any non trivial conflicts should
> be mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

Thanks.

Eric, I'll send that patch to you for inclusion in the userns tree,
please.

