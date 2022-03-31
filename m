Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061674EDF12
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiCaQqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbiCaQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:46:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417722220D1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA35661657
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28082C340ED;
        Thu, 31 Mar 2022 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648745103;
        bh=hOb992+h2SlUSt/m6xZIwnr0FGQrgWY1gKUG/M01AEQ=;
        h=Date:From:To:Cc:Subject:From;
        b=dU31FwxRDs0UJ+5EGXmtJmAIvzOaD70esyPYQ3IOcpVgSGFzs4Esy/qx2Cwl1/GD4
         dSxMKbEJEo8bGx9nPG4vLy6T/4gpVksONpc9OhMPQRYcKtwBUxJa0nxjyHfUqoZRwj
         hXpf3CUrxV0ae6UVHGIrai3cfxGyVG9jGaF+AbPJFYTdmE6v7ASDP0ld9cWK6onTcQ
         uk0srN+ZPJHxI3pBa8riHwJ4QWnc1HIuA5fjLjdeZV4eBulrGyMhPP8N/+0Q8bbfFi
         fXO2xBw1hXOauabgGdTgNIfDXpTmtD0nXfoweKBrDKn2mSz404qcmOXL0BYURecPAf
         pGy0pye9SEv7w==
Date:   Thu, 31 Mar 2022 18:44:46 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.18-rc1
Message-ID: <20220331164446.GA21062@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A late but non-urgent PR for auxdisplay. It has been ~10 days in -next.

Cheers,
Miguel

The following changes since commit 09688c0166e76ce2fb85e86b9d99be8b0084cdf9:

  Linux 5.17-rc8 (2022-03-13 13:23:37 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.18-rc1

for you to fetch changes up to 13de23494f387315c6cfab6fe78fbed7d1b25586:

  auxdisplay: lcd2s: Use array size explicitly in lcd2s_gotoxy() (2022-03-18 20:31:14 +0100)

----------------------------------------------------------------
A few auxdisplay's lcd2s improvements from Andy Shevchenko.

----------------------------------------------------------------
Andy Shevchenko (5):
      auxdisplay: lcd2s: Fix multi-line comment style
      auxdisplay: lcd2s: make use of device property API
      auxdisplay: lcd2s: use module_i2c_driver to simplify the code
      auxdisplay: lcd2s: Switch to i2c ->probe_new()
      auxdisplay: lcd2s: Use array size explicitly in lcd2s_gotoxy()

 drivers/auxdisplay/lcd2s.c | 55 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)
