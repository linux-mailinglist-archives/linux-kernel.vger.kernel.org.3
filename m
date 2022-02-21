Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0500F4BE17A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbiBUJKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:10:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347532AbiBUJFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:05:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E72E0BE;
        Mon, 21 Feb 2022 00:59:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16E4061132;
        Mon, 21 Feb 2022 08:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F37C340EB;
        Mon, 21 Feb 2022 08:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645433954;
        bh=JSSkz6JDVVsI+47zV8Q+XVfwTHl1baGUJpcfSdWbuDI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HeIHqQIFKHM8049vKx1LZN3kU75xJmSqSydqHLqGgLhyg+Wl5RvXHNVcYooalkSRM
         ouTYDPiXpwUmTCw4zGrocSKK4lWPcTAV43k6n3pr8mfUzJmLpUgIFw+bJLr+evF+5n
         fvfm0XfCVBiC0bmVcLjO9zz7Is9dK8l47FFykORu+3NRKPcBSuZnHVupxCTVFzOT20
         OqTREa5Vh2nOkdZi++CM9ScSCKJZaSo5UnXdfvMKZ7wujtiicfHuVYnhegf5T/GVph
         oOc9ijmQq4O60zuvAhLxf4dHXpz8gN4oqTfas/0JdELudZQZxPKH64ykIIGMmnY/Jq
         mzGLiedH5EfMw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] bcma: cleanup comments
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220213213121.2806376-1-trix@redhat.com>
References: <20220213213121.2806376-1-trix@redhat.com>
To:     trix@redhat.com
Cc:     zajec5@gmail.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164543395140.995.4969921180404525569.kvalo@kernel.org>
Date:   Mon, 21 Feb 2022 08:59:13 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'info'.
> Replacements
> 'adventages' with 'advantages'
> 'strenth' with 'strength'
> 'atleast' with 'at least'
> 'thr'u'' with 'through'
> 'capabilty' with 'capability'
> 'controll' with 'control'
> 'ourself' with 'ourselves'
> 'noone' with 'no one'
> 'cores' to 'core's' and 'core'
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Patch applied to wireless-next.git, thanks.

032931fdd53b bcma: cleanup comments

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220213213121.2806376-1-trix@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

