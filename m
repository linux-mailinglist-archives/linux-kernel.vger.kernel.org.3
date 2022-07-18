Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A976C577C64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiGRHWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiGRHV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:21:59 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F5639C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:21:56 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3C8A72222E;
        Mon, 18 Jul 2022 09:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1658128912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NASt9wxN6DuJH9tMOB2+yU3AYq+oeIqH6OCgUY+ZBlc=;
        b=Vl4yPRBiYvVL/zTJ8WRUdsBu8wqWtEb7m4tYyUpayM9E3juj1eTAzFqPg68qMBLZP+lzQQ
        Tzgand/7yPejFYX83bZg4Pyv1ARJXXU/RkJF0OulOFv3MSnpHTDSQvGR1o1d20gr2Oxeyq
        Cd6PtbcqKTLPUneA5bC67ex9QtbkGxc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Jul 2022 09:21:50 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, quic_c_sbhanu@quicinc.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: spi-nor: winbond: use SNOR_ID3() for w25q512nwm
In-Reply-To: <735a88af-c4f1-a6b3-3f85-ea532b3f39c7@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-3-michael@walle.cc>
 <735a88af-c4f1-a6b3-3f85-ea532b3f39c7@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5d3af3ad552a00913ba1bc50707e257d@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-12 10:40, schrieb Tudor.Ambarus@microchip.com:
> Shaik, can we have your Tested-by tag on this?

This will need the following patch to work correctly:
https://lore.kernel.org/linux-mtd/20220716000643.3541839-1-quic_jaehyoo@quicinc.com/

But other that that, the SFDP data is exactly the same
as in the w25q512nwq, except for the "hello world" string.
But that string is between the header and the tables in
an unused area and I suspect it was accidentally written
during OTP testing as it happend with the w25q512nwq, too.

So this should be good to go once the w25q512nwq is merged.

-michael
