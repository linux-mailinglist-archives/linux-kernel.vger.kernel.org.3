Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BECF48BAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbiAKWVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:21:31 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46047 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbiAKWV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:21:29 -0500
Received: by mail-ot1-f46.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso389346otf.12;
        Tue, 11 Jan 2022 14:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eXnuPsm6XOy6OO5kINyQC2KNf2jcAboFWMAeaxM8vOs=;
        b=uI3FUKJ7Dowu544cjK36TQMsu/0TBNzf6G/RdjvMJG6luhbR7ubm2TEsq/NNzLiOUJ
         5qH+Ccg8k1/CQ/T/w3It1F8ZC/YQ8APD16XF8xPsKO320NzcUpYq0K/pu9zn0n8CX5JS
         YpaYAVmkmmR37DpBfGsdZWWpseoFQ6i6thZQh1aq/w/5uDYMXO+Me1tPs45T1nj5R0wB
         Gks0sLQ0BhsfR7tMGU/KAv0rC8HijGgTNTQHv6txOjUB16rf7jENV8ohv4uIMpKb4EQz
         Ihyp3Ke0myO74kiSlq06BK9WEMyD12PUf4128UnVzj7G8LbyHSWftiobtz/TnDkERFS+
         uEVQ==
X-Gm-Message-State: AOAM532xb4GDhWYCKF2/4ILW27LdzXxZW11OPGLYPoclfyME12854gAY
        EI4YIUltJwAd2pFa7zPQ1w==
X-Google-Smtp-Source: ABdhPJzy+NTAhL+JzZOe+O0CoyTNWVo+qGjS7KlhXYDh37rW8SJupSpaxDgRIVFHmsWvz33yNEhyDQ==
X-Received: by 2002:a9d:125:: with SMTP id 34mr1776677otu.255.1641939689107;
        Tue, 11 Jan 2022 14:21:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y8sm2178573ooq.22.2022.01.11.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:21:27 -0800 (PST)
Received: (nullmailer pid 3607761 invoked by uid 1000);
        Tue, 11 Jan 2022 22:21:26 -0000
Date:   Tue, 11 Jan 2022 16:21:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: maxim,max14577: convert
 to dtschema
Message-ID: <Yd4C5mx/FzBpB6Bm@robh.at.kernel.org>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
 <20220111174337.223320-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111174337.223320-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 18:43:36 +0100, Krzysztof Kozlowski wrote:
> Convert the regulator bindings of Maxim MAX14577/MAX77835 MUIC to DT
> schema format.  The existing bindings were defined in
> ../bindings/mfd/max14577.txt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/regulator/maxim,max14577.yaml    | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max14577.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
