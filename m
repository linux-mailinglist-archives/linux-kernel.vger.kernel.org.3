Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720E04715FE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhLKT7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:59:35 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:36708 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhLKT7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:59:33 -0500
Received: by mail-ot1-f44.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so13175587otl.3;
        Sat, 11 Dec 2021 11:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QPfcHLAovIoOflHgk4Ai+A1x1hZ1x5e8vE0/cIOANFs=;
        b=dfD21PpDacootpkNkN10jS2FzxXn5KGuuarKliUvMQBNtY9yAxwdVJlpXKwbnl3tbZ
         GR0p+Z99VDYEUitP9ttvs1jv5Kj952WHNsJH0nRYCsN13//bY0cAniZP6d5y3snDKLNV
         CBaXNIOtLOtcaonHAlfvEAXI4QxEmw2PVkbQxG4RTUwwiaXDvmNSYoDH4ezCCKc235To
         39OsL94BnjPRlKnsNzjNjat3+87WcgDVIFk61gywFmA85y64PusP42mD6GcZ7G/FlMHj
         gBm+3Bj74V46ByBSdltlG2FJmGoqXCAHv1jjDeEJ2+7QEBGe1MZyGdFciMd6oThHk/wE
         m39w==
X-Gm-Message-State: AOAM533ybuM5AiE+vBF6w4IsJsaS6cVuiWM38dWyQIP9NTZ4HCOJYFOA
        6JSsqLIWqfcDTqa5L54F3z8elEimiw==
X-Google-Smtp-Source: ABdhPJwQcaO7gNwT8rSD3SKfg90VmjK0dSIHk4htDtsUGW4+uvIPgmgBbO0n6tB9wy2fUoFWMVMMFw==
X-Received: by 2002:a9d:798d:: with SMTP id h13mr16754818otm.132.1639252772888;
        Sat, 11 Dec 2021 11:59:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z7sm1551241oib.0.2021.12.11.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 11:59:32 -0800 (PST)
Received: (nullmailer pid 3986889 invoked by uid 1000);
        Sat, 11 Dec 2021 19:59:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Joel Savitz <jsavitz@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mwesigwa Guma <mguma@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Mattias Brugger <mbrugger@suse.com>,
        fedora-rpi@googlegroups.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211210221033.912430-5-cmirabil@redhat.com>
References: <20211210221033.912430-1-cmirabil@redhat.com> <20211210221033.912430-5-cmirabil@redhat.com>
Subject: Re: [PATCH V5 4/6] dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
Date:   Sat, 11 Dec 2021 13:59:31 -0600
Message-Id: <1639252771.082209.3986888.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 17:10:31 -0500, Charles Mirabile wrote:
> This patch adds the device tree binding
> for the Sense HAT in yaml form.
> 
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  .../bindings/mfd/raspberrypi,sensehat.yaml    | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml:2:1: [error] missing document start "---" (document-start)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml: properties:interrupt-parent: False schema does not allow {'items': [{'description': 'gpio pin bank for interrupt pin'}]}
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml: ignoring, error in schema: properties: interrupt-parent
warning: no schema found in file: ./Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.example.dt.yaml:0:0: /example-0/i2c/sensehat@46: failed to match any schema with compatible: ['raspberrypi,sensehat']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1566669

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

