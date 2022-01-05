Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E25484B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiAEAFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:05:41 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49709 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiAEAFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:05:41 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 9DCEDC0005;
        Wed,  5 Jan 2022 00:05:38 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Camel Guo <camel.guo@axis.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Camel Guo <camelg@axis.com>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] rtc: rs5c372: fix incorrect oscillation value on r2221tl
Date:   Wed,  5 Jan 2022 01:05:31 +0100
Message-Id: <164134112610.1688528.2304039595793971938.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211206125832.6461-1-camel.guo@axis.com>
References: <20211206125832.6461-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 13:58:31 +0100, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
> 
> The XSL bit only exists in RS5C372A/B. On other Ricoh RTC chips
> supported in rs5c372, this bit has different meaning. For example, on
> R2221x and R2223x, this bit of oscillation adjustment register
> determines the operation frequency of oscillation adjustment circuit and
> the oscillation is always 32768HZ. But rs5c372_get_trim gives 32000HZ to
> osc when DEV is 1.
> 
> [...]

Applied, thanks!

[1/1] rtc: rs5c372: fix incorrect oscillation value on r2221tl
      commit: ed06106614341301b3c4b84b6c0b497a72caec7d

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
