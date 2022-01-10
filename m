Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0298C48A04F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbiAJTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:43:02 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42668 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbiAJTnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:43:00 -0500
Received: by mail-ot1-f48.google.com with SMTP id s8-20020a0568301e0800b00590a1c8cc08so10267442otr.9;
        Mon, 10 Jan 2022 11:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zqf0lxpyDYLolwCzW0Am7zZh3ipLNoodALoA+Vyy/ss=;
        b=Nte+c9bq0613ai6P2Y01wykEaRCrP1pza6XLJZn+FjcWW6nDZzr+afEY8nNMtKAitH
         atE5C1aUrHIAauPNg+ZMt1cM0CFBtpoQTJLJIgXkGWqq6zWZqWyvGTwL6fd3E/hUqe/P
         uhNV/pvDFdiXerYFl4tubj6d21N+mxjpRVKGcLkT1uBD5xIoHqQMVSp5JGvZBuOyORee
         VUgr4gEM9R9J4VPR+FlI6XxC3Y3YGc7ZJIZDV7yhS0j0mwRa26l1ofXlkQVR3ZGzHEK5
         serKoHyUvyE1lCLkXZ+3uqrkia/FJ0GmImIJoWFCgZdYeExIPGuL9Y+NfKeXFf8Zeh64
         SCfw==
X-Gm-Message-State: AOAM5310THiWOPN77EFhC8wJADidqIL6qddC9WBn4bMfjDvhHuOA73JR
        bOCu9I4Dkl+8kx02T0dUZw==
X-Google-Smtp-Source: ABdhPJwZZM/nBMXdZxSNDa4Ao9zfBXyZJPsBbveh8wtTfVIVHDzuVjXD27OR+WFOiziYyxzYYiQklQ==
X-Received: by 2002:a05:6830:2710:: with SMTP id j16mr1046953otu.257.1641843779989;
        Mon, 10 Jan 2022 11:42:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o11sm1337836oiv.10.2022.01.10.11.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:42:59 -0800 (PST)
Received: (nullmailer pid 1371958 invoked by uid 1000);
        Mon, 10 Jan 2022 19:42:58 -0000
Date:   Mon, 10 Jan 2022 13:42:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: maxim,max14577: convert
 to dtschema
Message-ID: <YdyMQiRRooFgjfyo@robh.at.kernel.org>
References: <20211229141524.34174-1-krzysztof.kozlowski@canonical.com>
 <20211229141524.34174-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229141524.34174-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 15:15:22 +0100, Krzysztof Kozlowski wrote:
> Convert the Charger bindings of Maxim MAX14577/MAX77836 MUIC to DT
> schema format.  The existing bindings were defined in
> ../bindings/mfd/max14577.txt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/power/supply/maxim,max14577.yaml | 84 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
