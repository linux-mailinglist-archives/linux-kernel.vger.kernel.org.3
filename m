Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62F94ECCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350674AbiC3TLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350614AbiC3TKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:10:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ABF2FE5F;
        Wed, 30 Mar 2022 12:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E761B81DA6;
        Wed, 30 Mar 2022 19:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA65C36AE5;
        Wed, 30 Mar 2022 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648667345;
        bh=8q5C1g4P8gw7/AKnUUnvd1mR2xSIma9c2c2WnS5gV5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDuecAEv1wA9+HkDAa/jaSghorJ4i0iwtKQajK/syzW3Jkw9YXzv9+fiQ9dUi+G9R
         lH3ZJnco5SLU72OGjPXr2ML+3/8T48kOodA8DcdFiURkVISSrPtYpa5P2bdUdNtnh9
         wa+Q36kJmFhwZrKc/UJsavR1qJRsdJKfX0AfrcFr81VAZdTfD8lXZkFV300UKsxGze
         qMGcEoI2W2soXAtqvOIxQo9ahM8pWvGWR7rD8ABT90qwToqEYKa1cPz4qXWmHcEjBf
         YhUTGdpKbx9MLcgMknwm0e5v3z/ZvzuVB7JFCCItHX6tRhOOcFB3574rZhxu1uSyD4
         PU3Ahc2M2LU5g==
Received: by wens.tw (Postfix, from userid 1000)
        id 428045FBF9; Thu, 31 Mar 2022 03:09:02 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: display: ssd1307fb: Add entry for SINO WEALTH SH1106
Date:   Thu, 31 Mar 2022 03:08:44 +0800
Message-Id: <20220330190846.13997-3-wens@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330190846.13997-1-wens@kernel.org>
References: <20220330190846.13997-1-wens@kernel.org>
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

From: Chen-Yu Tsai <wens@csie.org>

The SINO WEALTH SH1106 is an OLED display driver that is somewhat
compatible with the SSD1306. It supports a slightly wider display,
at 132 instead of 128 pixels. The basic commands are the same, but
the SH1106 doesn't support the horizontal or vertical address modes.

Add a compatible string for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 9baafd0c42dd..1ac016a2d847 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -13,6 +13,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - sinowealth,sh1106-i2c
       - solomon,ssd1305fb-i2c
       - solomon,ssd1306fb-i2c
       - solomon,ssd1307fb-i2c
-- 
2.34.1

