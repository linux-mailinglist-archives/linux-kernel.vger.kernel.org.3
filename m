Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D64A7BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348146AbiBBXvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:51:07 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51415 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239716AbiBBXuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:50:51 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F6C55C01D4;
        Wed,  2 Feb 2022 18:50:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 02 Feb 2022 18:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=G3uMJoiuyTNYSzQLHkBtYHuRGGlAUi5KOnThdB
        0YcG8=; b=NXJUF3YhKRU8bfeCGs/x/X2JQdeLsluEgkicQJx6DgojU5K1kP1egf
        MjvBexuh379F9p7Hr4QkjeDfPjE7jLlYpXnA1EPaJ19oF2CbNNG2SBOhhvNyuyQv
        D7ruPgB3BaHr37k7Q3/dKrASPaQqFCDDxpYLbQsoDNhEFTN6nwRBB6d6GnOPQTe2
        r252aLGGfKgYE2rtu1Ok1VdvI3h7mSa+V6pHiIWAV46SDEEP+v2oTcGvrdQAediW
        zCFM9acWwtLAdznMqKjlYINtKITMbm8Y7qWf96JUYVr1Zcv++ImPgDlSySBvtnwV
        d9tEjmSWYcW7Kiypgq2VrYAAaX2Cje2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=G3uMJo
        iuyTNYSzQLHkBtYHuRGGlAUi5KOnThdB0YcG8=; b=MIKrEs6WfmCWJ7tQql0C80
        WHMokSU/wQi3Xs0D+OzuLb7WpxE993bmu2xDWxOPv7CD5/UzlaDizng73KhrG+Im
        T+utaLt4xjJ8azlv/z9airUp9fRigZOI5tMiBcB3O8HRvTc8/2uuc04HO/AAWIAo
        huR7yIH+mydfbKdADO+CqkzjmbjBQSn9wN46ptZgnQ9rP4hvMMTLcFuRBCUUW1zV
        v0VcMZLlWbb6uvaSdDoEc6yEpIg/xoCJCzufplkqmPKtKJoQBqScgrgNR4xxG2mX
        tYoQreaKvZDRtqs8CMAsPzG9Tp5aXFd1/P1csPDy9qWnLd161pf8+rCRabOWFU6A
        ==
X-ME-Sender: <xms:2hj7YVtOiVGqZ2pZ55PmWyi7jPOog0EOPBsseY4c0ErmU8m-PAJ2lQ>
    <xme:2hj7Yec6toGLUbgOYviI0ZPpuFgHdzq_7xfXm3j8RZKQ6E36EvZ_oUSK4mUpSfwnM
    VO2Vpc6BR5kIOnN1Q>
X-ME-Received: <xmr:2hj7YYz21onOCS5Gy_x_fWyGDaGxdyN9yzaiwh-eImjlfkD-E1IE2FpXjd-R_JRSeIMB4xQ_o4Q2nXe7sMClgR_h3HEzQZqZojBRTLnm_RHdVRqZKJjhBkCC_qx75BFFwluirg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpedvleefveegvefghfegheeghfehtdeigeejfefhvedvueekieefheetfffg
    veethfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:2hj7YcMt_MdI0rrH2DIeCHb7e1Mr7yHSJuxGyVx15C06csFGZy-_fg>
    <xmx:2hj7YV9yhD214nDm-krfaw8GMwfCx5b1COQwiYoOsrLLMbYoHrIavA>
    <xmx:2hj7YcWooIKl7elu2kANYbtxeNxftV4qNYWyuwpPXoPM1xpJV_kdDQ>
    <xmx:2xj7YeNM0J5PlIMVIm2-wDTYVw3NZx9Iw1du4tVNBTdB4BfVCurOoA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 18:50:50 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/3] iio: Silan SC7A20 accelerometer support
Date:   Wed,  2 Feb 2022 17:50:45 -0600
Message-Id: <20220202235049.8051-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip is register-compatible with an ST part, so it works without
any issues when added to the existing driver.

Previously I called it a clone, but it's not really a clone, because
it's not a drop-in replacement for the other chips. The software
interface matches the ST parts, but the pinout does not. Instead, the
pinout matches the Kionix KX122 and KX132.

Changes in v2:
 - Move the new compatible to its own section
 - Add a comment about the WAI value
 - Update commit messages

Samuel Holland (3):
  dt-bindings: vendor-prefixes: Add silan vendor prefix
  dt-bindings: iio: st: Add Silan SC7A20 accelerometer
  iio: accel: st_accel: Add support for Silan SC7A20

 .../bindings/iio/st,st-sensors.yaml           |  3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/iio/accel/st_accel.h                  |  2 +
 drivers/iio/accel/st_accel_core.c             | 83 +++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c              |  5 ++
 5 files changed, 95 insertions(+)

-- 
2.33.1

