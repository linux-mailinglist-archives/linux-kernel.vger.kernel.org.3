Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76298473DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhLNHbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:31:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbhLNHbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639467084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wvde8CtsdQOjkstOijaK6Q9+B5YbfvaEIvbvn68jOk4=;
        b=WyXv/iy7e34y6ZW3lhgi8n1HolG9cqO5oj5nOaa8gJjrXycjPpk4DOPgof9i86+KGG7LRl
        +PMXEKoI6YGiPJySrgxdeNOqWHSiM3ZYVEEpoK+FgNSf5/zK/DXqfKdqCoEQzcAiegICUV
        hPWu4ICPVSQlU+U0TgKJsHj6YnOFnak=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-a8q4MS8tPPuNxGMtxDzS9g-1; Tue, 14 Dec 2021 02:31:22 -0500
X-MC-Unique: a8q4MS8tPPuNxGMtxDzS9g-1
Received: by mail-wm1-f69.google.com with SMTP id ay17-20020a05600c1e1100b0033f27b76819so10893309wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Wvde8CtsdQOjkstOijaK6Q9+B5YbfvaEIvbvn68jOk4=;
        b=TV7DNsOaiNOQLNbouacLV1+4pMEsdkR6UWsESP4mQiin6gcBoQUfFBteT2ZKIZIoL7
         wi9ZnA7/bQbNHieea9pndeJUxDr72Dzf/KU/Qkp4Vex/M7qLMSS1OZhzQHou2Q3sAJ2U
         kduu//Cyf+mxIwKvvqYG1hQcVxdmLxrL2Bue5EwqsrhCfz61r4JHSXH5zAOrNwWtZLlJ
         /DaD9vXb4PIuiRkQU4adXdZyJyl59Z4Rl+hZoF+6lB173CMUoBL64mhbeeiQHIYIsTwp
         fYyVnm4ObbprEsUAPcHiFX057Wh9HEdCr8Frr3a9SWQHl8RwF5sNx9v9yuhjencPQrmR
         yw+Q==
X-Gm-Message-State: AOAM530BC0vRi6YK3A++jVItXRdgIPnRGtcCl8i1o/Uhf3GzqZHAmt7H
        K3/EUqsch27V6dv9aZu8zemSGSM8qr2NzGXoYzhUcuOQb8K+qmeG6++UWoTW1aU8iHVdyqnyrTl
        BpHnyz2Zk0m2nMKh1OzBz0xw0
X-Received: by 2002:adf:e3d2:: with SMTP id k18mr3914101wrm.613.1639467081786;
        Mon, 13 Dec 2021 23:31:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoS2yYCD5fPkhBfLCW2zLO0P6DYXynlbqRFGcf1yOD6BOG0aAgVouySlP7VuX8fAhl+gHpNQ==
X-Received: by 2002:adf:e3d2:: with SMTP id k18mr3914078wrm.613.1639467081590;
        Mon, 13 Dec 2021 23:31:21 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id j18sm1457377wmq.44.2021.12.13.23.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 23:31:21 -0800 (PST)
Message-ID: <13f7887aed105b08901f9b71a3a00a67b7fa8303.camel@redhat.com>
Subject: Re: [GIT PULL 1/3] bcm2835-dt-next-2021-12-13
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 14 Dec 2021 08:31:20 +0100
In-Reply-To: <134050ec-c156-8361-7fe6-c4191f8c9873@gmail.com>
References: <20211213123040.184359-1-nsaenzju@redhat.com>
         <134050ec-c156-8361-7fe6-c4191f8c9873@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-13 at 19:38 -0800, Florian Fainelli wrote:
> 
> On 12/13/2021 4:30 AM, Nicolas Saenz Julienne wrote:
> > Hi Florian,
> > 
> > The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> > 
> >    Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-12-13
> > 
> > for you to fetch changes up to 5e8c1bf1a0a5c728cee2b6c2162348a9dfddf1bf:
> > 
> >    ARM: dts: bcm2711-rpi-4-b: Add gpio offsets to line name array (2021-12-13 13:08:04 +0100)
> > 
> > ----------------------------------------------------------------
> > Uwe Kleine-König adds offsets to GPIO line names array for better
> > readability.
> > 
> > ----------------------------------------------------------------
> 
> Merged into devicetree/next, thanks!
> 
> PS: please remove your older @suse.de email address from the CC list 
> otherwise people get bounces when replying to this mail, thanks!

Done!

-- 
Nicolás Sáenz

