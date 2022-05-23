Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC10530A44
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiEWHyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiEWHye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:54:34 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144182124C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:54:31 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 00DC52223E;
        Mon, 23 May 2022 09:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653292469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nQd9mRIHd5HSKD0thiQmrkrrJ499m3Sgzr8RpImTClw=;
        b=uexTZvcTXG1n68dSnxbq7ygIbq0oAIhBbYviFY52m8xr/0EBvdPUB/S0U5K9EvXeEDKErD
        RHFHq7f/1Ike13lwAzuc6I27hJSaQN/IG12Sbtp+zusbKuj8xfub5iJloNmhkL/aX0rM62
        rlXAgEPVPQijHnlA+Y5MiSfhQ5MDOiE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 May 2022 09:54:27 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: macronix: Add support for mx66l2g45g
In-Reply-To: <20220522054802.1719443-1-jiaqing.zhao@linux.intel.com>
References: <20220522054802.1719443-1-jiaqing.zhao@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <04c432289041752d113c15245361ade8@walle.cc>
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

Hi,

Am 2022-05-22 07:48, schrieb Jiaqing Zhao:
> Macronix mx66l2g45g is a 3V, 2Gbit (256MB) NOR flash that supports
> x1, x2, and x4 operation modes.

I presume this one supports SFDP? Please provide an SFDP dump, see [1].
If it supports SFDP please try to use the SNOR_ID3() macro [2].

Also please add what was tested in your commit message.

Same goes for your patch 2/2.

-michael

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
[2] 
https://lore.kernel.org/linux-mtd/20220510140232.3519184-1-michael@walle.cc/
