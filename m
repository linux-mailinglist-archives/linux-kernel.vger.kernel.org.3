Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D74470C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhLJVPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:15:53 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36669 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhLJVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:15:48 -0500
Received: by mail-ot1-f46.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so10906373otl.3;
        Fri, 10 Dec 2021 13:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0hJgzETDIdKVM7uHj3dj5GcAkRRZ6sKwa6wgFkGEWGA=;
        b=c5bKv+icEN9xwJPmAW0XPYcnaIRb8PTHIRf/R5jss89eSqIbi060On2yYwtrPnOfvB
         8CoxzX6zYHYtOSNFcfjXAW16eVgBe3xYjgeqgWMT5ZuSARKSFdjMJEvlf9keBBsH+Auz
         JMW+7tAClSFQ2N/WbjnX4NFoKGXWkTHeRnsSEfjfYxT4qGSBDey+uDce9D7rPKGgRM/L
         DwKSolDns/GXNgmHqrARanXTVlzCSlCXPY/WL0F8ulQgW0NkBosQFWT9rG/J602Nol9A
         kkK3GSwQ4o1tcl9rVnA8s2qWt0z+zGyw1diwq3RuRuh5cqSGQ8xFj3mRG6xYb+vJVA7G
         eLSQ==
X-Gm-Message-State: AOAM530H1rZCEFujwQtFXaJE7Prl/rCmUKEsdjhxVVHMsOf2kvjibnfJ
        uSah/8o7cBifj4ZqiW+V+ofGWvTsNg==
X-Google-Smtp-Source: ABdhPJwjCSZ1SBdQUyVJrnEL1oj0zInKeF/peJSbc/ZqiK4fpnwzu2V5o7tVpmzmRIsAPFtWIiRTMA==
X-Received: by 2002:a9d:2085:: with SMTP id x5mr13169150ota.228.1639170733015;
        Fri, 10 Dec 2021 13:12:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e16sm739611ook.38.2021.12.10.13.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:12:12 -0800 (PST)
Received: (nullmailer pid 1906126 invoked by uid 1000);
        Fri, 10 Dec 2021 21:12:11 -0000
Date:   Fri, 10 Dec 2021 15:12:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     support.opensource@diasemi.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, festevam@gmail.com
Subject: Re: [PATCH v5 4/5] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
Message-ID: <YbPCqz2ON5HgdEnK@robh.at.kernel.org>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <20211206064732.280375-4-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206064732.280375-4-andrej.picej@norik.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 07:47:31 +0100, Andrej Picej wrote:
> Document the watchdog timeout mode property. If this property is used
> the user can select what happens on watchdog timeout. Set this property
> to 1 to enable SHUTDOWN (the device resets), set it to 0 and the device
> will go to POWERDOWN on watchdog timeout.
> 
> If this property is not set, don't touch the WATCHDOG_SD bit and leave
> the configuration to OTP. This way backward compatibility is not broken.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
> Changes in v5:
>  - no changes
> 
> Changes in v4:
>  - no changes
> 
> Changes in v3:
>  - add note about using the default OTP setting if this DT binding is
>    not specified
> 
> Changes in v2:
>  - new patch, document new DT binding
> ---
>  Documentation/devicetree/bindings/watchdog/da9062-wdt.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
