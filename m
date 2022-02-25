Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85314C4939
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbiBYPgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiBYPgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:36:53 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE54B21CD34
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:36:20 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1ED062222E;
        Fri, 25 Feb 2022 16:36:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645803379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0Um098r4StpC9E3GpfYoclk0Kr7F8+yFe60ER/u4MU=;
        b=kZjKi9Ss5c0QGn8M4BR52N3J5Ggy/qT7ZsDuoYegIYjnjR2xf1eb547EslZm70hfhXjZmp
        7LIpkB3/bkS6Q0yfyfUUd6u6TTSWF0BacizP9fvTpHrelXdOwZvSvOdclIKseun8BFyQSI
        W2ndR0Cp3HuFeCnHKt8dLeuuxg/PR3c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Feb 2022 16:36:16 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, yaliang.wang@windriver.com
Subject: Re: [PATCH v5 26/32] mtd: spi-nor: micron-st: rename vendor specific
 functions and defines
In-Reply-To: <3bd0bfad-7f04-a972-0f65-21dea2173dd7@microchip.com>
References: <20220223134358.1914798-1-michael@walle.cc>
 <20220223134358.1914798-27-michael@walle.cc>
 <3bd0bfad-7f04-a972-0f65-21dea2173dd7@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <7f3ab0cc9115f15f1cfa85e7da13d56d@walle.cc>
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

Am 2022-02-25 15:03, schrieb Tudor.Ambarus@microchip.com:
> On 2/23/22 15:43, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Drop the generic spi_nor prefix for all the micron-st functions.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> Tested-by: Pratyush Yadav <p.yadav@ti.com> # on mt35xu512aba, 
>> s28hs512t
>> ---
>>  drivers/mtd/spi-nor/micron-st.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/micron-st.c 
>> b/drivers/mtd/spi-nor/micron-st.c
>> index 1a7227594bf0..8a20475ce77a 100644
>> --- a/drivers/mtd/spi-nor/micron-st.c
>> +++ b/drivers/mtd/spi-nor/micron-st.c
> 
> you forgot to rename the macros, as you did for xilinx.

Sigh. Actually, I didn't rename the macros at all (except for xilinx,
but that was already way before the naming discussion). I couldn't
come up with a good name, so I just left it as they were.

TBH, what was just a clean-up for the ready function turned
into a gigantic patch series and it is very time consuming
(and frustrating) to respin it just for renaming. We shouldn't
aim at perfection for patches. Minor details can always be
fixed later.

-michael
