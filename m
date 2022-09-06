Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3342B5ADFC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiIFG15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiIFG1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:27:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D1C5E308;
        Mon,  5 Sep 2022 23:27:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x23so10339485pll.7;
        Mon, 05 Sep 2022 23:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tZGkVWfVwu3VMSzAGROw7vkLVEx9FkktQXY75aiAv1g=;
        b=q5hGWkzHC+IcxG4HYOa7ijNSm1gIy0xI5yvRIJoJ4rgtFb2yeGg7eV0Lgc8rAzwEyh
         /QWrx4UiRJbjR2JAimM/PiPuId0VOld9GL6aNQX60m10yKQ3PY4GXU4P0J5Qfj+tgw/D
         6Hhqvib3H9O+nL22TPeHRfO/axMjJNt23nIm9cgDFLQrD32clHnaShP4nWQe5Gj3lIp/
         owHKctlCy1/sheAOOwGmfruXxWvuJi7QF+kUQOZVB5KwuStkhy8x4nUJZbOrG/W7gZEW
         Q3HfIxUSPIf3wLI/8Z6m8zljULEgzTDuyImYCzcxsooqpotxIO4mGp2rrvhmSXoveut/
         g/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tZGkVWfVwu3VMSzAGROw7vkLVEx9FkktQXY75aiAv1g=;
        b=kfBDzPLVBCA3J+yWBWK1DAhXwCoWAHiazG0GR0zBAw4lXq6CejciLoXPrFVKtgAvk1
         Tg2AcZOwiFe8HXpQvvRB/7E3004Fs4IWXAVvympMD+vmXRPYBETRkEEYw0NOz1Z9/re8
         3t7Mwn/nDw7/cHuaQ+rC2Y2D5wy+sLEiBKXcp900PbrvxvlWz9j3pqV7GYnN+B5GuA0m
         r7Ik1yc/agygVqLydjK5ZXNEk5j2rn5hC+nLQQ3SMTBXVpFr+YK59ouOsBb/jnt8zPXJ
         FHFA/ZOepAq148z4+qNyfAwQC+EjwPVKfeuc4rtt4gg74R7rQCx7R7d0IOcjAybEa/57
         ZMDA==
X-Gm-Message-State: ACgBeo1z8FnXkOpKvHTDKfe4Vi7trpmAgPs/ItoIAoqvdeSUrrf60GGv
        xEN0o9eaicvmOoQEiru9Rwg=
X-Google-Smtp-Source: AA6agR6bqQvVPxZDdNU9/IYUxuqxClwUpHLhvoX7Ki3t2GJAr6RH4b3PG2Cl6yU8oos1upmBqsa86w==
X-Received: by 2002:a17:90a:5988:b0:1fd:6a33:abf with SMTP id l8-20020a17090a598800b001fd6a330abfmr23105126pji.69.1662445672225;
        Mon, 05 Sep 2022 23:27:52 -0700 (PDT)
Received: from taoren-fedora-PC23YAB4 ([76.132.249.1])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b0016dc78d0153sm842426plg.296.2022.09.05.23.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 23:27:51 -0700 (PDT)
Date:   Mon, 5 Sep 2022 23:27:42 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v1] Update for Facebook yosemite V2 BMC.
Message-ID: <YxboXspF+0Y/+spD@taoren-fedora-PC23YAB4>
References: <20220906050702.GA10565@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906050702.GA10565@hcl-ThinkPad-T495>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karthikeyan,

I don't have much experience with ipmb-dev, but I'd suggest updating the
patch tile so it's consistent with other dts patches. For example:

"ARM: dts: aspeed: yosemitev2: Enable i2c13 controller"


Cheers,

- Tao

On Tue, Sep 06, 2022 at 10:37:02AM +0530, Karthikeyan Pasupathi wrote:
> Added IPMB-13 channel for Debug Card communication.
> 
> ---
> --- v1 - Initial draft.
> ---
> 
> Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> index 8864e9c312a8..84236df522dc 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -215,6 +215,17 @@
>  	};
>  };
>  
> +&i2c13 {
> +	status = "okay";
> +	// Debug Card
> +	multi-master;
> +	ipmb13@10 {
> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
>  &pwm_tacho {
>  	status = "okay";
>  	//FSC
> -- 
> 2.17.1
> 
