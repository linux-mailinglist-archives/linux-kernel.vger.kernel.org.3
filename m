Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6C94981FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbiAXOYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:24:02 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41949 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiAXOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:24:00 -0500
Received: by mail-ot1-f54.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso6148352otl.8;
        Mon, 24 Jan 2022 06:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+D29YanAKs3L1gHjOyyt+m20QdvdI5oLFA9QyczrS8=;
        b=zNAx1K4PLjzAPWYTEmZMyTMPWXE+LMNy06fBI7F5PaZuFQnob80KMTfK+6UiXHeQVf
         cbAY7E8ihalDr+qNuzYHELLizgglHH+K+MrfB88K35an17Y48lWul7jc5eykSAJ2c2D8
         iOBm2AIRDDcrOZlptFZlxRDdZc8j0mhmCXp631MzaZagJYoDDMRI6hN0OaxXwCtbZKeC
         8QkuMMAHE/NAryexMBld1YvdmzZRwgT6IyJgTutJXupNeb1Av4xXb9s9OmBZf7rWHGcb
         HfSPA/mwtFfvnWC+meoUPQd8Stbsd0OXIgZs9ieH7niZEfVoMUo0HloTEAGdmDnbMXmD
         HIIA==
X-Gm-Message-State: AOAM5305ygzBaJf3jJctwz+n+Hgsa1sfNQbNwIXq5/BEB+AMvZn9ADeF
        rn6QNnXxx0RB1gqrenBadg==
X-Google-Smtp-Source: ABdhPJws7XpBNJMAQdKBK6GaO/bf4PEk06rgeQ74760SKb9FpQ7OIYIP0MnvFv1Cc5+LIOlI5CzZvg==
X-Received: by 2002:a9d:5908:: with SMTP id t8mr11603234oth.186.1643034240120;
        Mon, 24 Jan 2022 06:24:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m26sm910983ooa.36.2022.01.24.06.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 06:23:59 -0800 (PST)
Received: (nullmailer pid 3749184 invoked by uid 1000);
        Mon, 24 Jan 2022 14:23:58 -0000
Date:   Mon, 24 Jan 2022 08:23:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] of: base: add
 of_parse_phandle_with_optional_args()
Message-ID: <Ye62fhOgaojt6Uqj@robh.at.kernel.org>
References: <20220118173504.2867523-1-michael@walle.cc>
 <20220118173504.2867523-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118173504.2867523-4-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 18:35:04 +0100, Michael Walle wrote:
> Add a new variant of the of_parse_phandle_with_args() which treats the
> cells name as optional. If it's missing, it is assumed that the phandle
> has no arguments.
> 
> Up until now, a nvmem node didn't have any arguments, so all the device
> trees haven't any '#*-cells' property. But there is a need for an
> additional argument for the phandle, for which we need a '#*-cells'
> property. Therefore, we need to support nvmem nodes with and without
> this property.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v2:
>  - make index signed
>  - add missing function parameter doc
> 
> changes since v1:
>  - new patch
> 
>  include/linux/of.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
