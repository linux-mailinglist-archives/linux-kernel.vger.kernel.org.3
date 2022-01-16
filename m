Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635A648FF92
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 23:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiAPW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 17:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbiAPW62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 17:58:28 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810E4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 14:58:27 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6A94D240002;
        Sun, 16 Jan 2022 22:58:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        vincent.sunplus@gmail.com, a.zummo@towertech.it
Subject: Re: [PATCH -next] rtc: rtc-sunplus: fix return value in sp_rtc_probe()
Date:   Sun, 16 Jan 2022 23:58:22 +0100
Message-Id: <164237389104.3519935.13650173996002383472.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220106075711.3216468-1-yangyingliang@huawei.com>
References: <20220106075711.3216468-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 15:57:11 +0800, Yang Yingliang wrote:
> If devm_ioremap_resource() fails, it should return error
> code from sp_rtc->reg_base in sp_rtc_probe().
> 
> 

Applied, thanks!

[1/1] rtc: rtc-sunplus: fix return value in sp_rtc_probe()
      commit: 5ceee540fdc7f1d65ca6e2b1b193ce5aa95ab99c

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
