Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF884FB6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344103AbiDKJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344115AbiDKJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:03:22 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21C43EF36;
        Mon, 11 Apr 2022 02:00:54 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5DCD260006;
        Mon, 11 Apr 2022 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649667652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eAal80AxgzHfiJq/cToM0/q1B2DW2EQ/K6BrHuWb2m0=;
        b=H++49mYKob5uXrsVDsy8b2/SS2PlHX9K69f7O2nsW/FelegzIDrfl6uNL7A1/afkv+UYXk
        l28T6Ree+1t/R76+0cH7geDNm716FiqU03W62iHI69ztA4DaSkWe513FPLXDTvVMzEuvMK
        ZLEHNgU9g1PzVr/ehnQSE9fMdMXjITKTgWG7GA/xrNJ2Dh4PR/6fyo2EyCnwRMLiuxdlkF
        BBewTgS+KBPGAEuc5Ovo/9iSFoafSCpvk5VZTn6Iy8SmqZGc9FGyzIsQ38G5+vCoBtdZ+H
        9A0eL1LKWmGAcmwwMWkMgvWlxvpmwsZCoR3XRnU2b+f5luJknZLX/izzqifYnw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     krzk@kernel.org, richard@nod.at, vigneshr@ti.com, kishon@ti.com,
        nm@ti.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mtd: ti,elm: Convert to yaml
Date:   Mon, 11 Apr 2022 11:00:50 +0200
Message-Id: <20220411090050.11199-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220326080726.30372-2-rogerq@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6863c612024f92dfba656cc4f74b19d348cfce8f'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-03-26 at 08:07:24 UTC, Roger Quadros wrote:
> Convert elm.txt to ti,elm.yaml.
> 
> hwmod framework use is deprecated for new platforms
> so mark it so.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
