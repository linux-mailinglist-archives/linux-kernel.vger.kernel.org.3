Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF6456BAF5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiGHNhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiGHNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:37:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994021D312
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:37:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36BD662669
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4598DC341C0;
        Fri,  8 Jul 2022 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657287424;
        bh=OlZu7gVrofXn6LBnwtPOUaIyp47CqBBEG0OqSHQgl+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABzcsTwY5coKKCabZEAuxPv9yu/aB86eLqyGH8jheo28b7qaQaplgcm4znGQGKHAZ
         2SjJpUrzuiYkyuulv5cSpzhB0trMeUiglI8wnNHsALxteIsi/cdDB43C6ocArUXM7s
         uPpu21bSu6bI5G81bCKy7h2Lex6IUJt//8OsT770=
Date:   Fri, 8 Jul 2022 15:36:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ALKML <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] cacheinfo/arch_topology: Updates for v5.20
Message-ID: <Ysgy0Fdww3dIe2zL@kroah.com>
References: <20220706124644.2276077-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706124644.2276077-1-sudeep.holla@arm.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 01:46:44PM +0100, Sudeep Holla wrote:
> Hi Greg,
> 
> This is my first pull request to you, not sure if you are open to
> pull request or prefer pulling the patch series directly. I am fine
> either way. You can ignore this and pull the patches from[1] if you
> prefer.
> 
> Most of these changes are in -next for almost 2 weeks with small update
> to fix issue reported on RISC-V last week. The small changes in ACPI
> and arm64 are acked-by Rafael and Catalin.

This worked great, thanks!

greg k-h
