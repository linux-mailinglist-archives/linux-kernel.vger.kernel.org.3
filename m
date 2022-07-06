Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C10356857D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiGFK0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGFK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:26:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5218425C65
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657103178; x=1688639178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lDcnrQ3SvllQAhkrUfdQKHhYt09k0lDrulZb1ZGJglA=;
  b=POfDilWl/JIwMbHfiMsjC3eo8QZ+KsXlOw6Qx+uC7aRI9IcGQZzwgzkb
   tBgzZlMKHv0zDtjyK4AfA6LRKQgiPhQZMHJEAdvQEDBFwJSV0b3QB+jjd
   fUXJvgk86wD5STaOfzl7botnWOEKKbVnJfTK4luvyNXd57LN8TeTeSmWZ
   4X0FutsvfELgkrWwq890dMDIVuqFCR2pUh5sm+R6E/ncifsOAUTi15vrC
   nH9fGdXlTrwDjYeJgan+0nTurQ+NBPryOGXZMLA+whzm8Fjg9biZb9waP
   5exyBJPkGOPtyEWdnzYYVYnn1H7PpVlJelEC4EnAPukfX/1EmVxpywwPc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284826168"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="284826168"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="920108731"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2022 03:26:14 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, karnan.shanmugam@intel.com,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: RE: [PATCH 0/2] extend svc and rsu drivers for new RSU DCMF status feature
Date:   Wed,  6 Jul 2022 18:23:30 +0800
Message-Id: <20220706102329.1643576-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331154237.4158001-1-kah.jing.lee@intel.com>
References: <20220331154237.4158001-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Hi Dinh,
Any feedback on these two patches?

Thanks. 
Regards, 
Kah Jing
