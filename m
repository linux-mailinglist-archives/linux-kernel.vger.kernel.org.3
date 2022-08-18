Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A787E598CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbiHRTrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiHRTri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:47:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ED6DF4A;
        Thu, 18 Aug 2022 12:47:37 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 2so2398369pll.0;
        Thu, 18 Aug 2022 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=D+Y8CteJgMixNET3rM8bosPRl8cJEoA+Fl+sHN052Sc=;
        b=OBifYf4Jna9bbUewT4D+0/ADl/ZLgiwW0AOV9sjFoTFpE/M0+1RybUFYw1GsfwpDlW
         Pjkp/Ht62GbswAO6ds5PTKbyC8IG1ZsF+HUx/UzWS2CdbDb8b/8nTpYzm0bNpLWjkne2
         ESZtUgyodyoyW4qZ7Oh+1t/utJ03zqlJicddU5ilTSzPSO2itTaIG04b/eqD6N7B90B2
         t0LdmURHW8dI1vpNnMs1nkMKMFkHOlm+xGfABPn9dBbc4hiP0mTckUsNImI+1jq94X1B
         W/McfL0RlXEPTToLGfMvSrmJl7XOUMyDO1hwx2K5NEUj3eXDWrAr8mWEI9YiwfJcK40M
         e3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=D+Y8CteJgMixNET3rM8bosPRl8cJEoA+Fl+sHN052Sc=;
        b=qfFlq0cwT0G0nDglXJNnCmC3KHMLPb4dvldNzT4TUT5rrm78FotKZ/q5bM1V8Q1zUi
         zDeTlSaN6hiP2YWQn3SQw0Wsov3LA4lE96OYW9/Vcg6HKLk5Q7XVQBKTDl02rF6rhzHc
         rbYaMIzffj29iZW7+q2Scq63hodUh2Tce5FgjZqYNMGpn9OJKHTfm72nOj/ET3jMneG/
         3jzuqhSX2cHmQsj5nQRGRV2FQZR/GT2veovgOL2jM96wm77a5R5eYPRzILyaK2ZupOO6
         ztV1C7BFOqpUzC0oCsbu1TjoDG1rvQT7Fr5PqGBDBgBmMSsTOZj1TpEoJZTb+xMfwXEN
         hWvQ==
X-Gm-Message-State: ACgBeo0kvstSjNiFbv7cJL4ytWM31avmzaM0l8sOvrV6nkewrMy/sxTj
        Wf4MXg/AU2vCv7BzSA23F6s=
X-Google-Smtp-Source: AA6agR5eVP/JuOmNRZ2PnXGZmybLUtrlEy9/6hn594HN8kcLmV4rDc0B13E/HZoUuegH1JRv6mjymg==
X-Received: by 2002:a17:902:e3d5:b0:172:a78f:dbc with SMTP id r21-20020a170902e3d500b00172a78f0dbcmr3844013ple.144.1660852056984;
        Thu, 18 Aug 2022 12:47:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id li2-20020a17090b48c200b001f320faea95sm1910798pjb.2.2022.08.18.12.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 12:47:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 12:47:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 03/16] hwmon: (mr75203) update Moortec PVT controller
 intel,vm-map property
Message-ID: <20220818194735.GA3279179@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-4-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-4-farbere@amazon.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 05:43:08AM +0000, Eliav Farber wrote:
> The "intel,vm-map property" is optional and not required.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Ah. This patch should come first, before making associated
code changes, and there would need to be an explanation
_why_ it is not a mandatory property. Also, some action
is taken in the previous patches if the property is not
there. That indicates that the driver is expected to
use some defaults if the property is indeed not provided,
and that expected default should be documented.

Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index 6f3e3c01f717..f9e849cc73e0 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -48,12 +48,12 @@ required:
>    - compatible
>    - reg
>    - reg-names
> -  - intel,vm-map
>    - clocks
>    - resets
>    - "#thermal-sensor-cells"
>  
> -additionalProperties: false
> +additionalProperties:
> +  - intel,vm-map
>  
>  examples:
>    - |
