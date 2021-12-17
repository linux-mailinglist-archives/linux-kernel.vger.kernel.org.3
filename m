Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE044790E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhLQQCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbhLQQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:02:33 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B863C061574;
        Fri, 17 Dec 2021 08:02:33 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso4475705pjc.4;
        Fri, 17 Dec 2021 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gd9e5lJ9Xdrc0uDZFZ9we4a9UNXcjMLY1IV8r6XooqU=;
        b=P/SaAriho7iCKhklzAF4N3rcbn4BTbLLOyk3nzchMsmBlnbpMzJP/FOTJNjiI86sef
         T08XFDuGp7bGGrDGN7kWELynyg4wRP/M3xZR4ARCh5oWH7gBo+vzM/pxJ7D/R4nFhl/y
         G//DWFZ6SI5FgPsRnGqGHtzwgaokBklcycF6NBUmsBwBeVCLEzQccEsreR6Mq5BQQEtz
         5BbxhzsYuNmyQrxnztH+FwGXlP8JvKwFhJbTBGggTIwsMqITcFN7vWjWy3X+0A/hlIel
         gcBztKtrVXpdisq6XPqJviDcSM3CsZz6SysItEShUAQf+HJB/dmZkI0x29HqKrcqan4A
         ECIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gd9e5lJ9Xdrc0uDZFZ9we4a9UNXcjMLY1IV8r6XooqU=;
        b=pG43LPfCIRCdWtSYfg//NDxbPOdvxAAYInLSWJVQt+lezSYTIhibmSoLuktk8hRhEx
         03MO+dDz6AlCET9Y6rNiiBm6EA+jtmOHNZbQUGoxzidAPHLIc7kZziGKZuYxjoy3rszv
         6/zl2x3J5ws2M3kel9HoIDQGRekq/9WAcSuAMss8GotMlJ8h7B3R9ddHpuCTL3EaXIP3
         ITWmfhNvY6hd4+L8CRExM8/6OWk8KsiSdmgxLqMlA/LkpK4uPc4PfeHoVlZamG5dzeWd
         +dL2aNtQt+b1ceCJWlXeTfjPFHe83X31F1Locl+l+qdhESrWLIXXGhjDHPIBnDQlJpGe
         61Nw==
X-Gm-Message-State: AOAM5310opaz1yRGS5Y8fEtFOx94yWyWeBMpP9pgPQpuQsqSPU0DfiVJ
        9aK6s9M+4XDnPdBiKXYm6Ro=
X-Google-Smtp-Source: ABdhPJz+DvgJl6fTwktZZBFCFPYBoNTGmMphKjTjgzXookL36RCV9ukcFuP5K0oNcQ1NRbvXr50XDw==
X-Received: by 2002:a17:902:6b47:b0:142:82e1:6cf5 with SMTP id g7-20020a1709026b4700b0014282e16cf5mr4125468plt.28.1639756952578;
        Fri, 17 Dec 2021 08:02:32 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id f21sm10691482pfc.85.2021.12.17.08.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 08:02:31 -0800 (PST)
Message-ID: <23798061-647f-85fd-8e8e-fe50db09599e@gmail.com>
Date:   Fri, 17 Dec 2021 08:02:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 3/6] ARM: dts: NSP: Rename SATA unit name
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
References: <20211217042001.479577-1-f.fainelli@gmail.com>
 <20211217042001.479577-4-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211217042001.479577-4-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2021 8:19 PM, Florian Fainelli wrote:
> Rename the SATA controller unit name from ahci to sata in preparation
> for adding the Broadcom SATA3 controller YAML binding which will bring
> validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to devicetree/next!
-- 
Florian
