Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2075AF24E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIFRUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiIFRUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:20:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B492B80F46;
        Tue,  6 Sep 2022 10:08:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so11214662pgb.4;
        Tue, 06 Sep 2022 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=jpBqPqc/lFpM1zTXIIfM2j2me7eqE2ehqTemnrYiK5w=;
        b=QGXiQIxSQsEpcNPUUPnW5yJPk5GOM5XzDyrQb4RwgQ1zmFeoYRjlmRc1Jg8ZwfqHhk
         qLXeaWcP8yYpuSzBKHVMwApLlqmP74OygkSCswPzoSGMTs9qpccGGq7cpThsNaCP6ZKv
         6WvB3LO6Ei3hMasSc4kfFMgzU1hEMynEsnxhT1ADlxAc0AMySVp1hU+TdrKgEQpPFrdO
         1JWaj5tsO5Sa33XtGH3g/I8yBQXqeBYNk293+FgrmXBbVeoan93Apj9oROO06YcOinPT
         YgprEWmtrpc177YnbNitYee0LKAf20BFUXj4LwdBKv2eL7C+o0vOHmYzHQFahbu2QJaW
         aNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jpBqPqc/lFpM1zTXIIfM2j2me7eqE2ehqTemnrYiK5w=;
        b=HvBZx+OlpZfMU/5Yp0JEVrF6dy+TG+LyCDI1EU6Hx6X8GGJDy0yvqT29bHmCZ8543/
         CluZXgp2v4ENT9kdZK6PY0cwL1Ow/M4fEfJtlMsPMdHTedQrF+qm3RMwFqVBa8cicU8M
         enN4+f2T1MKYHydVgwaVz2nm2p1QZy1hRTfFOxCb50Gb7fq/rAd0kzwFKe0NQoakoz/x
         Q6SE6phdc1f8vMypAJxsgvLCcaOMzuo2sd5Qe+YMayB3ABaJJTsXGJ6cn9htQoWSTYUF
         OzLrFtuEJSGkypLOvV0cwAIqvl4AnmbvQwUy9i4Ahu+5XiWZVJQ2EkXMhZr5Cf5T3Jix
         rlKg==
X-Gm-Message-State: ACgBeo1busVUGTZOGD9S/XkaCWa0aBSZUZslHhtKMWHYkTuDI9lmnHd1
        /HgyKB+KPS9N9mbEuBKilq4=
X-Google-Smtp-Source: AA6agR6djT+Gr6oxqaWgaxkmVn4FURMY7NmIiyN4yolJ0TcFK5fVrSnKtj8nJiQ3g749xyanhP/EUw==
X-Received: by 2002:a05:6a00:1a14:b0:52d:3e35:5b38 with SMTP id g20-20020a056a001a1400b0052d3e355b38mr56351303pfv.11.1662484132748;
        Tue, 06 Sep 2022 10:08:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b0016db7f49cc2sm10069358plm.115.2022.09.06.10.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:08:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Sep 2022 10:08:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hhhawa@amazon.com, jonnyc@amazon.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v4 12/21] dt-bindings: hwmon: (mr75203) add
 "moortec,vm-active-channels" property
Message-ID: <20220906170851.GA900242@roeck-us.net>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-13-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906083356.21067-13-farbere@amazon.com>
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

On Tue, Sep 06, 2022 at 08:33:47AM +0000, Eliav Farber wrote:
> Add optional "moortec,vm-active-channels" property to define the number
> of active channels per VM.
> 
> This shall be useful to avoid exposing sysfs for reading inputs that are
> not connected to any voltage source.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V4 -> V3:
> - Fix DT checker errors.
> 
> V3 -> V2:
> - Add "moortec" prefix to property name.
> - Add explanation why this change is needed.
> 
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index 9454576ebb73..2aa4c3618596 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -70,6 +70,15 @@ properties:
>    "#thermal-sensor-cells":
>      const: 1
>  
> +  moortec,vm-active-channels:
> +    description:
> +      Defines the number of channels per VM that are actually used and are
> +      connected to some input source.
> +      Maximum number of items - number of VMs.
> +      Maximum value of each item - number of channels.
> +      Minimum value of each item - 0 (which means entire VM sensor is nou used).

s/nou/not/

> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +
>  required:
>    - compatible
>    - reg
> @@ -91,5 +100,6 @@ examples:
>          intel,vm-map = [03 01 04 ff ff];
>          clocks = <&osc0>;
>          resets = <&rcu0 0x40 7>;
> +        moortec,vm-active-channels = /bits/ 8 <0x10 0x05>;
>          #thermal-sensor-cells = <1>;
>      };
