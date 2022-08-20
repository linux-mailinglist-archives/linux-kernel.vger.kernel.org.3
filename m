Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91BC59AACD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 05:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbiHTDE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 23:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiHTDEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 23:04:24 -0400
X-Greylist: delayed 628 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Aug 2022 20:04:20 PDT
Received: from xilka.com (bbb.xilka.com [IPv6:2001:470:1f11:5a5:16da:e9ff:fe11:e54b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B4E5D0E0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 20:04:18 -0700 (PDT)
Received: from comer.internal (comer [IPv6:2001:470:1f11:5a5:a6ea:a72b:2712:4fe7] (may be forged))
        (authenticated bits=0)
        by xilka.com (8.17.1.9/8.17.1.9) with ESMTPSA id 27K2rkIB764576
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 20:53:47 -0600
From:   Kelly Anderson <kelly@xilka.com>
To:     linux-kernel@vger.kernel.org
Subject: Lenovo Ideapad 5 Pro-16ACH6 Laptop Updated GSCN33WW BIOS Slows Linux
Date:   Fri, 19 Aug 2022 20:53:46 -0600
Message-ID: <4981778.LvFx2qVVIh@comer.internal>
Organization: Xilka
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please CC me with any response.

I updated my Ideapad 5 Pro 16ACH6 BIOS (AMD Ryzen 5800H) to GSCN33WW.  
Performance under Linux dropped what seemed to be by a factor of 10.  It was 
painful to use the machine.  I was using the latest 5.18.x kernels.  I tried 
various things including dropping back to previous kernel versions to no 
avail.  Finally I reverted to the previous BIOS verson GSCN32WW and the 
performance returned.

Here is the summary of changes for GSCN33WW.

Summary of changes
==================
General Information:
GSCN33WW:
BIOS Notification:
1. Fixed
  1) Fix Security level 2 fail issue.
  2) 
2. Add
  1) NA
3. Modified
  1)NA
EC Notification:
  1). N/A

If there is anything I can to do help identify/fix the problem, please let me 
know.

Thanks



