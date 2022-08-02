Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804C258847D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiHBWjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiHBWiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:38:50 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACC57242;
        Tue,  2 Aug 2022 15:38:34 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id b12so7024760ils.9;
        Tue, 02 Aug 2022 15:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=4M0eNIcFrYgM5K/B0q/9btVK0E4O23iIxQ1FHEylB2U=;
        b=TG8lkkOyxPw0P1EV4FBtI/TxCLA8iJdOBkDguv+NJKMEPw5sVJHR5JX00VJOEbvn4v
         ny3J3iCOjQeUtjDExcjaH8yoc18Jxnpgv0qsImtbB63JEczz4thsGa97uV69NCLROiED
         f8hbV0iRXTkPaX1OkHxwxSvMV9JHVd/dFeyYioikso3RhWVcGRSIEY+zHauH8F1Cu5pV
         b/W02YTOCpBDHo2oFnILQqEKUfHaNih1+ytv7Wb0FFA6VJf9I2E9uAn6ClZwmuoCijB/
         v02zf/hXUNongpn3FY406MMnZGvVeX42bitNApHWdBVZMZ8l+Nww85fY87VGb2YbYQ6F
         CbvQ==
X-Gm-Message-State: AJIora9lOzEzMfKia5Q1GKpxWb7eoi0mUvIwG/j1OyUc0xC7tinu4Qdo
        3Po9XDsK+WDXRwMMPnm4Vw==
X-Google-Smtp-Source: AGRyM1t4Mw6kVtI+EzyL63IE/rpUMY/PA8D8Z57S4TVy7ZVABHlfY8+rPMcwlSBHTLSqzeTeseVjDQ==
X-Received: by 2002:a92:cbd1:0:b0:2dd:ab8f:ed15 with SMTP id s17-20020a92cbd1000000b002ddab8fed15mr9012529ilq.251.1659479909841;
        Tue, 02 Aug 2022 15:38:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h14-20020a02b60e000000b0033ebbb649fasm6918776jam.101.2022.08.02.15.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 15:38:29 -0700 (PDT)
Received: (nullmailer pid 758795 invoked by uid 1000);
        Tue, 02 Aug 2022 22:38:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-fsi@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux@roeck-us.net, devicetree@vger.kernel.org, jdelvare@suse.com,
        joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20220802194656.240564-2-eajames@linux.ibm.com>
References: <20220802194656.240564-1-eajames@linux.ibm.com> <20220802194656.240564-2-eajames@linux.ibm.com>
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add IBM OCC bindings
Date:   Tue, 02 Aug 2022 16:38:27 -0600
Message-Id: <1659479907.535740.758793.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Aug 2022 14:46:54 -0500, Eddie James wrote:
> These bindings describe the POWER processor On Chip Controller accessed
> from a service processor or baseboard management controller (BMC).
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/hwmon/ibm,occ-hmwon.yaml         | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/hwmon/ibm,occ-hmwon.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

