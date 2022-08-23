Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8DC59D045
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiHWE6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiHWE6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:58:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3EF5A155
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661230682; x=1692766682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cNxzDbwrsjHAHf3Ry/RTPETly9gpzhY9qK4HhF9EKO0=;
  b=mxSjOwIS6rKdbsyPOKfsaYe5bWLiS0eWZPOOj/0Ucz9snDitAkmGFHzN
   7vuEZocIURJ2arfFcP2Q//3nUFjnVPS75obdOIguukLdKgrCS3RoDVC4y
   7irftGEl0s2rUFRrAv8k1fuqdvR35xX7QRhQRISRtpsGD9fs3F96owHo0
   cUvatbVPyKC2bKwRFTdZaceJsjQqXRDqZnUNjCOSv3lJvyFFQC7nD8Pgb
   ycSBKtVE6S4dxGry5ZgiCdbGkZqyp1M6uXP4mm3qRzLrdq7tnWzPMeoNr
   +AH3u9djE+3NsQfzyWNzy1Lkjom54vpNgRNoHVcqDKYyYqLu6xAM6DeZ+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291148294"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="291148294"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:58:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="605536620"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:58:00 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/2] soundwire: remove use of __func__ in dev_dbg
Date:   Tue, 23 Aug 2022 13:01:56 +0800
Message-Id: <20220823050158.2671245-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module and function information can be added with
'modprobe foo dyndbg=+pmf'

Pierre-Louis Bossart (2):
  soundwire: bus: remove use of __func__ in dev_dbg
  soundwire: intel: remove use of __func__ in dev_dbg

 drivers/soundwire/bus.c   | 16 ++++++++--------
 drivers/soundwire/intel.c | 14 +++++++-------
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.25.1

