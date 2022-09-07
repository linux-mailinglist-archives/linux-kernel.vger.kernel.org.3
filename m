Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC145B0378
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIGL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIGL4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:56:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D8779A7F;
        Wed,  7 Sep 2022 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662551774; x=1694087774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gdw6dbZpo1DaAaGY0fNLdu4Ie3rJKx46x9yqgZ/nX+c=;
  b=MXBU9ShAj83QB7nYcSBxpYNDrK/Je64FVrtf9AAHsQfrxNDJZWNmRzh8
   cdWpgwbj9D6c0EON2lc0pctBhAQNFLqYJZZVdH4I+PcZUdtwM9rbsDJyH
   AytXj30eZzWKe6k6RH0J6Ml6pdFjVvpXXtvU7LjOUaIIxBJ7l1671QJ5X
   7Ze1jr9S0I9QoQaIhUHxjZVH0n8jYp2VvfagUU40GGDuHZtnNC7DiwX1X
   vbIgXNoOJ95tbxNT7SddJ2e0mkaQMqb049sUUcv+yv0HCYGgnuZSe+NfB
   26N6EDcaVXXuiQ/UqxeuGWigGlZlZBCqoTN1vhuSaQhJDuptWMErJSX9p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296851202"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="296851202"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 04:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="756742642"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2022 04:56:10 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, grzegorz.alibozek@gmail.com,
        bastian@rieck.me, andrew.co@free.fr, meven29@gmail.com,
        pchernik@gmail.com, jorge.cep.mart@gmail.com,
        danielmorgan@disroot.org, bernie@codewiz.org,
        saipavanchitta1998@gmail.com, rubin@starset.net,
        maniette@gmail.com, nate@kde.org
Subject: [RFC PATCH 0/2] usb: typec: ucsi: Check connection on resume
Date:   Wed,  7 Sep 2022 14:56:24 +0300
Message-Id: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

Hi,

I'm sending these as an RFC first because I'm not done testing.

I made a small modification to my original proposal (in the bug
report). Now also connection during suspend should be covered.

I would appreciate if you guys could test these again. If everything
works, and the bug is fixed, let me know, and I'll add your Tested-by
tags to the patches.

thanks,

Heikki Krogerus (2):
  usb: typec: ucsi: Check the connection on resume
  usb: typec: ucsi: acpi: Add PM hooks

 drivers/usb/typec/ucsi/ucsi.c      | 42 +++++++++++++++++++++---------
 drivers/usb/typec/ucsi/ucsi_acpi.c | 15 +++++++++++
 2 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.35.1

