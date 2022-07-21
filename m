Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7957C66A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiGUIgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiGUIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:36:17 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 01:36:13 PDT
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60C9A165AA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:36:12 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ERe9oJVIEtk1HEReAojXf5; Thu, 21 Jul 2022 10:35:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1658392507; bh=l4vFZ+EHfnK9g5hF6wRXTjqmfPIDKKppU4UR+TepPDw=;
        h=From:To:Subject:Date:MIME-Version;
        b=ZFLpXnPcR2TmLR3T30v6PfJMrjAlUPeNG461B4NB4apNEWepA7kMHqrsPXCFZVK/x
         s55XqEf/i61XXuo08urQ3QfzgEu042cj1rtnZD8MHvyrBychr6GFzyER1PAcIy+Xnm
         s3mfgRh3UcxJPQjGZDiJjsBilKRpg+UOYkQ+YdIbLymHwmRb+gJP2UeQ8mURr2ngJh
         tTcKBd9haaePXz0qx/ZbKtx4qTSPcD4uqPwBgWrLU9mLE1xpuQWAxpRauLbTlKO56f
         9kaaOQi3xJM5yKtqAgxA+jwsgtx39mae5exQjAFmkEYVIRdGyhruFjLpR34u1EfGCU
         w2+uocevPcmjw==
From:   Luca Ellero <luca.ellero@brickedbrain.com>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <luca.ellero@brickedbrain.com>
Subject: [PATCH v2 0/3]  ads7846: fix support for ADS7845
Date:   Thu, 21 Jul 2022 10:34:55 +0200
Message-Id: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfI+04pkcyHM1lQYQWHTfuHr0jkcF12s6rMiEb4guNI8qUuMDLx0a+I0B4Ev1m8Rb35oJaTz5PAtwtZXB2bNEthmDoSCGjC/+MWsQNXGz0kmwto5xKVLY
 NT0+6IsgxwH4+80TDt+Cq+u52zAUFM4VJMoXl+T+RykuZOh2YKFBKQZ9vIDBnge1EeA7eKEtt7501cYmiVMQWnVlTMeyIbMePQXtWg0nZMIVOrrhK95/invb
 YQ8rUQBSdASohtKsym+Ng6inlR7lHaGDUtIGnoqLnch0xAmrGd2aRyeulObApc2qfRGh+/mG51SOTJo23f5ixqneVAsvIb6ARLVE9irfGlDWv2nDsb8we8nu
 SEbQZKwl2sdFoKINaTojYZxRNj48AkrJXgz31FlAAGEi0DUNjS9SZFGGur1AcmgAWkasIqe53i1xDcx5OyPule9oLYrcnJq5UcI0cn/hC2nqAjmXWl6w8WlF
 qyLc6wTaxTBX7numNCLRfTP6a+sVayauI6wxnzUL4Heyuhs80yqRW3lKAd4AMeegU0B9k26qKe2HJXNeSY1VZrZwNjbykOe20t1V2YDSzBMG7DXDnz3dee0k
 jBS1CfmWRfbaWkemQEmBUBTE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 
Luca Ellero (3):
  ads7846: don't report pressure for ads7845
  ads7846: always set last command to PWRDOWN
  ads7846: don't check penirq immediately for 7845

 drivers/input/touchscreen/ads7846.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.25.1

