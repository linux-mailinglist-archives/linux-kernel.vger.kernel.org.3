Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE37570008
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiGKLSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiGKLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:18:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA04A190;
        Mon, 11 Jul 2022 03:41:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LhL5T4Hkrz4xD9;
        Mon, 11 Jul 2022 20:41:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1657536062;
        bh=WkUBTudz6dG+TVvLeDvu9O1AhkbCdb5uNCCAictTr2g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=w0cOffT/9tTiRHg2BhqZIQK+XKZC7zeFHiPlYdJZqgVyy7K78aV7UI7HRpX++qhYD
         QCUmrsSj+cT54B0rgOiDWhQpwVOazT00+CiEao10e/LWnLcBq4sWfvKSHfP1BNK8iA
         oP1QL8jt9Kd+j9O1KPOxbUH853N/SSKATmj/dvecsxmnV8NiaRFBWjWSOE2KItF6SK
         Er3xAimALb3TlI/Om51KOhk5c+fYLvDgs73m87RbtF+OxpT+BNmAr7WXV7mAAmYPmx
         6KagakpccinWRER1Zl4ce/KscfrLXugFFwKrgN0ZwzzNjp+ks2eApMeM0I4wKTBEfY
         n+5T8EocAu9Wg==
Message-ID: <74b98265ff9638ad7a06a58ef0dea1758396744f.camel@ozlabs.org>
Subject: Re: [PATCH] serial: 8250: SERIAL_8250_ASPEED_VUART should depend on
 ARCH_ASPEED
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Jul 2022 18:40:38 +0800
In-Reply-To: <259138c372d433005b4871789ef9ee8d15320307.1657528861.git.geert+renesas@glider.be>
References: <259138c372d433005b4871789ef9ee8d15320307.1657528861.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

> The Aspeed Virtual UART is only present on Aspeed BMC platforms.=C2=A0
> Hence add a dependency on ARCH_ASPEED, to prevent asking the user
> about this driver when configuring a kernel without Aspeed BMC
> support.

All fine by me. It'd be super weird if this hardware appeared on a
non-ASPEED platform.

Reviewed-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
