Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275DD53BEEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiFBTht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiFBThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:37:46 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85172E692
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:37:45 -0700 (PDT)
Received: from ipservice-092-217-081-045.092.217.pools.vodafone-ip.de ([92.217.81.45] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nwqdW-0003py-Ne; Thu, 02 Jun 2022 21:37:38 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/11] staging: r8188eu: continue the cleanup of issue_action_BA
Date:   Thu,  2 Jun 2022 21:37:15 +0200
Message-Id: <20220602193726.280922-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code to send the addba response and the delba message. Use
ieee80211 helpers if possible.

This series should be applied after the "start cleaning up
issue_action_BA" series.

Martin Kaiser (11):
  staging: r8188eu: use mgmt to set resp dialog token
  staging: r8188eu: use mgmt to set the addba resp status
  staging: r8188eu: use mgmt to set the addba resp timeout
  staging: r8188eu: use ieee80211 to set addba resp capabilities
  staging: r8188eu: calculate the addba response length
  staging: r8188eu: use mgmt to set the delba reason code
  staging: r8188eu: use mgmt to set delba params
  staging: r8188eu: clarify the contents of the delba params
  staging: r8188eu: calculate the delba length
  staging: r8188eu: remove the pframe variable
  staging: r8188eu: use u8, u16 in issue_action_BA prototype

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 51 +++++++------------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  3 +-
 2 files changed, 18 insertions(+), 36 deletions(-)

-- 
2.30.2

