Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5572545F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347812AbiFJIeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347950AbiFJIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:33:25 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D68A93FBE9;
        Fri, 10 Jun 2022 01:31:03 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nza2n-0001hj-00; Fri, 10 Jun 2022 10:31:01 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 61DD3C0331; Fri, 10 Jun 2022 10:30:44 +0200 (CEST)
Date:   Fri, 10 Jun 2022 10:30:44 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Genjian Zhang <zhanggenjian123@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, f.fainelli@gmail.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, huhai@kylinos.cn,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH v3] MIPS: Remove repetitive increase irq_err_count
Message-ID: <20220610083044.GA7565@alpha.franken.de>
References: <20220525043916.584850-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525043916.584850-1-zhanggenjian@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 12:39:16PM +0800, Genjian Zhang wrote:
> From: huhai <huhai@kylinos.cn>
> 
> commit 979934da9e7a ("[PATCH] mips: update IRQ handling for vr41xx") added
> a function irq_dispatch, and it'll increase irq_err_count when the get_irq
> callback returns a negative value, but increase irq_err_count in get_irq
> was not removed.
> 
> And also, modpost complains once gpio-vr41xx drivers become modules.
>   ERROR: modpost: "irq_err_count" [drivers/gpio/gpio-vr41xx.ko] undefined!
> 
> So it would be a good idea to remove repetitive increase irq_err_count in
> get_irq callback.
> 
> Fixes: 27fdd325dace ("MIPS: Update VR41xx GPIO driver to use gpiolib")
> Fixes: 979934da9e7a ("[PATCH] mips: update IRQ handling for vr41xx")
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: huhai <huhai@kylinos.cn>

This is missing your the Signed-off-by as submitter of the patch.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
