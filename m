Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B799847D5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbhLVR0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:26:48 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:40920 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhLVR0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:26:47 -0500
Received: by mail-qt1-f173.google.com with SMTP id l17so2552905qtk.7;
        Wed, 22 Dec 2021 09:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7O2k2ThLqx+KpeKMT54zzcaZKyNhPXxf7BxowZGmDzY=;
        b=dwOgzpTrjgxF6IXKh2JSdlMY5b/DncofR6PyGveE4UqgPxAnqeXAfOTmpDa/pEEIvk
         Pt5b2miRG7pOHWXdM2gDPIta6QxlUjahGdTm5nty7QQugJkxMMX4nnuEQ2POdbDSMPOK
         z589W+H18Lz38Sq2Tfpwo7TOjGqbm4UDD+4PNhl3w9YrsQhk2DGJ1d7c5CP/6n2SQ00O
         uqzZjZhJAi/D0yIrGqtCfzRGeI3z1r8NY2n4dDlHDdvjfQc0xx/V80sI6nw1DjDnNTKm
         m9oXahOhedSh8lbrHaiRjpikArp+78K64wh19Q93aOU9mK4GMF9wGrK6fcwMmr6LBlUF
         6rcA==
X-Gm-Message-State: AOAM530Oi+flp3xmbM3oofPSMkW68Lafwq7Kc+QE8umljobYtKsbhtKn
        4IusPIp8u32e1jpwu3gvrQ==
X-Google-Smtp-Source: ABdhPJyEwRWAdXu0mtApim4mISLV2vx5OQBpemTuKvlbTokcvtXqlcdCS32It7cDK5U8uxfj7fHP2A==
X-Received: by 2002:a05:622a:242:: with SMTP id c2mr1135714qtx.559.1640194006586;
        Wed, 22 Dec 2021 09:26:46 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id v12sm2311394qkl.50.2021.12.22.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:26:45 -0800 (PST)
Received: (nullmailer pid 2361638 invoked by uid 1000);
        Wed, 22 Dec 2021 17:26:44 -0000
Date:   Wed, 22 Dec 2021 13:26:44 -0400
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-binding: soc: qcom: convert Qualcomm Command DB
 documentation to yaml
Message-ID: <YcNf1Iu1kMhCDElj@robh.at.kernel.org>
References: <20211218184617.19923-1-david@ixit.cz>
 <IXQB4R.TDKX07UI05SQ3@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IXQB4R.TDKX07UI05SQ3@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 07:48:54PM +0100, David Heidelberg wrote:
> Since Mahesh Sivasubramanian <msivasub@codeaurora.org> email doesn't exist
> anymore (returned with 550 User doesn't exist.), who should I assign as
> maintainer for this document?

I'll update it to Bjorn when applying.

> Davi
> 
> On Sat, Dec 18 2021 at 19:46:16 +0100, David Heidelberg <david@ixit.cz>
> wrote:
> > Convert Qualcomm Command DB documentation into yaml format.
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  .../bindings/reserved-memory/qcom,cmd-db.txt  | 37 ---------------
> >  .../bindings/reserved-memory/qcom,cmd-db.yaml | 46 +++++++++++++++++++
> >  2 files changed, 46 insertions(+), 37 deletions(-)
> >  delete mode 100644
> > Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
> > b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
> > deleted file mode 100644
> > index 68395530c0a5..000000000000
> > --- a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
> > +++ /dev/null
> > @@ -1,37 +0,0 @@
> > -Command DB
> > ----------
> > -
> > -Command DB is a database that provides a mapping between resource key
> > and the
> > -resource address for a system resource managed by a remote processor.
> > The data
> > -is stored in a shared memory region and is loaded by the remote
> > processor.
> > -
> > -Some of the Qualcomm Technologies Inc SoC's have hardware accelerators
> > for
> > -controlling shared resources. Depending on the board configuration the
> > shared
> > -resource properties may change. These properties are dynamically probed
> > by the
> > -remote processor and made available in the shared memory.
> > -
> > -The bindings for Command DB is specified in the reserved-memory section
> > in
> > -devicetree. The devicetree representation of the command DB driver
> > should be:
> > -
> > -Properties:
> > -- compatible:
> > -	Usage: required
> > -	Value type: <string>
> > -	Definition: Should be "qcom,cmd-db"
> > -
> > -- reg:
> > -	Usage: required
> > -	Value type: <prop encoded array>
> > -	Definition: The register address that points to the actual location of
> > -		    the Command DB in memory.
> > -
> > -Example:
> > -
> > -	reserved-memory {
> > -		[...]
> > -		reserved-memory@85fe0000 {
> > -			reg = <0x0 0x85fe0000 0x0 0x20000>;
> > -			compatible = "qcom,cmd-db";
> > -			no-map;
> > -		};
> > -	};
> > diff --git
> > a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
> > b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
> > new file mode 100644
> > index 000000000000..fa5cd6a77634
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/reserved-memory/qcom,cmd-db.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Qualcomm Command DB
> > +
> > +description: |
> > +  Command DB is a database that provides a mapping between resource key
> > and the
> > +  resource address for a system resource managed by a remote processor.
> > The data
> > +  is stored in a shared memory region and is loaded by the remote
> > processor.
> > +
> > +  Some of the Qualcomm Technologies Inc SoC's have hardware
> > accelerators for
> > +  controlling shared resources. Depending on the board configuration
> > the shared
> > +  resource properties may change. These properties are dynamically
> > probed by the
> > +  remote processor and made available in the shared memory.
> > +
> > +maintainers:
> > +  - Mahesh Sivasubramanian <msivasub@codeaurora.org>
> > +
> > +allOf:
> > +  - $ref: "reserved-memory.yaml"
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,cmd-db
> > +
> > +required:
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    reserved-memory {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges;
> > +
> > +        reserved-memory@85fe0000 {
> > +            reg = <0x85fe0000 0x20000>;
> > +            compatible = "qcom,cmd-db";
> > +            no-map;
> > +        };
> > +    };
> > --
> > 2.34.1
> > 
> 
> 
> 
