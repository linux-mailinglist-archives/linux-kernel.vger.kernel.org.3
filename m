Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549034F118E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbiDDJCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiDDJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:02:07 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4BD2AE16
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:00:11 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nbIZC-0008Ew-9Q; Mon, 04 Apr 2022 11:00:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Johan Jonker <jbx6244@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: rockchip: pm_domains: Fix typo in comment
Date:   Mon,  4 Apr 2022 11:00:01 +0200
Message-Id: <164906273050.1398682.14077881523760006890.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326183451.66115-1-sebastian.fricke@collabora.com>
References: <20220326183451.66115-1-sebastian.fricke@collabora.com>
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

On Sat, 26 Mar 2022 19:34:50 +0100, Sebastian Fricke wrote:
> s/eject devices form power domain/eject devices from the power domain/

Applied, thanks!

[1/1] soc: rockchip: pm_domains: Fix typo in comment
      commit: dc08a6884dfbd2974f681c8fc1211d7284273bfc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
