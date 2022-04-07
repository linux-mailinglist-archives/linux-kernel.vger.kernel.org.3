Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039EB4F7E30
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbiDGLn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiDGLnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:43:21 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB526DA6F9;
        Thu,  7 Apr 2022 04:41:21 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4D00122175;
        Thu,  7 Apr 2022 13:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649331680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anZIlz+C7nCyO9qv7nTAB94XjsPcbeyf8vLkyCHxpOY=;
        b=FzQxRClq9Dt7zR4qrq5+7nAYwxA8epciMbhR6QgAhAdcsB9VSFnDpXL0e/m2n72UKgQEXa
        G9f58KhmGMSjHPs1PhKiaYTQeK47TBV3TWKbYtCaSDjp0MUKZFHKuKVZKF986gCWJWycta
        UUYQeIoTzSwVSja4hsS1NTI4P4EqLCg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Apr 2022 13:41:20 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Manohar.Puri@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, kavyasree.kotagiri@microchip.com,
        krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        tudor.ambarus@microchip.com
Subject: Re: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
In-Reply-To: <Yk7LjrvqSLbzPYkw@sirena.org.uk>
References: <Yk7Ex5ltaxC7Z+N6@sirena.org.uk>
 <20220407112345.148316-1-michael@walle.cc> <Yk7LjrvqSLbzPYkw@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <561bbc1cf43c3795eee67e10537ba365@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-07 13:31, schrieb Mark Brown:
> On Thu, Apr 07, 2022 at 01:23:45PM +0200, Michael Walle wrote:
>> The subject should also be prefixed with "dt-bindings: ".
> 
> I tend to complain about people doing that.

After all it is mentioned to use that prefix in
Documentation/devicetree/bindings/submitting-patches.rst. I try to
remember when submitting SPI related bindings.

-michael
