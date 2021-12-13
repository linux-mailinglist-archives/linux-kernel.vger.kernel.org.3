Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDFB4732B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbhLMRJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:09:39 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40830 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhLMRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:09:38 -0500
Received: by mail-ot1-f46.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so18126849otj.7;
        Mon, 13 Dec 2021 09:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Khqyj9+xFHnDhGPLfNWmudZatAboa3V2EmaSyE9HE7Y=;
        b=gPAmvxMt/rWRzDer8uRGdqhUi+tgqXw/9to8cttpxrHv0jPmq/H++6U5BLVCJYLUeL
         dyvXXVePdRoH8Q38ihLD2Nt//7epE/HnSHtBGIp6vbYssscOQRr9elhRa4cjeR7VNwAi
         NjQ0sA0NQ5mn4P0dq6EK+TnFvWc7BORoWM9vlafVCiqXvwzGh5J2v8hhKYm+/surIqeC
         5m1zuTZqtrBY7gQSVXui0ewPLKy6AhHYXSiPg4Yb+xH3IEP7HD6WDaWwIPWlSsGhskXW
         GHpwOjm3zJVwsIGZ0CkltITVXllSkh00Q5NZrrEMJA7WKCIagtU20b9vdLjasSg6VZEb
         nn9A==
X-Gm-Message-State: AOAM533IC4N7K2oKNWp6vjh/kjz1hfxHOM2gq98SMFUgvQVT4cMCtCh6
        s3Kxo44dZ6w7xMaQ3aBLiQ==
X-Google-Smtp-Source: ABdhPJwV9qEV6md/3Y95g+sLGR4YSSHkJTcciZhVQR9Bjhf8LtgjwsbYS4xQShKB76+lTOusFVzNHQ==
X-Received: by 2002:a05:6830:4195:: with SMTP id r21mr25783740otu.33.1639415377888;
        Mon, 13 Dec 2021 09:09:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c3sm2895662oiw.8.2021.12.13.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 09:09:37 -0800 (PST)
Received: (nullmailer pid 1211602 invoked by uid 1000);
        Mon, 13 Dec 2021 17:09:36 -0000
Date:   Mon, 13 Dec 2021 11:09:36 -0600
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
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 4/6] dt-bindings: mfd: sensehat: Add Raspberry Pi
 Sense HAT schema
Message-ID: <Ybd+UKPH53hkeNcV@robh.at.kernel.org>
References: <20211210221033.912430-1-cmirabil@redhat.com>
 <20211210221033.912430-5-cmirabil@redhat.com>
 <1639252771.082209.3986888.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639252771.082209.3986888.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 01:59:31PM -0600, Rob Herring wrote:
> On Fri, 10 Dec 2021 17:10:31 -0500, Charles Mirabile wrote:
> > This patch adds the device tree binding
> > for the Sense HAT in yaml form.
> > 
> > Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> > Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
> > Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> > Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > ---
> >  .../bindings/mfd/raspberrypi,sensehat.yaml    | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml:2:1: [error] missing document start "---" (document-start)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml: properties:interrupt-parent: False schema does not allow {'items': [{'description': 'gpio pin bank for interrupt pin'}]}
> 	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml: ignoring, error in schema: properties: interrupt-parent
> warning: no schema found in file: ./Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.example.dt.yaml:0:0: /example-0/i2c/sensehat@46: failed to match any schema with compatible: ['raspberrypi,sensehat']

'interrupt-parent' is not needed as it is always valid or could be in a 
parent node.
