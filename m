Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615FA4E4C45
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 06:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241836AbiCWF1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 01:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiCWF1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:27:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3936F60DB;
        Tue, 22 Mar 2022 22:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA5FDB81E08;
        Wed, 23 Mar 2022 05:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C63C340EE;
        Wed, 23 Mar 2022 05:25:28 +0000 (UTC)
Message-ID: <472947d1-a827-a490-bd24-6ecb5a762047@linux-m68k.org>
Date:   Wed, 23 Mar 2022 15:25:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.18
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu git tree changes for v5.18.

A few fixes, nothing too exciting. Fix warnings when building for dragen2
targets (sparse and "screen_bits") and ucsimm targets. Fix compilation
problems when test compiling for ColdFire targets with the mcf_edma driver
enabled. Remove an incorrect clock definition for the ColdFire m5441x.

Regards
Greg




The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

   Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.18

for you to fetch changes up to e6e1e7b19fa132d23d09c465942aab4c110d3da9:

   m68k: coldfire/device.c: only build for MCF_EDMA when h/w macros are defined (2022-03-07 15:20:16 +1000)

----------------------------------------------------------------
Fixes include:
. fix 'screen_bits' defined but not used
. fix ucsimm sparse warnings
. fix dragen2 warnings
. fix test builds with the mcf_edma driver enabled

----------------------------------------------------------------
Angelo Dureghello (1):
       m68k: m5441x: remove erroneous clock disable

Greg Ungerer (3):
       m68knommu: fix warning: no previous prototype for 'init_dragen2'
       m68knommu: fix 'screen_bits' defined but not used
       m68knommu: fix ucsimm sparse warnings

Randy Dunlap (1):
       m68k: coldfire/device.c: only build for MCF_EDMA when h/w macros are defined

  arch/m68k/68000/dragen2.c   | 1 +
  arch/m68k/68000/screen.h    | 2 ++
  arch/m68k/68000/ucsimm.c    | 9 ++++-----
  arch/m68k/coldfire/device.c | 6 +++---
  arch/m68k/coldfire/m5441x.c | 1 -
  5 files changed, 10 insertions(+), 9 deletions(-)
