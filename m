Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7839D554149
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356840AbiFVEL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356874AbiFVELV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:11:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA44340EB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE495B81996
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3177C3411B;
        Wed, 22 Jun 2022 04:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655871067;
        bh=0BsWNOfJDzAXL1RFauzW4Eg+bltYhSLXctfjHV6iGfE=;
        h=From:To:Cc:Subject:Date:From;
        b=oKxEJeOEezlW/QtxTKZjCcwDl2r70/PyjadiZiDnRq/lrBceVews4NLkdY/ULqYPb
         D8QZyoAYiIOSsf+F1kayfyvgnaB08+yPa6wpWxdC5kuTUP+s7tV6GpDHEMHtN5F9I+
         hhNXVBop8gaDEG3558iMYB2RsIlDJtLV1rnzp4nzADs7l3mJ33r5C/gEevg/rX/dPo
         MsUj06D4NmYlWeKoAx0090CPa+AiygUvXukZpali1bJxzNSv0w6osDp4RyfhykdEr1
         QRS16sHyb6P/+au4ksK0SvQoFjwBwC1BEr48rfHO77UmjcnhY0lj6qHScLbVx9zSb0
         XlXLODAyEHEbg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] platform/chrome: cros_ec_proto: add Kunit tests
Date:   Wed, 22 Jun 2022 04:10:33 +0000
Message-Id: <20220622041040.202737-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series add Kunit tests for the rest of exported functions.

The series applies after
https://patchwork.kernel.org/project/chrome-platform/cover/20220615051248.1628156-1-tzungbi@kernel.org/.

Tzung-Bi Shih (7):
  platform/chrome: cros_ec_proto: add Kunit tests for cmd_xfer_status
  platform/chrome: cros_ec_proto: add Kunit test for cros_ec_map_error()
  platform/chrome: cros_ec_proto: add Kunit tests for get_next_event
  platform/chrome: cros_ec_proto: add Kunit tests for get_host_event
  platform/chrome: cros_ec_proto: add Kunit tests for check_features
  platform/chrome: cros_ec_proto: add Kunit tests for get_sensor_count
  platform/chrome: cros_ec_proto: add Kunit test for cros_ec_cmd()

 drivers/platform/chrome/cros_ec_proto_test.c | 694 +++++++++++++++++++
 drivers/platform/chrome/cros_kunit_util.c    |  22 +
 drivers/platform/chrome/cros_kunit_util.h    |   7 +
 3 files changed, 723 insertions(+)

-- 
2.37.0.rc0.104.g0611611a94-goog

