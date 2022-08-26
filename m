Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16755A231F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244922AbiHZIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343671AbiHZIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:36:48 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C419AF96;
        Fri, 26 Aug 2022 01:36:40 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x10so917578ljq.4;
        Fri, 26 Aug 2022 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=0mzSJLrYErOqc1s11b3RmVKhpdRQXjWEWDYCPDuYlHM=;
        b=jh5j0MNihGo71XS/a1txQyJn7NCts42QUd7sRcGQOz3T6IY3i3n8zHhKgcg+EihtmC
         rUyyJDD5rxY3vM8c86yi2+pTosxeMLgaev3uRxZl+jGq5AdxxwXqCNRnV9wycMd/yF32
         YuPPRohcLKxd5sTNOkLCBLl8qQPuun+JQILXTShj+X2NC5gBipvekyb1jrdewdqIwotK
         hjx1cZLmc6/hsWc2MZeJIr0io6tGqMz10LKPfs+FrRm/iHYMMWY3vI4s5fLEjoV3t9ip
         jkPZ14sEh1My+eIa2nvt+9xDP6jh7LIT/vGrLbNmIjzZWISvmvOvCZtJ9tu73mSRa2HI
         CohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=0mzSJLrYErOqc1s11b3RmVKhpdRQXjWEWDYCPDuYlHM=;
        b=3ot7B2chvRkVZ3yNXBBtKhN0GBO+AqqXHpYeJtwExAgWW/Rv4/lDobBWm8JKj3ervB
         3NkQGP80wIQRY2rYpgbdmCgSvqrF9KX/SzicBW7XXWTwWBnjd5+ELFvuSZdNVtcMZjdR
         PGKzuYhssaeswqXwVKACOMX2XFqtYi2R6C8/v/A7xT/7CNgFSTrxVD4K4LD3cs0r4OXg
         GW4hm8M6N+BrQhS086JYjP3q/rQr+GhfsN2DNDpFzaw0NEdbcZvDrVA7Z6EZyoKJqHKM
         +4q1oPeIcu3NX0QGQE2HLEnHGO4pFwYXrsB9q/iXZrSwWSGhAqM6foSrMH7rixeJnisS
         T5zQ==
X-Gm-Message-State: ACgBeo1ndHs1HVV2t9/+z3qQHwppfTZN8m4vEpLnE6kHPsRhTwu2gLZB
        x9JwwI5RUDCDxlTuHG6Y5D/OnZtf52w=
X-Google-Smtp-Source: AA6agR6xn7+0871p78M2qgVzH7qB6JDVNIF/5V0KvfufEACYqwVFvQ720t8e+yAL7p7ALWs8CWOK0g==
X-Received: by 2002:a2e:3e17:0:b0:261:c12c:2b2c with SMTP id l23-20020a2e3e17000000b00261c12c2b2cmr1900288lja.179.1661502998825;
        Fri, 26 Aug 2022 01:36:38 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.85.51])
        by smtp.gmail.com with ESMTPSA id j8-20020a2e6e08000000b0025fe7f33bc4sm376520ljc.49.2022.08.26.01.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:36:38 -0700 (PDT)
Subject: Re: [PATCH linux-next] usb: typec: tcpm: tcpci: Remove the unneeded
 result variable
To:     cgel.zte@gmail.com, linux@roeck-us.net
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xupanda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20220826074856.253810-1-xu.panda@zte.com.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <84246f1c-97b9-1bb3-3981-15ea3871f97d@gmail.com>
Date:   Fri, 26 Aug 2022 11:36:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220826074856.253810-1-xu.panda@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 8/26/22 10:48 AM, cgel.zte@gmail.com wrote:

> From: xupanda <xu.panda@zte.com.cn>
> 
> Return the value regmap_update_bits() directly instead of
> storing it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: xupanda <xu.panda@zte.com.cn>

   Is that a real name?

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index b2bfcebe218f..4436e9e5e2f7 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -328,11 +328,9 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(dev);
> -	int ret;
>  
> -	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
> +	return regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
>  				 enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);

   You need to re-align this line now...

> -	return ret;
>  }
>  
>  static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
> @@ -884,5 +882,3 @@ static struct i2c_driver tcpci_i2c_driver = {
>  };
>  module_i2c_driver(tcpci_i2c_driver);
>  
> -MODULE_DESCRIPTION("USB Type-C Port Controller Interface driver");
> -MODULE_LICENSE("GPL");

   Hm, what's that?

MBR, Sergey
