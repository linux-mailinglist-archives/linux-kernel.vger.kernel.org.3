Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43457176B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiGLKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiGLKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:33:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E425C4D;
        Tue, 12 Jul 2022 03:33:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l12so6875840plk.13;
        Tue, 12 Jul 2022 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gachuNnC0hTkk24/HLpfKX6g4vzvef3pJHZ1Ef05Ets=;
        b=UB2x/3aki2VL+aBcCTr0mvD9nZnmGGre2jKDPsuX5LuzxTbzSk+8kLhPZPFFopGVJB
         pSj8/q+g9fKizaQjZxz01iq1XhURfbNdvnZHDsNvoDXMSw/lcQWNdH1UicDZfBNXCQg3
         Kw8Mj372CZVgAhEEna9L/wRKIzYhVGRsr62MfroYO3fpunOmgA6qRBLVII3cITY/76GL
         P+MPpXsqBTGQ8GvmGBt1zofpPeitPbj+VWaoqGHuyIYMj3vqpAWjO6OylCX1avnDWrc8
         49G6YUwR/Q4uEmYRV5PHspcU0WBfmWSK3E2X9EAcgZ1fy/epkwrKUK/9RC7izqF/mD5w
         NbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gachuNnC0hTkk24/HLpfKX6g4vzvef3pJHZ1Ef05Ets=;
        b=uGbhNglO0etbIlRLjMkz6T6+QgcBQQMHqKA+fz+JzlW4aydajTTYN5F2hxRB5uUbJ+
         bQr1VLrAfTfS5vX7nshkdyL89qeKy+aTvyg+Cw7l+yyj9cxxCIJ6Zdo9I1DT1/pA5kdP
         RgwclDuiRHQnTDxaDoeldQM7vJj6/pSBL0BAKPNc0frEE6AIbQklWYyFqSyCfJ+Smv6f
         WLZQobdxhu5ZyvtSItkglNZhQvqcVfRHybAoIhulucj2onv/IDXtwMi/3L7Z648Ec6lj
         9PtLIBlHVvamcNmlqSGmqAqh4ygEqGvgRXABXCI83+TlOGbyyRmBOyiT5Q47HhrHD0uz
         8Pgg==
X-Gm-Message-State: AJIora/OPhoBiornQjj2udtULKbAl58QTTMJQNQsl0FCl8KBcSQrQfbU
        Nq+WR3Yvi17SIyJ9fEiHVws=
X-Google-Smtp-Source: AGRyM1u160iiaMviEuP/qevyCQ6X01OBEMaq/CFW962Wxt+Mpxi0uVdRUmon7eb/UMIbgAoPTEhR0A==
X-Received: by 2002:a17:902:f605:b0:16c:116d:ecaf with SMTP id n5-20020a170902f60500b0016c116decafmr23203946plg.164.1657622031116;
        Tue, 12 Jul 2022 03:33:51 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a2b4900b001ef869aa755sm8678869pjc.15.2022.07.12.03.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 03:33:50 -0700 (PDT)
Message-ID: <0ec6f86a-a78b-4b5e-fb43-72f74ee71ceb@gmail.com>
Date:   Tue, 12 Jul 2022 17:33:45 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND] crypto: qat - fix indentation in ABI documentation
Content-Language: en-US
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>, lkp@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org
References: <202207090803.TEGI95qw-lkp@intel.com>
 <YsvuJsjxEjp/LHZa@silpixa00400314>
 <CAMusb+QfUZwq+JRkUrOLGO7mQLZbg_ueFVo2_PTSiSRiq7BoEA@mail.gmail.com>
 <YsxJnq32lAJIRSET@silpixa00400314> <YsxP5n0rjUaX0mL8@silpixa00400314>
 <YsxlfOG17XQ+zLLZ@silpixa00400314>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YsxlfOG17XQ+zLLZ@silpixa00400314>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 01:01, Giovanni Cabiddu wrote:
> @@ -47,14 +43,14 @@ Description:	Reports the current configuration of the QAT device and allows
>  		The following example shows how to change the configuration of
>  		a device configured for running crypto services in order to
>  		run data compression:
> -			# cat /sys/bus/pci/devices/<BDF>/qat/state
> -			up
> -			# cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
> -			sym;asym
> -			# echo down > /sys/bus/pci/devices/<BDF>/qat/state
> -			# echo dc > /sys/bus/pci/devices/<BDF>/qat/cfg_services
> -			# echo up > /sys/bus/pci/devices/<BDF>/qat/state
> -			# cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
> -			dc
> +		# cat /sys/bus/pci/devices/<BDF>/qat/state
> +		up
> +		# cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
> +		sym;asym
> +		# echo down > /sys/bus/pci/devices/<BDF>/qat/state
> +		# echo dc > /sys/bus/pci/devices/<BDF>/qat/cfg_services
> +		# echo up > /sys/bus/pci/devices/<BDF>/qat/state
> +		# cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
> +		dc
>  
>  		This attribute is only available for qat_4xxx devices.

Hi,

I think the culprit is just missing code block marker, which is added
above. Thanks.

-- 
An old man doll... just what I always wanted! - Clara
