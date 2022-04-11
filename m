Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6FD4FC198
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348312AbiDKPzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiDKPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:55:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620EF31502;
        Mon, 11 Apr 2022 08:53:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 37A3C5C0244;
        Mon, 11 Apr 2022 11:53:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Apr 2022 11:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1649692400; x=1649778800; bh=C9DKg6V1tZ
        iLrBe/wdMsxkBkoEmu0OP0fNztWC46E3U=; b=pN5TnRhWhpVC+3YE18aubxei0h
        ZXLBGyCHpp/c7tAcQ0LK5tKxb1CMmFKwSYV01T714ifDQLpKwGoaLp6Nqke1FiwT
        O+fTeJn46iJ3H6zNduAX391666vDH7WineN9ZeNjOyNoGcfboGR6n4VB7CTxBa9Z
        NbTv/AFl6iMeBLVSNYLefCHSQpUMjcJgJw5EYE4vvffn/hMpNcgxGbsRJwZSY9IS
        J47iTllWaFndvKltHwriuuLjyDuukARHRcA8IhYbZGWx0Zm/zeMwKVJBx0sdwHhM
        saidp72V8e/cJ1kVUPIVVX2gdFuZ27aoJBMQ0ijJux+xNRiNEUIfNzJeFPhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1649692400; x=1649778800; bh=C
        9DKg6V1tZiLrBe/wdMsxkBkoEmu0OP0fNztWC46E3U=; b=UZegvQ35q34lAwixN
        4fwiq3Mei4KPkY+Fi5NpjuZLu3FWFX2DfyKyUZLMQOiYqPwEiS+b1Z7VnDupdp07
        cRqwFGM9/7TAnFmJ8QkKJ+CWzAipqNz5VK5T250qXUCgJklLqreodrs0wh0UE9Dc
        99aLPRlP9/igrdqzU2Pa+3qGb0wEviiJem36a/WL5x8D/NjKe/YHiuwOkoAmcQdT
        e7vKzr/HU9IXpFyS8udvWizOrjNExMiZHCK1IeOhUPHLoK7QaTSb7RcuFQ5OY2LE
        e3NhGnr2w9cugb98hMO5wiRWTg6zrn3sbN/MCzLdlXjdRUqfpcpBev1udAMYale7
        FKzKA==
X-ME-Sender: <xms:705UYg7C_P60qXCFX1TaDWc394EKY9B-hMBhLQJ3n2FDsZyNiDJn7A>
    <xme:705UYh5Q1fgAwbK5euXLdhvrG1nZijiia2EoEJtFVieevx1wbMgRI74FdioFOH7ej
    pqA4csdxENCiyoAK2k>
X-ME-Received: <xmr:705UYvdo1m9LFjG1w_K0HL8HWhLN2I1RfA9-WfvpUOqtldf5TSYbT1kKXugnh5ZtGD6wINGGIzbsddcrmdIP8csmSpgjSBJysTMbwRp5168cguxC9vL4RW83xMmxcHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:705UYlIHMHuQYtILwwZv23ivgiVWaG2ltmNyxfvsAgc9kanLwDSZPQ>
    <xmx:705UYkKO4rEPB4SOHCuwcItJZfWfjPtxMBpxn2N3RcnFj85ZpldEXA>
    <xmx:705UYmx6BCts7w2Ykh5hdyJlmmCMTcnahjSo9LNRvGSbdn-5LDR_nw>
    <xmx:8E5UYs_GdpH4AzKesLfxh1_FM1uAvjhgpl0-y6mzYvnLQtJWchvHIg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 11:53:18 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Hector Martin <marcan@marcan.st>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: Try usb-role-switch first in dwc3_drd_init
Date:   Mon, 11 Apr 2022 17:53:00 +0200
Message-Id: <20220411155300.9766-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the PHY controller node has a "port" dwc3 tries to find an
extcon device even when "usb-role-switch" is present. This happens
because dwc3_get_extcon() sees that "port" node and then calls
extcon_find_edev_by_node() which will always return EPROBE_DEFER
in that case.

On the other hand, even if an extcon was present and dwc3_get_extcon()
was successful it would still be ignored in favor of "usb-role-switch".

Let's just first check if "usb-role-switch" is configured in the device
tree and directly use it instead and only try to look for an extcon
device otherwise.

Fixes: 8a0a13799744 ("usb: dwc3: Registering a role switch in the DRD code.")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/dwc3/drd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 9a22ce601504..ff40ff26275c 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -586,16 +586,15 @@ int dwc3_drd_init(struct dwc3 *dwc)
 {
 	int ret, irq;
 
+	if (ROLE_SWITCH &&
+	    device_property_read_bool(dwc->dev, "usb-role-switch"))
+		return dwc3_setup_role_switch(dwc);
+
 	dwc->edev = dwc3_get_extcon(dwc);
 	if (IS_ERR(dwc->edev))
 		return PTR_ERR(dwc->edev);
 
-	if (ROLE_SWITCH &&
-	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
-		ret = dwc3_setup_role_switch(dwc);
-		if (ret < 0)
-			return ret;
-	} else if (dwc->edev) {
+	if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
 					       &dwc->edev_nb);
-- 
2.25.1

