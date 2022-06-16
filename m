Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C9A54E99B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377728AbiFPSnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiFPSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:43:20 -0400
Received: from 1.mo581.mail-out.ovh.net (1.mo581.mail-out.ovh.net [178.33.45.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9960F2AC6C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:43:17 -0700 (PDT)
Received: from player715.ha.ovh.net (unknown [10.111.172.45])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 6DF5224DBA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:25:09 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id 5AE862B80DA9F;
        Thu, 16 Jun 2022 17:25:03 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R0033e926c55-2866-4034-a799-f193b4c44a42,
                    EEA695ED62D0B30D35F9F30395731DD21189161B) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Kitt <steve@sk2.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/panel: Use backlight helpers
Date:   Thu, 16 Jun 2022 19:23:12 +0200
Message-Id: <20220616172316.1355133-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7454864759303931611
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddvfedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekud
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

backlight_properties.fb_blank is deprecated. The states it represents
are handled by other properties; but instead of accessing those
properties directly, drivers should use the helpers provided by
backlight.h.

This will ultimately allow fb_blank to be removed.

Changes since v1:
- remove the last remaining fb_blank reference in drm/panel in the
  last patch
- remove unnecessary parentheses

Stephen Kitt (3):
  drm/panel: Use backlight helper
  drm/panel: panel-dsi-cm: Use backlight helpers
  drm/panel: sony-acx565akm: Use backlight helpers

 .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  |  7 +----
 drivers/gpu/drm/panel/panel-dsi-cm.c          | 29 ++++---------------
 drivers/gpu/drm/panel/panel-sony-acx565akm.c  | 12 ++------
 3 files changed, 9 insertions(+), 39 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.30.2

