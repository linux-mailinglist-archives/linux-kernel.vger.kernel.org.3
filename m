Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E340F46A6DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349680AbhLFU2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:28:05 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:42529 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349484AbhLFU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:28:02 -0500
Received: by mail-ot1-f46.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so15130738otv.9;
        Mon, 06 Dec 2021 12:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jEXGbs8t8zHzg061q4w+dTqR7kI/UQIsGWsr/5lgX5I=;
        b=gOJZei4fHVg8YzoUwuIm396Xlj2DfI9Iino0Q8RJaGhpWQfocLy/Xp/2wCDPh6l2Kp
         p5+JG55+UZEB3jbOwX9enIcwKMthItRU1+XZBr5FLdZUwYtT8tK4QQ90DcHC/QgOufTZ
         ynLg/99jUZyYOF8NubHLIfglCtpgKtnjBgPN8bF/0KziI2Uf3b+kfshv+gYivqE4Q0TU
         ONHWycstQ60U7D8faJNf/2SibQiYvQ+eq+9kzUi/X3IxwttcYyC4m4ODVlInX51u6ADU
         wm4sRgkqTPGwVaGu/Vcu7HUrB5OX1x3nzu8EvJebCV3cBFsLa8JOek5ZUDy8/3P5oDXK
         MxfQ==
X-Gm-Message-State: AOAM532K3NwgvnpW0XbZHfUfGpneQs4VzGVNkRhr94poeIxz7LZf8Z1v
        262mBp3Ni7pbm9hOLhyCGeW5gx4CXg==
X-Google-Smtp-Source: ABdhPJyr0R1r6Cdk0vmVPda+pPuk/WVg0Lbsk396FExNpH1bUyMTSNYEuaGp/XYFNVL46OGZzmpEFw==
X-Received: by 2002:a9d:373:: with SMTP id 106mr31778337otv.127.1638822273260;
        Mon, 06 Dec 2021 12:24:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d12sm2370518otq.67.2021.12.06.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:24:32 -0800 (PST)
Received: (nullmailer pid 2524466 invoked by uid 1000);
        Mon, 06 Dec 2021 20:24:31 -0000
Date:   Mon, 6 Dec 2021 14:24:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] dt-bindings: regulator: Fix type of
 regulator-coupled-max-spread property
Message-ID: <Ya5xfxaJs3D7ZjIw@robh.at.kernel.org>
References: <20211206153726.227464-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206153726.227464-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 16:37:26 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> According to the description and the various uses of this property it is
> meant to be an array of unsigned 32-bit values, so fixup the type to
> match that.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
