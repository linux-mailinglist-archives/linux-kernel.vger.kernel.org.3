Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CE6466C12
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243366AbhLBW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:27:54 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52931 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbhLBW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:27:51 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id CDF321C000C;
        Thu,  2 Dec 2021 22:24:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: Re: [PATCH v3] rtc: da9063: add as wakeup source
Date:   Thu,  2 Dec 2021 23:24:25 +0100
Message-Id: <163848385220.116247.9488906740285227230.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129072650.22686-1-nikita.shubin@maquefel.me>
References: <20211129072650.22686-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 10:26:49 +0300, Nikita Shubin wrote:
> As da9063 RTC is not a real I2C client, but relies on da9063 MFD
> driver, we need to explicitly mark da9063 RTC as a wakeup source
> to be able to access class/rtc/rtcN/wakealarm sysfs entry
> to set alarms, so we can wakeup from SHUTDOWN/RTC/DELIVERY mode.
> 
> As da9063 driver refuses to load without irq, we simply add it
> as a wakeup source before registering rtc device.
> 
> [...]

Applied, thanks!

[1/1] rtc: da9063: add as wakeup source
      commit: 029d3a6f2f3c73ac29a7460d8007798e940488fd

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
