Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25692509961
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385922AbiDUHjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385972AbiDUHjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:39:31 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A691BEBA;
        Thu, 21 Apr 2022 00:36:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 21EA01BF20C;
        Thu, 21 Apr 2022 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650526570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcb4fNSQYUR6OWiIdyOzCplJ/DTcA5AU/+7wwXW0E90=;
        b=MOj5ny+Vw2r4F0LVZL6WM582GYT413UwNGIAbPUvPMklTVkYFZxLDyO8GI6bBnEKy4V5gB
        KkTpR1CgsUYoCCW/7vddUpcSjOrE9v1vC3CgbuPs/25jtHG76naJyO6MFmc2EfRMiWIFVb
        8EQR2OMOagscs25K9yq524dllQKWR9TEPIPkrtLUiwG+v5cvE9bems/c37Vg1uILhE/MN/
        binECpa7A928AsFGVx/9dDeycf6cGVHAs6no7X/CfFiW7ThM3wuXnYDrRXvj8NGkkSU0IJ
        bROhCPozgNknDeNQI/oCQfugBawiIUVTS7GukWGTMJMrL+wnfl5+yvsfQEl+RA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, vigneshr@ti.com,
        richard@nod.at, miquel.raynal@bootlin.com, joern@lazybastard.org
Cc:     kernel@axis.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        frowand.list@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: reserved-memory: Support MTD/block device
Date:   Thu, 21 Apr 2022 09:36:08 +0200
Message-Id: <20220421073608.72216-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220412135302.1682890-3-vincent.whitchurch@axis.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9638e151eeeaeabcad4341ba20f63fe80916cd7a'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 13:53:00 UTC, Vincent Whitchurch wrote:
> Add bindings to allow MTD/block devices to be used in reserved-memory
> regions using the "phram" (MTD in PHysical RAM) driver.
> 
> This allows things like partitioning to be specified via the existing
> devicetree bindings.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
