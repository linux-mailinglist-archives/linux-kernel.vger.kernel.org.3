Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF274ACCEF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344891AbiBHBEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245533AbiBGXJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:09:40 -0500
X-Greylist: delayed 80 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 15:09:39 PST
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.18.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6EFC061355;
        Mon,  7 Feb 2022 15:09:39 -0800 (PST)
Received: from [92.206.166.137] (helo=note-book.lan)
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1nHD6s-0001JC-Pd; Tue, 08 Feb 2022 00:07:50 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v2 0/3] Add support for ocp8110 flash
Date:   Tue,  8 Feb 2022 00:06:35 +0100
Message-Id: <20220207230638.56730-1-git@apitzsch.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20211117091405.7412-1-git@apitzsch.eu>
References: <20211117091405.7412-1-git@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The led is used as front flash of BQ Aquaris M5.

https://github.com/bq/aquaris-M5/blob/901d0b2ca05c0b0af49786fb548eb0fc289867ff/arch/arm/boot/dts/qcom/piccolo-msm8939-camera-sensor-qrd.dtsi#L16

v2: Reorder patches

André Apitzsch (3):
  dt-bindings: vendor-prefixes: Add ocs prefix
  dt-bindings: leds: sgm3140: Document ocp8110 compatible
  leds: sgm3140: Add ocs,ocp8110 compatible

 Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 4 +++-
 Documentation/devicetree/bindings/vendor-prefixes.yaml   | 2 ++
 drivers/leds/flash/leds-sgm3140.c                        | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)


base-commit: 2ade8eef993c37a2a43e51a9b1f6c25509a2acce
-- 
2.35.1

