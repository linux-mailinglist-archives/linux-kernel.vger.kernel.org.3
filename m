Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F0B484B6D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbiAEAFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:05:43 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38309 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiAEAFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:05:41 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 37DBBC0004;
        Wed,  5 Jan 2022 00:05:40 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Camel Guo <camel.guo@axis.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Camel Guo <camelg@axis.com>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2] rtc: rs5c372: add offset correction support
Date:   Wed,  5 Jan 2022 01:05:32 +0100
Message-Id: <164134112610.1688528.6892083362224736032.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202152252.31264-1-camel.guo@axis.com>
References: <20211202152252.31264-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 16:22:52 +0100, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
> 
> In order for linux userspace application to be able to adjust offset to
> keep rtc precision as high as possible, this commit adds support of
> offset correction by adjusting the time trimming register on
> rs5c372[a|b] and oscilluation adjustment register on r2025x, r222[1|3]x,
> rv5c38[6|7]a.
> 
> [...]

Applied, thanks!

[1/1] rtc: rs5c372: add offset correction support
      commit: dd93849d47ce1517c1383ef30bd7497a001d213f

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
