Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1D5531942
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbiEWRFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbiEWREx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:04:53 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372AA674DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:04:51 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 65E722223A;
        Mon, 23 May 2022 19:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653325485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jb6PERdk6i9UFuOnXNXUP3rrDZ8XeDfZdaGqhadGnCU=;
        b=Ih5AmYm8o1wIkM6kcDHNAbqqH2sSuEv1mYQKGBnAgUS3MHS26G0HujQQ36/S8RVWPFcfSn
        Vq2LBEL+oL6sqFXVRAU8YnD4c0yakjpr3QdQBeJsSswrm4md5PdEEhXdN9QSoBajQDiaDT
        iRdpv9dd8Sv7E5C/cEz5vIjYFlY13jk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 May 2022 19:04:44 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: spi-nor: macronix: Add support for mx66l2g45g
In-Reply-To: <20220523150334.1758649-1-jiaqing.zhao@linux.intel.com>
References: <20220523150334.1758649-1-jiaqing.zhao@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e310ab2100f459346ae6cfa77c9ada19@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-05-23 17:03, schrieb Jiaqing Zhao:
> Macronix mx66l2g45g is a 3V, 2Gbit (256MB) NOR flash that supports
> x1, x2, and x4 operation modes.
> 
> Tested read/write/erase with Aspeed AST2600 BMC SoC operating in x2
> mode at 50MHz, using Aspeed spi-mem driver.
> 
> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>

Reviewed-by: Michael Walle <michael@walle.cc>

# is this picked up by b4? link goes to the sfdp dump
Link: 
https://lore.kernel.org/r/2b859cff-2403-0526-f3ae-749920b3fd8b@linux.intel.com

-michael
