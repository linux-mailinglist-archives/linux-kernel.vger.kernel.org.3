Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909C74E2AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349030AbiCUOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349293AbiCUO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5733EFD2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:21:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g20so18035483edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=wqQ731hjmzYwePMzj+DNt4zNoUy/RV/H/tR/xZClBEc=;
        b=a7Rj6AcABHT78i9TWBgkQWPokagDU0jBGQ8LsSbBRRv/OI/4rMl/1lju5JlyvS+tKB
         IuOqDYxcyotfBCrs3bvIdzLsazH1bv1ZEmVlUQGa01tFitcvq362wqqPjcwvMHU7Adyr
         LKkIWbPU5R+35AO/6VOvWccjhxctlXSXVTUvF9VuG2KG6LZQSYI9F5O6OHG7RmNdiQsC
         bUXm1f5BMaOcPQIoXlbmwPYJhJEIUd8GGJfSKJ0o7MumrzXVWEi6/qIwGoJ7Pq6eiTMO
         Eppsl4kulnTjm3XxgvwUK4oVT+R3wYUCPwo0/7uQkZWeF7evkxcElK0yCJUwT40bNalq
         gn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=wqQ731hjmzYwePMzj+DNt4zNoUy/RV/H/tR/xZClBEc=;
        b=qbQF+Gq4xKKc/ZHxJlE4aP6RX6Tub+acy0OXZODrJIPicTh3+V3N42f+Q56lWroGIK
         uChjBDy9qvoVN5DBP+RfGWnTzUbasgAH0Bx+R3+oDwfyscyKViGeKnArIy8Bpv+C8SSN
         p8rEhFpk48YL55YWqcI4B/0GxXjMZ9ilJsZXl2F7ZwzOe1yAtKPNYlPUpZSprclckf7H
         hkqG5BglKXRnNyKHL8BcudfJksYSkKCGOtql2+AzK66YLLQwT3S5ASRc9Td1ITxgqA12
         HKnTej6dP1pQb3AN+bUGuTMIXOcEMZ6Wi1l3BN6oDWBgNQLOaHqBVb5ADeuKTEEoRifi
         3bYQ==
X-Gm-Message-State: AOAM5317tXkaVEnCy9nXZwlERJAzcLM1BoY6nSQnTqIihy40aJRkLN1j
        gAXlZHAQijarRhDZkt/5WuJR4Q==
X-Google-Smtp-Source: ABdhPJyJQVu0Cr0w5giMNOtom9UMGLM/PCPym5H/QrHqy+QJ5fE7S8CUPrlQk3ekr9KXq9nUVZImUA==
X-Received: by 2002:a05:6402:d2:b0:413:2e50:d6fd with SMTP id i18-20020a05640200d200b004132e50d6fdmr23158510edu.171.1647872517856;
        Mon, 21 Mar 2022 07:21:57 -0700 (PDT)
Received: from localhost (a246182.upc-a.chello.nl. [62.163.246.182])
        by smtp.gmail.com with ESMTPSA id bn14-20020a170906c0ce00b006c5ef0494besm6945946ejb.86.2022.03.21.07.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 07:21:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Mar 2022 15:21:56 +0100
Message-Id: <CIPM1ZGMNRPK.36O4MO2RGWRV8@otso>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@somainline.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] pinctrl: qcom: sm6350: fix order of UFS & SDC
 pins
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Bjorn Andersson" <bjorn.andersson@linaro.org>
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-5-luca.weiss@fairphone.com>
 <YjiIZBbPN7pAUl1q@builder.lan>
In-Reply-To: <YjiIZBbPN7pAUl1q@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mon Mar 21, 2022 at 3:15 PM CET, Bjorn Andersson wrote:
> On Mon 21 Mar 08:33 CDT 2022, Luca Weiss wrote:
>
> > In other places the SDC and UFS pins have been swapped but this was
> > missed in the PINCTRL_PIN definitions. Fix that.
> >=20
> > Fixes: 7d74b55afd27 ("pinctrl: qcom: Add SM6350 pinctrl driver")
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>
> Your proposed change looks good, but when I look at 7d74b55afd27 it
> already has these entries in the correct order.
>
> Can you please confirm that this is still applicable. Or help me see
> what I am missing.

There are 3 times where number and description should match.
For this UFS pin on sm6350 only 2/3 match.
2x the number is 156, 1x it's 163

$ grep -i ufs_reset drivers/pinctrl/qcom/pinctrl-sm6350.c
        PINCTRL_PIN(163, "UFS_RESET"),
static const unsigned int ufs_reset_pins[] =3D { 156 };
        [156] =3D UFS_RESET(ufs_reset, 0xae000),

Does that help?

Regards
Luca


>
> Regards,
> Bjorn
>
> > ---
> > Changes in v2:
> > - nothing
> >=20
> >  drivers/pinctrl/qcom/pinctrl-sm6350.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/pinctrl/qcom/pinctrl-sm6350.c b/drivers/pinctrl/qc=
om/pinctrl-sm6350.c
> > index 4d37b817b232..a91a86628f2f 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-sm6350.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-sm6350.c
> > @@ -264,14 +264,14 @@ static const struct pinctrl_pin_desc sm6350_pins[=
] =3D {
> >  	PINCTRL_PIN(153, "GPIO_153"),
> >  	PINCTRL_PIN(154, "GPIO_154"),
> >  	PINCTRL_PIN(155, "GPIO_155"),
> > -	PINCTRL_PIN(156, "SDC1_RCLK"),
> > -	PINCTRL_PIN(157, "SDC1_CLK"),
> > -	PINCTRL_PIN(158, "SDC1_CMD"),
> > -	PINCTRL_PIN(159, "SDC1_DATA"),
> > -	PINCTRL_PIN(160, "SDC2_CLK"),
> > -	PINCTRL_PIN(161, "SDC2_CMD"),
> > -	PINCTRL_PIN(162, "SDC2_DATA"),
> > -	PINCTRL_PIN(163, "UFS_RESET"),
> > +	PINCTRL_PIN(156, "UFS_RESET"),
> > +	PINCTRL_PIN(157, "SDC1_RCLK"),
> > +	PINCTRL_PIN(158, "SDC1_CLK"),
> > +	PINCTRL_PIN(159, "SDC1_CMD"),
> > +	PINCTRL_PIN(160, "SDC1_DATA"),
> > +	PINCTRL_PIN(161, "SDC2_CLK"),
> > +	PINCTRL_PIN(162, "SDC2_CMD"),
> > +	PINCTRL_PIN(163, "SDC2_DATA"),
> >  };
> > =20
> >  #define DECLARE_MSM_GPIO_PINS(pin) \
> > --=20
> > 2.35.1
> >=20

