Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272AE527985
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 21:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiEOTcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 15:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiEOTcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 15:32:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E2F286EF;
        Sun, 15 May 2022 12:32:29 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nqJyb-0005zF-2M; Sun, 15 May 2022 21:32:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] add Pine64 touch panel support to rockpro64
Date:   Sun, 15 May 2022 21:32:23 +0200
Message-Id: <165264312976.2522653.14035035334759399126.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511113517.4172962-1-pgwipeout@gmail.com>
References: <20220511113517.4172962-1-pgwipeout@gmail.com>
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

On Wed, 11 May 2022 07:35:13 -0400, Peter Geis wrote:
> Good Morning,
> 
> Apologies Heiko on taking so long for this v2.
> 
> This patch series adds support for the Pine64 touch panel to the
> rockpro64 single board computer.
> This panel attaches to the dsi port and includes an i2c touch screen.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: display: panel: feiyang, fy07024di26a30d: make reset gpio optional
      commit: d0956e2c520c9d730979a9669f27a77d40acac13
[2/3] drm/panel: feiyang-fy07024di26a30d: make reset gpio optional
      commit: de5db71e4c8c35ed5e92006e3064ce9230881ece

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
