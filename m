Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2751E1E0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444978AbiEFXJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444916AbiEFXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:08:58 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5796D391;
        Fri,  6 May 2022 16:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1651878310; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGhwf4sYiYCYD5eWpzxgTupVNYyX9SJesdBqmCbRwqw=;
        b=i90xn6oynU4xRZMiQ4i+NyI2KzJSk8b6ivKryUam3OxPRFhVgYSZmcU3Sj0wS4Egqa3Jnh
        pYsaN+56BjFyNlRrLiNZbq0pQ2SLkI+Jxbc8reqhQ4MLiJXyTJcSAyHR4sP/68JcodSIce
        m5aNY1TwE8cA+gOzJmbyfflMyLjcthI=
Date:   Sat, 07 May 2022 00:05:00 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 0/2] iio: adc: stm32: Fix ADC IRQ handling on STM32F4
To:     Yannick Brosseau <yannick.brosseau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <CGHHBR.49W7GPLHSYOE@crapouillou.net>
In-Reply-To: <20220506225617.1774604-1-yannick.brosseau@gmail.com>
References: <20220506225617.1774604-1-yannick.brosseau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick,

Le ven., mai 6 2022 at 18:56:15 -0400, Yannick Brosseau=20
<yannick.brosseau@gmail.com> a =E9crit :
> Recent changes to the STM32 ADC irq handling broke the STM32F4=20
> platforms
> These two patches bring it back to a working state.

If the STM32 ADC was broken recently, and these two patches fix it,=20
then I'd expect to see a Fixes: tag on both commits and Cc:=20
linux-stable.

Cheers,
-Paul

> Yannick Brosseau (2):
>   iio: adc: stm32: Iterate through all ADCs in irq handler
>   iio: adc: stm32: Fix check for spurious IRQs on STM32F4
>=20
>  drivers/iio/adc/stm32-adc-core.c | 7 ++++++-
>  drivers/iio/adc/stm32-adc.c      | 9 ++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>=20
> --
> 2.36.0
>=20


