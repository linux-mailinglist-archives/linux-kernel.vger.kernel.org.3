Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0208948BC25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347487AbiALBEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:04:50 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44745 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbiALBEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:04:50 -0500
Received: by mail-oi1-f170.google.com with SMTP id s9so1386905oib.11;
        Tue, 11 Jan 2022 17:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LT4eYtjNvaxTTtUHWccUaSbJL5qAtxfDk/8iLK1em9Y=;
        b=u0BZ0eXdAdmE0kRpvZYUz4kPvjyTWJgUl3Tm6SL39CWqOSLmadKkfQpb0YIlnf6tVz
         0EZEDRkKuT8IZiyLuvjTghIjokWvnVQ6P4OhIDVZR488YYDU7uTRWp5sjXpAnSRb4UT6
         /wTTmjLBXGmxcsh1B7Jz/jOfseL/OMg2pgNvS9dMKZM59Q0250QgD0BGy05x94CzS3He
         PeQ1BKRQ/Lp8BqMdYcBWnqYJ1gsDpyYmOt3Nzo/3qxSwKMtU7yzos2oB6aTyy2YAWktW
         fhMhX7EmxQZlUaj4QQMYHjhNzyEbpN5d3jtRTIao026/W+VOSb5qcmkMDDj8XhslRKwu
         4YAQ==
X-Gm-Message-State: AOAM532bDmrZVbZDDvYnhoGFxxt4A4h3GFB+On4/hncegxmnS7ZatoYb
        +Hst1agi+tyF6DHw+1aS7g==
X-Google-Smtp-Source: ABdhPJxVywseiwdmHTe/HKrNCqPijLT0cv9/zTQkv5QeAGBWeqNWgJhuZ/pJY8AqUw3zgeFoYT5J1Q==
X-Received: by 2002:a54:468b:: with SMTP id k11mr3619465oic.105.1641949489513;
        Tue, 11 Jan 2022 17:04:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p16sm1991097oiv.13.2022.01.11.17.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:04:48 -0800 (PST)
Received: (nullmailer pid 3833599 invoked by uid 1000);
        Wed, 12 Jan 2022 01:04:47 -0000
Date:   Tue, 11 Jan 2022 19:04:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Scull <ascull@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 1/2] dt-bindings: reserved-memory: Open Profile for
 DICE
Message-ID: <Yd4pL8ktqdQAI7PU@robh.at.kernel.org>
References: <20220104100645.1810028-1-dbrazdil@google.com>
 <20220104100645.1810028-2-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104100645.1810028-2-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jan 2022 10:06:44 +0000, David Brazdil wrote:
> Add DeviceTree bindings for Open Profile for DICE, an open protocol for
> measured boot. Firmware uses DICE to measure the hardware/software
> combination and generates Compound Device Identifier (CDI) certificates.
> These are stored in memory and the buffer is described in the DT as
> a reserved memory region compatible with 'google,open-dice'.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  .../reserved-memory/google,open-dice.yaml     | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
