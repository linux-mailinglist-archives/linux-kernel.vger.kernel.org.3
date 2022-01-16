Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3548FF8F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 23:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiAPW61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 17:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiAPW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 17:58:26 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E9DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 14:58:25 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5B1F040002;
        Sun, 16 Jan 2022 22:58:22 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Riwen Lu <luriwen@kylinos.cn>, a.zummo@towertech.it, e@80x24.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtc: cmos: Evaluate century appropriate
Date:   Sun, 16 Jan 2022 23:58:21 +0100
Message-Id: <164237389104.3519935.14751133795537334588.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220106084609.1223688-1-luriwen@kylinos.cn>
References: <20220106084609.1223688-1-luriwen@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 16:46:09 +0800, Riwen Lu wrote:
> There's limiting the year to 2069. When setting the rtc year to 2070,
> reading it returns 1970. Evaluate century starting from 19 to count the
> correct year.
> 
> $ sudo date -s 20700106
> Mon 06 Jan 2070 12:00:00 AM CST
> $ sudo hwclock -w
> $ sudo hwclock -r
> 1970-01-06 12:00:49.604968+08:00
> 
> [...]

Applied, thanks!

[1/1] rtc: cmos: Evaluate century appropriate
      commit: ff164ae39b82ee483b24579c8e22a13a8ce5bd04

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
