Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478C1519FA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349695AbiEDMjm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 May 2022 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349818AbiEDMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:38:50 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62AAD326E2;
        Wed,  4 May 2022 05:35:09 -0700 (PDT)
Received: from smtpclient.apple (p5b3d276d.dip0.t-ipconnect.de [91.61.39.109])
        by mail.holtmann.org (Postfix) with ESMTPSA id 83679CED05;
        Wed,  4 May 2022 14:35:08 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH RESEND] Bluetooth: ath3k: Add MODULE_FIRMWARE for patch
 and config files
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220504074606.15505-1-juergh@protonmail.com>
Date:   Wed, 4 May 2022 14:35:07 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6A323366-2AB3-443E-A605-C18EA7A2E161@holtmann.org>
References: <20220504074606.15505-1-juergh@protonmail.com>
To:     Juerg Haefliger <juergh@protonmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juerg,

> The ath3k driver loads patch and configuration files so add MODULE_FIRMWARE
> macros to povide that information via modinfo.
> 
> Signed-off-by: Juerg Haefliger <juergh@protonmail.com>
> ---
> RESEND:
>  Resend from protonmail email account to please the test bot.
> ---
> drivers/bluetooth/ath3k.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 88262d3a9392..56e9a64177ae 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -538,3 +538,5 @@ MODULE_DESCRIPTION("Atheros AR30xx firmware driver");
> MODULE_VERSION(VERSION);
> MODULE_LICENSE("GPL");
> MODULE_FIRMWARE(ATH3K_FIRMWARE);
> +MODULE_FIRMWARE("ar3k/AthrBT_0x*.dfu");
> +MODULE_FIRMWARE("ar3k/ramps_0x*_*.dfu");

I am still not convinced by the glob file matching. How would that actually work?

Regards

Marcel

