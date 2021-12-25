Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B29947F387
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhLYOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:49:07 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:37808 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhLYOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:49:01 -0500
Received: by mail-qk1-f180.google.com with SMTP id m186so10563106qkb.4;
        Sat, 25 Dec 2021 06:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZKo4CuVNE9aj6YktgJ2/0mQdTIBC53q4u65AzxojkOI=;
        b=h6r/Jx6JaHetFln2Ch8U+XOWNAx94VlVI5WBTLExe7nNOF7Sub4q0+8mr5QkjXSNe4
         GDhmVul3LIBz61i5mcU2oZAM87lU//FszXNKvrd1R8ag4WNAcaCZNasE9ZNqeDWapPzC
         vbba9EJ+WjgZ7EVe5LF8QtWglLh0dJhQJTcTT4IqT0dA/knjzy/q4to4qIG8Tyqm+nnJ
         5weA82PvOfeDGlLtvRpjtDwKjiXLO07EpNSjLIzowZ3VNOerTDVWrvX8t5wbclw1xmjj
         zkBqtZL9WiaUkTiv4DKkCP4g9XEiOgyAjklByFzRWt3p2BJuyIyziULOCekJpBLUfNSh
         BJtQ==
X-Gm-Message-State: AOAM533NJ/FelXCqC8a90U06Wl0E03iBOqr5cS18NvdqyxMhjj7UuINm
        Ct08tq5eqSoizBhckg9A/A==
X-Google-Smtp-Source: ABdhPJxbEwWOAh1OuwX92qa21z32NQ6vc/Q6XUc34IMLFdh/n70CHypODZCeYjxxUMlkjawTK0+Z+Q==
X-Received: by 2002:a05:620a:14ae:: with SMTP id x14mr7451582qkj.347.1640443741093;
        Sat, 25 Dec 2021 06:49:01 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id q12sm8962160qtx.16.2021.12.25.06.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 06:49:00 -0800 (PST)
Received: (nullmailer pid 363345 invoked by uid 1000);
        Sat, 25 Dec 2021 14:48:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20211224211632.1698523-3-atishp@rivosinc.com>
References: <20211224211632.1698523-1-atishp@rivosinc.com> <20211224211632.1698523-3-atishp@rivosinc.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: riscv: Add DT binding for RISC-V ISA extensions
Date:   Sat, 25 Dec 2021 10:48:42 -0400
Message-Id: <1640443722.919526.363344.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 13:16:32 -0800, Atish Patra wrote:
> RISC-V ISA extensions can be single letter or multi-letter names.
> The single letter extensions are mostly base extensions and encoded in
> "riscv,isa" DT property. However, parsing the multi-letter extensions
> via the isa string is cumbersome and is not scalable.
> 
> Add a new DT node for multi-letter extensions.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/riscv/cpus.yaml: Unresolvable JSON pointer: 'definitions/boolean'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1573119

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

