Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F222B4EB7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbiC3Bov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 21:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiC3Bos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:44:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD0E181163
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648604584; x=1680140584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RBfikAOvRA4lz391tZg0rlL77dX/vA4hBKheGf719eM=;
  b=iqOnz74WGI3Igt40u+lLVQB+y/U+A2ZH6DrFvi5+qqM84+A/lUqQD29J
   SsBX938YMNeExGV5Hhn+MztDeSY2QOCSQImRndaBBgGxO+b/o+dJP0mmT
   mIEpDE6/7AAmu9XuODFnbduvisok9KulqYAIGYm6aMVLqErbnnrETKENX
   l6LKLmysMKBVIM2qqWbbXPQlc0vcnq6vvyqDWPQ0QI2nXGhBHHCweLU7A
   4Zb3TBT23XiUXKJHK1om4Jb93OjBWYQy3R/OZq5wuVUSQjQQWp/IzPh6o
   mldiAT4StJqYRkanexAgNmD+Ln2Ry7bMOQYLf45yvjKr0OP5hOIRFcgdk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345857225"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="345857225"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:43:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="694935357"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2022 18:43:00 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, kah.jing.lee@intel.com
Subject: [PATCH v4] firmware: stratix10-rsu & svc: extend RSU & svc driver to get DCMF status
Date:   Wed, 30 Mar 2022 17:42:52 +0800
Message-Id: <20220330094253.3248179-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <be70b809-659e-9a7e-2819-c38450c1014e@kernel.org>
References: <be70b809-659e-9a7e-2819-c38450c1014e@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Resent, missing out linux mailing list.

Thanks.
KJ

