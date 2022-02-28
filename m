Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13534C7D93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiB1WkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiB1WkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:40:07 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3554A12559C;
        Mon, 28 Feb 2022 14:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646087968; x=1677623968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxPkQmC4SHUxeAYkXMXlFFqEMODjBZBuzvHgbKNXCYo=;
  b=JnmrdEgr9w2odENEiVRd52MxtKlBDt+GSbsqMgxRImwIv0do74jxk8+6
   RIRdvKJ9XyGhQAwuGK2vWxXDMRjOzDegmir0tdPduAW7HLSgUNNqWNjog
   mj18uAqwiVPQoYzE0+rsqUQTrYE/gVLbOxvToTqsnGJTPqqk7S62RJpRc
   qeMLY/Jpc6ludGOw7dk37hOa01Dj82nsIsyKrAHw5xF+aVYErbMpoEx6Q
   HkuXn4QIYaVYUOZPKypl5WVvaGXeGoctair8NZyPY1QhqIUSAKHaTboFB
   NRTIOlLxrcT2kFpCHrWsGl3rMjAFBF/0i9ZXlL/DyWXqW9d/ULiO85H/g
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313724233"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="313724233"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 14:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="685501809"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 14:39:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2C2A0183; Tue,  1 Mar 2022 00:39:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 4/7] ACPI: enumeration: Amend PWM enumeration ASL example
Date:   Tue,  1 Mar 2022 00:39:33 +0200
Message-Id: <20220228223936.54310-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
References: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop blank line and add a closing curly brace to make ASL example closer
to the reality.

Fixes: ef3d13b86763 ("docs: firmware-guide: ACPI: Add a PWM example")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index c7dbf79d45b0..96179d2a8871 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -316,9 +316,9 @@ introduced, i.e.::
                     }
                 }
             }
-
         })
         ...
+    }
 
 In the above example the PWM-based LED driver references to the PWM channel 0
 of \_SB.PCI0.PWM device with initial period setting equal to 600 ms (note that
-- 
2.34.1

