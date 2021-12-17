Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61679479719
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhLQW2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:28:14 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42621 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhLQW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:28:13 -0500
Received: by mail-oi1-f175.google.com with SMTP id p4so5691537oia.9;
        Fri, 17 Dec 2021 14:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oy9ynnGy4whY6EBqSRstAqc45+euDKF4+pC9GX/4BXs=;
        b=Gb6OHycm4nZihTCf0KxrOs740ZOOEdLZyChylO9TJxt4U12NhwcQYqPYikf+DZpnZY
         WyaxXSQ//T4e4kd6vj8sOkf639vPhK8Dlkd5TDB+eKZcfbnsDC5JAClrdKfsdxZIoA0D
         PmepwPMk7UNOiC1K+vk55QsT5yDv9MDJ82ECLHu6mODCrRg5QTGTHxMXE7wCfVYlHSPJ
         DTBWAQwt2zD3NmAeiICHYXiG9+5GjX8FyirmVkwD+a6MNNWEOwYhBvyKO0k6F3NPPI4D
         r1tGxp/6Fz/jp7sCbrxYM0hV8matHZK9OTH1N0VQFVn5MU0UbOX0QzzPtDWARR00LdQ1
         CnRw==
X-Gm-Message-State: AOAM530mqo7aUYEw7s3YpeI2WouI2yBFn0b5SilkuLWm5Be+fFHAw269
        MN3vFm2S3k3ifqFadCyK6w==
X-Google-Smtp-Source: ABdhPJwlsYxGfa1AkrtvMTj870rRm62U72cdIXe+xbuPtfbgEuKhRH9cvsMXxaFaKqWbBOqikIDd/A==
X-Received: by 2002:a54:480b:: with SMTP id j11mr3796414oij.102.1639780093236;
        Fri, 17 Dec 2021 14:28:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o6sm1781611oou.41.2021.12.17.14.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 14:28:12 -0800 (PST)
Received: (nullmailer pid 3693043 invoked by uid 1000);
        Fri, 17 Dec 2021 22:28:11 -0000
Date:   Fri, 17 Dec 2021 16:28:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 1/2] dt-bindings: interrupt-controller: Convert
 BCM7120 L2 to YAML
Message-ID: <Yb0O+3EDUJnFvJGR@robh.at.kernel.org>
References: <20211217160546.497012-1-f.fainelli@gmail.com>
 <20211217160546.497012-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217160546.497012-2-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 08:05:45 -0800, Florian Fainelli wrote:
> Convert the Broadcom BCM7120 Level 2 interrupt controller Device Tree
> binding to YAML to help with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../brcm,bcm7120-l2-intc.txt                  |  88 ------------
>  .../brcm,bcm7120-l2-intc.yaml                 | 126 ++++++++++++++++++
>  2 files changed, 126 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
> 

Applied, thanks!
