Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDB5484A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiADWQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:16:10 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37377 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiADWQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:16:08 -0500
Received: by mail-ot1-f51.google.com with SMTP id 45-20020a9d0a30000000b0058f1a6df088so49012453otg.4;
        Tue, 04 Jan 2022 14:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SuGukoNPooesabXeAdaxQqSV8RWg79OHbj9bSw0hpC0=;
        b=kPtFWgAEC1SvnWk4mz+kk6TT42+mhR8xw7oYli4Hndooqqe45/jWeIJppwneYWMyQq
         5HFrIvy/ykG6NWaToK7zIDHE6fiJ8l5jRbaIoKtQH46VVdhKB8+8lj8TAudI8u/obii3
         3xImcy6nkPzD7z4i53IqLp2zV/Y58aFzPlRQ7s2Vp0BazztIjjKWzWkkJMCp5sGpHf2z
         I4YLhYn+gAt0GtiiFItYpRSVO7uQ0Z9DNlUzXmsX5kLGwly2krtfrDEsSdZpNKq1BO/J
         9VCNaW9YPUsKGJGmpI+cpxgXFungAdr/vTGn+nvjOEV0JJArmZwf97sGVUHG76rpM/gu
         eHSw==
X-Gm-Message-State: AOAM531B9sGIkSqbifLaof+VZ/JvBkkVx79SbhwFlDznAZAPv60uaXU4
        RhbXD5NW4/388D7DTE5S+g==
X-Google-Smtp-Source: ABdhPJyWWBdwDhHOY9YQSLSHOZtAKoY0iHLxicl58vShawhYSkoTxM6Cv6OfDigF8mP+BC5iYta/dA==
X-Received: by 2002:a05:6830:4094:: with SMTP id x20mr37291654ott.53.1641334568149;
        Tue, 04 Jan 2022 14:16:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x4sm10126613oiv.35.2022.01.04.14.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 14:16:07 -0800 (PST)
Received: (nullmailer pid 1540165 invoked by uid 1000);
        Tue, 04 Jan 2022 22:16:06 -0000
Date:   Tue, 4 Jan 2022 16:16:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add Qualcomm TCSR registers
Message-ID: <YdTHJrqjt5IPhoM2@robh.at.kernel.org>
References: <20211225140708.22000-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211225140708.22000-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 03:07:07PM +0100, David Heidelberg wrote:
> Qualcomm devices have a set of registers that provide various control and status
> functions for their peripherals.
> 
> Modification:
>  - dropped "qcom,tcsr-ipq6018", "syscon", "simple-mfd", since it's not
>    used anywhere.

There is about to be. See: 
https://lore.kernel.org/all/b5053b42f73e574f48cf860a8e225d6b1939d216.1639499239.git.baruch@tkos.co.il/
