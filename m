Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FF15AB8FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiIBTvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIBTvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:51:17 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09064AB180;
        Fri,  2 Sep 2022 12:51:16 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1225219ee46so7363859fac.2;
        Fri, 02 Sep 2022 12:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z/1e21K0fic8vcdpiAOPusKQ6uAC44z45F500a/5SUA=;
        b=5PgxeI5J4mw5J27oUr9pFffuMpB7QqYzM835D9GLtNYrWO5DBZz595xzOC3YgzkEcj
         jJtN6XmPq9M0LxBiuBEVyqZmy+CwmN9+lN7bf2uLTbpUA9Evg53C+43HoDqqF4AGCPnC
         miM9680cXMwAgD/geZrIFCcoaKaNiodabKTqlcKeDpNT/nenwoCDXaNC6pWgsLdv0Jtu
         BleVK0T46tTBrMz/py7wGZLki5xolSLvQ6ZrOLak3Ll5NTuXSMk6uDWPC4aL4+8lXYRx
         Y4zvcX0sBFdR20g3zxuwX/SqWybm7Z2LZNIGVBsbUT4AATn14+jbGsv0Oq3Sk6fZHacO
         ynEA==
X-Gm-Message-State: ACgBeo1JVdCKGWhD7Ok+TloxRIJhkKsFD7DQrXvSo9iTpahQ5KfoljYX
        v2UaFN82pTu1spuWjone0Q==
X-Google-Smtp-Source: AA6agR6DTTGeiiUnLCzaaZP9BSI8eCO9U1ifoI27QIQY+ErlyxK+PZR9YkTYlxALfL3CcXnCUKs6HA==
X-Received: by 2002:a05:6870:45a9:b0:10a:9ebc:63ab with SMTP id y41-20020a05687045a900b0010a9ebc63abmr2983240oao.209.1662148275348;
        Fri, 02 Sep 2022 12:51:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cz20-20020a056870649400b0010c0d04eb00sm1626681oab.2.2022.09.02.12.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 12:51:15 -0700 (PDT)
Received: (nullmailer pid 306663 invoked by uid 1000);
        Fri, 02 Sep 2022 19:51:14 -0000
Date:   Fri, 2 Sep 2022 14:51:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, rahul.tanwar@linux.intel.com,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH v3 04/19] dt-bindings: hwmon: (mr75203) change "reset"
 property to be optional
Message-ID: <20220902195114.GA305400-robh@kernel.org>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-5-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-5-farbere@amazon.com>
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

On Tue, Aug 30, 2022 at 07:21:57PM +0000, Eliav Farber wrote:
> Change "reset" property to be optional instead of required, for SOCs that

'resets'

And subject too.

> don't support a reset controller.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V3 -> v2:
> - Change "reset" property to be optional instead of adding new
>   "reset-control-skip" property.
> 
>  Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index 6abde48b746e..2ec4b9da4b92 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -49,7 +49,6 @@ required:
>    - reg
>    - reg-names
>    - clocks
> -  - resets
>    - "#thermal-sensor-cells"
>  
>  additionalProperties: false
> -- 
> 2.37.1
> 
> 
