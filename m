Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535664CBD7C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiCCMRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiCCMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:17:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3F715E6F3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B19D61865
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C43BC340ED;
        Thu,  3 Mar 2022 12:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646309799;
        bh=zbUChRDujwtCzXRoG1CpPeen2waZyVS0M7dak0YHk1M=;
        h=Date:From:To:Cc:Subject:From;
        b=JIoINa4mEHH+l2Cm7H3OQ1m1Y5tkSY92gXnEXeIkdJsH2ySpA11q6QOpUsoNmM8Ds
         bvYghsYd46+KU8k/KjMNIoNomBgYG11XC3ApeCML46IDzEq2GtmcyeP1UAsfrrHEVl
         KUd2dpt0LRP//Xp2MQX/a5FPTWUdFO0pd986+UOHM2l1/2dtEZ9tZygOJ23aa+DBzT
         BXMogizVl/lTgxChE9JSAZGbvxKJ1NN0DsufGshlLAAPobV6eklOpjohWcKf2w/Bd/
         ZDwiIZF4CmFbDLPuUCGhh+61mSsoKuDbErj5ajR50E/g+Wpe3qqIkE+GyIFC27m2fx
         74qhgVcENwP9w==
Date:   Thu, 3 Mar 2022 13:16:07 +0100
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.17-rc7
Message-ID: <20220303121607.GA11312@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these fixes for auxdisplay (they have been in today's
-next run, only).

Cheers,
Miguel

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.17-rc7

for you to fetch changes up to 9ed331f8a0fb674f4f06edf05a1687bf755af27b:

  auxdisplay: lcd2s: Use proper API to free the instance of charlcd object (2022-03-03 00:30:31 +0100)

----------------------------------------------------------------
A few `lcd2s` fixes for `auxdisplay` from Andy Shevchenko.

----------------------------------------------------------------
Andy Shevchenko (3):
      auxdisplay: lcd2s: Fix lcd2s_redefine_char() feature
      auxdisplay: lcd2s: Fix memory leak in ->remove()
      auxdisplay: lcd2s: Use proper API to free the instance of charlcd object

 drivers/auxdisplay/lcd2s.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)
