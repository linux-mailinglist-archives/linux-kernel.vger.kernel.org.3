Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B388475B00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhLOOsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhLOOsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:48:37 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2346DC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 06:48:37 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id 14so30403320ioe.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 06:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=+zgw5ZjOiRsYG6plb7tjILNdpDgZuwxUtcBg9nx0kBw=;
        b=G0N2QMGAJIwsFDkwmDEBEjKwf1R6XUKF1dUDwwi84tqkOa9m9Ohji7eTuQ0FgAcPTM
         6VKh/Dqs/5t258JrxOF71MwUXyNrWciolgBI54inZh3e+xdNXan5JQN83qUCfKEU8C5k
         osfonV56+lDAkJGI759/fO/YVvbooOOakkEVlc8tsh10FR0hUpynpsgNu+kobAadJBqu
         U55Dl7oAvFHS5OA6h6DFTC1VuoYYyjdX53gR2GLrU5vot7cHv06TLWcs6vYoeuEFkEzV
         B/2DxpMSdy+olU5rye9gM7/P04zh/zfYj8E9Y6tHNxKsO92KFZUtWu3CEw2wpee98MF/
         w2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=+zgw5ZjOiRsYG6plb7tjILNdpDgZuwxUtcBg9nx0kBw=;
        b=nXbkOjdH65pJUUNgF0wzavO6X/VSeHy4QP5X3aP4lVCBxiC1hsKNUpQTeva2U+Rhcl
         k1JqP7XV2lyepEne9t/JEFvTRjmWXZ8lMnzn508YEt1F9DO6CrJ7Fi9zxrIyP5NCRSQ6
         G4k1CZn7LW8RM7aLCmf7SSShSWwez5WugMWF/9vFdFCVvPMvBbxUmPhKFGmh+bzlItgf
         z27ORGh3zXnl5mjNEc3RPLJtp6lQ/RDkZzkBKSlj31iezqUCF5VG7B8hFKBU/zMKa+GK
         rT4kTvX8c6mP62Yr5i1gDFPRtHRCj99k5iZaaYijrCILn5Tfaeijea3hhV0+whx3Jboy
         D6Nw==
X-Gm-Message-State: AOAM5333m9LMA6uHP/ol/iuzGEoNu39KpjURhDRotasPVBvcxOMOIWnC
        KVF2KOmFqP0jMBWAFBO+4FfX
X-Google-Smtp-Source: ABdhPJxSO1DISO3NqNKiKwUdNOAyJkKw7vT69WVU287cXCawI69TkejkGLA87llHTzGGTkdEoWzSeQ==
X-Received: by 2002:a05:6638:12d3:: with SMTP id v19mr5937331jas.318.1639579716471;
        Wed, 15 Dec 2021 06:48:36 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:2ba9:697d:eeec:13b? ([2601:281:8300:4e0:2ba9:697d:eeec:13b])
        by smtp.gmail.com with ESMTPSA id y6sm1023380ilu.71.2021.12.15.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 06:48:35 -0800 (PST)
Message-ID: <0a60ada80d4eb658d5ac249c9487ba759a94194a.camel@egauge.net>
Subject: Re: [PATCH v5 0/2] wilc1000: Add reset/enable GPIO support to SPI
 driver
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Claudiu.Beznea@microchip.com, Ajay.Kathat@microchip.com
Cc:     adham.abozaeid@microchip.com, davem@davemloft.net,
        devicetree@vger.kernel.org, kuba@kernel.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, robh+dt@kernel.org
Date:   Wed, 15 Dec 2021 07:48:26 -0700
In-Reply-To: <6f7ed239-a521-81f5-caaa-a24b537abcc0@microchip.com>
References: <20211215030501.3779911-1-davidm@egauge.net>
         <6f7ed239-a521-81f5-caaa-a24b537abcc0@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-15 at 05:37 +0000, Claudiu.Beznea@microchip.com wrote:
> On 15.12.2021 05:05, David Mosberger-Tang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > The only change in this version is to fix a dt_binding_check error by
> > including <dt-bindings/gpio/gpio.h> in microchip,wilc1000.yaml.
> 
> For future patches, here you should have the full changelog b/w version,
> something like:
> 
> Changes in v5:
> - this
> - that
> - etc
> 
> Changes in v4:
> - this, that
> 
> ...
> 
> Changes in v2:
> - this, that

Sure, I can do that going forward.

Thanks,

  --david

