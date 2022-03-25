Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2915A4E6F35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbiCYIA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiCYIAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:00:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED48403F5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:58:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id pv16so13813528ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=YNqe6IKQwYU1SXQAtrDZx7Ab2V139yZrlAAi/SFO/aQ=;
        b=uONsPRuQB+JMPTjrrZXDNX9+tYvAwUVXzuxU7B7b6xzGdgQffKhED+1WkANhvZu/3R
         ECVyrCWklcku038ZFfN2E+UYkMZP1NfzPToi/rt4EvREaeMbJlG3OLfQ0ee45eySZLVM
         teGum288u8sFE7jVV1rZP1qZvahMEitALpxe6ZVr5018nLhCEHWYAoUqyD29FZSc3z+U
         ssUC53eeGpYye/VY3P90BZoBjajHxl6jDRjF1FCC0r3J26XJL7oxiiro4JB31TRfPdh+
         J9+w8S922rIcyzuR2lfBSIJVc6FTp0P+Buet5AZWt9j+5t8nRh7STWRNpYSgmbXUD0gP
         lZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=YNqe6IKQwYU1SXQAtrDZx7Ab2V139yZrlAAi/SFO/aQ=;
        b=EOmm8HCPRQk8zKgPhG2LdU3b8SAFDjmh0yJ5ScZ0HFFua9w0XjspodvcdHORtaZcd3
         8N/tUAIpkHR7MaqUwnRnch5EKHdXUvUQzUS7Cv2nWU1ORPNbEfky1lLiDIs3zih0/ceu
         xYp9Mu85IyTzL6WuvXkspgG3WowoyUgKxMEIv5MryrLRH4u23FLyjee1draNBQXG8Shl
         KR/3Mz0Rgz6m4fuZmzb19aFfCN7GRaqQOic5ZRNBt12mhlSG6YBB90NY8wpTixNCtv/x
         Yt6XgMJZafSDT1dNpqXJtU+4r4xDXdFVUZMWtcpVdIIdIC5Tbk1tYIR+EO8LFtT5Kuy2
         oqyA==
X-Gm-Message-State: AOAM5310r4irlPhyXbeJGYUhYn75wmEOJSlHnpR64UluMAqBY3ilmNuP
        lPdlJIutjdo7/DarFZaDU0z85/8JAFFI5w==
X-Google-Smtp-Source: ABdhPJyGmgoyqTfWdSJLcXAdfk5XkWpJmQ/J5c9pZ+zK1/fBk0F9kLpL3O6/Xqrkn+9QLuwVPVL5IA==
X-Received: by 2002:a17:906:3ec9:b0:6bb:2eb9:84f with SMTP id d9-20020a1709063ec900b006bb2eb9084fmr9968528ejj.86.1648195128732;
        Fri, 25 Mar 2022 00:58:48 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906275500b006d10c07fabesm2007178ejd.201.2022.03.25.00.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 00:58:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Mar 2022 08:58:47 +0100
Message-Id: <CISSESOMBR2Y.2L4TX1ZPPPIT8@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        "Stanimir Varbanov" <stanimir.varbanov@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] media: venus: hfi: Add error message for timeout
 error
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Luca Weiss" <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20220114110226.130380-1-luca.weiss@fairphone.com>
In-Reply-To: <20220114110226.130380-1-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

any feedback on this patch and the following one?

Regards
Luca

On Fri Jan 14, 2022 at 12:02 PM CET, Luca Weiss wrote:
> This error can appear with wrong configuration and is difficult to find
> as it just returns -ETIMEDOUT with no further message.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_venus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/medi=
a/platform/qcom/venus/hfi_venus.c
> index 3a75a27632fb..9a34662fea38 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -1583,8 +1583,10 @@ static int venus_suspend_3xx(struct venus_core *co=
re)
>  	 */
>  	ret =3D readx_poll_timeout(venus_cpu_and_video_core_idle, hdev, val, va=
l,
>  				 1500, 100 * 1500);
> -	if (ret)
> +	if (ret) {
> +		dev_err(dev, "wait for cpu and video core idle fail (%d)\n", ret);
>  		return ret;
> +	}
> =20
>  	ret =3D venus_prepare_power_collapse(hdev, false);
>  	if (ret) {
> --=20
> 2.34.1

