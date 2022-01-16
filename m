Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C848FF7A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 23:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiAPWg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 17:36:28 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:43919 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiAPWg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 17:36:27 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 210781BF205;
        Sun, 16 Jan 2022 22:36:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rtc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] rtc: gamecube: Fix an IS_ERR() vs NULL check
Date:   Sun, 16 Jan 2022 23:36:24 +0100
Message-Id: <164237257208.3515791.7822452654038948546.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107073340.GF22086@kili>
References: <20220107073340.GF22086@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 10:33:40 +0300, Dan Carpenter wrote:
> The devm_kzalloc() function returns NULL on error, it doesn't return
> error pointers.
> 
> 

Applied, thanks!

[1/1] rtc: gamecube: Fix an IS_ERR() vs NULL check
      commit: 900ed72c8a190e8c0b87cb17abc645b8ec713011

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
