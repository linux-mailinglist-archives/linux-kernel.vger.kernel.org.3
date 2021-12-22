Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3CB47D648
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbhLVSKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:10:00 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:39751 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhLVSKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:10:00 -0500
Received: by mail-qk1-f171.google.com with SMTP id 69so3112269qkd.6;
        Wed, 22 Dec 2021 10:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KTIqQpQ7RCF278GdqSbhmvSoIu5FXpBD2evLi7Gwsvo=;
        b=Ph16s+vi7pXX9RIlyejHAQR0O+GBULuJ/DONxPOjMDlVRuA6EISl2ZEmrnSSCa2Cr2
         jmWDo3ZdiWrIfHxRnPKTRQ6dwdOyyT/8q8tRA1aFsNzYBdjqaIBiQRENdvFhUOtnNcv1
         ozugIiMxuLUe+s/wUoQmMoNN81301h9thukxXapTGPC1BXwZmFfSWe8CFWicCYlityyR
         kTsDiT+2usxZGtt7K40snMi9FtTz1nnTHwvb4Zi0kfaCBd+Ux/H4o61r3Iw62JUJSVjG
         DKlM4Oy7P0tNwcGsVacaVq0795baU176IXEJ+TPOR0mXlGbjx2+OjTGE+vrLpbzymVjk
         yBGQ==
X-Gm-Message-State: AOAM533QP5u/396zDj8qUzqYo2xwOiifTo+Til9qkshifX24ZmSolqah
        EqxeaqdCNHlIyJ2a6I/50A==
X-Google-Smtp-Source: ABdhPJwgtaYFVUDdyame6/XYYKkRbGq5W7j9AjqEkQUD/2pDfkzBHsdHwIMdSEfPe52Am76ViUavpw==
X-Received: by 2002:a05:620a:1792:: with SMTP id ay18mr2926162qkb.5.1640196599172;
        Wed, 22 Dec 2021 10:09:59 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id q12sm2229494qtx.16.2021.12.22.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:09:58 -0800 (PST)
Received: (nullmailer pid 2433267 invoked by uid 1000);
        Wed, 22 Dec 2021 18:09:56 -0000
Date:   Wed, 22 Dec 2021 14:09:56 -0400
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        ~okias/devicetree@lists.sr.ht, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] dt-bindings: crypto: convert Qualcomm PRNG to yaml
Message-ID: <YcNp9KRLgkiI65p2@robh.at.kernel.org>
References: <20211220184355.86582-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220184355.86582-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 19:43:55 +0100, David Heidelberg wrote:
> Convert Qualcomm PRNG documentation to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/crypto/qcom,prng.txt  | 19 --------
>  .../devicetree/bindings/crypto/qcom,prng.yaml | 43 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/qcom,prng.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> 

Applied, thanks!
