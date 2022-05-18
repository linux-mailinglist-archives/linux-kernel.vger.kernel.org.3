Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58C52BF68
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiERPab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiERPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:30:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91ED1A29D3;
        Wed, 18 May 2022 08:30:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i19so4498274eja.11;
        Wed, 18 May 2022 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eIwb4I0AwekwEpYMZmVGy6yg88acm8K/xMMngQQs0ts=;
        b=BDVWzBwgW8nUV9ufnXuwBYEi7IYd+UCbdLMt8V1mSIrGR1YwWGZGmM8dmCh90ssZrU
         tLT6BPrKtp/nRHm7BSf7zDX5nTwZIuPTT26KXiL/oo6RklIpiCNyVVDxaWeOMGCguOGk
         X5w/Z+eQdJAG4n9rHESqnQjY2a2i7U5omRmm6qIsVOeggtTLKmFaDRWqrdGhfr/rZPUW
         7Z4HjRXH+9tly+0Rk3je8nAuG62qp0OBZTWoTJFJFEuG97Y0ibV5nL/Oh0K41ppWXFZn
         OpwOc96AX3ec2v1+f0lhbrB3jJltt9oEyf3VGgEn7Kn8u4mM+0ATVk1VVBe16AYBqTlN
         9zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eIwb4I0AwekwEpYMZmVGy6yg88acm8K/xMMngQQs0ts=;
        b=e8OeS4G+tvrtFkftWGPblqohecrOcQjxax+Oy34K7LBrhZKqYm+G/YzcaRBLrnAclN
         8SNDRoCwEtvaz7QdzFyoJc7b/uW9Ic9DGWAOdhuajtJzAgW4/bMtJH6523fKFOoTooNj
         4puUurqqiBoUwR88YjT6BXImv16Hp/chdrOpoi0oDGYkduMyFjHUdmpgEhbZHuklS6cU
         lsKsD6SPdvoAZpwXgtEif3yZqy/2oO7baPyw+q3TBS5zuf1fPYNZxrdJawD6hcvUt+uA
         t2hU66OXmL4J4CaosRl4m0gtALsWcM0WOW9I4EtyOQzA/TIrf0EDy176nI6XcjEgT52n
         3hyQ==
X-Gm-Message-State: AOAM532a0TXzlAJ5/pVIfBH8TqyacNfvkTYybspniKPJTVaaHs68oYQe
        7ZV9pveMiaUti0k5Erw5wKJ3wdy5Hr1vqLQU5IX7G0PZB5o7VQ==
X-Google-Smtp-Source: ABdhPJxsi9nMEKiVYaazPPhTBmzUAFFAp90WptYrLpDKLLw0lqq05xSIfgvppNf/eoYKuFksNbhOl9iOjrJAexnpfNc=
X-Received: by 2002:a17:906:a219:b0:6e4:86a3:44ea with SMTP id
 r25-20020a170906a21900b006e486a344eamr120040ejy.385.1652887826262; Wed, 18
 May 2022 08:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220518024347.213402-1-lizhengyu3@huawei.com>
In-Reply-To: <20220518024347.213402-1-lizhengyu3@huawei.com>
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
Date:   Wed, 18 May 2022 18:30:15 +0300
Message-ID: <CALT56yO_ek55BGX4cKuTim2gWwQp7EXUFyh332MPYHPdi7xEWw@mail.gmail.com>
Subject: Re: [PATCH -next] usb: host: ohci-tmio: Remove redundant if statement
To:     Li Zhengyu <lizhengyu3@huawei.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 18 =D0=BC=D0=B0=D1=8F 2022 =D0=B3. =D0=B2 05:45, Li Zhengyu <=
lizhengyu3@huawei.com>:
>
> (ret =3D=3D 0) is true when (ret) is false, so remove it.
> Also remove unreachable code.
>
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
> ---
>  drivers/usb/host/ohci-tmio.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
> index 49539b9f0e94..6bcb0cb53f7c 100644
> --- a/drivers/usb/host/ohci-tmio.c
> +++ b/drivers/usb/host/ohci-tmio.c
> @@ -243,12 +243,8 @@ static int ohci_hcd_tmio_drv_probe(struct platform_d=
evice *dev)
>         ret =3D usb_add_hcd(hcd, irq, 0);
>         if (ret)
>                 goto err_add_hcd;
> -
>         device_wakeup_enable(hcd->self.controller);

I think the proper patch would be to check the return value of
device_wakeup_enable(), so NAK.

> -       if (ret =3D=3D 0)
> -               return ret;
> -
> -       usb_remove_hcd(hcd);
> +       return ret;
>
>  err_add_hcd:
>         tmio_stop_hc(dev);
> --
> 2.17.1
>


--=20
With best wishes
Dmitry
