Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A02951FB0C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiEILQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiEILQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:16:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9714C742;
        Mon,  9 May 2022 04:12:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p18so15833590edr.7;
        Mon, 09 May 2022 04:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idPGnnRp9pP0FFwfqlTXpXWL0sXolKua3kdnvGGZYcI=;
        b=je68A1zFVEfEiFtrzG/L9/q7N25aPiRdunrQyDqQUHt8cOrRr01LfItEvoDRAMMYsB
         vPj+YfJtlssNxrecCOkSRddTaNBnSz9rW/5VKSQM0nx8cQKLwV3o6ReJVsWsnPObBVxT
         OFCTW7S7r8Ys4iNC3z+Dt0UsZssVSNX0xCXFb36WlQL0/pv+F2jmSBzNip9yh3SqUGDT
         oDeYheSi3Vha1px3kaEVad/TFI9NXksp42CockgIYKTxy15F/lT5Cx30II0EHzjEfVE1
         ATB60q8tN3yPmKywQNL22iMpxE4aConJjyUpatff0yKtX9udEwAV8Fx0qHqI4GwuVQsJ
         VeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idPGnnRp9pP0FFwfqlTXpXWL0sXolKua3kdnvGGZYcI=;
        b=nyI2hSwsSzhwKcDXYkARVJQY7YyYpGQ+xjqWuhiwpfAs+flkiV5DJl0Lvl6I5YeRMc
         uhl/OePMj68haP5gcJpeECN2iDPvqDmB7pzKW7m1PzCdcxXlV1AWMOoSurpWWfkhOD9m
         5OLfKvv4C5eCo0l8IuhbM+l7+twdgPTr6vUDlRBuP4rN5OXHNU9LJMp/WN8W0U9/Y0d8
         1H/Gw6DFzwOeq09dG+lo2dMTt3IkF3GbXFPOQ/nJLjvRMFxPKs1rTGu2V+jhBqls/VRh
         gpFcUrD2QorGtU/4XAn2P+sm36cAXfbXPCr9E9C3ym5SNmWkXPKhTN1tklDKH/thuq4G
         mkKQ==
X-Gm-Message-State: AOAM533dMd4HVE1yxH0VX8eRDsGNjeCl18BAwbx0ou6fZ+fLlkygyJa5
        TpzBT+KK6KM7GBGGXfNvKUI=
X-Google-Smtp-Source: ABdhPJz9wdR1rC08gBIlvkZM1bHaMQ4i3GawbXtkLUVt2W+KDNTvwwFoxPdyd3xvlh6LnBVwfFLhXA==
X-Received: by 2002:a05:6402:228c:b0:425:d911:fd35 with SMTP id cw12-20020a056402228c00b00425d911fd35mr16682477edb.325.1652094725070;
        Mon, 09 May 2022 04:12:05 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id c24-20020aa7c758000000b0042617ba63b4sm6075672eds.62.2022.05.09.04.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:12:04 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] ARM: dts: imx6dl-colibri: Unify with changes to Apalis iMX6 device trees.
Date:   Mon,  9 May 2022 13:11:23 +0200
Message-Id: <20220509111126.7032-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>


- Follows a change to the SGTL5000 MCLK handling fixed for Apalis iMX6 by
  Fabio.
- Simplify handling of inverted PWM backlight
- Fixes a regression for the capacitive touch introduced with
  https://lore.kernel.org/all/20220411152234.12678-1-max.oss.09@gmail.com/



Max Krummenacher (3):
  ARM: dts: imx6qdl-colibri: Fix capacitive touch reset polarity
  ARM: dts: imx6qdl-colibri: Mux mclk for sgtl5000 with the codec node
  ARM: dts: imx6qdl-colibri: backlight pwm: Simplify inverted backlight

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.20.1

