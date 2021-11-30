Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388724641F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbhK3XLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:11:25 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39827 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344850AbhK3XLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:11:12 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1C69D40008;
        Tue, 30 Nov 2021 23:07:49 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     ferlandm@amotus.ca, a.zummo@towertech.it
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] rtc: pcf85063: add i2c_device_id name matching support
Date:   Wed,  1 Dec 2021 00:07:49 +0100
Message-Id: <163831366173.80369.17100409949013853477.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211116164733.17149-1-ferlandm@amotus.ca>
References: <202111051119.UeuF3GiJ-lkp@intel.com> <20211116164733.17149-1-ferlandm@amotus.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 11:47:33 -0500, ferlandm@amotus.ca wrote:
> From: Marc Ferland <ferlandm@amotus.ca>
> 
> The pcf85063 driver regsitration currently supports the "compatible"
> property type of matching (for DT).
> 
> This patch adds "matching by name" support to the driver by defining
> an i2c_device_id table and setting the id_table parameter in the
> i2c_driver struct.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf85063: add i2c_device_id name matching support
      commit: 1c1b3098ae1e0d9725d0d4d49986e0edebba443a

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
