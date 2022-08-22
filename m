Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD559C28D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiHVPXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiHVPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:21:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3348E419AF;
        Mon, 22 Aug 2022 08:15:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88AD7B8124B;
        Mon, 22 Aug 2022 15:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B43C433D7;
        Mon, 22 Aug 2022 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661181312;
        bh=oOBpV+kQLcdiRCH072jVwXy/v1KyShAjHL22oLdvKHA=;
        h=From:To:Cc:Subject:Date:From;
        b=HsrBkCQWygotKWt7en6snLQp4SqotmjCROvU3SBDUbETbDylHfFwl7Hr+k0FWJepv
         7ENSIdVG19jlULLzwf5i0Etae9QAT5rAxG2B0Iz0wdJgDr+hRZdGhSkwFLIr7yD33R
         /1FtusFInldvFnVWqwhmOn4UZG/Tjpn9CNnN4GfzefpbV0xbjH+b/gyQf25j4/ci0i
         D+5M9JAlNqGtaRwdKHK4qOdAHwbzGq9M5pTIFKlJipuOiGN4H0vWzHjqZVsqQpZDd8
         8+kGq07VcgqPha0SfwBRngp6u9yccyiN7rUUSTTKMLikE5spiTWoTMK26Lp1eOD5w1
         4oOXWUEPmqLSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQ98w-00074f-7o; Mon, 22 Aug 2022 17:15:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH RESEND 0/3] media: flexcop-usb: probe cleanups
Date:   Mon, 22 Aug 2022 17:14:53 +0200
Message-Id: <20220822151456.27178-1-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
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

This series cleans up the probe helper functions a bit to make the code
more readable.

It has been two months and two completely ignored reminders since this
was first posted so resending.

Can someone please pick this up and let me know when that has been done?

Note that these apply on top of the fix resent here:

	https://lore.kernel.org/r/20220822151027.27026-1-johan@kernel.org

Johan


Johan Hovold (3):
  media: flexcop-usb: clean up endpoint sanity checks
  media: flexcop-usb: clean up URB initialisation
  media: flexcop-usb: use usb_endpoint_maxp()

 drivers/media/usb/b2c2/flexcop-usb.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.35.1

