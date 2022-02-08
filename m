Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1644ADEC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383614AbiBHQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348791AbiBHQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:59:27 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C7BC061579;
        Tue,  8 Feb 2022 08:59:25 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nHTpq-0002ya-5o; Tue, 08 Feb 2022 17:59:22 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add the i2s3_2ch node to rk356x
Date:   Tue,  8 Feb 2022 17:59:18 +0100
Message-Id: <164433936977.231183.92484649914361985.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131153457.391460-1-michael.riesch@wolfvision.net>
References: <20220131153457.391460-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 16:34:57 +0100, Michael Riesch wrote:
> Add the two-channel I2S controller I2S3_2CH to the rk356x device tree.

Applied, thanks!

[1/1] arm64: dts: rockchip: add the i2s3_2ch node to rk356x

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
