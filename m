Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEFE5431FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiFHNzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbiFHNzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:55:01 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 966E129F5AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 06:54:59 -0700 (PDT)
Received: (qmail 440507 invoked by uid 1000); 8 Jun 2022 09:54:58 -0400
Date:   Wed, 8 Jun 2022 09:54:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] usb: host: ohci-at91: add support to enter suspend
 using SMC
Message-ID: <YqCqMsr7FxT/KtZk@rowland.harvard.edu>
References: <20220607133454.727063-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607133454.727063-1-clement.leger@bootlin.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 03:34:54PM +0200, Clément Léger wrote:
> When Linux is running under OP-TEE, the SFR is set as secured and thus
> the AT91_OHCIICR_USB_SUSPEND register isn't accessible. Add a SMC to
> do the appropriate call to suspend the controller.
> The SMC id is fetched from the device-tree property
> "microchip,suspend-smc-id". if present, then the syscon regmap is not
> used to enter suspend and a SMC is issued.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
> 
> Notes:
>     Changes in V2:
>      - Change check order in ohci_at91_port_suspend()
>      - Renamed smc_id to suspend_smc_id for clarity

Acked-by: Alan Stern <stern@rowland.harvard.edu>
