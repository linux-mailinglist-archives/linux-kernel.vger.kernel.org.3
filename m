Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63043571C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiGLOTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiGLOTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:19:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF803340A;
        Tue, 12 Jul 2022 07:19:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t1so10661103lft.8;
        Tue, 12 Jul 2022 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7U7RsYqGMW/Fuz5G2Ml9y4+TwTHhAM4/OuSGIAeWbUM=;
        b=opkQ5LRmeZQfW7OxvixldzYBv/+hIidMoUVZf13hKz5+zku8M/PtCuwFuwaTdTMFRp
         5oUdZgmSizQJ2YyKGTkbAOIEyemv9Nf0qk1VWum6QBkGcsDf+yS1qr89Sg5/LQ0RiE5o
         4KSUa5LSRsgFmqN81eiHygwnn0fUu6YfFVNQ4YyX/7Cx/+MyP8r9Emk4mUyzGKhIA+b4
         bie6NVVcSKZCFiRQDpNL0ke49gkNI4XrAkWDUY+vupjYblUBVmPK9pJ0vCTFJ9v6SrEA
         lVwrvlb3JlRPQ54xZQ9b/WtBWhFyXh7gNOYf5easL+4DSzD4J60nDBYbX7adGd5dVJIA
         qyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7U7RsYqGMW/Fuz5G2Ml9y4+TwTHhAM4/OuSGIAeWbUM=;
        b=0ReUyD2pJgdA+3oBc1RxlpCBMoCBD2qVMU/qJvsbWurS6JgaoIKbtLG8luvtLoFVMy
         1r2n9kt60mst8MRKnNYbS9W59+g8uH1nI6UbyRE2iOZeesBIwIxkzGsmfdGjYk0g1ea6
         VQ5CoEb2ffwA5OKL3FYQImxQUcOTogBlH6QrhwI5yQD4Aq8EWu/skYq2LhZXPgcReo7R
         slwQS/9G2r5iD090jd3eaOyGJId1fj+UMWvi87toRoMX9LmhUJezqo1onQU6/Q6ghF2b
         2aEH2HOPBDgZtjMhfJrXeCWzZUNmGG8BRwWd/gU1KMNb3To89V/g2gMasZXk7WwPo3yy
         UfZw==
X-Gm-Message-State: AJIora+b8xzMFLJRUkwGHMPWGZdaDK8/ABvWeJZcMzuKX9HYRvFafCHv
        5HboTc/TKtpsU+UlkT3tdDcHUhOc1EtzLg==
X-Google-Smtp-Source: AGRyM1tVrlnrOfg8pwo/F6ioRtUvp/BhxrW3YH3CUSeqJ2l2ax7KrKyDDTSNAmQu/5A5zzNZz889yQ==
X-Received: by 2002:a05:6512:10d1:b0:489:feee:3b80 with SMTP id k17-20020a05651210d100b00489feee3b80mr85265lfg.212.1657635573757;
        Tue, 12 Jul 2022 07:19:33 -0700 (PDT)
Received: from localhost (95-31-189-152.broadband.corbina.ru. [95.31.189.152])
        by smtp.gmail.com with ESMTPSA id o16-20020a2e9b50000000b0025d6856933fsm1854964ljj.134.2022.07.12.07.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:19:33 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH 0/2] Add Omnivision OV4689 image sensor driver
Date:   Tue, 12 Jul 2022 17:19:08 +0300
Message-Id: <20220712141925.678595-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series implements support for Omnivision OV4689 image
sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
megapixel image sensor. Ihis chip supports high frame rate speeds up
to 90 fps at 2688x1520 resolution. It is programmable through an I2C
interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
connection.

The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CSI-2
and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
3399-based FriendlyElec NanoPi M4 board with MCAM400 camera module.

While porting the driver, I stumbled upon two issues:

(1) In the original driver, horizontal total size (HTS) was set to a
value (2584) lower then the frame width (2688), resulting in negative
hblank. In this driver, I increased HTS to 2688, but fps dropped from
29.88 to 28.73. What is the preferred way to handle this?

(2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
gain is not linear across that range. Instead, it is piecewise linear
(and discontinuous). 0x0-0xff register values result in 0x-2x gain,
0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
with more linear segments in between. Rockchip's camera engine code
chooses one of the above segments depenging on the desired gain
value. The question is, how should we proceed keeping in mind
libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
libcamera will do the mapping, or the driver will do the mapping
itself and expose some logical gain units not tied to the actual gain
register value? Meanwhile, this driver conservatively exposes only
0x0-0xf8 gain register range.

[1] https://github.com/rockchip-linux/kernel/blob/develop-4.19/drivers/media/i2c/ov4689.c

Mikhail Rudenko (2):
  media: dt-bindings: media: i2c: document OV4689 DT bindings
  media: i2c: add support for ov4689

 .../bindings/media/i2c/ovti,ov4689.yaml       | 122 +++
 MAINTAINERS                                   |   8 +
 drivers/media/i2c/Kconfig                     |  14 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/ov4689.c                    | 899 ++++++++++++++++++
 5 files changed, 1044 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
 create mode 100644 drivers/media/i2c/ov4689.c

--
2.37.0
