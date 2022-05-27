Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F587536684
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352887AbiE0RWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiE0RWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:22:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BB7127194
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAB56B825E5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 17:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29222C385B8;
        Fri, 27 May 2022 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653672160;
        bh=ksqzfYXpPCpPg+NYKPyCLzfWFGKgoNk81m22wvyvaX0=;
        h=Date:From:To:Cc:Subject:From;
        b=LybaVRxQbdTCMNn4EpSl0H5dKeJAtNTUMs55aw74tISByI4NvNeOz5OyDazXok2pX
         P8X0JYE7xxspi8ObAzPMstOf6cChkSqZUkrwYm7WHwZ0cxNrh7hV9KV0dm2zK5Jx0S
         +6mb8f66reKscd4jpCUezajeY7N0JzkF7SR4zbll4PzM2R+Ddw9ScCqdScewIPcg0z
         hp4WxFRTndLl2PDeadj310HEmAuJofwFpGeSpYs8LFCv2O1Lxxm9k1QPp1VTmf+iIA
         daSOft85nj7PP7PYLZjz38uj7qt3O1jsevFo9gweJOMrgMq2D2A91rK5wlmJCGYY2s
         VCkdjwwHJWt3w==
Date:   Fri, 27 May 2022 19:22:24 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Brian Norris <briannorris@chromium.org>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for v5.19-rc1
Message-ID: <20220527172209.GA15519@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: elm/2
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these changes to clang-format. Thanks!

Cheers,
Miguel

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.19-rc1

for you to fetch changes up to 781121a7f6d11d7cae44982f174ea82adeec7db0:

  clang-format: Fix space after for_each macros (2022-05-20 19:27:16 +0200)

----------------------------------------------------------------
clang-format modernization and cleanups

A few changes from Brian Norris and Mickaël Salaün to start taking
advantage of some clang-format 11 features, plus a few cleanups
and the usual update of the macro list.

----------------------------------------------------------------
Brian Norris (1):
      clang-format: Fix space after for_each macros

Mickaël Salaün (3):
      clang-format: Extend the for_each list with tools/
      clang-format: Update to clang-format >= 6
      clang-format: Fix goto labels indentation

Miguel Ojeda (3):
      clang-format: Update with v5.18-rc7's `for_each` macro list
      clang-format: Use POSIX locale for `sort`
      clang-format: Simplify command with `sort -u`

 .clang-format | 218 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 170 insertions(+), 48 deletions(-)
