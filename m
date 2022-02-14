Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8676E4B410D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiBNFBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:01:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiBNFB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:01:28 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B766A51E4D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:01:21 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 803A33200C14;
        Mon, 14 Feb 2022 00:01:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 14 Feb 2022 00:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=P8ny0glPIbzXvv8K/3CaR5QyxbAhzVqg86FprJZW2OY=; b=HrjtF
        zbFtZVMBbvBl1WkukQh9pKnGjuvx8S83wsDZBHbDizdi+BaKnGtiw9AVs1RcDHbQ
        cpnqM0frDb0JG9vBq0rXNlxvrBW2gguiaQO1GHQalL3ZvtkYY3dGUb60xZe6L/DL
        dGF31DNz7GD/Nt9aZRMVGK0IRPkADFqUovS+rjaZi9l+87SRonDoeTI0V4mMq3T8
        6qj3J0aO0hM+pwySjfcw6VxlS0cU0z/iu6VB/s7vIk66DbGJPzrGHU1xr4UmxHBm
        u5ehqfGeMw6jXjY7Kz09qFhbTi1cI/PQU08MhrCIrJACtlEqmdg4uUwATP3JbHAw
        xGO1ExVPk0p5kVhGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=P8ny0glPIbzXvv8K/3CaR5QyxbAhz
        Vqg86FprJZW2OY=; b=YjoyhXLgIod/mI8Bm2IY3DDStW4fn/mi0x2r5IP3ACNap
        D4625rTKMn44UWhxRTV25tC1cOpb/b3AI+DoDaD8UXQwUgjcqMAUozNVJNv8VXp8
        4FPbMVZKgCTTV1grcd1kKmqXTAFWp3MCUqLcvKtmMjVS/gN6ErO4W9UpLuG+YX4A
        ymRZKyaksJ+Mf9thQ+uToTV15tT85vka1wXd5KMKUublBqPz1QyqONlBpAxrR9Nd
        0oH81WVhx2BYfJ4CLYPncRr2RTMV7wVWGZHXOxxXe6p9ohzkLK/1s1tXNC40JBim
        H6J9sloVcsjr0FPD7GJwCvdJ5bMvkY5Vd4xO4LSKQ==
X-ME-Sender: <xms:H-IJYryh9mGueuqbIfZxv0vfpY0uLmcJvD7eUwMIxI5Y3fT5Utdl2g>
    <xme:H-IJYjThl7SLS6eN22sgi76xWaKmDhaUumxfv3-tj0_iu5cj9wAUkExGRw880TXN5
    oMJWnPTEXMFEQRE5w>
X-ME-Received: <xmr:H-IJYlXzTwRZ72_Tndpss9iBqP9x5kPawh3kllkCD7B3AL9teh2wg8388I7yQeRb0ybXMJhQfN4J0XleRYO39ew5c_aG6ro-jpSv1n9l9uY_pTc6cALtTROsJ2pXxYCS5SqAzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:H-IJYlhl6PeSJpP4xOAuXOmVs_BiYIK3CsXkwTLsQHnAPlDWJraFww>
    <xmx:H-IJYtD6Y1I9V4wMu8u5QCAhfqnsFjkzyby2pLCTEudsq8i71XiLDw>
    <xmx:H-IJYuJGjwBD7NtXNLPL5QZI4T0DC_YSB6kjWf5guyeHdedIoczS_Q>
    <xmx:IOIJYo8SnXN4JX4hAMbY77twR3hVwqr-5Aft45a_3qqDisI_s5Ox4w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 00:01:19 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/4] usb: typec: WUSB3801 devicetree bindings and driver
Date:   Sun, 13 Feb 2022 23:01:13 -0600
Message-Id: <20220214050118.61015-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds bindings and a driver for the Willsemi WUSB3801. This
chip's bindings use the standard USB Type-C connector bindings, but the
driver does not use the TCPM library, so a refactoring patch is included
to avoid duplicating some fwnode parsing code.

Changes in v3:
 - Leave the call to fw_devlink_purge_absent_suppliers in its original
   place in the TCPM code. It is not needed by the new driver.
 - Remove unused variable from TCPM function.
 - Remove version info printout

Changes in v2:
 - Always put the return values from typec_find_* in a signed variable
   for error checking.
 - License the driver as GPL 2 only; probably best anyway as I used a
   lot of other drivers/usb/typec code as inspiration
 - Don't try to be clever; use `default` instead of `unreachable`
 - Free the IRQ before unregistering the partner/port

Samuel Holland (4):
  dt-bindings: vendor-prefixes: Add willsemi
  dt-bindings: usb: Add WUSB3801 Type-C Port Controller
  usb: typec: Factor out non-PD fwnode properties
  usb: typec: Support the WUSB3801 port controller

 .../bindings/usb/willsemi,wusb3801.yaml       |  75 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/usb/typec/Kconfig                     |  10 +
 drivers/usb/typec/Makefile                    |   1 +
 drivers/usb/typec/class.c                     |  43 ++
 drivers/usb/typec/tcpm/tcpm.c                 |  24 +-
 drivers/usb/typec/wusb3801.c                  | 437 ++++++++++++++++++
 include/linux/usb/typec.h                     |   3 +
 8 files changed, 572 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
 create mode 100644 drivers/usb/typec/wusb3801.c

-- 
2.33.1

