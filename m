Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACDE4AA345
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351295AbiBDWi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:38:57 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36756 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbiBDWiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:38:55 -0500
Received: by mail-oi1-f179.google.com with SMTP id s185so10223014oie.3;
        Fri, 04 Feb 2022 14:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v38Kfg/wf9t6mUoqPaOFlIjuWloQG1bbjKXeADCLqYU=;
        b=DjdqQ6MY4PVwbkQBCI8BarnQMeczP576lSL3Rj5WUuAihyb6/Ifh35mVwXM7yX7Mg+
         EJ1/f9S+3SfhJ/8kCEbvf66wcdTE4Ygk6Mcxz0AIiKlclyWPWY1Nv29sqsU6+/AuZduQ
         qgYJSyQDwRFmgp9sZFu/MO9SpoIe8caaj0hZq0l1CQ7kVryhcXSemYSfngml8Trr1VXY
         XtIKuJevOs/P3NzOESK/+sUFyjlAjZhZPQjST0gpO9LAxdpuOFo/IjIcH+uHywNq4Cqy
         wC2/ADAMqxXnYd+FkMrbqfrMqIgaTb1tCCBzcrm7KadvjBnEwVA+Qz7bx23+8/mshaY1
         JdiQ==
X-Gm-Message-State: AOAM532SaF7zUgqCBEal/l2rHrtEEGBpbrKLswnYExxLz3rgglVsdVUV
        AV5xEysH8eIGZlsQ0lddGg==
X-Google-Smtp-Source: ABdhPJyTrqs4CLu0auGGEAWVcE1rpCQ9ftRnQzFJS9Ype3oGGmsjbsjoLQ7hzZHWJCTfKDaIHZOw5Q==
X-Received: by 2002:a05:6808:209e:: with SMTP id s30mr596076oiw.13.1644014334871;
        Fri, 04 Feb 2022 14:38:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x17sm1197653oop.1.2022.02.04.14.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:38:54 -0800 (PST)
Received: (nullmailer pid 3312730 invoked by uid 1000);
        Fri, 04 Feb 2022 22:38:53 -0000
Date:   Fri, 4 Feb 2022 16:38:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings:iio:frequency: add admv1014 binding
Message-ID: <Yf2q/cZMebdudNny@robh.at.kernel.org>
References: <20220131100102.15372-1-antoniu.miclaus@analog.com>
 <20220131100102.15372-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131100102.15372-2-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 12:01:00 +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the ADMV1014 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v5.
>  .../bindings/iio/frequency/adi,admv1014.yaml  | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
