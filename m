Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C20478ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbhLQPA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:00:28 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42779 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbhLQPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:00:27 -0500
Received: by mail-oi1-f180.google.com with SMTP id p4so3945102oia.9;
        Fri, 17 Dec 2021 07:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gj1+YCrvjagMZfZ2hlaDMtS0ue6pd0IPHkIateaFnXc=;
        b=egc+oviAkzUDvTjH0Ct1s0LwZEBGlc0blg8ebSb05V7fgKZK2UWLhL9RIN6lCLfxtE
         lQu5/5qphWxmAEW9gt5rikhH0KT53EVwy+SfUR/iEBXPQNyoQ0mxMZOIu5EmIUHaBBwj
         aON7LGvcOpDIk0bnRoQtHWDnGQ4KFAJr70SBkI8UltnbSUW7DBlwziRsuYNeT1AQFeMj
         fJIQc4Gn9M+o2WXBlu1JPdQiUiH89oc3DIvXR8uD4WwRRc4WF0y1quuWJA82s7xuiP3v
         bCFuHcODpC2C46K38j3DX8AclQM+zGfuw91eFJHobhFPnIFsE+muSSPXuUtUatMd7+49
         w0uA==
X-Gm-Message-State: AOAM532DhsaSgn35SnJJYOZpXto9D96tsL9+pKUd2TZxrQJGUohRV18t
        EGOmWh0q3WJBGTgreiadL123W4uDOA==
X-Google-Smtp-Source: ABdhPJyxF8MIKKhouuSw5bmg2S1qo4tkS+gWPoAwkO1+xjcuIa5GdJGlMJFOkzd07KICvV56iZ4jNg==
X-Received: by 2002:aca:230b:: with SMTP id e11mr8164558oie.22.1639753226553;
        Fri, 17 Dec 2021 07:00:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id be12sm1797328oib.50.2021.12.17.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:00:26 -0800 (PST)
Received: (nullmailer pid 2882466 invoked by uid 1000);
        Fri, 17 Dec 2021 15:00:25 -0000
Date:   Fri, 17 Dec 2021 09:00:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Al Cooper <alcooperx@gmail.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ray Jui <rjui@broadcom.com>, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Scott Branden <sbranden@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/6] dt-bindings: ata: Convert Broadcom SATA to YAML
Message-ID: <YbymCeT0zYH+OiH2@robh.at.kernel.org>
References: <20211217042001.479577-1-f.fainelli@gmail.com>
 <20211217042001.479577-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217042001.479577-5-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 20:19:59 -0800, Florian Fainelli wrote:
> Convert the Broadcom SATA3 AHCI controller Device Tree binding to YAML
> to help with validation.
> 
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/ata/brcm,sata-brcm.txt           | 45 ----------
>  .../bindings/ata/brcm,sata-brcm.yaml          | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> 

Applied, thanks!
