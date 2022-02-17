Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7794B9C64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiBQJsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:48:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiBQJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:48:09 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2891705F;
        Thu, 17 Feb 2022 01:47:56 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5C32A22205;
        Thu, 17 Feb 2022 10:47:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645091273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/SeRqbApzV4y62bCi+32CxUX+3k7cvnup6tnvoYbOQ=;
        b=pr0QPKH09MsrAjht5TSyVQG9NHU7g4h/7Fa2Jc284nKVCrC/IPZxbAg+qH481LdWy/1AsL
        KYcbV6tYY4qHcgf6roT7pwdolyQtWahdHDqGXJIPwT22kx/+j5CAHant7RB+n6HDSOf7qc
        wqMQJVv+Br8JTpBt+PszumWbpdV4mpM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Feb 2022 10:47:47 +0100
From:   Michael Walle <michael@walle.cc>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: atmel: add earlycon support
In-Reply-To: <20220217094620.1148571-1-michael@walle.cc>
References: <20220217094620.1148571-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <80af0c12cf04e01e50c71daacd38f89c@walle.cc>
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

Am 2022-02-17 10:46, schrieb Michael Walle:
> Add early console support which relies on the bootloader for the
> initialization of the UART.
> Please note, that the compatibles are taken from at91-usart MFD
> driver.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Sorry forgot the changelog:

changes since v1:
  - add "select SERIAL_EARLYCON"
  - rename atmelserial to atmel_serial

-michael
