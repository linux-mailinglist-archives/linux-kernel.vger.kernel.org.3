Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB3B509F23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382554AbiDUL7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbiDUL7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:59:45 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D490727B3D;
        Thu, 21 Apr 2022 04:56:55 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D9B9B221D4;
        Thu, 21 Apr 2022 13:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650542214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOeQgoECQEhyta1L5h2/I133FzGSSN8MIFX4Atj/rK0=;
        b=OHied78EstkaA4YcA9JI+ooNCI3q92EHUJ00a//CVYwrxG3C4g5BIktr4SSSyLRIjAu9KZ
        wLcKD0OpA856uJHZ/K/ECpGH3pGSTJUi1U3syzpFMQ8ueDs/ZR48axWH2NtYrGWZsXerVa
        PG1+GXrxqomkuqCmweDnniLgdjCKixA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Apr 2022 13:56:53 +0200
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        jerry.huang@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
In-Reply-To: <663d9e81-9036-6986-f52a-3846b4b5c673@linaro.org>
References: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
 <20220421094421.288672-1-michael@walle.cc>
 <663d9e81-9036-6986-f52a-3846b4b5c673@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <20ef94a4ae0928deaadb52eccfd6e882@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-21 13:08, schrieb Krzysztof Kozlowski:
>> But there *could* be a sane default which then could be replaced in
>> an DT overlay. Like "mirkobus-socket" or similar, which might expose
>> spidev. Actually it is more than just SPI, there is GPIO and resets 
>> and
>> I2C. Maybe it should be an MFD? I don't know. But that is something 
>> for
>> the DT maintainers to decide if they'll allow such "generic" devices.
> 
> I think if you have DT overlay, you can add device node and there is no
> need for placeholder, right?

Yes, that is certainly correct. I was thinking of the user
experience. Sometimes you have eval board with that connector
to tinker around with different modules. Therefore I thought it
would be nice to have an userspace spi device by default for
first steps and tinkering.

There is UART which you can use by just opening the tty. There is
I2C which you can use by the i2ctools. There are GPIOs and PWM
which can also be used either by sysfs or the gpio-utils. But there
is no SPI device which can be used by the spi-tools.

But as I said, that is something up to you to decide :)

-michael
