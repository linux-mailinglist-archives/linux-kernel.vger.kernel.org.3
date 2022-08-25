Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB625A1BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbiHYWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244097AbiHYWDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:03:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CC2792C3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B512B82EB5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938A6C433C1;
        Thu, 25 Aug 2022 22:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661465006;
        bh=qqj1sPuIU2M5if+JbH3KWWswkdV/0dNUDeh0IvSKFtg=;
        h=From:To:Cc:Subject:Date:From;
        b=fsl6BuPVos27L0w8g+6EOItCVKILp9mDLjbYEWiXKpjPO+US7EgJrrgvD7M82zf+e
         yzgwyTgBaJYJ8VyOu14Fs2/mchkB0bYgblVjP1jpwPd0bA82CWAKYl8okkcyNhv0hs
         wdhtzlBMoNbJSTpd34G3zGz+1Oid0KIFlPAUNybcdekzx11Gxa9S4++7P7oUlTIxT5
         oM2iio9FnF+NEJwPhANiOzEvNxBK5ZygJkM7Bvyx9rK4HldxCcTVhhHOVI0XXCdfI7
         MrG85m38Lp/IfTj2/6/KDAc3lUow6xOcADZRTN/IInjPa3YG7TF84csTeIO1LZuqo7
         zmtLmQL8iohzw==
From:   SeongJae Park <sj@kernel.org>
To:     damon@lists.linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [Reminder] DAMON debugfs interface will be removed
Date:   Thu, 25 Aug 2022 22:03:19 +0000
Message-Id: <20220825220319.95226-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


As announced before via the DAMON sysfs interface patchset[1] and also noted
in the document[2], DAMON debugfs interface already in new-feature-frozen state
and will be removed once next LTS kernel is released.  As there could be some
users who still depends on the debugfs interface and forgot about the
announcement, I just wanted to remind.

DAMON user-space tool, damo[3], has supported both interfaces since the
introduction of the sysfs interface and defaults to sysfs interface now, so the
users of damo would have no problem.  If you are still using the debugfs
interface, you could refer to that to know how you could use sysfs instead.

That said, there is no problem at extending the timeline if there is any
critical user issue, of course.  If you have such a critical issue, please let
me know.

[1] https://lore.kernel.org/all/20220228081314.5770-1-sj@kernel.org/
[2] https://docs.kernel.org/admin-guide/mm/damon/usage.html
[3] https://github.com/awslabs/damo


Thanks,
SJ
