Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17E04F67A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbiDFRfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239295AbiDFRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:34:51 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFA0220335;
        Wed,  6 Apr 2022 08:41:47 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id r8so2787809oib.5;
        Wed, 06 Apr 2022 08:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CSjXS3liiZsQ5y+dsNvQXrAg4KGiXpv7ZiLu0UE4ATo=;
        b=NAo5q6itzjUS+NlX/U7TVFtpy9+vbMKonuPYTvwqsOdxPQlvP4xZBA4CwSDcuG3mV9
         Sq5K83XSawg3teRzpodaTEHPdTSRur0fDOteh/wl0qaNnB4bKFj24sL5sHeiHSzb9mv2
         TLeFCrueCH2jxme00JV1Z1ksZHa8tJLugdxc48QCUlb0hwjAbvoIe0GlV8spIXHY28WC
         8nRcMp6TvVfudCnCn8eGtZs0dlwmvhjSZl/2kt7fiDmPnuH5u8bjQi2idNHPmbLVRyxK
         Vuelsw1gfK/jgu+XAf6F+AIlxvu/RKqVtBb+0hsKNLa/nmCIe3rDGRdLuu+/MRXcJi2j
         D1gA==
X-Gm-Message-State: AOAM531pgLibVwT1Uch02RVDU8JiJogG7Jr3EhkeZ+U9B1iDf9jO41xd
        jkP7sKPg00PcQmAQ75foag==
X-Google-Smtp-Source: ABdhPJxbIZn0sFuEhJ20HhaeEdyTBrFvADnchwCiV0ko8mITBghdswBGY+ASd5Yd9f7doax3tDWvbg==
X-Received: by 2002:a05:6808:144a:b0:2ef:9fa2:ba7f with SMTP id x10-20020a056808144a00b002ef9fa2ba7fmr3693043oiv.88.1649259706857;
        Wed, 06 Apr 2022 08:41:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v13-20020a4ae6cd000000b00328882a2388sm6181366oot.14.2022.04.06.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:41:46 -0700 (PDT)
Received: (nullmailer pid 2298416 invoked by uid 1000);
        Wed, 06 Apr 2022 15:41:45 -0000
Date:   Wed, 6 Apr 2022 10:41:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: update google,cros-ec-pwm
 documentation
Message-ID: <Yk20uTE/Vdm2c6jI@robh.at.kernel.org>
References: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
 <20220331125818.3776912-4-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331125818.3776912-4-fabiobaltieri@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:58:17PM +0000, Fabio Baltieri wrote:
> Update google,cros-ec-pwm node documentation to mention the
> google,use_pwm_type property.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> ---
>  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> index 4cfbffd8414a..9c895c990ed8 100644
> --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> @@ -19,6 +19,12 @@ description: |
>  properties:
>    compatible:
>      const: google,cros-ec-pwm
> +
> +  google,use-pwm-type:
> +    description:
> +      Use PWM types (CROS_EC_PWM_DT_<...>) instead of generic channels.
> +    type: boolean

Either do a new compatible string if the cell interpretation is mutually 
exclusive (channel number vs. type) or split the number space for the 
1st cell between type and channel number. IOW, set a bit (31?) to 
signify the number is a type, not a channel.

Rob
