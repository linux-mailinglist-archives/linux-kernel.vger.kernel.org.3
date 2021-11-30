Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478A84641F2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345045AbhK3XJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:09:43 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:43205 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhK3XJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:09:41 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7CE52200004;
        Tue, 30 Nov 2021 23:06:19 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Camel Guo <camel.guo@axis.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com, Camel Guo <camelg@axis.com>
Subject: Re: [PATCH v3] rtc: rs5c372: Add RTC_VL_READ, RTC_VL_CLR ioctls
Date:   Wed,  1 Dec 2021 00:06:18 +0100
Message-Id: <163831354984.80026.71132451941412651.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211111083625.10216-1-camel.guo@axis.com>
References: <20211111083625.10216-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021 09:36:25 +0100, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
> 
> In order to make it possible to get battery voltage status, this commit
> adds RTC_VL_READ, RTC_VL_CLR ioctl commands to rtc-rs5c372.
> 
> 

Applied, thanks!

[1/1] rtc: rs5c372: Add RTC_VL_READ, RTC_VL_CLR ioctls
      commit: f601aa7930669439623dd266fc9e90b0218b42c1

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
