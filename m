Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672F24ACB88
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiBGVpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiBGVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:45:22 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776D0C061355;
        Mon,  7 Feb 2022 13:45:20 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so11895701otf.1;
        Mon, 07 Feb 2022 13:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RTR0nFrp3s4BqIEjNWo3YoJyTs4shL49W7ioqon6aOI=;
        b=ppQlB8a61ujPHJoRjtEC0kDnXAs36iTrS92dFAwmFhkBWu1gqzTgn3K9e0zByUESpu
         zpweDvyKK/xkKOjRP3pLUPWMGI3bKLQYZ4Wz7bara2ziD3QYlExx5natURxAJ3IPJDRn
         FhWm70I4O0of1kagvsIfd5bsVG8sGM1quYch95YKDY27+CE3+SAxDI8fVR5/z6f7Y1Al
         LBuRJl8X9GDHavmozvMHHAv+PITCuKxGgD/warwUfckszih5SbI15jXPRPbdKaxg/RPM
         AI+enlNbpY/7fZ6E/+Su+GhysU7jq5dT7KEj2gchzAZb8X69yudp2N84q0Y14cAFkCK6
         QaOw==
X-Gm-Message-State: AOAM53169+pEO2y44ufZ9G0n01Sl/y94cnZVBIwgOuahsyH3QPXFg/0D
        JbCUvz2Ty43bZig9LunRCQ==
X-Google-Smtp-Source: ABdhPJxLdm3APhJ37DTFNGxqX95hogQIoqUwXlXstkPJI3BHIac1nI2rUdV08uKnk1cUk3SKliVRVg==
X-Received: by 2002:a9d:6f8d:: with SMTP id h13mr712005otq.309.1644270319682;
        Mon, 07 Feb 2022 13:45:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h9sm4542956otk.42.2022.02.07.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:45:19 -0800 (PST)
Received: (nullmailer pid 977724 invoked by uid 1000);
        Mon, 07 Feb 2022 21:45:17 -0000
Date:   Mon, 7 Feb 2022 15:45:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: interrupt-controller: stm32-exti:
 document st,stm32mp13-exti
Message-ID: <YgGS7YkSl+hGKx/1@robh.at.kernel.org>
References: <20220202140005.860-1-alexandre.torgue@foss.st.com>
 <20220202140005.860-2-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202140005.860-2-alexandre.torgue@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2022 15:00:03 +0100, Alexandre Torgue wrote:
> Support of STM32MP13 SoC implies to create a new compatible in order to
> manage EXTI/GIC mapping changes.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
