Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF74BA631
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbiBQQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:40:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiBQQkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:40:18 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D822B2FFE;
        Thu, 17 Feb 2022 08:40:03 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id p11so2686211ils.1;
        Thu, 17 Feb 2022 08:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZTjwSd+wHhmCGk8JqBXyhv8IcrizpvVNCPSWVUYfN5Q=;
        b=GqcH+bNBCdbBMu/Q3xd7RgD0yGfOpCIb7KiLDo9mqxZ6e0uEyeDhh4iEFHo+m3V/3y
         K6oE/gJT4VtrTKzyRMbMyvBwDDfhuxQLliTVy1r7qFnNumwNAogLBh87bZZA7xE1sFXm
         ABdXvaCyjdKTMf/UmgwzvYK5zHyL3nCSae2isTojg6rOkxQWQ5A35MhgK0yIiiccL7Bc
         aCgvT8erJ6K33Ebz6lzcQbF77uknpMQJq18CnbF+EdbJSTs0FzuKFfbo53Xu692e+Q6a
         3os9rsWNdJVdjZzO90HYZaT/TcmGWByk6+o9ffWS86bYdumyQmYOXOfZXkltWGRmGwV9
         5aMQ==
X-Gm-Message-State: AOAM531RVzMzYdnp4V5I4hStt64XO0Wesz6ArZ/S+8EstwtIiV+yiCdx
        RfoW8NlK4GIdaE9ZHB12Cw==
X-Google-Smtp-Source: ABdhPJz1Y8+veVYBuVo5eRY627g99ZkONn9xwBPYq02yX+hJd5PmyyrIfeQd/bz4Iu6Wu1GjvWbFEQ==
X-Received: by 2002:a92:d242:0:b0:2b9:a33b:9068 with SMTP id v2-20020a92d242000000b002b9a33b9068mr2622224ilg.144.1645116002966;
        Thu, 17 Feb 2022 08:40:02 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q4sm2131485ilv.5.2022.02.17.08.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:40:02 -0800 (PST)
Received: (nullmailer pid 3365327 invoked by uid 1000);
        Thu, 17 Feb 2022 16:39:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220217104444.7695-4-zev@bewilderbeest.net>
References: <20220217104444.7695-1-zev@bewilderbeest.net> <20220217104444.7695-4-zev@bewilderbeest.net>
Subject: Re: [PATCH 3/4] dt-bindings: Add power-efuse binding
Date:   Thu, 17 Feb 2022 10:39:55 -0600
Message-Id: <1645115995.379177.3365326.nullmailer@robh.at.kernel.org>
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

On Thu, 17 Feb 2022 02:44:43 -0800, Zev Weiss wrote:
> This can be used to describe a power output supplied by a regulator
> device that the system controls.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../devicetree/bindings/misc/power-efuse.yaml | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/power-efuse.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/misc/power-efuse.yaml:10:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1594124

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

