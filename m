Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABE54FBF1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382981AbiFQRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382080AbiFQRKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:10:38 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7E83B017
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:10:36 -0700 (PDT)
Received: from [213.70.33.226] (helo=phil.intern)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o2FUN-00063w-0p; Fri, 17 Jun 2022 19:10:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux@armlinux.org.uk, Liang He <windhl@126.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm: mach-rockchip: (pm) Add missing of_node_put()
Date:   Fri, 17 Jun 2022 19:10:28 +0200
Message-Id: <165548567344.3407211.15518569345867067474.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616021713.3973472-1-windhl@126.com>
References: <20220616021713.3973472-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 10:17:13 +0800, Liang He wrote:
> In rockchip_suspend_init(), of_find_matching_node_and_match() will
> return a node pointer with refcount incremented. We should use
> of_node_put() in fail path or when it is not used anymore.

Applied, thanks!

[1/1] arm: mach-rockchip: (pm) Add missing of_node_put()
      commit f4470dbfb5ff92804650bc71d115c3f150d430f6

There was an unneeded tab in the blank line above out_put
and a completely unneeded blank line added at the end of
the function. I dropped both.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
