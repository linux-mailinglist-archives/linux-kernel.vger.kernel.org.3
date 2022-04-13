Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F88500173
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiDMWAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiDMWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:00:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7365289A6;
        Wed, 13 Apr 2022 14:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BC8BB8278B;
        Wed, 13 Apr 2022 21:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E193FC385A6;
        Wed, 13 Apr 2022 21:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649887103;
        bh=3Qp8VakLhp3AT/Ltza7kSfd4UrLpvGlIXVTq7iBxA8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aF8OBacYw1Ms5OVAjVzXxx6KgYYxb/1BZB3jCWeUnCB8KA7bffTAKkSeH0cVuJ22/
         6UmkqmLYf+hz0ToBjepct5ZaaApTiGxj1t8k83I/hcFKUbX7ePjIPK1w3habU3Svj8
         boJXaAjvp2rcDvsulnXI6+SrFswlNcUdgo8wOF+ygofQ9kwrVtmVOwTYLH0UhMa81K
         NbZWRNsVMYcDRWI15/BaMpa7OnIR+gXfFb3XdI9a+iYmXGEjFWPX9n/7UIBR6iByUz
         dUpMV0IImVZKmAavYWbwJ7xXbjd4CnHXjZRa20oqMoJwbdd97pwaqjq9D0I2cgRD4O
         tU53Ghmzf6QlA==
Date:   Wed, 13 Apr 2022 14:58:21 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the f2fs tree
Message-ID: <YldHfXQCUzb3ZqG3@google.com>
References: <20220414074156.2c454505@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414074156.2c454505@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   4b6857882c90 ("f2fs: remove obsolete whint_mode")
> 
> Fixes tag
> 
>   Fixes: commit 41d36a9f3e53 ("fs: remove kiocb.ki_hint")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected

Thanks, fixed.

> 
> -- 
> Cheers,
> Stephen Rothwell


