Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9135323F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiEXHTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiEXHTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:19:48 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78D6941AE
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:19:47 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 865732222E;
        Tue, 24 May 2022 09:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653376781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/htG7OyW5YqCjznA1oXKYQhkz8pG2pTnLrCkASZVoo=;
        b=ksnNzOVQTrqvIX7KFcA/r0rYwmv2R4E/MZsYZwjPUJvVCkviboit4z2Ko7iAOwlVW2sLAa
        JGfP6tS8OCbVwPUrITcOOl8nSgeZ0dzFRc2ihvxi2vkyrxhe1NnxY9I0tGeEbgwPItk3No
        RZ4rDiVGCjoAVYoZvbTDOTixXV2Of3I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 May 2022 09:19:38 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: spi-nor: macronix: Add support for mx66l2g45g
In-Reply-To: <91183d9f-a4a2-b237-b097-2ba546f9308c@linux.intel.com>
References: <20220523150334.1758649-1-jiaqing.zhao@linux.intel.com>
 <e310ab2100f459346ae6cfa77c9ada19@walle.cc>
 <91183d9f-a4a2-b237-b097-2ba546f9308c@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <02b3a83b5fafa7099d79fac7ca9250f2@walle.cc>
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

Am 2022-05-24 05:35, schrieb Jiaqing Zhao:
> On 2022-05-24 01:04, Michael Walle wrote:
>> Am 2022-05-23 17:03, schrieb Jiaqing Zhao:
>>> Macronix mx66l2g45g is a 3V, 2Gbit (256MB) NOR flash that supports
>>> x1, x2, and x4 operation modes.
>>> 
>>> Tested read/write/erase with Aspeed AST2600 BMC SoC operating in x2
>>> mode at 50MHz, using Aspeed spi-mem driver.
>>> 
>>> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
>> 
>> Reviewed-by: Michael Walle <michael@walle.cc>
>> 
>> # is this picked up by b4? link goes to the sfdp dump
> 
> May I ask what do you mean by "is this picked up by b4?"

It was question to the maintainers (or myself). b4 the tool
the spi-nor maintainers [1] use to pick up the patches. And,
no it is not picked up automatically.

-michael

[1] 
https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation

>> Link: 
>> https://lore.kernel.org/r/2b859cff-2403-0526-f3ae-749920b3fd8b@linux.intel.com
