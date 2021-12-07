Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D552C46C6B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbhLGVdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:33:44 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36681 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhLGVdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:33:43 -0500
Received: by mail-ot1-f43.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so605801otl.3;
        Tue, 07 Dec 2021 13:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ks4hfTfIIz0PesStVcEJSpGBRhRRrquhE5zLvXUEKOs=;
        b=C+MuF9TApdo/gUyRZaDgGqTnwHB4ZOR25oIGbXhTNgZLD4Ey95YjsGTaWdG1jfDneH
         1qsxcjrCrN6uiwD4l5pkuz1Ri1vimUTG25KHd6AP3Mve/9Krp5EMCfAlQqzZLrnxOmgK
         2nPX5RMK49jhFziWs+oZD8y4fwJVPthgq6mOXq3xrm0WIrsnpqDxqHNfMNB4SPZQfz4N
         qcho9Fh0wm+JE2KwVsUDsIWPEImfxU4SxTxV4gk7u8Ht/lwgyfZMtALxIBnm3q6zsVp4
         bak2n+/bg04V7d1SijkQ1JMv5AMOhjHXm84wtUP2NcuiPGxBN7rRI6Obk9CV7fUdcWIx
         DwHA==
X-Gm-Message-State: AOAM5316+efEJAOUULV71Rva14ThsFqxaTrXmGamYmu02hfkNG4osyY4
        TTZeQhzKlbSn/5pzMRfEWKUNNHkSsg==
X-Google-Smtp-Source: ABdhPJyq7RmlHs9Yjf1BtNBb/sX5BQMw344tFd2GcKRh6e1//kRLcA0BA09+zJ52mWCn+tLU1cs9wQ==
X-Received: by 2002:a9d:4a8:: with SMTP id 37mr38477867otm.83.1638912612042;
        Tue, 07 Dec 2021 13:30:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n26sm161267ooq.36.2021.12.07.13.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:30:11 -0800 (PST)
Received: (nullmailer pid 866904 invoked by uid 1000);
        Tue, 07 Dec 2021 21:30:10 -0000
Date:   Tue, 7 Dec 2021 15:30:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Harsha <harsha.harsha@xilinx.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, saratcha@xilinx.com, harshj@xilinx.com
Subject: Re: [RFC PATCH 3/6] dt-bindings: crypto: Add bindings for ZynqMP
 SHA3 driver
Message-ID: <Ya/SYqbVTPRdch5x@robh.at.kernel.org>
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
 <1638262465-10790-4-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638262465-10790-4-git-send-email-harsha.harsha@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 02:24:22PM +0530, Harsha wrote:
> This patch adds documentation to describe Xilinx ZynqMP SHA3 driver
> bindings.
> 
> Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> ---
>  .../bindings/crypto/xlnx,zynqmp-sha3.yaml          | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
> new file mode 100644
> index 0000000..45a8022
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/xlnx,zynqmp-sha3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx ZynqMP SHA3 Hardware Accelerator Device Tree Bindings
> +
> +maintainers:
> +  - Harsha Harsha<harsha.harsha@xilinx.com>

space               ^

> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  The ZynqMP SHA3 hardened cryptographic accelerator is used to
> +  calculate the SHA3 hash for the given user data.
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-sha3-384
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    xlnx_sha3_384: sha3-384 {

crypto {

> +      compatible = "xlnx,zynqmp-sha3-384";

You need some way to access this h/w.

> +    };
> +...
> -- 
> 1.8.2.1
> 
> 
