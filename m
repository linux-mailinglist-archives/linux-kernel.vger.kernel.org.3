Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F1157E1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiGVNEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiGVNEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C1AFB45;
        Fri, 22 Jul 2022 06:04:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE4361F0C;
        Fri, 22 Jul 2022 13:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179ECC341C6;
        Fri, 22 Jul 2022 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658495061;
        bh=LlFCSEN1b4eCAl4kQVKpesxHnF3XtrdrYgvhd2XWf3Y=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OvXe/QyiK5qCfKUOSnHasdGez0dFqoK8EuRRwSfXaNAGAsARXsguvbk9wsZnBgrWt
         LqCKC5E77tiA1oFYzlZB1wsAFI4HlOcmEOAcSkH1EWfZWVnLoXOOLqbE6VpJPeE0bt
         hVQxqkpoXbaMx8BW1WAh2xjwp1AouB1cF3nGBDuY1ecW30/UA4zxfOlFCo7/gn84lQ
         kXJj1PlxUT9XDHdoxi/qqh4ng9UW3NZmlbWYBHqmROZ7/NptVxtL7reaFSkkZxoroO
         gIxLP6idtZ9X4dpwvMFRcteyNJ7KTgtXLx8+2wzFj7C4K+CEXuj8mM8lJn5LVcN+n8
         gSaODKJyg+fqA==
Date:   Fri, 22 Jul 2022 15:04:17 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Aashish Sharma <shraash@google.com>
cc:     "Daniel J . Ogorchock " <djogorchock@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: Fix unused-const-variable compiler
 warning
In-Reply-To: <20220720054225.1623875-1-shraash@google.com>
Message-ID: <nycvar.YFH.7.76.2207221504020.19850@cbobk.fhfr.pm>
References: <20220720054225.1623875-1-shraash@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022, Aashish Sharma wrote:

> The following compiler warning is produced when CONFIG_NINTENDO_FF
> is not set:
> 
> >> drivers/hid/hid-nintendo.c:405:29: warning: 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
>    defined but not used [-Wunused-const-variable=]
> 
> To fix this, move the variable 'JC_RUMBLE_ZERO_AMP_PKT_CNT' under the
> CONFIG_NINTENDO_FF's conditional compilation block.
> 
> Signed-off-by: Aashish Sharma <shraash@google.com>

Applied to for-5.20/ninitendo. Thanks,

-- 
Jiri Kosina
SUSE Labs

