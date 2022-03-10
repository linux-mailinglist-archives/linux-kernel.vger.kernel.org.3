Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E024D4463
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbiCJKUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiCJKUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:20:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF313DE15;
        Thu, 10 Mar 2022 02:19:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47ABDB8258F;
        Thu, 10 Mar 2022 10:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED27BC340E9;
        Thu, 10 Mar 2022 10:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646907557;
        bh=XXD0vSzBZmcBzykyhLzyEkrCVoo5VlLApcFK+XQCz0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ov9/3jj+BPcOqyX7jjds+3n0MSCIhhVirM2wghviUZjV7idmrTevy0ryHo3EgVbVd
         arqbIfW1REUQvsv6HJEL6QuVe4rBVVBx6AAUr0SOnsg5hRMsyYGmRm+FeXju3Qa5Yj
         kwAGIoJWyqn6H70qu/RYuGG6gRvVSwijkYw+RRNP1lwPhyjnKckrc/rjncJbPTgYoO
         1ry6IRpRHhS1vyi0zsF8fF69lbF9GEuK6woMCRPrFsOLoqpW85YVz9u8L6m3U46P5M
         nO4wXWOnr4pG+2tpzF1BAZ+dEysdLVZ9xOgEu1gBm1WY1twbEZOh5zB+qtWhe9CDXu
         NBvAiZCwvefAQ==
Date:   Thu, 10 Mar 2022 12:19:09 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the memblock tree
Message-ID: <YinQncz54HIjp5HR@kernel.org>
References: <20220310211315.595cca09@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310211315.595cca09@canb.auug.org.au>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 09:13:15PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the memblock tree, today's linux-next build (KCONFIG_NAME)
> produced this warning:
> 
> Documentation/vm/index.rst:12: WARNING: toctree contains reference to nonexisting document 'vm/memblock-sim'
> 
> Introduced by commit
> 
>   cc5a1e382509 ("memblock tests: Add TODO and README files")

Huh, wrong git add, fixed now.

Thanks Stephen!

> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Sincerely yours,
Mike.
