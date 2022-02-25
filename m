Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFC24C432C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbiBYLPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbiBYLPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:15:39 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4921DF06
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:15:06 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C4006C000A;
        Fri, 25 Feb 2022 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645787704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7d1/5MJwyJAgWC/q9iG3LwqQNqmMpQwEOsY7A8M4lE=;
        b=IyRdrHehUts03izUFa6y1cmECbhYSKoHw+G3I/YNJRt0klaM6cbaJmMNqEiPIaDssUm4Qn
        G5B2oHDBFws3A/4Ydi4s5hKLZrmCzI92yMfBBjZNvq45BlmQuWgg0vky7gaEjzSzB6HaA0
        xTRkvPdxjEdtKfa7LncpXTZUBvrejz41blBCMTqxTNBZtYiw+VCRJEu8oJvIAKB88ObFUY
        Cvnftzf+jyVB3OrwX0LZrDic7hEYok8Z1+imm6XnOjxdaFfmyIK7znRsyg31U1cewlF+cL
        IjZsPGtoQOafPncyNwyviiMuWv7Fr9REeMfmmvRRzHWYuyBHxCS5PuGKYcRpQg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        krzysztof.kozlowski@canonical.com
Cc:     vigneshr@ti.com, nm@ti.com, linux@roeck-us.net,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: omap2: Actually prevent invalid configuration and build error
Date:   Fri, 25 Feb 2022 12:15:00 +0100
Message-Id: <20220225111500.497281-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220219193600.24892-1-rogerq@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'7cf1de957a980d96d8b9c9e481c8bb1ad53fd99b'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-02-19 at 19:36:00 UTC, Roger Quadros wrote:
> The root of the problem is that we are selecting symbols that have
> dependencies. This can cause random configurations that can fail.
> The cleanest solution is to avoid using select.
> 
> This driver uses interfaces from the OMAP_GPMC driver so we have to
> depend on it instead.
> 
> Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid configuration and build error")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
