Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9770541DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384831AbiFGWQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380167AbiFGVLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:11:35 -0400
Received: from 19.mo582.mail-out.ovh.net (19.mo582.mail-out.ovh.net [188.165.56.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B93149D8B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:53:21 -0700 (PDT)
Received: from player796.ha.ovh.net (unknown [10.108.4.24])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id B517E2478D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:47:02 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id 7B42B2B43739F;
        Tue,  7 Jun 2022 18:46:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R003e100f37a-472c-4ee8-8084-671dd768fd49,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 0/4] platform/x86: Use backlight helpers
Date:   Tue,  7 Jun 2022 20:46:31 +0200
Message-Id: <20220607184635.1127913-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11323738314411247238
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Stephen Kitt (4):
  platform/x86: acer-wmi: Use backlight helper
  platform/x86: apple-gmux: Use backlight helper
  platform/x86: compal-laptop: Use backlight helper
  platform/x86: thinkpad_acpi: Use backlight helper

 drivers/platform/x86/acer-wmi.c      | 7 +------
 drivers/platform/x86/apple-gmux.c    | 5 +----
 drivers/platform/x86/compal-laptop.c | 4 +---
 drivers/platform/x86/thinkpad_acpi.c | 5 +----
 4 files changed, 4 insertions(+), 17 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.30.2

