Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D873B5179ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiEBW1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiEBW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:27:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB084B1F3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:24:14 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nleSf-0005bu-N0; Tue, 03 May 2022 00:24:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: Support YUV formats with U/V swapped
Date:   Tue,  3 May 2022 00:24:05 +0200
Message-Id: <165153020899.255051.8265541516247012144.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220114074038.2633848-1-wenst@chromium.org>
References: <20220114074038.2633848-1-wenst@chromium.org>
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

On Fri, 14 Jan 2022 15:40:38 +0800, Chen-Yu Tsai wrote:
> The VOP in Rockchip SoCs that support YUV planes also support swapping
> of the U and V elements. Supporting the swapped variants, especially
> NV21, would be beneficial for multimedia applications, as the hardware
> video decoders only output NV21, and supporting this pixel format in
> the display pipeline would allow the decoded video frames to be output
> directly.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: Support YUV formats with U/V swapped
      commit: 3fa50896c35982afb59ad5bcbe04ec2e91bb54a5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
