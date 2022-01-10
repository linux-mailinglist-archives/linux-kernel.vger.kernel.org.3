Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0FE48A05D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbiAJTo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:44:28 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:45678 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243992AbiAJTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:44:26 -0500
Received: by mail-ot1-f47.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso16134352otf.12;
        Mon, 10 Jan 2022 11:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EZBK0oFNH2/W2DrO7l+FshtEaU1QbkTH5JA6mptoxOM=;
        b=IoMlThqaGlToRs3RvJx2W6DbsMWkri+/AqbFezf2BZG7EktsZBIF2IRik932sJXmqk
         xzGldM88qw+x7nwJWUsO2HXZawBtk4lFXSOMEFzkReT/zkIJrRsO0XdKkEyv19SSWseQ
         p32RdG7+2BYyuYzFcq2ddFZLdU9c2qYpInrrZCnfX3IQQW2HDtngP+EsL47yVH6gwKk7
         sxF6dnOp8g3eezO6lDC4LVd9jehj7UkZE+11/XHJNyK0mu2VggzC1IAz03Pqub60T41m
         2G2+66tnpqMeVVwWpdznTIEP1cmH2sQJWrxqac9CWWjQgJmWjI7TNAZO+Cv+gTXKJvB8
         2Odw==
X-Gm-Message-State: AOAM532rlVxrhAGN9Lo9PgNj3++ZNwYK9785K/DCF9W6oQnVoPC3NAT1
        lY7Ghcue9QY9KR1T+o/afQ==
X-Google-Smtp-Source: ABdhPJyPWXNo9u1HoK1u2CGHhc5RKtLNjdegJxxJSZbcZE0nSiaSrAtzDQPyqq86BxZNsxnLhcpDcw==
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr1011382oth.241.1641843865304;
        Mon, 10 Jan 2022 11:44:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 186sm1304268oig.28.2022.01.10.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:44:24 -0800 (PST)
Received: (nullmailer pid 1374641 invoked by uid 1000);
        Mon, 10 Jan 2022 19:44:23 -0000
Date:   Mon, 10 Jan 2022 13:44:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, phone-devel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] dt-bindings: backlight: qcom-wled: Add PM6150L
 compatible
Message-ID: <YdyMl5Ma6yM0Cbga@robh.at.kernel.org>
References: <20211229170358.2457006-1-luca.weiss@fairphone.com>
 <20211229170358.2457006-2-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229170358.2457006-2-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 18:03:55 +0100, Luca Weiss wrote:
> Document the compatible for the wled block found in PM6150L.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
