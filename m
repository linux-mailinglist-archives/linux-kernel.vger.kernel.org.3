Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC90478EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbhLQPE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:04:26 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43805 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbhLQPEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:04:25 -0500
Received: by mail-oi1-f170.google.com with SMTP id w64so3963085oif.10;
        Fri, 17 Dec 2021 07:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vAlEDIiSuhbqkj9T2K1Mncm8D6+1tTAwxfTUCDC4sCk=;
        b=c0d/1k2Sz/PXdWLLnP6fRv+HamIt1+H4uYrMMw8usvOvlCXMttFwTiiyXwGwzDNs++
         lcXGbk49+zhUUdf+wGaNRPP5EMGH/fXo0Lyf1Gk7q2v+W0t2fEsjOvlFwiW7CoLOsCJU
         pq6DdqqVTUHm3WMeyN2lSfcaE8CecimEPo+Z65UP/xxl29mELT3TmXc29/WzdgCQ0elc
         FQ0Mc0Wt8uQh+rsHwvHjTpKKJrIFG1sFkKJPjmxVWT54z+oFGznTy2NiqiYq/dw/fAyh
         jei98M1gv8wOY2eCfab26aXT8pudytmPwkKK+oFAKIbzXO0bOg0E0ZT4PDOetgN3LHzK
         LNDA==
X-Gm-Message-State: AOAM530KwlqoFuHxfGFbPsGcQ6LKnLzK6a+rZ8qJ2aYg1YQZc8MZ5agw
        hVbrKABq46R/C6ge6ezMEQ==
X-Google-Smtp-Source: ABdhPJywY9+tWSe0QAH9R5izM1TehP2QFOHQ7YkJV/EcV1cTInKEFsym0ieNZyS6e1meAK8UTXKqlw==
X-Received: by 2002:a05:6808:1c5:: with SMTP id x5mr2351401oic.144.1639753464281;
        Fri, 17 Dec 2021 07:04:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y17sm1683388ote.48.2021.12.17.07.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:04:23 -0800 (PST)
Received: (nullmailer pid 2889574 invoked by uid 1000);
        Fri, 17 Dec 2021 15:04:22 -0000
Date:   Fri, 17 Dec 2021 09:04:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-ide@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-arm-kernel@lists.infradead.org,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Marc Zyngier <maz@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-usb@vger.kernel.org, Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH v4 6/6] dt-bindings: usb: Convert BDC to YAML
Message-ID: <Ybym9mlMZjtt9zZ4@robh.at.kernel.org>
References: <20211217042001.479577-1-f.fainelli@gmail.com>
 <20211217042001.479577-7-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217042001.479577-7-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 20:20:01 -0800, Florian Fainelli wrote:
> Convert the Broadcom BDC device controller Device Tree binding to YAML
> to help with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/usb/brcm,bdc.txt      | 29 -----------
>  .../devicetree/bindings/usb/brcm,bdc.yaml     | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 50 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.yaml
> 

Applied, thanks!
