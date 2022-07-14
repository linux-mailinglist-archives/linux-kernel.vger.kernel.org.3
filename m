Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC5575095
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbiGNOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbiGNOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:16:42 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50AE6393A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:16:41 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5A75722238;
        Thu, 14 Jul 2022 16:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657808199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4hkXMmFP+CHQ05L6lGn9y6aeHyZZDWO3dv2qnfJNbI=;
        b=nNAGnq+MNxIYaLLhUxVHcQUBPZA+T0V9Z/XOTnEAh5DWVO8Q/dLrTgswYOd1d5GoQ/PaIE
        sGh1JnJBKdPlXfkYG0abvN/nb3jzF8h/MWvYwtO5Ifoh4IbuTp3Ee0F8nHI5yv8hWlYezg
        htvnggQyWQfOyolVvfUDhr5/ioYuuJw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Jul 2022 16:16:39 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Cc:     clg@kaod.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        quic_ggregory@quicinc.com, quic_jiles@quicinc.com,
        tudor.ambarus@microchip.com
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for W25Q512NW-IQ/IN
In-Reply-To: <63cedfce-34bb-ed63-3871-75a6c3dd5d73@quicinc.com>
References: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
 <20220711095042.2095360-1-michael@walle.cc>
 <a42fbef2-3eff-9e88-233e-a805cfbe2376@quicinc.com>
 <4972a85d04e39ebb7b4a5872f6632c45@walle.cc>
 <2260955b-354d-ceda-cadc-49453bfca3e4@quicinc.com>
 <00f0c9d480ef5a414f1c34492661bd9e@walle.cc>
 <63cedfce-34bb-ed63-3871-75a6c3dd5d73@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6be710bb5c1bf0449e54a54b78f6f7a0@walle.cc>
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

Am 2022-07-14 15:47, schrieb Jae Hyun Yoo:
> On 7/14/2022 12:41 AM, Michael Walle wrote:
>> What does "doesn't boot at all" mean? Are there any kernel startup
>> messages?
> 
> I'm sharing the error messages below.

Thanks.

> [    0.748594] spi-nor spi0.0: w25q512nwq (65536 Kbytes)
> [    0.865216] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 
> [0x406c0741]
> [    0.872833] ------------[ cut here ]------------
> [    0.877984] WARNING: CPU: 1 PID: 1 at drivers/mtd/mtdcore.c:583
> add_mtd_device+0x28c/0x53c
> [    0.887237] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> 5.15.43-AUTOINC-dirty-23801a6 #1

Could you please try it on the latest (vanilla) linux-next?

-michael
