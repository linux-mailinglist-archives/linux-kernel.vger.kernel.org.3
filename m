Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A46563EC3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 08:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiGBGJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiGBGJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 02:09:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93666375
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 23:09:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z41so5328270ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 23:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uohFf1DkkWNhAVQnV45ZTdTOfbQegv4GUmhl5weagcI=;
        b=NdAs6H2PwDrMo62QVT4fkndCt+xzIEYZOx7ONqkp/yJeJGhchoBWAxYrybOH/u7+H5
         GrwWyCrCrJ0I2BZDh/IgeVqheViKh6MVVwI2C/M0Q4fmxu4LKHfURCBNIX7YVCCVgKni
         5f2vTsl5lXFHZMEifhnZNYppFMSwPH3KsGsdm9XEBES4kTfEWgsm63Bk4HCKJx1tOLbk
         /pEOdS0FCIFar0u0eWTeEnd4+nFXDfr/KpaCjsh48ap1pWgjrxcMkZsPeVmErmZMPe4L
         IorR/FeCtePoedSJMTF91Gw2VWRokh5XfVraMjciR1DE8mLr8RQyfyn2VDUwJ5xH138R
         z5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uohFf1DkkWNhAVQnV45ZTdTOfbQegv4GUmhl5weagcI=;
        b=Gtufcf9BzxIcjeSaUV5DtsbBttSlH9j/LKJmAzVmavp1et8K6zaE5ur6zwV40OdS68
         p3Gjo8roA8TmMcGwASVHKvJxvYW+8+pUYZe5Ca4lhTCGVIY9Aftk2Ppj4AZuE4b03+As
         9NjKmURMVw9CSyP8WqL4n1SYyjnr32sXM9bunNh2NgLmPGcSlG+30U2J/hfUBaKdTGsr
         nT9IY7DxLDSHmsd5l0wl3IKiu550Map4W+Ojo7murGTfIAPHPMmcOCYVE7AQKcWfmfC/
         ViIHwIOhGOxSww9fzrDp2CXeJrk4hZwjr17EkLeoYdWmegKf98a+orsFx1v8MMjfed/Z
         WrkA==
X-Gm-Message-State: AJIora9IDQy5Ihp9Z+mPw94rsq80RDzLUhi6Xf+lP7l9Nkcvq5hCI2Ih
        DxeFaJwbL8gh1XF+TFQlNFg=
X-Google-Smtp-Source: AGRyM1vkR7mdB+a/hQvZeBsACuqRy2I67xkX6/9BlPXPiqWXm8bs4Vgq1lbQsViroKDS7TFuI+NA2Q==
X-Received: by 2002:a05:6402:4316:b0:437:8d2e:cf2d with SMTP id m22-20020a056402431600b004378d2ecf2dmr23384347edc.229.1656742142404;
        Fri, 01 Jul 2022 23:09:02 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6912:39ab:4063:59d3:a7cd? (p200300c78f2e691239ab406359d3a7cd.dip0.t-ipconnect.de. [2003:c7:8f2e:6912:39ab:4063:59d3:a7cd])
        by smtp.gmail.com with ESMTPSA id d18-20020a05640208d200b00435bfcad6d1sm16317737edz.74.2022.07.01.23.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 23:09:02 -0700 (PDT)
Message-ID: <9c7673b3-29ec-8a4d-0571-c869bc60b567@gmail.com>
Date:   Sat, 2 Jul 2022 08:09:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/6] Staging: rtl8192e: Remove unnecessary parentheses
Content-Language: en-US
To:     Felix Schlepper <f3sch.git@outlook.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com
References: <cover.1656667089.git.f3sch.git@outlook.com>
 <0e4e340be3f4c7f35a5381b726b1db5fc6842f10.1656667089.git.f3sch.git@outlook.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <0e4e340be3f4c7f35a5381b726b1db5fc6842f10.1656667089.git.f3sch.git@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/1/22 11:24, Felix Schlepper wrote:
> This addresses an issue raised by checkpatch.pl:
> 
>       $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
>       Unnecessary parentheses around wrqu->encoding
> 
> Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
> ---
>   drivers/staging/rtl8192e/rtllib_wx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index 121bf939c6a4..db076e819993 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -277,7 +277,7 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
>   			 struct iw_request_info *info,
>   			 union iwreq_data *wrqu, char *keybuf)
>   {
> -	struct iw_point *erq = &(wrqu->encoding);
> +	struct iw_point *erq = &wrqu->encoding;
>   	struct net_device *dev = ieee->dev;
>   	struct rtllib_security sec = {
>   		.flags = 0
> @@ -449,7 +449,7 @@ int rtllib_wx_get_encode(struct rtllib_device *ieee,
>   			 struct iw_request_info *info,
>   			 union iwreq_data *wrqu, char *keybuf)
>   {
> -	struct iw_point *erq = &(wrqu->encoding);
> +	struct iw_point *erq = &wrqu->encoding;
>   	int len, key;
>   	struct lib80211_crypt_data *crypt;
>   

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
