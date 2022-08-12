Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72C5590D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiHLIoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiHLIoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:44:16 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Aug 2022 01:44:09 PDT
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 678A6A8CC0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:44:09 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id MQG1oHcRkr8wyMQG1oLaqZ; Fri, 12 Aug 2022 10:43:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1660293786; bh=NxaxWNFbRRQY7VhyoO0NUj1pY5bmO9TocFL7tldXkno=;
        h=From:To:Subject:Date:MIME-Version;
        b=XY2IjWpKAH4OVAnXPFXYCpPtFVWtfOH3ux4bACn4drlU+YhFug57+qdMdj1KsFGVm
         sMh+lle/kF2hzkk7JF/f99WSsfztUkKkWMwANYN1/TsmWUrknuf5A/KKtogbIVK5Mh
         sLv4ar/ZVckcb9n/acjAqqDLcto4FpX9nNVuYYedJqr00AVvuAMcRalLq0AOb0dNvy
         63wpXm1Abpfv82A9rUxE6pn0MBD2fjrcVW8k5w52qPjRb9D6/B8LJ9I+4LdCAwKlzR
         ygFC17dgsiz7+zxCess2oC5+YPS1ozSj7z6Mk+CNw+caSeMtJ+XnncwPVwqAR8fm3w
         pHkIcF8WNCCNw==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH v3 0/3] ads7846: fix support for ADS7845
Date:   Fri, 12 Aug 2022 10:42:45 +0200
Message-Id: <20220812084248.9270-1-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfINYNb0c8Pd6SPE3UVYZj1Pr+j847umfkCz/Rq2KFoOwibyE6doSnHDRj2yMPy5SDdYWUwvkTJYz9B/vUvtfBt70bNAM2yMsnB9zmvo/6lTBMkI44w9s
 PKK/B5pjubIl/c7rPVG1wkhYVCI+pXdHMLADJCv5aH/K6nffZvtZY+B6or1+pNbwQNEHKiq6rDyDfSvw15aWx3az+wmVhqKsxBQ8yEg9Zw0EuPnYgyGsEIFX
 6hKQyJi1KkDc3bxW19IfRdtSiaXLsj6JPPHWwqmqJDvjr8umj+xphXjCiJLQbdDL4Lp4XmfllNAlDCufNf12dN+iTY01wZwaxWNfVFpi+nNgz6tZluWcknCo
 pqGKQAKrv+7U14bbAJ/VwbA6ZrRSaimCFQIFtqoDJFHVwCkp4vYsHvbeSAnVpq8HE5o8eA6LLZqxyx575fQN9mXo7gaNmTNS/Zlvp2CzaTlP00pCjNLC9qnK
 C3RJOwVEXPxzWfj33BgbNZI1lbXBny7LFAA67/WZDYDMX2izSBKhufHYsGWyIVAcLcKWRhhjsqFsneZiJaKUiaYGW6eR+FXae/t+YT13RHK+z40RwqYAq1XK
 dX2xi4tVbCFLCg9ZSUqHKtWw
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADS7845 support is buggy in this driver.
These patches fix various issues to get it work properly.

Changes for v2:
 - add missing period in patch 0001 message
 - elaborate comment in patch 0002
 
Changes for v3:
 - send from the same email address of "Signed-off"

Luca Ellero (3):
  ads7846: don't report pressure for ads7845
  ads7846: always set last command to PWRDOWN
  ads7846: don't check penirq immediately for 7845

 drivers/input/touchscreen/ads7846.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.25.1

