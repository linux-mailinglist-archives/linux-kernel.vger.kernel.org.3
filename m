Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC43A465D84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355592AbhLBErE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:47:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:34201 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355563AbhLBEqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:46:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236854428"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236854428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:13 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="541081875"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:13 -0800
From:   ira.weiny@intel.com
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/7] Improve Auxiliary Bus documentation
Date:   Wed,  1 Dec 2021 20:42:58 -0800
Message-Id: <20211202044305.4006853-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The auxiliary bus documentation was not wrong but it was a bit difficult to
follow.  Furthermore the documentation was not tied to the code so it was
potentially harder to maintain.

Add clarifications to ensure that details are not missed.  Move the overview
documentation into the code.  Finally, add some of the existing function
kernel docs into the main Aux Bus section.


Ira Weiny (7):
Documentation/auxiliary_bus: Clarify auxiliary_device creation
Documentation/auxiliary_bus: Clarify match_name
Documentation/auxiliary_bus: Update Auxiliary device lifespan
Documentation/auxiliary_bus: Clarify __auxiliary_driver_register
Documentation/auxiliary_bus: Add example code for
module_auxiliary_driver()
Documentation/auxiliary_bus: Clarify the release of devices from find
device
Documentation/auxiliary_bus: Move the text into the code

Documentation/driver-api/auxiliary_bus.rst | 236 +++------------------
drivers/base/auxiliary.c | 152 ++++++++++++-
include/linux/auxiliary_bus.h | 164 ++++++++++++++
3 files changed, 339 insertions(+), 213 deletions(-)

--
2.31.1

