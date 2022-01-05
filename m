Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02FF484B77
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiAEAFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:05:52 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48265 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiAEAFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:05:50 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id DE44F20005;
        Wed,  5 Jan 2022 00:05:46 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        wells.lu@sunplus.com, Vincent Shih <vincent.sunplus@gmail.com>,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vincent Shih <vincent.sunplus@gamil.com>
Subject: Re: [PATCH v3 0/2] Add driver for RTC in Sunplus SP7021 Soc
Date:   Wed,  5 Jan 2022 01:05:37 +0100
Message-Id: <164134112610.1688528.3307578607185999484.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <1638517579-10316-1-git-send-email-vincent.sunplus@gamil.com>
References: <1638517579-10316-1-git-send-email-vincent.sunplus@gamil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 15:46:17 +0800, Vincent Shih wrote:
> This is a patch series for otp driver for Sunplus SP7021 SoC.
> 
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
> etc.) into a single chip. It is designed for industrial control.
> 
> Refer to:
> https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> https://tibbo.com/store/plus1.html
> 
> [...]

Applied, thanks!

[1/2] rtc: Add driver for RTC in Sunplus SP7021
      commit: fad6cbe9b2b4137f5af5355d4ee7e4eb38221e7e
[2/2] dt-bindings: rtc: Add Sunplus RTC json-schema
      commit: 8462904204abd8cc7f75947d7005c71e8a77da7b

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
