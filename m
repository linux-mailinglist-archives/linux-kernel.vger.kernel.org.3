Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E9953D769
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiFDPHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiFDPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 11:07:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99251107;
        Sat,  4 Jun 2022 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654355257;
        bh=MK7DuyiZdK1YpKOOq0sNLlM/dwzCP4yHWHcA3XxuvMQ=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=cMk34iwwBF58lwHtSR7cfeVmzK9c2G0cnlQfS9x45xrQjtGjDsm63XaTgXQF3aRCB
         HFyRrZY8wGaUfZBE0x26SL/0Q1BjI0B7y9RoodHSBNOFGBfduSq+ilO6LMKs0jgfbx
         pm0JzYUxNU0Hwvn5d3RBvNDME7Rp2vtTUjJWHZ54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.176.199]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1o3FrO2Xyl-00Bx0g; Sat, 04
 Jun 2022 17:07:37 +0200
Date:   Sat, 4 Jun 2022 17:07:35 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [GIT PULL] more parisc architecture fixes/updates for v5.19-rc1
Message-ID: <Ypt1N+GyXEMfAxR6@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:QCDalqORPxkFFBgSja/LphiCYN0xIX5hS+XV2kLSORgE7MAQJMm
 cUjdsHeu/xJCBnTuC4tNcPZ37Cj7O1Uv0Lm1aQ90z+mPduX+uX1H+yGngwhF9Y7KQidJMLR
 soTna8k1s47wiI75tr/1qBkfE2h4TWQyWykSByrM3ntoGnTwpiVLxiGSF/WARFBuWz2sYX8
 asWF1bqM/AyG/eHGrB5Bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VaCAlYmrQi0=:4WEAaTu1pPYu3l30uZGaqQ
 o7ZQBNnV91RDIov58iAQ4Y19Q4TXaktTpIjS2I09JKLTv1+aTvNHSe5AP6wasc+0Ny2/DUDTJ
 QMnTqziEHrpA2HQPBb7t0LlMFQUbq9tTZYumTisUvAS9qFR4HwRl+ywIpI9qQBCYOOGAX5t8Z
 pz78/nUanlOagyxmrl7YWy4m0hOpZOZ7Oo0Dm8y8Kk1ZI5ZYpKll4rzSB1YrnhZVQ0THGX/+p
 Om7HRvoYr2d00C2BjOugXlGw/pyCqzQg9d99oY6Bf9vbmbMCPCYYGcPuCut8PB7tZXsEOzLFS
 bVSTaAI/EpNBI9YUrZFh3vuvik/c5yiyl184yrkZPKE96Im1r01MnePNZP1HbCojayWz7E1AH
 sZbsg5Cqi1V2jJYU6jz0DzkyYwn8o0pc0Vhau0UkrVcuryo9TIahB3fRSeFvbitFcza4+qc36
 lVRF1bFr4l/Tdf41OIvirm/i8hDFWLFdErvOzaYq6aSSrwKwAPDN9V2PdIMx1lxQWmxi0pXEB
 2zqNDkbPrT+xHV5ewcP//okD6inrVk0Dk1ek2ACxNRdDZwy0H5xFStetfeFfMCDBJ4vFlC+2+
 1hcV5XmOZChaWlhizP9czdpPFTxIXGWEnS/I6jubeF6/TXitl58UZZZxxpL7W5pz7y5oJKfrW
 5GkktOaDBmW5Jabgood8U1iaBIV4gijp/Svqydjsgthz/del+Ey2BNycy4KayJWN5t59PwdNa
 CjSJnGsPCeaCP6oKohpsxla/edN4JwrZabhJBevvj3LoWxOFSMKSA1tvrIT7StXsi9spPFayW
 EogPO1363I19aF3AtFIje8ZRwYQAE4u9/99pbqvJrqnhVNZsSbiDKn6xq5bdseEm30Db0HO88
 FPPjceuCDYk36TatOAHMhv6UxZ9aqodEPC2Xcwh/utZ4dfaxqEJ7MTXSpc9OH/RnrlWMEnhXz
 LPeWu/hxqZfbMMURRPc5Z5vZlPethkyrm02oLZzLpcV6Pdu6ZLtGe/k0Mcph+0tIWeBX5I8Wa
 Bmtv4F/dFYUbDOcsmNagMOIua+Smj0Kk/OchzEqN3E/mxiaZbGugkoXsy1PA8FUo6CeQp8hmk
 CQ7Fy7MEB6k5Egghenq4jHTLjt97JuPbRTIEkgQpS/otj1V6yAUVC91/w==
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

please pull some additional parisc architecture fixes and updates for kernel v5.19-rc1:

Mikulas noticed that his C8000 workstation hangs at bootup with v5.18 if
CONFIG_SCHED_MC is enabled.  His fix rearranges the topology setup and thus
prevents the problem.

The other two patches enhance the info from the STI (text) console driver and
add the missing fb_is_primary_device() function which helps the framebuffer
driver to detect the primary STIfb framebuffer.

All patches are marked for stable v5.10+.

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit 4b0986a3613c92f4ec1bdc7f60ec66fea135991f:

  Linux 5.18 (2022-05-22 09:52:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-2

for you to fetch changes up to b046f984814af7985f444150ec28716d42d00d9a:

  parisc/stifb: Keep track of hardware path of graphics card (2022-06-04 15:47:03 +0200)

----------------------------------------------------------------
parisc architecture fixes & updates for kernel v5.19-rc1

A fix to prevent crash at bootup if CONFIG_SCHED_MC is enabled, and
add auto-detection of primary graphics card for framebuffer driver.

----------------------------------------------------------------
Helge Deller (2):
      parisc/stifb: Implement fb_is_primary_device()
      parisc/stifb: Keep track of hardware path of graphics card

Mikulas Patocka (1):
      parisc: fix a crash with multicore scheduler

 arch/parisc/include/asm/fb.h    |  4 ++++
 arch/parisc/kernel/processor.c  |  2 --
 arch/parisc/kernel/topology.c   | 16 +---------------
 drivers/video/console/sticon.c  |  5 ++++-
 drivers/video/console/sticore.c | 32 ++++++++++++++++++++++++--------
 drivers/video/fbdev/sticore.h   |  3 +++
 drivers/video/fbdev/stifb.c     |  4 ++--
 7 files changed, 38 insertions(+), 28 deletions(-)

