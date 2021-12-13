Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A24473855
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbhLMXR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:17:58 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45788 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243871AbhLMXR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:17:57 -0500
Received: by mail-ot1-f44.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso19082230otf.12;
        Mon, 13 Dec 2021 15:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQPTmQrXfRx7KguRstavbiQoAcmuCotS7cZFs4UAP+4=;
        b=OxRy4zgjSfv0eEC6MDHF/aijRyq77k45rCQMQTXiOKbiAqdfq1cFw0ipNjI1VMp4LQ
         LQ2coJF8yeIwTEXRVMsC7fOiC7vjVtaexDBOyJcQHYegiogTFMRXvJMV88MOjKlJR947
         Fdos6PX5QRWc+5N1RMxlCvgg9ociNg4fGBbRw8FknZMcLmhZF0FUZ/cSLNJiWaEY/t2T
         f3wkHdch/hDud2uKnnmxjnMVKH0hW/fgREvbzg9Hv6YY8n4WV5sGG1vFUB0SK1ADVG6z
         jPGr8NtINXIggkZjfqBUFY7RKokRhydEnuMgrZGY3sca2/IhkvsPwO24LVMmubMsgTWG
         Q07w==
X-Gm-Message-State: AOAM533t40JWEFvwWyFAVqMqkhzxiWgjAgdMTgmlGA4Wi8KalBKJMVB0
        s2PjlNBv5BWjoiUPZZIYLfKP5X+QBQ==
X-Google-Smtp-Source: ABdhPJwvn7kLDGtkfsA0DVEg7VB8TSohSce7x5r3spbf15NurssWz0rg1t/HXcCylFlyq/fbSKcxeQ==
X-Received: by 2002:a05:6830:4090:: with SMTP id x16mr1317986ott.281.1639437477200;
        Mon, 13 Dec 2021 15:17:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l23sm2483640oti.16.2021.12.13.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:17:56 -0800 (PST)
Received: (nullmailer pid 1764188 invoked by uid 1000);
        Mon, 13 Dec 2021 23:17:55 -0000
Date:   Mon, 13 Dec 2021 17:17:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     devicetree@vger.kernel.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, wells.lu@sunplus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: nvmem: Add bindings doc for Sunplus
 OCOTP driver
Message-ID: <YbfUo2dLIqpVhfPF@robh.at.kernel.org>
References: <1638867233-8383-1-git-send-email-vincent.sunplus@gmail.com>
 <1638867233-8383-3-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638867233-8383-3-git-send-email-vincent.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 16:53:53 +0800, Vincent Shih wrote:
> Add bindings doc for Sunplus OCOTP driver
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
> Changes in v2:
>  - Address the comments from Mr. Rob Herring
> 
>  .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       | 86 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
