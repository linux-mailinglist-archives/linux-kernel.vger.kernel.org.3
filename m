Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7CF4FB6B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbiDKJDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344035AbiDKJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:02:58 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3AF3ED38;
        Mon, 11 Apr 2022 02:00:43 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 14CA11BF20E;
        Mon, 11 Apr 2022 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649667641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++jLax8sR9pn5mPU9t/CMQ0Kj/6sNh+shn1ykS+deAw=;
        b=A2UVo0+sSv2C3acp212wvCCjmE7zzudbRXzQb4q5gT7AYicz67d2HVkU1jcKi8a4sVhw6l
        Tu/PPe8hNd3pQbSDZl7UedEDNP3ot+jrv527UbdnocNe+fXBQNxcBLNvzVv2xM1nZ0mKzT
        1YTiK9PVuQlfg/C0bswoj2hWKWCYZ/TByatVei/M5G0D+EIKsQV3U36ELb3hSD1cEj0Msq
        BBWFMQ5n5ND5+SWkTyeYKIxmadNJ0GnYkD6O+jnU1DH5VTJFuqG1X33NWrmVNhq4If6aj8
        p0h6zmi5UpCJfRHM5aHyFwQZ45QqulVvTVP9PTG8dewfhq9rue4ZvQlmT6alcA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     krzk@kernel.org, richard@nod.at, vigneshr@ti.com, kishon@ti.com,
        nm@ti.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mtd: rawnand: omap_elm: Add compatible for AM64 ELM
Date:   Mon, 11 Apr 2022 11:00:39 +0200
Message-Id: <20220411090039.11071-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220326080726.30372-4-rogerq@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'51a4a71d974c25dc102216a52462ff6d53eced15'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-03-26 at 08:07:26 UTC, Roger Quadros wrote:
> The AM64 SoC has the Error Locator Module. Add compatible id for it.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
