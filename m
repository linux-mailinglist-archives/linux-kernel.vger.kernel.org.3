Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03853477D39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbhLPUPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:15:48 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34394 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhLPUPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:15:47 -0500
Received: by mail-ot1-f46.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso308658otj.1;
        Thu, 16 Dec 2021 12:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gnZ2FBw98i/ACm5Oz2lt4Y7quKT4nxqXJ+lm8AP+1O0=;
        b=GnTlnwkWh+474VidzngNcIs9cQpYEtXqjLHZZm/nwQe/nxUr9lAN5N6OEWRMTy6gZv
         hzu0BofV2Sa4Ius56e4kt+Y6JmMa2CqmZyOxM7bNOT1zBVWWStp/E4pJphX13BtyDMzd
         Ya4sF6DZSKgGmjgj09giYvxCaJHQ6rshYyx+TXZuFv3YxIpQOsla2Q8n14rK76OTROCV
         IO4nUP26EjVIepleYi6jaxOSsrgrOl2GLyE7ujHLUXfPdzeDO8jMmRswH6ngXiCBFAYb
         vhsf4BWYz6TzUtD7cYqp7sDowh8zYJ0bmlrJPT54Ap+RKAuidQQyM098FfYgZYlIBa3g
         UhEg==
X-Gm-Message-State: AOAM532iiuWpkUZHGxV+Fi82tGVoKErYEoHCj9jQ+NZO3mv98wmzst3t
        I3rlgSGGGHxP5lmN4fb+Fw==
X-Google-Smtp-Source: ABdhPJySK6rf6Rcp4m3frEmeBIfJFU98tfB1Ohx58HPIMFdOnSgnDvtOpeqqOegdtB4lfWkjYj/zfg==
X-Received: by 2002:a05:6830:1281:: with SMTP id z1mr13987300otp.230.1639685746879;
        Thu, 16 Dec 2021 12:15:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh12sm1188906oib.25.2021.12.16.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:15:46 -0800 (PST)
Received: (nullmailer pid 682135 invoked by uid 1000);
        Thu, 16 Dec 2021 20:15:45 -0000
Date:   Thu, 16 Dec 2021 14:15:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] dt-bindings: interrupt-controller: stm32-exti:
 document st,stm32mp13-exti
Message-ID: <YbuecSGljX4Zzso+@robh.at.kernel.org>
References: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
 <20211215105847.2328-4-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215105847.2328-4-alexandre.torgue@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 11:58:45 +0100, Alexandre Torgue wrote:
> Support of STM32MP13 SoC implies a new EXTI-GIC mapping.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
