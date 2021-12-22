Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98DF47D652
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbhLVSMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:12:06 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:45677 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344526AbhLVSMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:12:03 -0500
Received: by mail-qv1-f50.google.com with SMTP id a9so3016798qvd.12;
        Wed, 22 Dec 2021 10:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OFOeNc3Y0ndz/EXm1f7thJms/RZmhtXvY2DccU76yx4=;
        b=GgSnAlhyu4JEpvff13zkNHym/92t9yqqfJwoEQNph1ZRWGcNYQP/YYTW1mz/OmH/FX
         nQkJiYVurjjISOlt3AEuL6VzIgRqgiSzr3OYNy7bBDfOdY26SC5RxVcWQA6H/Pc+pxMw
         ShCjzSAQUwXs+RaooHQ8FBCqHoTEl32gQ3uHxY6/YV1Zp/aBO1DtE69k8wCWxlw0tke2
         /ZiB4L+Leo30+dtCLiIM0omGF/GqOPM2NdKpt50dZ47qWmlJh5T7L/7ps1xBNGVfoAdK
         yHaO70Fq6JQ4Br3uwHoSd1SgHdB5+8p7lAVhVZ9WeW8RPE4AWEU5TC9IplA/TJl+sdS0
         971A==
X-Gm-Message-State: AOAM531c+jM0jGAwtkklu6soeSeXS8j32BD6k5Iq8enjrj7m6mQlwtTF
        2UwiOYgCPGy4BH8qUnw+sQ==
X-Google-Smtp-Source: ABdhPJzGakyluSdij/OLglbf0wU9LSPWCjpmjuvVW4JZ5+JzF9r8FSIgVMpgGjbFF+FN/XQXb/CvnA==
X-Received: by 2002:a05:6214:529e:: with SMTP id kj30mr3461167qvb.117.1640196723101;
        Wed, 22 Dec 2021 10:12:03 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id x4sm2313380qtw.44.2021.12.22.10.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:12:02 -0800 (PST)
Received: (nullmailer pid 2436857 invoked by uid 1000);
        Wed, 22 Dec 2021 18:12:00 -0000
Date:   Wed, 22 Dec 2021 14:12:00 -0400
From:   Rob Herring <robh@kernel.org>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Vyacheslav Bocharov <adeep@lexina.in>, kelvin.zhang@amlogic.com,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH V3] dt-bindings: arm: amlogic: add S4 based AQ222 bindings
Message-ID: <YcNqcKWJrJS02nkL@robh.at.kernel.org>
References: <20211221030014.434-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221030014.434-1-xianwei.zhao@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 11:00:14 +0800, Xianwei Zhao wrote:
> Add bindings for the new Amlogic S4 SoC family,
> and add binds the compatible for the Amlogic S4 Based AQ222 board.
> 
> S4 is an application processor designed for hybrid OTT/IP Set To
> Box(STB) and high-end media box applications, with quad core Cortex-A35.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V2 -> V3 : upate author name
> V1 -> V2 : modfiy soc name S805X2
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
