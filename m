Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE01D54D483
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbiFOWZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiFOWZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:25:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BE62F027
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:25:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z7so18124125edm.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8znYIfEaEVt09OzYM/EQpid5mF6s7TkBS4JSqx18ajs=;
        b=Rxs3FHAFio23LDCBA4IeD8l+fcHd66FCnBOrPLfNSi2dVhM8fu8Y1ngMRzF7u1v+sy
         hlefXfMtku384wVo/5W0u2f2rJnSv4ag6unfliQwBOUB7HrMcYzKuWswjVzoYYsYyFPq
         f2z/a5nF+rv77KTWfTQ/RCbq8qmA6URiHF8va2BmYDZ9iEQYi6VDJeDb2Q/mNPt9ozqU
         RKGn00XbxP6+fKacZeDftwoFWJa9vwmOVg9VdThDZ1LTMWbdvvf1TwgRXCnV9H2hpD2O
         4zMy8y6NoKDhwt7X+DjGX3BFUwJr6DPdqvEKyLpN+yZc+SueKKD7pBpbS9/4jAEZ5A7G
         KvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8znYIfEaEVt09OzYM/EQpid5mF6s7TkBS4JSqx18ajs=;
        b=DxKf8Et7lgKW6oTvnjYwf93W2wseH561gp5LRIqybFbxSkhYv6kwytvr6LwopVw6dP
         Ihi65UTyfRQRR3gFP3/09zxtnN7OcAX4ygUKY6KWbAlGOMlUYJf7PeL+ud9EsQ8o9UNB
         u6QfSzvVV8hERxd1be62eWqnqaMDEf5xc/7lbhPXzngn/qSBLcd+X/SFD0KWeElmyCom
         7mpVHeZvfNUGdssUUV089GAlNBSjkL3d8zkV8uC9ECllnAbaCksDxfHx4ig1oKFNJhEB
         QsGlT7zUs5J6HYbXn3BejtSDj4h2raN6+JQRSc/53ISEYlZlw3tsIdqN0m0U3+tu8mlE
         bpGg==
X-Gm-Message-State: AJIora8CygeljalxElpu2/cnH5TuSkCLHXToxIwLuxtszyRgXVlD8zAy
        GMHPsuvl48VIrYPYom+OFKc=
X-Google-Smtp-Source: AGRyM1u7nc9AWz6dTB7DXAlxJkR+1iKtO5UNs2icGj0/pfNLt9KsQsQMsb4LGENkZGk8827Dahz3yw==
X-Received: by 2002:a05:6402:f:b0:42e:561:a1c0 with SMTP id d15-20020a056402000f00b0042e0561a1c0mr2533963edu.309.1655331904913;
        Wed, 15 Jun 2022 15:25:04 -0700 (PDT)
Received: from debian.home (90-180-208-18.rcn.o2.cz. [90.180.208.18])
        by smtp.gmail.com with ESMTPSA id y3-20020a056402358300b0042dc25fdf5bsm350427edc.29.2022.06.15.15.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2022 15:25:04 -0700 (PDT)
From:   Jiri Vanek <jirivanek1@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Vinay Simha B N <simhavcs@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiri Vanek <jirivanek1@gmail.com>
Subject: [PATCH 0/2] Fixes for TC358775 DSI to LVDS bridge
Date:   Thu, 16 Jun 2022 00:22:19 +0200
Message-Id: <20220615222221.1501-1-jirivanek1@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes two bugs in the driver for TC358775 DSI to LVDS bridge.

Jiri Vanek (2):
  drm/bridge/tc358775: Return before displaying inappropriate error
    message
  drm/bridge/tc358775: Fix DSI clock division for vsync delay
    calculation

 drivers/gpu/drm/bridge/tc358775.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.30.2

