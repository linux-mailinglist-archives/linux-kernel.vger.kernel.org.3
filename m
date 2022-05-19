Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68B552D7F3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiESPjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiESPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:39:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03884AE41;
        Thu, 19 May 2022 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652974758;
        bh=EGoVXUhVSSepK6SMgGBNRDd2ecOo5NkMGxt3TC8hLD8=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=lt1Z+lH+5hLmbDrW+H5ik7n3zvkMSNcpexWHpzfQEz0wirtAioFJp5xbTFe7e7ZnO
         ehKejTwcLymVCXvLVzMWzfKpzDzb0PDqBx128+5K0SplU9l1EzQGtzvME7frun/EbY
         bGAeNXLHe8pK5wcyf2mS6Iqewmjr0ALrp52i+GZY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.152.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1o2PkL1UFP-00BxXn; Thu, 19
 May 2022 17:39:18 +0200
Date:   Thu, 19 May 2022 17:39:16 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture cache flush fixes for v5.18
Message-ID: <YoZkpODq/SGRunJC@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:xF1eu8nEadzt9SEiFNl/D8ihMqZPQlXX0ju3fMDhHkWlKX78R8L
 j+uVU4V1LxwYT8FtwHxvfTZqSqUUBbVyb6MDbXio14CBTD4343pQcqgas2BNbZSpcPMBvG9
 g9fomPHw41Ta2PUfpeZyYy4KBS8R939AWkxGIqkAiugWyUX21s8jKozQeGu1CoLnAx4BteV
 brfvGOU0N+QLNbo1MDECQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HxomJYYePIM=:LnY+gXzgYSRILHcX7Zib5j
 rdOIwR+njnkw6ATFtzogcc5atcViufd/rnFPRH3jyG/xHpCf+fxvZpR2KZ+vbk7q8KDQntoLG
 GiniXRwY48ziKz7hHOZvWw7Oqh1vO9U4A92zSTXtWNhAadi6eavPVFc/VHSFe0pIfHHE6d6jD
 1JY0J70cDHPoGDo3qKFHCAEgZLizz6smecujn5Ubgv1BKdLsZfyOBaqID5szZpCL8D/Qwy44T
 bHMJN5fefa/u4DgNsp+Hpf8zkP4ahS3Wm34YOXBTwq7nbQ3ANGIrbJMpXgNLwaQGfN7nUQBDJ
 GooDobl2PZX1BzCXrWLQzIJrr5vjK73HD+HGpivXiGeOvuckgoFd/2Z7admIopu9DK4/QcWzn
 noMlmyWhynb4q4jWxwK53NB2OInEOL4KXWxANqJSUUrcdZ51sx3078vJGLxj+W5Yu6Oj2j180
 P1kXJgMfioETQrJ9d3Y3c6vkyrMnjQ/ssWMy1Tabz+rC+chkC+WXEyXDTGHpKyvxQPg/6h7r0
 pTZbG+sOHLbiU9fZagTwRBg1hsVnn0MqzpSX0G4yKB0CxdFzp3/f1tKwk///zR8Jww65pVUAC
 9lsYQMGMXrwOfjrSgHG3BpcVkNUvY+G9ymi7xpEede/o8iGiOWervwvZdrXPfLCuWBLj2Qxud
 XeLRmt6zWjMIAwhbDu5bjtKR8iA/EivSCl7FBPqIfHIs71ADBGNqe5Bweyrf5UtZUEKtc3c1L
 llvbyKlYxRb0qINqeoVuzFP02x0jmH1epVfxvfcfRdV8/OtzlA9HwQAl6U/lk+b9SfRZAm09l
 DZLHONAU77hUcZRQfcjCGH05bqn48svJiVEGx+gy5YfcY8iUIjcDlDcgNoIapViMIuLvP2zTl
 kI5zCefKAjmpGsPpwLaIfe2vVxNa6E8CxCKmjkdwXXbe2AOYgOBWrsejwbP7H+OsWynRFax+A
 XVZAdCycWdnniEThvpJtRhFPkXB10htYJffh4IhPSwtrqK3KVK7bFkHAx1YbMgSx+GwE8l/NK
 ZEl7deTg0I/TiNKrWsb9nUy058HgzYeTFzRq8Wjkc5/JdDolaFwbpsaSVMU2bgGv6nRLrLFwn
 VLkISzF06rdu8VzDA0+3cigM2Zv2+APBc4W
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

please pull the latest parisc architecture fixes for kernel v5.18.

We had two big outstanding issues after v5.18-rc6:

a) 32-bit kernels on 64-bit machines (e.g. on a C3700 which is able to run 32-
and 64-bit kernels) failed early in userspace.

b) 64-bit kernels on PA8800/PA8900 CPUs (e.g. in a C8000) showed random
userspace segfaults. We assumed that those problems were caused by the
tmpalias flushes.

Dave did a lot of testing and reorganization of the current flush code and
fixed the 32-bit cache flushing. For PA8800/PA8900 CPUs he switched the code to
flush using the virtual address of user and kernel pages instead of using
tmpalias flushes.  The tmpalias flushes don't seem to work reliable on such
CPUs.

We tested the patches on a wide range machines (715/64, B160L, C3000,
C3700, C8000, rp3440) and they have been in for-next without any
conflicts.

Please pull.

Thanks,
Helge

----------------------------------------------------------------

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-4

for you to fetch changes up to 798082be69fea995a475ca1db8f9873589e207d9:

  parisc: Fix patch code locking and flushing (2022-05-17 21:52:59 +0200)

----------------------------------------------------------------
parisc architecture fixes for kernel v5.18

Rewrite the cache flush code for PA8800/PA8900 CPUs to flush using the virtual
address of user and kernel pages instead of using tmpalias flushes. Testing
showed, that tmpalias flushes don't work reliable on PA8800/PA8900 CPUs.

Fix flush code to allow 32-bit kernels to run on 64-bit capable machines, e.g.
a 32-bit kernel on C3700 machines.

----------------------------------------------------------------
John David Anglin (3):
      parisc: Disable debug code regarding cache flushes in handle_nadtlb_fault()
      parisc: Rewrite cache flush code for PA8800/PA8900
      parisc: Fix patch code locking and flushing

 arch/parisc/include/asm/cacheflush.h |  31 +---
 arch/parisc/include/asm/page.h       |   6 +-
 arch/parisc/kernel/cache.c           | 326 ++++++++++++++++++++++++-----------
 arch/parisc/kernel/patch.c           |  25 ++-
 arch/parisc/mm/fault.c               |   6 +-
 5 files changed, 251 insertions(+), 143 deletions(-)
