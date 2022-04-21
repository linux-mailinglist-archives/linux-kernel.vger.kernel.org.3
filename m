Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75660509956
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385952AbiDUHjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385889AbiDUHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:39:29 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BAD1B7A1;
        Thu, 21 Apr 2022 00:36:06 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 048121BF20A;
        Thu, 21 Apr 2022 07:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650526565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QwbuwKVBOef3FVZDFj8PDSdkA6YXrwYauV0H1YXv1+4=;
        b=ThdalBss+7bFsH6ZCSivg0aPGe4tb0Nur0cjeUbhNYr4Aqof2cnb+2ilfRDnhrD4SfaD9S
        mf67j5HCJcXNn6DfP1Dj2qtadbnNd+cAoxr7MMD0OXF4aucdJdIz3fcNCepQmYPtXShlAF
        aOKfoal3AOY8l9OoycGf9OQHUL3nIFj3Nb+YW6JCQLz7iGObNIW/591ndHOYcF/JHPgIL9
        lkVpL3TEV0nrbIuVRtLUC6C/NOoMcACA+V7arp73apfALDOU8xrSqba2vR6z9P8MdbCSTh
        cAYQvQlaQ94OZyxoUVmiJx3DzDmuqzUMDwO5fg+rGN9ewnHXJh4OHZVX8QCm5A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, vigneshr@ti.com,
        richard@nod.at, miquel.raynal@bootlin.com, joern@lazybastard.org
Cc:     kernel@axis.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        frowand.list@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mtd: phram: Allow probing via reserved-memory
Date:   Thu, 21 Apr 2022 09:36:03 +0200
Message-Id: <20220421073603.72148-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220412135302.1682890-4-vincent.whitchurch@axis.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd55e5d8931a8b7a3ae11e6c8b031e1900bbbe90d'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 13:53:01 UTC, Vincent Whitchurch wrote:
> Allow phram to be probed from the devicetree.  It expects to be in a
> reserved-memory node as documented by the bindings.  This allows things
> like partitioning to be specified via the devicetree.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
