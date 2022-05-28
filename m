Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97F536B63
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiE1HgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiE1HgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:36:03 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6514F286FD
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:36:02 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 1E36C20000E;
        Sat, 28 May 2022 07:36:00 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 9A242807BE; Sat, 28 May 2022 09:26:19 +0200 (CEST)
Date:   Sat, 28 May 2022 09:26:19 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     cgel.zte@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] pcmcia: Use platform_get_irq() to get the interrupt
Message-ID: <YpHOm784dpzeVoBr@owl.dominikbrodowski.net>
References: <20220309053732.2081252-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309053732.2081252-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Mar 09, 2022 at 05:37:32AM +0000 schrieb cgel.zte@gmail.com:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
> for requesting IRQ's resources any more, as they can be not ready yet in
> case of DT-booting.
> 
> platform_get_irq() instead is a recommended way for getting IRQ even if
> it was not retrieved earlier.
> 
> It also makes code simpler because we're getting "int" value right away
> and no conversion from resource to int is required.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Applied to the pcmcia tree.

Thanks,
	Dominik
