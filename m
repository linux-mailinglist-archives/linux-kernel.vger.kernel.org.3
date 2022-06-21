Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2659C553810
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352681AbiFUQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352267AbiFUQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:39:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F02AE33;
        Tue, 21 Jun 2022 09:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25849CE1717;
        Tue, 21 Jun 2022 16:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598C3C341CB;
        Tue, 21 Jun 2022 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655829546;
        bh=VCez7PoXmCq8OMYH5lrZaxn9tW18j0vO8IsYehW8qjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cqDERhBlOPWY9Uixv94FxXcDJO1cNoL77AaV3Nf4hqRaRHaymiHwNgFz6e0nCiAzW
         KypAvopdtIM0Nr9R/cgYG3yJdn6kLp73lKhwmpwXRC/59LFjlaqtaFrt0yY3qisKGS
         uC6CNf31ufJwcOvL3eniLgGO7LvSF/YpJ4JiaYO8LKWWspf1io19+0ziIeMaBDz09E
         91oNEoWqOkbQMFMiJ/lBD4xbXx1wPSHqLT26pBxmNHeUyN6Mn3OkpZf3qqmiQM+4da
         m2a02bFNUuoj3pyfNmHKW1nvglyZwpR3RvnQcZ07+iqlFwm/v3onxVtup/rbAnUiCm
         74P8Wz/qDFZuw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o3gu6-0026pW-QV;
        Tue, 21 Jun 2022 17:39:02 +0100
MIME-Version: 1.0
Date:   Tue, 21 Jun 2022 17:39:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: mxs_lradc_ts: Warning due to "0 is an invalid IRQ number"
In-Reply-To: <CAOMZO5B6606rwWoG-ydEz2UQpnj9QhUK2b5dCHRtp9u=Pe4new@mail.gmail.com>
References: <CAOMZO5D7z=Eg=WYgzrpqn9VoU8HxMeBbEZiv9KLjMVD1_kRo+w@mail.gmail.com>
 <20200701224145.GA3616172@bjorn-Precision-5520>
 <YrHPA+TBKZU/RuSz@smile.fi.intel.com> <87o7ym2fcv.wl-maz@kernel.org>
 <CAOMZO5B6606rwWoG-ydEz2UQpnj9QhUK2b5dCHRtp9u=Pe4new@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <128b8f7dffe45dc241ad571e8a273a2e@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: festevam@gmail.com, andriy.shevchenko@intel.com, helgaas@kernel.org, marex@denx.de, ksenija.stanojevic@gmail.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 2022-06-21 17:23, Fabio Estevam wrote:
> Hi Marc,
> 
> On Tue, Jun 21, 2022 at 12:41 PM Marc Zyngier <maz@kernel.org> wrote:
> 
>> Something like the hack below could potentially make things less
>> broken, but I'm not holding my breath. If nobody cares, let's remove
>> the code altogether.
> 
> With your patch applied, the warning is gone, thanks.
> 
> The touchscreen is registered:
> 
> [    8.207461] input: mxs-lradc-ts as
> /devices/soc0/80000000.apb/80040000.apbx/80050000.lradc/mxs-lradc-ts/input/input0
> 
> but when I run  "cat /dev/input/event0" and touch the screen, no irq
> event is generated.
> 
> Looking at cat /proc/interrupts shows that no mxs-lradc-touchscreen
> irq happened:
> 
> 216:          0         -  10 Edge      mxs-lradc-touchscreen

I'm not sure I can help you further on that. '10' seems to be
the correct interrupt for the interrupt number (irq index 0 in
the lradc device).

You'll have to debug it further, I'm afraid.

         M.
-- 
Jazz is not dead. It just smells funny...
