Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434E6561934
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiF3Lab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiF3La1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:30:27 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D351B28
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:30:24 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2DsBgALiL1iffxkzoFagliDJYFXlBABAQEGgUKLMIEJh?=
 =?us-ascii?q?WktiieCBwEBAQEBAQEBAQkvEwQBAUCKESc1CA4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBgEBAQEBBwQUAQEjPCeFaA2GewFGhEsBA4JkATOuBoEBhloBgT+BZYE9i?=
 =?us-ascii?q?VqFIIFAgRCEfYURhW4Emj4KAwkEBwVGFxJOMSECRQscAQgGBgcBCAEFCCgEA?=
 =?us-ascii?q?gEBAQYFGBQBAwEBExIFEwwHKAoSAhIMChsHBwMLBTINAg4HAQEMDwECDwMBA?=
 =?us-ascii?q?hEBBwIJEggGDysIAwEBAwEHAQICAyALAgMWCQcIAgECBQICAQMPAQgKHBIQF?=
 =?us-ascii?q?AIEDQQeCQIIAQIZHiwHAgIEDgMjHQgLCgMOAwQDARACGAcCARUBBQIECAQBA?=
 =?us-ascii?q?wYDCBUZAQ0nBAcDEgINAQYBAgYBAQUFAQMYCAMUAwUBAggDFgcBAiEFCiYJB?=
 =?us-ascii?q?A0DASIbAgMDAQQbCgIBAgIFFgUCAQECAwIGFQYCAj8vER0NCAQIBAkSHCMBA?=
 =?us-ascii?q?gwBBAECBy8FBC0CAQEeBAUBBQ8CCAEBFgIGBAMCAgMBAQIBFgIQCAIIJxcHE?=
 =?us-ascii?q?zMZAQU3FA4PAQMGCBkcIgcJBwUGFgMMFSceKQUHERIbDwQNDQo0IBYkAQEOB?=
 =?us-ascii?q?QMBEhkRDgcUClMmIRUQBgErFgMEAQMDAgYaAQIDIgISCwkVAgQmCAkDFgYtB?=
 =?us-ascii?q?QEiHRmcDFohE05ZgQKSaSqDDatmB4NREAGLEJR5LYVFkR0CkgAtlkaidIRPN?=
 =?us-ascii?q?YEuA4IQTSODOAlIGQ+NdgGJXYUeczsCBgsBAQMJjwUBAQ?=
IronPort-Data: A9a23:Get78K0b2Xb8qirwzPbD5Ulxkn2cJEfYwER7XKvMYLTBsI5bpzQOy
 TBOWGHTOq3fZ2vxf95zOo6z8B8D7ZXUydQ2SgZo3Hw8FHgiRejtXInGdBeuY0t+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7xdOCn9xGQ7InQLlbGILas1htZGEk1Ek/NtTo5w7Rj2tAz2YDja++wk
 YqaT/P3aQfNNwFcbzp8B5Kr8HuDa9yr5Vv0FnRnDRx6lAe2e0s9VfrzFonpR5fMebS4K8bhL
 wr1IBFVyUuCl/slIovNfr8W6STmSJaKVeSFoiI+t6RPHnGuqwRqupvXOsbwZm97szuUw9lr0
 u9hrIKKahYCA6TTkboCBkww/yFWZcWq+ZfCKHm76ZXV0kvHNnvhwvljCEs7J4Je9usf7WNmr
 KZJbmpVMFba37rwmu/hIgVvrp1LwM3DJ4gfvnx41TzDJe06XJyFXqPLoN9V3Ts9gspDB/mYa
 8dxhT9HNUmfPUceZwhHYH44tNaKrybGXzkGkxHL5ukK0lnh71dU67e4ZbI5ffTRGZsJxB/Az
 o7cxEzmAAodKNW3xj+M83bqjejK9Qv0Qo8dF72Q8v9snU2dwXEVBBQKVFy95/6jhSaWX9NZN
 lxR4TYnoqk0+2SvT8LhRFu8oXiZrlgQVsQ4O+Nh8wqNjKXV/y6eG3QASTlCLtchsaceQT0sy
 0/MnN7zAzFrmKOaRGjb9bqOqz62fy8PIgc/iTQsSAIE54G65pw1j1fPQ9dvHaq/g8f6Xz39q
 9yXkMQgr5krg9NX3r+hx3zenQiPt7P0RxE8uBqCCwpJ8ThFTIKiYoWp733S4vBBMJuVQzG9U
 J4sxpL2AAcmUMHlqcCdfAkeNO34u6/db1UwlXY/Qcl5rlxB7lb+Jdg43d1oGKt+GuopEdMDS
 G/euA9c4JVeJnTCgURfPdPoUZxCIUTIP93pW/aRUXGaeIRteQqN8TthDXN8MkjomUkoyfh5J
 JGaNMahDHoXDa5q1jXwS+p1PV4XKsIWmzy7qXPTlkrPPV+iiJi9Euht3LymMrhR0U98iF+Jm
 +uzzuPTo/mlbMXwYzPM7akYJk0QIH4wCPje8pIKKLPZfVY9Qzh4VJc9JI/NnaQ7x8y5cc+Wo
 hmAtrNwlguXaYDvc13bNy46NtsDo74u8CtqVcDTAbpY8yN/P9r1tf93m2ofd7Qj6/FuheNyT
 ucIYd6BHuUHTDnb5DMHbvHAQH9KK3yWafa1F3T+OlAXIcU/LzElD/e+I2MDAgFSVXft3Sb/y
 pX8vj7mrW0rHl06UZ2GMK30lTtcfxE1wYpPYqcBGfELEG2EzWSgA3aZYiMfSy3UFSj++w==
IronPort-HdrOrdr: A9a23:3C4UUKw86Xpqa7TT0SXOKrPwCL1zdoMgy1knxilNoERuA6ilfr
 OV7ZMmPH7P+U0ssR4b+exoVJPsfZqYz+8R3WBzB8bZYOCFghrKEGgK1+KLqFfd8m/Fh4xgPM
 xbHJSWfeeQMbEMt6jHCWeDf+rJn7K8gd2VbKzlvhFQpElRGthdBq1Ce3qm+2NNNXF7OaY=
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 13:30:23 +0200
Received: from localhost (dhcp567-177.laptop-wlc.uni-heidelberg.de [147.142.67.177])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 0C8B7300084F1;
        Thu, 30 Jun 2022 13:30:22 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v2 0/6] Staging: rtl8192e: rtllib_wx codingstyle/refactor
Date:   Thu, 30 Jun 2022 13:30:13 +0200
Message-Id: <cover.1656587827.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses some issues raised by chechpatch.pl
and some minor refactoring of rtllib_modes[].

v2:
    - split multi assignment in two separate steps.
      This avoids having 'fixed'='disabled', which
      is silly.
    - Since there is no formatting of the rtllib_modes[],
      one can safely refactor this code into a array of
      strings. This allows using functions like strcpy/strlen,
      which is less error prone than using a
      rtllib_modes.mode_size.

Felix Schlepper (6):
  Staging: rtl8192e: Refactored rtllib_modes
  Staging: rtl8192e: Avoid multiple assignments
  Staging: rtl8192e: Remove unnecessary parentheses
  Staging: rtl8192e: Added braces around else
  Staging: rtl8192e: Remove unnecessary blank line
  Staging: rtl8192e: Added spaces around '+'

 drivers/staging/rtl8192e/rtllib_wx.c | 37 +++++++++++-----------------
 1 file changed, 14 insertions(+), 23 deletions(-)

-- 
2.36.1

