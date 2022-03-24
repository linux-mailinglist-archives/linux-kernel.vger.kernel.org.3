Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414D04E5ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbiCXGj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348222AbiCXGjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:39:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D0E0F2;
        Wed, 23 Mar 2022 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648103892;
        bh=eSQq/XcXAU2lYmD2WDC139IVXbDfpofvYA+9iId4Q5I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XyvlhDz5hIo6BOU0qJ/Vs0MX5Uv1gue06676C6xOtggsFAxOHDpH72iDXTlkdZnrS
         2WZXl5whAUh5D7uUIWRJdOtnD+nd34RS4FayNy7uqfSlEvWUrayXZtAy3JkA3rU9/l
         uaK6ZrZMSjPOJgJtJ8cPkpiPa2o2U5ger6j457W4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.161.116]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1nnIrO1VSE-00KT0S; Thu, 24
 Mar 2022 07:38:12 +0100
Message-ID: <4115b2c5-7f7f-2ef3-e368-b21766774b5c@gmx.de>
Date:   Thu, 24 Mar 2022 07:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] video: of: display_timing: Remove a redundant zeroing of
 memory
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <99f22ad1068fbbbc95acea59871cd408cde2623d.1647981212.git.christophe.jaillet@wanadoo.fr>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <99f22ad1068fbbbc95acea59871cd408cde2623d.1647981212.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CDiv9WbLv+NmReFdAyGNEBUXfh08WS4B6T6bgkSs+Df40MoBKCt
 Uad2SOYmSFYzTh5TyaEI6SHLEN42QkGaLXHXbWFH2ev/HpAQW2PYdcDWK5CjioKp5eKg2Lw
 C1KfZBYwGV5w/nzFHG7DbEQVSiYGhEkDYxcBG5T0h4VVATOWNLW8uTWqrQkeRG61vEibYmo
 QUxCnelQpkjykACYJDhCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ReJHmqSzpso=:cbmuW9uJdhzyf2ri8d8jsy
 GEswZP+eO0EMizGOirmsSqMkCq41SexPFM10EpFt755q+S7W4gMBnkUefZVXobwBT6zE/hIks
 KPxWKftCmlOafw96s2ukQ1STUldb2aRjdVAMrefInWqUwUmYMCb04yoZRou7mSPrdhq5K33/p
 /GtS2tbtxGpXz29t2kLwIkByTjE+4INgoY6nOAhwTLL1y9lJF33GCZbECl5JCmpBnzr+JMbaX
 EE3hMRD0VNIYRJNe43bbavOVRz893GOUcN6EWIv56AID9ggfSQ1Gv4irk3bsf/tm67zYLAEu2
 sivQ5sjU4yUEP7LlMLOxhVDQVQia4DnW2JXEBtd7xUY/dGRJ6aW365vxbDRrP7LI5yCP5CKxI
 InSMy9gu5Eng7jVaDhzuPMmm7c+WKp0/KxDvj3fiVYdtPPs3zmGE0vFQvXlQEVh6fUjXndcCb
 b7ijcmHdG4H4VydgRH04met58N02f9De+lZW8n+XjDOPiBNvLGbpe1NhfvP+7kzenxK3Yo++y
 eGEKqZdylLopdAAhaXOCSd9f1oqKPeSUzdaZ+nMSwznMsOyCHlHX6aNe28KT18h1yMQYyASUi
 0fQJLMulge1v5hfO95puNvnoruqDPilxHWv7QgktacgA8GDQMHhwwWGnzIikVGTjq3e0zJC2c
 eTDF08Yh17bSPHbCW+82BjzaZkMRMmMeM/MkljjPi7UyABLNqJSBlitO6KeDiew0EXyJyyskJ
 QzBFAqFmzU1IkpbGNRt49Wt1lO24840U0RY23f5Pn81oHEIrmI+XnyZyO8yL+UP2DQze4jLxh
 QjwW8nIFv9fmeNxV3WGfNrEUhp0dmf92YRowm9q/n4DjkykDaFoKEhlZ8aeRy4NNwk9T/mO2m
 PQlnU7QSQCZyK7/7Oiv5sEchaKZUz7BhdcrkgQA1TBoux7eL1XePIxVGrs58FrO2nffIiSrRJ
 o2WwHXJyuk9mSYHKRncj43lWWWyV9mP8jv+50509Np7ai7djeMg0JFiYPLLNKrCJfXjZEJM4L
 //3tgS0n5ziEGSOesSnLOp5ILeH0KYeO/38DxC2yl/TB4JsxJ0rbidlu4QdRSCq8CNRkC9cpf
 nLPzmP1TTKBXjs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 21:33, Christophe JAILLET wrote:
> of_parse_display_timing() already call memset(0) on its 2nd argument, so
> there is no need to clear it explicitly before calling this function.
>
> Use kmalloc() instead of kzalloc() to save a few cycles.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

applied.

Thanks!
Helge

> ---
>  drivers/video/of_display_timing.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_displa=
y_timing.c
> index f93b6abbe258..bebd371c6b93 100644
> --- a/drivers/video/of_display_timing.c
> +++ b/drivers/video/of_display_timing.c
> @@ -199,7 +199,7 @@ struct display_timings *of_get_display_timings(const=
 struct device_node *np)
>  		struct display_timing *dt;
>  		int r;
>
> -		dt =3D kzalloc(sizeof(*dt), GFP_KERNEL);
> +		dt =3D kmalloc(sizeof(*dt), GFP_KERNEL);
>  		if (!dt) {
>  			pr_err("%pOF: could not allocate display_timing struct\n",
>  				np);

