Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B594A858A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350888AbiBCNub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:50:31 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42766 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiBCNu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:50:29 -0500
Received: by mail-ot1-f42.google.com with SMTP id p3-20020a0568301d4300b005a7a702f921so2597968oth.9;
        Thu, 03 Feb 2022 05:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=khn0J1hGAEdgTf0rLlD9FQl4Wvx4sGaRcMim5y9NL1k=;
        b=6v2fagG5lOut6gdt3sEIu27emYze0nCnPXxS6rzD7/FPAW/+41pU7e9ecmoTvJQQwS
         72yYbkQP4kNeXYmc5lcQ48V9NTqmeX0lryym0evEtnzeAUWyzz/zdO/gs2RUrpBWQYIE
         LrsBeJ2MGiprOCcLX9sMhPaoxxXl1k430lpwATsE1dI2JnX7EfMfyTwlkc4v5osF5M3Q
         z9z26O5joUG8jxs/9vv4QiAhuN3ZWWHzSzfFMRkB70cng5dYGULvm+cYPLDFCwZwPfSz
         7Wi0nYFTJcQhVE8C7ISFE9Ma5Leg3URimvguuZW1NtptOpbwEDoV0LWghvWNszWVI/CN
         KuzA==
X-Gm-Message-State: AOAM533GcPHSTVnBofT871boP8CU/ES6LnSJnBUld+olBl3iu10IdR//
        /IPyvEYAibGg2iTiGlOvOw==
X-Google-Smtp-Source: ABdhPJwKmyOWRZGgG04p/R4KZWXS9KHFic5PfhAh6Tfhysew+fQ5Xn3lrLECULCTnXJOMAVrI+cltw==
X-Received: by 2002:a9d:469:: with SMTP id 96mr19751529otc.342.1643896228509;
        Thu, 03 Feb 2022 05:50:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g4sm18959207otl.1.2022.02.03.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 05:50:27 -0800 (PST)
Received: (nullmailer pid 252331 invoked by uid 1000);
        Thu, 03 Feb 2022 13:50:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Lee Jones <lee.jones@linaro.org>, fedora-rpi@googlegroups.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220203002521.162878-5-cmirabil@redhat.com>
References: <20220203002521.162878-1-cmirabil@redhat.com> <20220203002521.162878-5-cmirabil@redhat.com>
Subject: Re: [PATCH 4/6] dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
Date:   Thu, 03 Feb 2022 07:50:26 -0600
Message-Id: <1643896226.729154.252330.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2022 19:25:19 -0500, Charles Mirabile wrote:
> This patch adds the device tree bindings for the Sense HAT
> and each of its children devices in yaml form.
> 
> Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> ---
>  .../raspberrypi,sensehat-display.yaml         | 32 +++++++++
>  .../input/raspberrypi,sensehat-joystick.yaml  | 37 ++++++++++
>  .../bindings/mfd/raspberrypi,sensehat.yaml    | 68 +++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
>  create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml:2:1: [error] missing document start "---" (document-start)
./Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml:2:1: [error] missing document start "---" (document-start)
./Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml:2:1: [error] missing document start "---" (document-start)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1587831

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

