Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96D4B52F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355015AbiBNOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:16:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355021AbiBNOQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:16:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB5BC72
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:16:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q7so27010803wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kgQHfexaQuoUShSlLQPKVWrC/gt5SJSd7Yg7kgOgPDA=;
        b=Qar0O4VfTdm4BhCSDsumsP2Z0/NBPGBQXdxkXe6L8qV9ranTdvuer5MbywUm3O7Dzb
         9CbG2dZ46gKZiwzl1lTTQewq6TUEKA0sQzf9FZ34F1rCKzIDaA+aPYvWHiXaj9xlX4e/
         0Td6Dz4v9tLVZUc0SDAFeMmBQeYXoE0VzGwV6ePXCPoBJ4eKhATYyNml6yjcU/QJiMlR
         t7V3IpMTuW2bWnDsE6eLE/ERLls3LmxfJ5u5XElFkvdcEbwqqUYF47uwjcNjjuls7RIy
         pV2P7/7czjqcSJtzeaeC/xmW4t5V7NCUS3H1b2sPO88Oj4D+0dKCRm3xNPhwZJtT4tNk
         zTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kgQHfexaQuoUShSlLQPKVWrC/gt5SJSd7Yg7kgOgPDA=;
        b=pF9b2df4KOdLDuuY452a7uxYkkojzJejDIijrMSKGT9ANeMZHC22xrPCMdQneswjfw
         ajDRs36wq1qwDEeHDowXsUfsB5FaxTeGwZEkqgKjyOevBRKecrSp73jO7e/qs6L9Jcmy
         gnpGRC8teYJ4hs79nvXRWWq8AVmHKGMUR9E5UEw7LmSD25XiH+QHhr6lHnh9bOF8EVVn
         jBjkiALNQuAtba1LvseWvz/xQCOo9FXrSvyV0KRMffT11d0LYaWVsnRNbF7glPBn46S/
         GiBwGNKiTr3/6djYjNxtBqaKfmVMaGFpWWrhplSxx6YAi00kYSLQAjrq5kiq2jruzoOe
         Mkkw==
X-Gm-Message-State: AOAM533fNHrB/fX3LwUusDMcTd+aZzidm+KFCpYWqmCPxE/CwnmTt3UL
        ycKSr1tRv0dPOuJKCUJHf/S/JcYyfX/kNg==
X-Google-Smtp-Source: ABdhPJy7afZw39K6dXfik9BXiNDpeFayVD89osPiAt5JUbelWGzKm2KIokkvj0G/ptPA15p6XaVQWw==
X-Received: by 2002:a5d:6b90:: with SMTP id n16mr11641080wrx.558.1644848194706;
        Mon, 14 Feb 2022 06:16:34 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id q13sm29865253wrd.78.2022.02.14.06.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:16:34 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:16:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] MAINTAINERS: add myself as a maintainer for the sl28cpld
Message-ID: <YgpkQMbhWAJG6oCh@google.com>
References: <20220207184652.1218447-1-michael@walle.cc>
 <YgpkCyoSMg5RYfkO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgpkCyoSMg5RYfkO@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, Lee Jones wrote:

> On Mon, 07 Feb 2022, Michael Walle wrote:
> 
> > The sl28cpld is a management controller found on the Kontron SMARC-sAL28
> > board for now. Support for it was added by me quite a while ago, but I
> > didn't add a MAINTAINERS entry. Add it now.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> > Hi,
> > 
> > since this affects so many subsystems, I'm not sure through which tree this
> > should go. I'm sending this to the arm soc maintainers because it's an
> > aarch64 board where this driver is used as well as Lee as the MFD
> > maintainer.
> 
> I'm happy to take this, if it pleases everyone.

Hold on, you're not going to get many Acks if you don't send it to the
other subsystem maintainers. :)

> >  MAINTAINERS | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ddcee331dc09..c14209168ce6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17762,6 +17762,21 @@ S:	Maintained
> >  W:	http://www.winischhofer.at/linuxsisusbvga.shtml
> >  F:	drivers/usb/misc/sisusbvga/
> >  
> > +SL28 CPLD MFD DRIVER
> > +M:	Michael Walle <michael@walle.cc>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
> > +F:	Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
> > +F:	Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
> > +F:	Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
> > +F:	Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
> > +F:	Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
> > +F:	drivers/gpio/gpio-sl28cpld.c
> > +F:	drivers/hwmon/sl28cpld-hwmon.c
> > +F:	drivers/irqchip/irq-sl28cpld.c
> > +F:	drivers/pwm/pwm-sl28cpld.c
> > +F:	drivers/watchdog/sl28cpld_wdt.c
> > +
> >  SLAB ALLOCATOR
> >  M:	Christoph Lameter <cl@linux.com>
> >  M:	Pekka Enberg <penberg@kernel.org>
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
