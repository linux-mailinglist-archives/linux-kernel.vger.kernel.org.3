Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D165179F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiEBW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiEBW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:27:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A1FB1EA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:24:14 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nleSg-0005bu-0w; Tue, 03 May 2022 00:24:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, markyao0591@gmail.com,
        hjc@rock-chips.com, daniel@ffwll.ch
Subject: Re: [PATCH] drm/rockchip: vop: fix possible null-ptr-deref in vop_bind()
Date:   Tue,  3 May 2022 00:24:06 +0200
Message-Id: <165153020898.255051.10275204034959482615.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422032854.2995175-1-yangyingliang@huawei.com>
References: <20220422032854.2995175-1-yangyingliang@huawei.com>
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

On Fri, 22 Apr 2022 11:28:54 +0800, Yang Yingliang wrote:
> It will cause null-ptr-deref in resource_size(), if platform_get_resource()
> returns NULL, move calling resource_size() after devm_ioremap_resource() that
> will check 'res' to avoid null-ptr-deref.

Applied, thanks!

[1/1] drm/rockchip: vop: fix possible null-ptr-deref in vop_bind()
      commit: f8c242908ad15bbd604d3bcb54961b7d454c43f8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
