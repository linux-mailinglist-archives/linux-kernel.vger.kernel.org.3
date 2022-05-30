Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE89A538779
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242874AbiE3Sny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiE3Snv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:43:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69405663F8;
        Mon, 30 May 2022 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653936220;
        bh=GN2+g90LfYJCOmSum7gNkrgKkSMp0HPILRuiro2OMZc=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=QKlHKEhsyeq78fUVStdKETqlIVDSRaTWsqn1mEQRjx6H3iHTyv8M/3BvJBin2kGvj
         RIT7eaXBsTGZXOdFA/ERIv/FUfkycPS5u8ekOyq0BTYyGQl1T49ZKckPL+fFHZtlR1
         nsDGI6q/hFu9esgwleAB33m6czjeQTQ9XCTkD4yQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.163.222]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD6W-1nIp2c2bKs-00eMwe; Mon, 30
 May 2022 20:43:40 +0200
Date:   Mon, 30 May 2022 20:43:36 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for v5.19-rc1
Message-ID: <YpUQWLSW4OPOc2wX@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:vHdcqrt7+Jcwmud66cmHLPadIbJd205E/xr4h2XaKhBV4NgXyaw
 YRbtW3KBlp0LFQlIz0QRd87/ddVeoG2jrMDbjQOvybHB62oSAtim0OOBmMcre46d46R0dwY
 E8s+0jcf5R/ZkDx51wRpbfZk2jxlp9ueO7mwLeTqn+GyeYuPnsBruwCgbxUovjKK/CyOmlc
 OHl+H+FRWX8z3aDpp6+vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A3qzvfFbRuY=:Q0DXKQ9lxFLU/rRJmb1AUQ
 gIMUKM5QEjaIqpdzBOzhqmarXvQUZKagceW2/PltCKl6EZ+ErWyT70hqbqRY+BSsbiH7gucoL
 07E+HAIIsfhdLZez8IiYpY8wOa2/PqLzsGzhexXrcFUPbPU6VWsVAGRTztFC1EidbyGGbGvPH
 Y0k5TKQ/3nM+aBWUTROSmexEnFATRoeiPZD2lN1PDBAZeBdEp8SmRC7fJs1PwRS1yrKl1Cfuc
 osETUVW1qeNZbsWtri9q+FGRgsphyaVP6qQ/EzNXE3EWIHm28GKgPPtv1vACUrGg/TQtb1Sh2
 kdcd/3iWno10SCDx9Bq1uWB9DAqqYUZ86v9gpeVXYodpB5VXoScRBwUuwUjjIilMpUQx5+eIc
 +2WY8UPkmI1wAXRyrKMFRvN6jodalTFi7ebaT5AvkdgZxWisaJs4EPAnpEvs/qjkAkWe9PoBS
 wNQdkCrPGzXMVc+gaCur6LXqBJpGhzTxGIQ1m/pJteo1uY7Oj/ME8gG3oc4l4zf9KTtLdLy0q
 /AsOgon8FXPMXiKSCXJNKCQPtpLts8pRt0bNwhyrjzsIeTqaOSKUDbS+iMgDv9gzo/kI6Jkdv
 Shsp7smWaZyBcDsAh2S37qOPJwtFR70pkiom2YPkoemYVIQzkUVAjwbMGd3jEdQQ3i+wGwtt/
 u5dqT7ZOpYghrnQ890uZkaG/QuYBYevqWxH1bwd2MRFaboShl8l+3NmAtY6ujytgFiGBcPBQO
 85Y3agPBA0eiCcs8jxBOP9/+rfw6ktmPZGhw75pLt4txQsTfcsyHSVAdMjn/ZO1mn9MyWfE2u
 3WutgPdAgprRk5AbfRGbh5/r9TxRVlr1RzYPylktfTsKFcOJ1C5kiwIXFgIR32+07fAGijpbu
 rnJ/NT8ncHH1lODhV2exmT9m3rPVx6Tfb5KHMeS9Iyu+4Ba3vI955lpsIIL+apZeCBOq8/d4B
 Qm2PydrblZ235k+Be0DbY+KdHOKtr3U98ImfN/QjdklUGOdmjpYQiglps/MLlqI2Y6mVgxxGg
 IvV41kjrtjPY1TAVzTibho4YRvwQ+BbfkizitJ66G+Hr9ONnCtyIjEd0Vbuvd/PcxR0YxfmFq
 xZmR897jy5FxL3F+TC6qRuIbqENuznjxi5S492A8W6VA+BMg1rK2tgeCg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture updates for kernel v5.19-rc1.

Minor cleanups and code optimizations, e.g.:
- improvements in assembly statements in the tmpalias code path,
- added some additionals compile time checks,
- drop some unneccesary assembler DMA syncs.

Thanks,
Helge

----------------------------------------------------------------

The following changes since commit 4b0986a3613c92f4ec1bdc7f60ec66fea135991f:

  Linux 5.18 (2022-05-22 09:52:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-1

for you to fetch changes up to 72acadfeb378915a3c4990f4252ab33ce8225491:

  parisc: Drop __ARCH_WANT_OLD_READDIR and __ARCH_WANT_SYS_OLDUMOUNT (2022-05-30 17:43:44 +0200)

----------------------------------------------------------------
parisc architecture updates for kernel v5.19-rc1

Minor cleanups and code optimizations, e.g.:
- improvements in assembly statements in the tmpalias code path,
- added some additionals compile time checks,
- drop some unneccesary assembler DMA syncs.

----------------------------------------------------------------
Helge Deller (6):
      parisc: video: fbdev: stifb: Add sti_dump_font() to dump STI font
      parisc: Prevent ldil() to sign-extend into upper 32 bits
      parisc: Fix wrong comment for shr macro
      parisc: Add dep_safe() macro to deposit a register in 32- and 64-kernels
      parisc: Optimize tmpalias function calls
      parisc: Drop __ARCH_WANT_OLD_READDIR and __ARCH_WANT_SYS_OLDUMOUNT

John David Anglin (2):
      parisc: Don't enforce DMA completion order in cache flushes
      parisc: Don't hardcode assembler bit definitions in tmpalias code

 arch/parisc/include/asm/assembly.h | 12 ++++-
 arch/parisc/include/asm/cache.h    |  1 +
 arch/parisc/include/asm/fixmap.h   | 25 ++++++++--
 arch/parisc/include/asm/unistd.h   |  2 -
 arch/parisc/kernel/cache.c         |  3 ++
 arch/parisc/kernel/entry.S         | 22 ++++-----
 arch/parisc/kernel/pacache.S       | 94 ++++++--------------------------------
 arch/parisc/mm/init.c              |  6 +++
 drivers/video/console/sticore.c    | 21 +++++++++
 9 files changed, 86 insertions(+), 100 deletions(-)
