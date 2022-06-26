Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7038555AE1B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiFZCBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiFZCBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:01:48 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE0E13E38;
        Sat, 25 Jun 2022 19:01:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EBFD0320051E;
        Sat, 25 Jun 2022 22:01:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 25 Jun 2022 22:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656208903; x=1656295303; bh=cwUPUl+OA5
        T721UciMEMKWal2tgSsfaKw5bHf2WB2Bg=; b=Vrpc7VzWm2Is2FrgPWUh3oJS2J
        TZJVavr+Qi6w1BZCAlOfZK0eqOF3MUmo5XOzo1+k4iT6NGaAN3JjlNmG6RNWMVjR
        qGB+VkJ29f59nQWCkVNsjJr1bBLjVlLRnfh7+db3+l9nls8AgGXqkizaT/9gla4C
        ddfz18H/brNWgEm+jhlEbbyTvAiQiuxlt90oqOqrxRH0GZE31lfCds3cNjDtXM+T
        lpxl/90/dHUnhsYlB3SCjFlHKJWvz7iseJzcAg/yxIo2vlv5pdNDR6xnByYbWxtN
        /SH9NXmpuVf+iARsjhTFFbD7F5FdDUFwpo+e+7SlyCLDzzK3FjPu6CpJZ4Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656208903; x=1656295303; bh=cwUPUl+OA5T721UciMEMKWal2tgSsfaKw5b
        Hf2WB2Bg=; b=TrG7REjbLp2fryMdS/mOHTnncpwaYqBmKRy37t0AfUoLN1Jg+cJ
        uSu5slr8Iz6hB9p4JnCkDjspCWxWv2lnf7Rg4BazRzOdsB5lGukCGrUWvMmyTqsQ
        wxp1dlWvkh0+ETBME+LQmEqPnA9RMJ4Tm8vD+O++aIEf1aI0YwrxmDLwDNxp0N+n
        o7OOFT2jWBKwQIEr8TaYkEVlFx4vpguR52Oop3iztQMWDlYggj+PNMrtkhVVbGPd
        tc/uAZ55++6nnAHJ8bV+fv5yakL/K3at2Cz9t/+uB1cu686rfBfkdpt+tGth3eWH
        OzPS6imxzeKjNJ6TiXFGFPexUDUMaVr1kTQ==
X-ME-Sender: <xms:B763Yq9OQrv6n8E7W63sBoJchrjPUsAy0u1A_mu2x-jG350sab1DXA>
    <xme:B763YqvWNuHmKgjFB6p6o26CEXQamp6Dj4LrWWGI7erMAghkRHTW4iz_4FEHDFALW
    fWCcoVQkfss0g9_Ia0>
X-ME-Received: <xmr:B763YgBhO1C58QCCn73wPUCGPODUyeegxFsCRBlki5jTCAXxC3Ig_GPiQkkf-5usRb7T6x7jPa60sUBpHdQrquICHu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegvddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrvhhiugcu
    tfgvrghvvghruceomhgvsegurghvihgurhgvrghvvghrrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvvdeifeelgefgfedtjedtffehueeiffehjeeggfffjeevudeuueegteekheej
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esuggrvhhiughrvggrvhgvrhdrtghomh
X-ME-Proxy: <xmx:B763Yie5UTOKJwsSWtrkaiz3lY32BISJ5r8VIp3j7vwZAY-PShk7jQ>
    <xmx:B763YvOjXAS7Cq88-NSIAlud4Dv9S79OaC-Fa76e58W7YNvEMWJkSg>
    <xmx:B763Ysm8qHXV9HscF4kkuKoUVvmnpJb4JTviY9e5aiboPVtXCtRpJw>
    <xmx:B763YkoAMKpMtSWGfHBQRRWlaR3yLGXVKwX_i4UuANR4vGcrAJbWFQ>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jun 2022 22:01:41 -0400 (EDT)
From:   David Reaver <me@davidreaver.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Reaver <me@davidreaver.com>
Subject: [PATCH] staging: fbtft: fix alignment should match open parenthesis
Date:   Sat, 25 Jun 2022 19:00:02 -0700
Message-Id: <20220626020002.1577101-1-me@davidreaver.com>
X-Mailer: git-send-email 2.36.1
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

Fix alignment of this line of code with the previous parenthesis, as
suggested by checkpatch.pl:

  $ ./scripts/checkpatch.pl -f drivers/staging/fbtft/fb_tinylcd.c
  CHECK: Alignment should match open parenthesis
  #41: FILE: drivers/staging/fbtft/fb_tinylcd.c:41:
  +       write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
  +                      0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

Signed-off-by: David Reaver <me@davidreaver.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2c50..60cda57bcb33 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	udelay(250);
