Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26BA50F295
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbiDZHhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbiDZHha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:37:30 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1751331BB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:34:24 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F31C340004;
        Tue, 26 Apr 2022 07:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650958462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5bJaWA94MbeEcumkuk0ZButgw7OJvfuu3YZ1ypnOaY=;
        b=DKn2uSinHob9BtRTzHJGM+QzhKBlbJD2jEsOnPODIccuNrnwgPsZH6lJBrJcOnzgiIA1Uo
        nKKa2HU27uWChoaV4Zo236TMxDYI9h0ZVFVPkJI9QHw1wkzlU794vDsnQSDfRrSeu+sUFx
        5JQZfOLab7utin9mS+txApqj124u6vw5sNS5LC11/qPFkuKK2UXOcUATjVbwqm9Y8Hp012
        CeNQjiYQgX7lQpyUFusrzaHFTsHW2nQk/UjZ3AFfmo6gSBUjLUSVGQY9xV6k8Qz11cbZWa
        jfMWHHh/NrDtgMTS9/1dltGxCcTIcEOQd6Bz0St7FYqPX5bPC/fA53OAHpAntA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 2/3] mtd: mtdoops: Create a header structure for the saved mtdoops.
Date:   Tue, 26 Apr 2022 09:34:20 +0200
Message-Id: <20220426073420.36975-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220421234244.2172003-3-jmeurin@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'0bd359ee712d9d3e757971ded4094c8ba006acd4'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-21 at 23:42:43 UTC, Jean-Marc Eurin wrote:
> Create a dump header to enable the addition of fields without having
> to modify the rest of the code.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
