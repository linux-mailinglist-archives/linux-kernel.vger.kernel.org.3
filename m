Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4FA598D73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345866AbiHRUHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344438AbiHRUHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:07:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C10D2EB6;
        Thu, 18 Aug 2022 13:01:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d16so2376632pll.11;
        Thu, 18 Aug 2022 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=newzkmQUzujson7EueJWeL6KafDp3tWYzRmXIinSpck=;
        b=LbWXzPDPIJnzBvBCuHqGYaktwpuVJXJNXnNAOOUvoMJP1qrn3rhXXAWE+3U0bqg1Ds
         KddsXqzbWB/x3u0VN63w5ML89naR2sReYQ8xU+mXmt8UCW5zxXNHnf8e+LsZSaRFbZc5
         b2fuHAFmnnECXn7pH97L6Xv/+vweM7ifsqR0v8VzAYziIC87tmwv6gprUMUa8R99S7WO
         LV6QlWem4VKDYviRA3xzulChoT/PdU8hXoKR9/f/7bFLizlNWTHk4u9bCl8eSdblTuIB
         6MAfFd44xE2FXTQEE81r6THLpJH5XKMsRkG/ME0gwiDNZs4uV1+dAPYWPp9pQRPyhz59
         xwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=newzkmQUzujson7EueJWeL6KafDp3tWYzRmXIinSpck=;
        b=rnrH7QkOf4Z2vFZUPOZXdLZjNY69ycFbqjQnZY7M7HPzNoLVeMww/L0tM28WuO2pZw
         jxZcHcKAhoUIq33yYbM7GP7nBMsPdpMFAQnajVkrXBnXhF1zzUWQ1144qPxoO2ZljoO3
         MZpogTq4DnWwRL1w8N+xWI1aDVztGU+qi/TG5NxbQciaHOoK8TKlK18HRR8QAXGaM4s/
         7W551Kt8tV0RlaVg9Ayoplb3qBiZ6uSx3OJkrtVfTpDKQU4isdESUrBfuGoQPwe2YTvU
         CpCnkRcQ/1cD4sDhWpEdYbw3WXI1x/jO/NU2uljGF4iuBUwNbIy/5v3qDV6JNNhWxVTF
         7pWA==
X-Gm-Message-State: ACgBeo36VGhclmEFnDq+oDdLSfwAL/Kd+k0AbUoGGKUJXt8ikw/S+u/6
        OfAz6DV+DgOUATpwjnt9oF8=
X-Google-Smtp-Source: AA6agR7t0BR3+os83cK8htKnmIBZHqLnfhYRUc3qgjeRF6BNxBmbyyp0Y9i1ZMw7nCakzzywCp4VBw==
X-Received: by 2002:a17:902:788f:b0:170:8b18:8812 with SMTP id q15-20020a170902788f00b001708b188812mr3878338pll.1.1660852901678;
        Thu, 18 Aug 2022 13:01:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x63-20020a623142000000b00528c066678csm2054256pfx.72.2022.08.18.13.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:01:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 13:01:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 04/16] hwmon: (mr75203) add Moortec PVT controller
 reset-control-skip property
Message-ID: <20220818195742.GA3287145@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-5-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-5-farbere@amazon.com>
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

On Wed, Aug 17, 2022 at 05:43:09AM +0000, Eliav Farber wrote:
> Adding a "reset-control-skip" bool property to the mr75203 node will
> avoid looking up and obtaining a reference to a reset controller.
> 

This seems overly complex. WHy not just declare the "resets"
property optional ?

Guenter

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index f9e849cc73e0..da9c3cdcb6f0 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -44,6 +44,11 @@ properties:
>    "#thermal-sensor-cells":
>      const: 1
>  
> +  reset-control-skip:
> +    description:
> +      reset-control-skip bool property defines if obtaining a
> +      reference to a reset controller should be skipped.
> +
>  required:
>    - compatible
>    - reg
> @@ -54,6 +59,7 @@ required:
>  
>  additionalProperties:
>    - intel,vm-map
> +  - reset-control-skip
>  
>  examples:
>    - |
