Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78B7509110
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382009AbiDTUIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381910AbiDTUIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:08:35 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F1A45AD0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:05:48 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EAE4222249;
        Wed, 20 Apr 2022 22:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650485147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FM+OM+UGFo7QA8C4D+CNPizdEHpdObWY21ICZbjKN6s=;
        b=FPxIwhgfXCbVq7kuHMWkM11mTzLojrm6GlOjv7VPh8CrrG21YaoiHWFch5cWBErGVJutEO
        Q412TUq5GbC+aHzjpvenYmDwbnokAvQ2pMIxoAZEx10TmhROli2RDX9k8WDn64IPpvAEFt
        FBB61XP0hDHiESEvD2gAZDnzuMFCISM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Apr 2022 22:05:46 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Takahiro.Kuwano@infineon.com
Subject: Re: [PATCH v4 11/11] mtd: spi-nor: micron-st: Remove status polling
 on volatile registers write
In-Reply-To: <20220420103427.47867-12-tudor.ambarus@microchip.com>
References: <20220420103427.47867-1-tudor.ambarus@microchip.com>
 <20220420103427.47867-12-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f7943a0ef67a5195454448a343f92c79@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-20 12:34, schrieb Tudor Ambarus:
> Writing volatile registers are instant according to Micron and do not
> need any status polling. Remove status polling on volatile registers 
> write.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Michael Walle <michael@walle.cc>
