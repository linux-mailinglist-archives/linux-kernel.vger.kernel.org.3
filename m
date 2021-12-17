Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD90C478ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhLQPB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:01:26 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:44560 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbhLQPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:01:25 -0500
Received: by mail-ot1-f43.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso3141944otj.11;
        Fri, 17 Dec 2021 07:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vm+0KOiQ/cdorWbjPQlF8P1R3w9VNGME1PIo6ZZG+U8=;
        b=TDK5m2IDRN3wtjyZJrbwgYFtIVWGYGKg9oIcwLmDzdqbcKT2ReV/046GF87dEzh3TO
         qoe7ZXWxxfeS1doX608T6Vv4+QJ8hvNSpkkEKwYxj6oHILs82hi5ZkKyxmnOVlomwsR6
         tJhNRmLQGhOdV5t/5WOZzZ1jkNIwDUveqH5YVwtKXVmfOUnlqb/C9MAHZ0P1thZDfOY2
         1hEKvfPRj5vPs+O5VZTYif+6EKkqj1WKgwPVxP54XiCOvaH+/dJ39EfKH/q7rWN6zBp5
         AftGpKbVi/XPZCTowJhddMHPkozJy7HiacSB7tqNhEg5nn5m6h/hMFOJU+5BZ1+OI+fJ
         fRrg==
X-Gm-Message-State: AOAM5323jmkchN5XAhdfFSG9SoHjP/BkUSiVZXi84BAgxtQY+Ct2Cytm
        NSC1yLcXGnoehaqAwImfjQ==
X-Google-Smtp-Source: ABdhPJypwUInHv0Sczfg930N0JXh7v1ALIjDDA9QoZLIlYOznNwSV7sDgy4zD1VhjO/AGwJcFHxrKQ==
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr2433115otq.173.1639753283553;
        Fri, 17 Dec 2021 07:01:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x4sm1705576oiv.35.2021.12.17.07.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:01:23 -0800 (PST)
Received: (nullmailer pid 2884236 invoked by uid 1000);
        Fri, 17 Dec 2021 15:01:22 -0000
Date:   Fri, 17 Dec 2021 09:01:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v4 5/6] dt-bindings: bus: Convert GISB arbiter to YAML
Message-ID: <YbymQpEBpk8F2B/3@robh.at.kernel.org>
References: <20211217042001.479577-1-f.fainelli@gmail.com>
 <20211217042001.479577-6-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217042001.479577-6-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 20:20:00 -0800, Florian Fainelli wrote:
> Convert the Broadcom STB GISB bus arbiter to YAML to help with
> validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/bus/brcm,gisb-arb.txt | 34 ----------
>  .../bindings/bus/brcm,gisb-arb.yaml           | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
> 

Applied, thanks!
