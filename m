Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4555252AE00
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiEQWVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiEQWVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:21:49 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A558029C8D;
        Tue, 17 May 2022 15:21:47 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 338F11BF203;
        Tue, 17 May 2022 22:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652826106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/9LHOdniNqpsQQK4EjfOLUWtSZFf+YUbBePOrM8sjY=;
        b=Dz913Ph4XCoDRWfAUYm/4wmwX13Ds7HhDUORjFbIHvI9m12aGz+76PINitrvx2uWtyCK5A
        XVdUHqNp6rEleB6fkZl1bI7c9F2NHdZrrpcfcHbi77oMMYQXpSEBtM7sTtfJMDcnVogGHw
        TlzYHBZavoZmQ1WEGsu2LXeoNZWc5QUlz0YC65Eq/+u6bgyw+khrIN+6YJHhb1XqxaGK2X
        62ZoiHWnADfLIz2zobohb2pfPqqha3BPcbHC2LNXpGTjioJSpGqmpY+ljKjeouQN5lmMxf
        SYRa0zM+bcjbSWmrRofTlr1ONAbF4m/fFUae3qmNTvjbm75oU9Upk7B2fhy+OA==
Date:   Wed, 18 May 2022 00:21:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] rtc: rtc-meson: Fix email address in MODULE_AUTHOR
Message-ID: <165282608089.294838.1764827587733203954.b4-ty@bootlin.com>
References: <20220506232850.220582-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506232850.220582-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2022 08:28:50 +0900, Nobuhiro Iwamatsu wrote:
> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> 
> Ben Dooks's email address is <ben.dooks@codethink.co.uk>.
> Fix Ben Dooks's email address in MODULE_AUTHOR.
> 
> 

Applied, thanks!

[1/1] rtc: rtc-meson: Fix email address in MODULE_AUTHOR
      commit: a37bdde620c2eb89505ee42ff60ed7030b50f71a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
