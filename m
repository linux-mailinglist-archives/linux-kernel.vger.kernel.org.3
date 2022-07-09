Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F2F56C6FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 06:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiGIExu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 00:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIExs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 00:53:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0046140D5;
        Fri,  8 Jul 2022 21:53:47 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so559611pgb.4;
        Fri, 08 Jul 2022 21:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+zzXGVbFC1NRlQzxK4sf3CCcjjPYGBluawnVA4ofjIU=;
        b=f6puec+ID1sEU6WH0NJGgfBjywoXSoTjlZngp0ITvnEdeyyxaAHramKL+GnQSYJVsy
         hbWWbs9hOWWCYqLzNTzgx3PosYeWZE7lWzrwggKITvqeVPIp25CdrCssSaldtYI53+BL
         6As5MdnutdfaiUKzU7q41h1OFcqAds5iUbfI9kMwrJei8ujVeQyeVQtlxIx8OCGuhRn2
         k1e6p02WlEvl27Z1/yTtOJGdImzDyrh9MjEOAFgbB2NgCqFq9sUzVRiE2vLW45FhAhcT
         NHG8Ienq/46DyNCDgw4Ra5KE7FALuQSafsbwl/919mtGSAIdyTsqUs8zDEBXN+Gj0MfV
         XXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zzXGVbFC1NRlQzxK4sf3CCcjjPYGBluawnVA4ofjIU=;
        b=D7cxggQ6VF3qh/Byx5U+76vuK8WxV/RgOPYiJhsWNWkJyuNw3tX7RaoO9zpFnSh4rL
         d9titn/BaUcM3tyDrtaKnyahyemD454TdPXirCC2B4kcWiIFBQUvMp37X37OlokMlEQy
         3wprIEnaPN9l9APYupaDxgLK93Yrr+guPrG18kqNBdPEwVR6Qv1UPB4NLCYisL0Pg+Tp
         MhuzUAdraIxcEUpxeua83yUoj2FeIOjZBEX0qEk1+4sTgKw84dMnZN3LHoaY2Ox6i3wf
         2j5D6DRUM3XiYHQmo8v8OgFnZTz/VQm8FIRHSKK6rfzpY6vEuDPOzaS8s7L2jUSb5qTY
         0PFA==
X-Gm-Message-State: AJIora8uONd928o2BdAcrYK4hPw8MDQDqJm2q2tBT9UkR20wasYaNbmX
        f9I8EvfGloQL5ZqqlBEWy6zxafyxXuY=
X-Google-Smtp-Source: AGRyM1svvZnewMosK+TxZ7hMFRIqBj1pfpUK4mnYNH+vG8qwrxseKMaDLdMjIyhD9932ZGI/IIn7AA==
X-Received: by 2002:a63:4524:0:b0:412:a2ee:eaf4 with SMTP id s36-20020a634524000000b00412a2eeeaf4mr6090708pga.41.1657342427067;
        Fri, 08 Jul 2022 21:53:47 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:5011:9ea9:1cc2:a4c0])
        by smtp.gmail.com with ESMTPSA id 195-20020a6214cc000000b005286a4ca9c8sm439559pfu.211.2022.07.08.21.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 21:53:46 -0700 (PDT)
Date:   Fri, 8 Jul 2022 21:53:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 4/4] input: misc: rt5120: Add power key support
Message-ID: <YskJ1wAp0rV9qFRM@google.com>
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
 <1655892104-10874-5-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655892104-10874-5-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChiYuan,

On Wed, Jun 22, 2022 at 06:01:44PM +0800, cy_huang wrote:
> +
> +	is_pressed = !(stat & RT5120_PWRKEYSTAT_MASK);
> +
> +	if ((is_pressed && irq == priv->press_irq) ||
> +	    (!is_pressed  && irq == priv->release_irq)) {
> +		input_report_key(priv->input, KEY_POWER, is_pressed);
> +		input_sync(priv->input);
> +	}
> +

What is the reason for checking both the status and interrupt? Can we
simply say:


	input_report_key(priv->input, KEY_POWER,
			 !(stat & RT5120_PWRKEYSTAT_MASK));
	input_sync(priv->input);

?

Thanks.

-- 
Dmitry
