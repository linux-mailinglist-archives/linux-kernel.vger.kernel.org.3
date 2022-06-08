Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC614542CAE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiFHKKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiFHKJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3BED3F8;
        Wed,  8 Jun 2022 02:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA77E61A3F;
        Wed,  8 Jun 2022 09:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF08C34116;
        Wed,  8 Jun 2022 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654682070;
        bh=AzEVbvMp6p8V46Xl/eSBFT/ox0PW2CfgYNjNb28qaPs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fJfBz3cPlvZEPBAKmG9AvgHA1Nc+8TVn/ng9xVDjDNImDUlfFYP8mCKt9+gXDYbOl
         DsRdb22dFmP70IyYp0s/A40vwkSpxcxqeWArE2PWTenCOYQoDXBT7U3mCYg/Bo2HqA
         YZorATyovxsX3TqTsdrOPLuC9zOicfs2GCi54SOG3x1gKt9ptUW2wSVfMyy6Oe3j9J
         5uTSz0Q+qUfxbpSsFCKISKoFRymbtsMNMsUmfQU4Ev9Su4EBDE592AvsyWlrWp2Iwu
         k0riOLEhrcX4tCOaYsSm917oXxyk+KE9NIHmQeA2RN7GyhKObRHNUN4LACu+GKtfVh
         zPBM282Dosq7Q==
Date:   Wed, 8 Jun 2022 11:54:26 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hilton Chain <hako@ultrarare.space>
cc:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Bryan Cain <bryancain3@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5] HID: apple: Properly handle function keys on non-Apple
  keyboard
In-Reply-To: <20220602161219.152be32d@ultrarare.space>
Message-ID: <nycvar.YFH.7.76.2206081154160.10851@cbobk.fhfr.pm>
References: <20220529182036.10226-1-jose.exposito89@gmail.com> <20220530083752.1973a905@ultrarare.space> <20220530061812.GA10391@elementary> <20220531221102.7bd7da7d@ultrarare.space> <20220531223330.3d63e2fe@ultrarare.space> <20220531172053.GA10651@elementary>
 <CAPnXWxG8gbe1arQK9kBtwM1Xcta+wreTN742kgtBBr1v0ewKug@mail.gmail.com> <7f67ac07b8bd37d5817cd151674cc6b0@ultrarare.space> <20220601072651.242ce08a@ultrarare.space> <20220601121737.1226ffea@ultrarare.space> <20220601174956.GA10418@elementary>
 <20220602161219.152be32d@ultrarare.space>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022, Hilton Chain wrote:

> This commit extends fa33382c7f74 ("HID: apple: Properly handle function
> keys on Keychron keyboards") by adding an array of known non-Apple
> keyboards' device names, and the function apple_is_non_apple_keyboard()
> to identify and create exception for them.
> 
> Signed-off-by: Hilton Chain <hako@ultrarare.space>
> ---
> 
> V4 -> V5: Add Varmilo keyboards' name "AONE" to the exception list
> V3 -> V4: Remove unnecessary strlen()

Applied to hid.git, thank you.

-- 
Jiri Kosina
SUSE Labs

