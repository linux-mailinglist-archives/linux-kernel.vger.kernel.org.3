Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62B1533C09
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbiEYL4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiEYL4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:56:10 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226EDA2069;
        Wed, 25 May 2022 04:56:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C412F5C027B;
        Wed, 25 May 2022 07:56:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 25 May 2022 07:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1653479762; x=1653566162; bh=jA
        xrL7YUz+unCts2ytc9HlFrvuVEdWE6RN2VKDbjh44=; b=d2M9yUxcA9oH1c9dND
        cwrnYxcvgmYpg5HPKpJwm9AzWNkNaDfrmjcy67JUtPbFe2yR8n+tu1cO5zDomBPS
        v56nzNvGNXA+5B0FG43hm3jvc8jK7itaS+d1R7zBk/RyNZmNEg3YU6VLoKtzxd4L
        MMh7vWXX+T/tKTZ4zlhAaXtHn8TA1vMXxoUvYwFD4lAqicYzSp3NoZyCUfWfojnE
        LpVgwVmTQNCqVDCiteSmgJbrXHkWs1LtVb6bHoVwAfD9Cu22wNWvcSz1t30NlKz9
        6t4llEzAtFxpbeLrV/z1Han1wIDBx/7a/IySVyOk7vtVJE+j0KeXMvxzcJfIWsiD
        gEpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653479762; x=1653566162; bh=jAxrL7YUz+unC
        ts2ytc9HlFrvuVEdWE6RN2VKDbjh44=; b=lUkXJuMBL+glesNbfuKUEj0Lbwgaq
        QtNY04rvwGIivzJBLdLco81JslxvrYgBAa09RU7lXnM9a7ha7KVcJkliLsGbPkUM
        b1y910IEK5ZUwYhpuuvrtLbVSLQJKDv5I3nYSF42o/mXUBUtCKakpvA2suNiANDq
        1z2gp1vuimpBa8E0ZEgq876eVVqUOxG00yKKH0fT0OIReJsVRZIxFnTuQsFjpFtj
        b8YeNlWgScsWVm6zYUXrjZEwpbqkwo9+GzHoYw3xOh45m01/x34MrVRXChZAxriP
        zHnTf2ZZ/Zm6YAxihfhphTPDlyIWAMHBywwfHMmWNUQQa9pfh3hOufVKA==
X-ME-Sender: <xms:UhmOYpcBoC1qHV9rOKXvjcJH4nezQbO65uJJI3WY4MHIrdhrS1YAmQ>
    <xme:UhmOYnNzuN8DNrP3mXnhVj3qVPe1oUoKuWyjfWCMyy7EJx-WxGX5mi9F2hPqJemh5
    LuhhGitVgI83O0SpqY>
X-ME-Received: <xmr:UhmOYijSphjgTwUDg-aJ_jlNxeAIOgPsiqtQneA8M8Bl1iLl8PgHd1Xn909IYsJrCRaTj0TJ4Ery>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeehgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgtggfgsehtkeertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffekhfelteeggf
    etieekteekhedtffekvddtveetgeffgfelffeftdehuefgheefnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:UhmOYi_XmhGCZwoj4Kz-3w--1CMVuozb5LBxPuG6HEy8gebi_uwK2A>
    <xmx:UhmOYlud2fn7DqET4xV0F4lKucKShKxJMJFFUv5B-5YtUdXlo7E49A>
    <xmx:UhmOYhFe0l-qucpmYp5p7AHRzj2pqPcG7AuIBxiy5W6wMOalFnJ44A>
    <xmx:UhmOYgnyXF_DRbzCTQ_pPAqW6w_U8ckYxFB0kRQwKXeBUs8RDuJ48Q>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 07:55:56 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, lee.jones@linaro.org, broonie@kernel.org,
        robh+dt@kernel.org, kernel@pengutronix.de
Cc:     s.hauer@pengutronix.de, alistair23@gmail.com,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        amitk@kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-hwmon@vger.kernel.org, linux-imx@nxp.com, linux@roeck-us.net,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v21 0/4] Add support for the silergy,sy7636a
Date:   Wed, 25 May 2022 21:55:50 +1000
Message-Id: <20220525115554.430971-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset="utf-8"
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

v21:
 - Rebase on master
v20:
 - Remove merged patches
 - Fixup Kconfig selection based on previous discussions
v19:
 - Rebase on linux-next
v18:
 - Rebase
v17:
 - Rebase and fix build issues
v16:
 - Improve vdd regulator comments
v15:
 - Address comments on the patches
v14:
 - Merge the thermal driver and hwmon
v13:
 - Address comments on thermal driver
 - Rebase on master (without other patches)
v12:
 - Rebase
v11:
 - Address comments on hwmon
 - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message
v10:
 - Use dev_get_regmap() instead of dev_get_drvdata()
v9:
 - Convert to use the simple-mfd-i2c instead

Alistair Francis (4):
  mfd: silergy,sy7636a: Add config option
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
  ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a
  ARM: dts: imx7d-remarkable2: Enable lcdif

 arch/arm/boot/dts/imx7d-remarkable2.dts | 136 ++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig    |   3 +
 drivers/hwmon/Kconfig                   |   1 +
 drivers/mfd/Kconfig                     |  12 ++-
 drivers/regulator/Kconfig               |   1 +
 5 files changed, 152 insertions(+), 1 deletion(-)

-- 
2.35.3

