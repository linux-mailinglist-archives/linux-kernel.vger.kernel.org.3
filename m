Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D2252FDE5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245223AbiEUPik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiEUPig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:38:36 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE662CE1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 08:38:34 -0700 (PDT)
Received: from dslb-188-096-138-194.188.096.pools.vodafone-ip.de ([188.96.138.194] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nsRBT-0007XY-Mu; Sat, 21 May 2022 17:38:27 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/12] staging: r8188eu: start cleaning up issue_action_BA
Date:   Sat, 21 May 2022 17:38:12 +0200
Message-Id: <20220521153824.218196-1-martin@kaiser.cx>
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

Start cleaning up the issue_action_BA function. Use helpers from
ieee80211.h to populate some of the fields of the outgoing frame.

(I'll send more patches for the remaining fields and messages.)

Martin Kaiser (12):
  staging: r8188eu: remove unnecessary category check
  staging: r8188eu: use defines for the block action codes
  staging: r8188eu: use ieee80211_mgmt in issue_action_BA
  staging: r8188eu: use mgmt to set the addresses
  staging: r8188eu: use mgmt to set the sequence number
  staging: r8188eu: use mgmt to set the category
  staging: r8188eu: use mgmt to set the action codes
  staging: r8188eu: use mgmt to set the dialog token
  staging: r8188eu: use mgmt to set the timeout
  staging: r8188eu: use ieee80211 to set addba capabilities
  staging: r8188eu: use mgmt to set start sequence number
  staging: r8188eu: calculate the addba request length

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 124 ++++++++++----------
 1 file changed, 63 insertions(+), 61 deletions(-)

-- 
2.30.2

