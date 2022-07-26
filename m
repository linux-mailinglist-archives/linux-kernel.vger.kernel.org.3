Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B09581563
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiGZOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiGZOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:35:02 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616552B180;
        Tue, 26 Jul 2022 07:35:01 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 32BA74000A;
        Tue, 26 Jul 2022 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658846099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WupjPW5llhebGVDDR9KKjSngx407hYQmkh53pV6rbko=;
        b=L+OlUX9fehSwmWE2MjLK9g69D0/w6/azgTvVOvXeM9JUzwdOeKs/0deFrHSzgKU0d4rEYR
        punNARej1YSQ5ZmO9zzwyqj8VZ6Odw2xWPhZV7MAopPo1PmzHd3QqvG/+oMDGYSRqqjL+m
        EEzgx4LGcMP6QX0F7U32FA6SwEY/5CasMKeBYw3f2Cp30moVnIAc8BhtOevPGm4+yzXoHB
        5bEtSUFQMlwphianI2+bp1vCOe1M4uXyoh7wxYuDfyFSpJkKkLhIol0IkkuWMVoEAX5iDE
        HxzX1cBjdpDtblem8WOpDB9v8QZCM5M9Ck37MbFPgkAF8VgKvJ+JryTtj5TvVQ==
Date:   Tue, 26 Jul 2022 16:34:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH] rtc: remove VR41XX rtc driver
Message-ID: <165884607752.3158535.11325844040366413431.b4-ty@bootlin.com>
References: <20220715135330.134684-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715135330.134684-1-tsbogend@alpha.franken.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 15:53:30 +0200, Thomas Bogendoerfer wrote:
> Commit d3164e2f3b0a ("MIPS: Remove VR41xx support") removed support
> for MIPS VR41xx platform, so remove exclusive drivers for this
> platform, too.
> 
> 

Applied, thanks!

[1/1] rtc: remove VR41XX rtc driver
      commit: 2a692245b6de1f17baef24db46fed03186ff3cc3

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
