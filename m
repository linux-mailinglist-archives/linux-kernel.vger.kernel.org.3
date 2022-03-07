Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CEA4CFBC0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbiCGKrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241066AbiCGKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:47:03 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2822C7EB3F;
        Mon,  7 Mar 2022 02:07:20 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4BA82100014;
        Mon,  7 Mar 2022 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646647558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQQlMA2nuLJLAo0+B3NtqW+DcgylzMgC76dvoXeTZRA=;
        b=knu6CeM3PC7ksEhlVQu73z7qVuqYJykFGSYiszYLV6B3chz1mpF4biC7xv2M7daFHKM6fk
        Bp5koFCVR7C5sELfiZyJkW4QWrq9/JJHwSz4ETNuM1GTrBfYMj/f2ios5fNy0SEdCV5Rig
        iJjsUv35U3HYxS1v8pMVUN+vjjI7B3zbSkABdvbD7+W3OF7SyseDQesjrPUZzak0DtNPBz
        /BSZjEbi3+sroEx7UXzYpqmL10GAvFIC5qCoOz1Fx6l/uChSSIxivwxQwRmMKBc2DWsF6N
        LZE9TMjujZy3BMB6Vb/0MCK/a8J1q+oKZfDsv/qGE2mxeir72sxL4NNv6bJkGg==
Date:   Mon, 7 Mar 2022 11:04:34 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] rtc: optee: add RTC driver for OP-TEE RTC PTA
Message-ID: <20220307110434.33fd2f87@fixe.home>
In-Reply-To: <CAN5uoS9J7P-74Zi-AuiXfTMesFOPEmFSmT2GcO8QmR6ebCXGAw@mail.gmail.com>
References: <20220302150717.11193-1-clement.leger@bootlin.com>
        <CAN5uoS9J7P-74Zi-AuiXfTMesFOPEmFSmT2GcO8QmR6ebCXGAw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, 6 Mar 2022 22:08:48 +0100,
Etienne Carriere <etienne.carriere@linaro.org> a =C3=A9crit :

> Hello Clement,
>=20
> In the code, rtc-optee driver opens a session with optee and allocates
> shared memory from probe to remove time.
> This uses resources in the TEE but RTC is not accessed often by Linux I g=
uess.
> Would it be interesting if a session is opened and shared memory
> allocated only when a RPC command is to be invoked?

Hi Etienne, that is an idea that could be added later I guess ?

>=20
> Minor comments below.

Thanks for the review.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
