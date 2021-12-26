Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDD47F8FC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 22:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhLZVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 16:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhLZVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 16:25:49 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088ACC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 13:25:48 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1b1T-0000qQ-T1; Sun, 26 Dec 2021 22:25:43 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/10] staging: r8188eu: clean up private ioctls
Date:   Sun, 26 Dec 2021 22:25:25 +0100
Message-Id: <20211226212535.197989-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the definitions of private ioctls.
(Maybe it would make more sense to remove them completely?)

Martin Kaiser (10):
  staging: r8188eu: remove unused rtw_private_args entries
  staging: r8188eu: remove the private ioctl "get sensitivity"
  staging: r8188eu: remove the private drvext_hdl ioctl
  staging: r8188eu: remove the private ioctl "wps_prob_req_ie"
  staging: r8188eu: remove private ioctls that return -1
  staging: r8188eu: remove the private ioctl "wps_assoc_req_ie"
  staging: r8188eu: remove the private ioctl "tdls_get"
  staging: r8188eu: remove the private ioctl "tdls"
  staging: r8188eu: remove the private "test" ioctl
  staging: r8188eu: remove unused prototype

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 141 +------------------
 1 file changed, 7 insertions(+), 134 deletions(-)

-- 
2.30.2

