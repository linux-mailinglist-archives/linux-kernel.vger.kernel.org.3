Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329F7484B74
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbiAEAFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:05:48 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:41859 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiAEAFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:05:45 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 64FF1240003;
        Wed,  5 Jan 2022 00:05:43 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kees Cook <keescook@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: Move variable into switch case statement
Date:   Wed,  5 Jan 2022 01:05:34 +0100
Message-Id: <164134112610.1688528.1741157654038532644.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209043915.1378393-1-keescook@chromium.org>
References: <20211209043915.1378393-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 20:39:15 -0800, Kees Cook wrote:
> When building with automatic stack variable initialization, GCC 12
> complains about variables defined outside of switch case statements.
> Move the variable into the case that uses it, which silences the warning:
> 
> drivers/rtc/dev.c: In function 'rtc_dev_ioctl':
> drivers/rtc/dev.c:394:30: warning: statement will never be executed [-Wswitch-unreachable]
>   394 |                         long offset;
>       |                              ^~~~~~
> 
> [...]

Applied, thanks!

[1/1] rtc: Move variable into switch case statement
      commit: ba52eac083e1598e748811ff58d259f77e4c5c4d

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
