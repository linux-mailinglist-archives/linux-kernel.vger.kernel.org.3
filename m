Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C803147E373
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348439AbhLWMcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:32:23 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:34077 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348430AbhLWMcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:32:22 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BC74E223E9;
        Thu, 23 Dec 2021 13:32:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1640262740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Adq8KD1q0bwqULNzKvvB4egbuoMmHsacFlZtoJtCnVY=;
        b=J8OMEgcdPSZ/ZmjTdVpGipRQ5vyMnaQ91RkMH4pdmFBK5xUO8wEnz85pnuBvaQNMRm2uXO
        FK151qR8QcAMVfPOVRIj+dVzUuJ1d6mgAey1BeGBZsIea0UyBS5v61Pa4urH7kWMQ8a1x1
        Qyb7J98KWnIOcnXQ1lTtt6vnAFlrbnw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 23 Dec 2021 13:32:19 +0100
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: regmap: Switch to use fwnode instead of
 of_node
In-Reply-To: <20211223121606.67055-1-andriy.shevchenko@linux.intel.com>
References: <20211223121606.67055-1-andriy.shevchenko@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <84b97cb42349270bda5f6f49bc413741@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-12-23 13:16, schrieb Andy Shevchenko:
> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Michael Walle <michael@walle.cc>
