Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8C74F5ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiDFM5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiDFM4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:56:44 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F0286A6B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=LTsxBkbjEeXpUAsSXi0UL91gAEF
        GTNMWWkEVpE3XzZY=; b=2uaRHZUSDG1HrlrHzAKxCO3Ov1HZeMOnC+wnWoRqDtI
        Zh0BrFMPfKnhX0niEZqLyOSrk1MPLiAV+iVcs48GAfepMvykwlBwbH3rSEh0HJL3
        bU3ktYEHPZPGFGazxjz5DT3qT6XUdMElPQY/M2HCILHXWHS7eaYsJxAw1YlKQbSE
        =
Received: (qmail 2651213 invoked from network); 6 Apr 2022 10:56:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Apr 2022 10:56:47 +0200
X-UD-Smtp-Session: l3s3148p1@9l+bivjbjJQgAQnoAH8rAO83AtqmbDBd
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/1] delay: rename fsleep to usleep_autoyield
Date:   Wed,  6 Apr 2022 10:56:42 +0200
Message-Id: <20220406085643.33100-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently stumbled over the relatively new function fsleep(). While I
think it is usful, I also think the name is too short to be
self-explanatory. This is why I suggest a rename before it gets even
wider use in the kernel. Once this rename is upstream, I will convert
the users. The churn is still in the acceptable range with 12 patches
and 70 lines changed IMO.

The name 'usleep_autoyield' is the best I could come up with, but if you
can think of something better I am all ears.

Please let me know what you think!

All the best,

   Wolfram


Wolfram Sang (1):
  delay: rename fsleep to usleep_autoyield

 Documentation/timers/timers-howto.rst | 2 +-
 include/linux/delay.h                 | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.30.2

