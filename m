Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F0509960
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348809AbiDUHkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385990AbiDUHje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:39:34 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F80E00F;
        Thu, 21 Apr 2022 00:36:19 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ED276200004;
        Thu, 21 Apr 2022 07:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650526576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLnPW+LzI3lgBT5U7Gf+ZC/2rVGSb+JzlunzqTddV30=;
        b=hAcwO+0dalo4eBsDGa+vx8nyX9+AnXaN28rO6xDVVs/Qt/ydjT6rLxSbgIjhA5tqMnt/nM
        ebVbl0ro0RlRB3mOQ0aLZdFPZFs4vXqXN5e7C+2xT15EOdQ+2z/4mdC5IJkjNWCsTBlItr
        YOntuhuOwm43dWD3jAntkQSvZodTyLBrZH0RAICbTeO5jxqw9HeyuDjBZjAVqnFKkCdAPL
        ENT4keC+SigwBTyhmWzn0Ta/PHLQw8gs+2ZSVwu7v5h3hjqvJ8n8CWoVc35ai73DFk7epd
        xGgYNr08OeLxnbGjkemCZGl7+pvlhvIbaWlwKthTNrSdPatLUb1KgFX4LX+UuA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, vigneshr@ti.com,
        richard@nod.at, miquel.raynal@bootlin.com, joern@lazybastard.org
Cc:     kernel@axis.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        frowand.list@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mtd: core: Check devicetree alias for index
Date:   Thu, 21 Apr 2022 09:36:13 +0200
Message-Id: <20220421073613.72280-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220412135302.1682890-2-vincent.whitchurch@axis.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'304099a37cffdba2fd80af915334fc146e23132b'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 13:52:59 UTC, Vincent Whitchurch wrote:
> Allow the MTD index to be specified via a devicetree alias, so that the
> number does not just depend on probe order.  This is useful to allow
> pseudo-devices like phram to be optionally used on systems, without
> having this affect the numbering of the real hardware MTD devices.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
