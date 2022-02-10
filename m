Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC14B07B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiBJIEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:04:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiBJIE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:04:28 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11991088
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:04:28 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A53D42223A;
        Thu, 10 Feb 2022 09:04:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644480266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCRjulaua8nbar2xx5MsVkSgjkg/+PvqvIadAhk7kp0=;
        b=pypwTD4zSgrT/56iiczgSgNcWigGU0stm268lPi1hbcoaYT0nyWhFwNqv3HQlgcWxSHRFL
        8yT1XWrnGXLEjcBzZac7XhwuKespg+iI4znKJOFoi3V4SRodv3OZMyVKmQ20CsOynneoLW
        +vj23a2IUqTDmbKdhTsUunQvHmVWTf8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Feb 2022 09:04:26 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
In-Reply-To: <68aa414b-7a9d-1330-531c-37b2db2ab09d@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-6-michael@walle.cc>
 <68aa414b-7a9d-1330-531c-37b2db2ab09d@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <73d3d8ed2cb4ca1b06902b767fe529c3@walle.cc>
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

Am 2022-02-10 04:08, schrieb Tudor.Ambarus@microchip.com:
> On 2/2/22 16:58, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Drop the generic spi_nor prefix for all the xilinx functions.
> 
> mm, no, I would keep the spi_nor prefix because xilinx_sr_ready is too
> generic and can conflict with methods from other subsystems.

But all the other functions in this file start with xilinx_ ;)

I don't have a strong opinion here, other than it shouldn't
be called spi_nor_read_blaba() because that looks like a
standard spi nor function belonging in core.c

-michael
