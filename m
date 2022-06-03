Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F0E53C65D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiFCHhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiFCHhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:37:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2516C39
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654241818; x=1685777818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mXQ2T82LqdAdgfJ8j2kCB4XNSWejs1IoGcDsOXnVo30=;
  b=NzlCOF2n7J2YVnsn6OZIFj2B8HIAAxmBmAgSsgG51Spl7fRaLLjlbu5i
   5krULga+SFGaG3iW0CYIa3zSdQhtBJ9LJeAj0Nii7iJ+k5AkxcbGaaBvy
   bvgG7XxARI4WRgee29dOeHfW0EMBzW/Al1CFjKQLfWxpjivVyUB1Mr8Qb
   5SAU1tnHoRjwG6nZ+G4qpDTCtdGg8foPCRbF4LK7OnE0uktsOWYFVJC7M
   9VrD1hvkBhtBzN9gf7++JdeVj9tZYLVW86ZvHCCM0khPv+PDHAzVP1QTw
   zhDTtTibsp2aLvuU7RAdKT0nKTukwHJtILxb84bzjrI3vtAxZtfG8Ns/B
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="275931073"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="275931073"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 00:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="530915098"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2022 00:36:56 -0700
From:   kah.jing.lee@intel.com
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, dinguyen@kernel.org, kah.jing.lee@intel.com,
        lftan@altera.com, linux-kernel@vger.kernel.org,
        tien.sung.ang@intel.com
Subject: Re: [PATCH 0/2] New driver for Intel(Altera) FPGA System ID softIP
Date:   Fri,  3 Jun 2022 15:35:37 +0800
Message-Id: <20220603073536.3080721-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YpmtAtIx994hnpP2@kroah.com>
References: <YpmtAtIx994hnpP2@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Opps, I think I missed out the in-reply-to for the patch series.
Will do that for v2 once I get back from Intel OTC folks, and resent =).

Thanks,
KJ
