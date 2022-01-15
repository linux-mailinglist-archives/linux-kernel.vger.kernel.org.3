Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA348F80D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiAOQzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiAOQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:55:53 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4195C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:55:52 -0800 (PST)
Received: from dslb-178-004-201-171.178.004.pools.vodafone-ip.de ([178.4.201.171] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n8mLC-0005N8-CK; Sat, 15 Jan 2022 17:55:46 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/11] staging: r8188eu: clean up osdep_service.h
Date:   Sat, 15 Jan 2022 17:55:25 +0100
Message-Id: <20220115165536.231210-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a couple of unused defines and functions from osdep_service.h.
Replace some one-line wrapper functions with a call to the "wrapped
function".

Tested with Edimax V2 on an arm32 system (as usual).

Martin Kaiser (11):
  staging: r8188eu: remove unused externl variables
  staging: r8188eu: remove unused macros
  staging: r8188eu: remove unused bitshift function
  staging: r8188eu: remove unused PATH_LENGTH_MAX define
  staging: r8188eu: remove rtw_list_delete wrapper
  staging: r8188eu: remove _cancel_timer wrapper
  staging: r8188eu: call msecs_to_jiffies in _set_timer
  staging: r8188eu: remove rtw_netif_wake_queue wrapper
  staging: r8188eu: remove rtw_netif_start_queue wrapper
  staging: r8188eu: remove rtw_netif_stop_queue wrapper
  staging: r8188eu: remove _cancel_timer_ex wrapper

 drivers/staging/r8188eu/core/rtw_cmd.c        |  5 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       | 14 ++---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 38 ++++++-------
 drivers/staging/r8188eu/core/rtw_p2p.c        | 14 ++---
 drivers/staging/r8188eu/core/rtw_recv.c       |  2 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  6 +-
 .../staging/r8188eu/include/osdep_service.h   | 55 +------------------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 24 ++++----
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  2 +-
 10 files changed, 50 insertions(+), 112 deletions(-)

-- 
2.30.2

