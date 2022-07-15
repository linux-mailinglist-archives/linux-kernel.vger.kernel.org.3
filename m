Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD8D5761BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiGOMdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:33:49 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564B7BE25;
        Fri, 15 Jul 2022 05:33:48 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 25E0322175;
        Fri, 15 Jul 2022 14:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657888426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DtoALRRgxEEDsBQkleXCfpSZd8r6aW6vYyk+CuIr5DA=;
        b=jn11NQbVP6cZ+XfikQ7Y2sGDyR6oPV0diXN4mJDek6Hk2d4YzrpT+TI80qAFaADwv53T0w
        2TuXhslPQ3Iscgh9hPHe5svKCQ0mj5vqk8J9d/tfJPy9O8u4sxySRvZvCAjVq9PS+DHmE9
        Y1Iyq9GikC8gQDrPFauUGM9Ad8ROXf8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Jul 2022 14:33:46 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/2] tty: serial: fsl_lpuart: correct the count of break
 characters
In-Reply-To: <20220715025944.11076-2-sherry.sun@nxp.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
 <20220715025944.11076-2-sherry.sun@nxp.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <71eee711668a0a17a7f5a44096f2c398@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-15 04:59, schrieb Sherry Sun:
> The LPUART can't distinguish between a break signal and a framing 
> error,
> so need to count the break characters if there is a framing error and
> received data is zero instead of the parity error.
> 
> Fixes: 5541a9bacfe5 ("serial: fsl_lpuart: handle break and make sysrq 
> work")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Reviewed-by: Michael Walle <michael@walle.cc>

-michael
