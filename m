Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3E348A106
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbiAJUkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:40:23 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:41692 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240818AbiAJUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:40:22 -0500
Received: by mail-ot1-f53.google.com with SMTP id j6-20020a056830240600b00590eab8f4fbso1757223ots.8;
        Mon, 10 Jan 2022 12:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=brEnSG94a9dEuzAEhYmErXtFPNCp8zc17eSCyTs7HPY=;
        b=E7RWK9Tc/FBThUGT16wa9EIEX8zNGU0NCQEVrLsEPFJroXo23Ht+0HtkDraYTBUqXz
         xWNf/bEOMVhfp5EdW+P36E6o7LpM+MSmwDmuO/S3Ajy2CXkLl57CpmkLj0Tgwn78DtL8
         Z5NaSp7ASMKNEJgdIGmRYWFcuQrhUAPA8qYfLZFwpRZnzfRS3VIi0FUb5UwCRfeZG0zu
         Bns7Wu5Q+/tFRedTlud3jqKUGkWED3zYA0B1qgKwKy1iOHK0GmhR+AAe6YCRvgDWDEUs
         N3K1NkgyMqd2SCMSIb6F5zzKM6OjijrI//hWrOdhvzgc/8boTAwfxV6x62UOk0/Tzll/
         q7EQ==
X-Gm-Message-State: AOAM530iKc2ng/8QavRal4pBgyjQNNfYz4PZGQSJtryUdR6FR4Wiu5m1
        BO1HkVqfQ9KTJ/v82OBLXQ==
X-Google-Smtp-Source: ABdhPJzk49Ol9ambqLs0ZZIbcVdiZbc+q+NbxpnrF8t8Q/F7kIf1MubSNAMHOfkCOtRL57+99q7Pfg==
X-Received: by 2002:a9d:27e1:: with SMTP id c88mr1144745otb.354.1641847221453;
        Mon, 10 Jan 2022 12:40:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v4sm1507610oot.36.2022.01.10.12.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 12:40:20 -0800 (PST)
Received: (nullmailer pid 1466998 invoked by uid 1000);
        Mon, 10 Jan 2022 20:40:19 -0000
Date:   Mon, 10 Jan 2022 14:40:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     cl@rock-chips.com, vkoul@kernel.org, robh+dt@kernel.org,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, yifeng.zhao@rock-chips.com,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kever.yang@rock-chips.com,
        heiko@sntech.de, wulf@rock-chips.com, kishon@ti.com,
        michael.riesch@wolfvision.net
Subject: Re: [PATCH v7] dt-bindings: soc: grf: add naneng combo phy register
 compatible
Message-ID: <YdyZs7dDFPCWfJd9@robh.at.kernel.org>
References: <20211230084815.28110-2-yifeng.zhao@rock-chips.com>
 <20211231082249.5075-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231082249.5075-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 09:22:49 +0100, Johan Jonker wrote:
> Add Naneng combo phy register compatible.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
