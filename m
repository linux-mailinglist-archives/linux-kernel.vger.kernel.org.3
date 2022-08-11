Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F5658FB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiHKLkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiHKLkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:40:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0319426106
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5BF96CE216A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27A8C433D6;
        Thu, 11 Aug 2022 11:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660217998;
        bh=TaIQjrLXkSnl2SYGSAllOfzIvUAWrO+yjT61m/QK0s4=;
        h=From:To:Cc:Subject:Date:From;
        b=AyySmrKNpI3cG3L+LrItr/ivhzPwQdHXaRPp0DnNYFHHJtSqUoIxOxxBGKpnEEZ76
         Yzcz+8ORgIK5INkTl3HoycDFeVFI9fxAlU7RU+kFRUHmwKMpFDuoh9KfCAf5HVSana
         RPROj7acRD9AQ/OMRizdfDIDQHVl4S6gTWxZK4/Vhaexv2cmpnQ1baN94LWh6NS/WG
         WWowGihzJ4HugQaru81ZFhSofu54PYrVWYIDE1rhNORMeCqRbUsQdfk9ctxnH17H74
         13LJh6LV8n8doD+BDvgHajOQLKkxjrdQyavwE1sXm1srdtyZxJxPwem0DpnhQGJUU2
         4aOkp34/9VUrg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 0/3] Adding support for trace events to habanalabs
Date:   Thu, 11 Aug 2022 14:39:50 +0300
Message-Id: <20220811113953.1963412-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Hi Steven,

This patch-set adds support for trace events to our habanalabs driver.

As this is the first time we add such support, I would appriciate if you can
review the patches to make sure we did everything correctly and according to
the standard.

The patches are rebased on my habanalabs-next branch at:
https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/log/?h=habanalabs-next

Thanks,
Oded

Ohad Sharabi (3):
  habanalabs: define trace events
  habanalabs: trace MMU map/unmap page
  habanalabs: trace DMA allocations

 MAINTAINERS                                   |  1 +
 drivers/misc/habanalabs/common/device.c       | 47 ++++++----
 drivers/misc/habanalabs/common/habanalabs.h   | 40 ++++++--
 .../misc/habanalabs/common/habanalabs_drv.c   |  3 +
 drivers/misc/habanalabs/common/mmu/mmu.c      | 11 ++-
 include/trace/events/habanalabs.h             | 93 +++++++++++++++++++
 6 files changed, 168 insertions(+), 27 deletions(-)
 create mode 100644 include/trace/events/habanalabs.h

-- 
2.25.1

