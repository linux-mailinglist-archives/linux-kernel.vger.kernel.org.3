Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6C847C37C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbhLUQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbhLUQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:06:54 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72805C061401
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 08:06:54 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id m186so12999096qkb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 08:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=CA0vEmK4VuD0G874S6BcBlFV/fcXlZJ0vIg3qiYKRtE=;
        b=qOIVe/Ulrw9M0ql12nQM/iQjHwp0KJnIxM9TgARluh2svI6qk9dSBSboo9pua1hOoR
         jUsxmOzEVEFx4EzAcyVWC0ZA+ndcS6+sBpbGJ5VyTH7DRyDXo3Q7VT3HtXy4bxi3s+MV
         yWeof3dsaDfLiZydW3qhODT6lz3X7RKu1FkvfPnvUDtvUQo7y+D49vSVxSeuQnp5nOvz
         HCTVFaspA9npKQ2+SvimAumqTYCp4V8UJ1l/dE3/QD1nPB2IK2ENRrfoo/DcHVx9w5j3
         UubJs6ATzXZFi00dP8k0ZOVE+n4E3EzdUhPEif/Po+dM45o+7GvVulrBFO/uMV1Xk5su
         9BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=CA0vEmK4VuD0G874S6BcBlFV/fcXlZJ0vIg3qiYKRtE=;
        b=BxvbEf4ogoWrmeQhkk9yybzfMwMxRTDaB61sfAdvvDMKFuIs3h6z4gh33sNI1GwRjs
         tUnOky5DXqp34hp6l41/4XmlgT+m0+FyJT9KAS2L4kl0MSaJBRRZQqL1C2CJr8Gtz4iL
         z1rKwBOWkg687AfrG2kxi0K8gwzRiDh06+aVXx9j2pLtvH4HMw/H6t4BYw8+a07TaU/g
         R6rv++OrdtyRPMm3jlRddXCEQG4cVbfhMvga1dmAWlrQWTRu7pHYVXy5BDCvopPsSALI
         B5xlSdl7a9+CILTHKquT0qLe4ObmlSyJgax3loWFxDMuF40LmgfKUGMHG7PGJfmTUulN
         TuyQ==
X-Gm-Message-State: AOAM531ENtE1M6fHOVQAjaHGoH5KQ6CYqwSumfLV0hyVSWhyfF7awh3a
        XSRXrarV//wACqpjJgInz01P
X-Google-Smtp-Source: ABdhPJwY/i2y/TBE4bud79JOMazs61JlNK44ovTedNtrgQW3IL7WCnnDmTktbDvmJaqxOyESEh8t3Q==
X-Received: by 2002:a05:620a:4301:: with SMTP id u1mr2533209qko.134.1640102813467;
        Tue, 21 Dec 2021 08:06:53 -0800 (PST)
Received: from sloth ([2607:fb90:ac99:dad1:b58:661c:23ad:781e])
        by smtp.gmail.com with ESMTPSA id 196sm13506624qkd.61.2021.12.21.08.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 08:06:52 -0800 (PST)
Message-ID: <5f4ab50b4773effafd0a43c8c541d49621f78980.camel@egauge.net>
Subject: Re: [PATCH v6 2/2] wilc1000: Document enable-gpios and reset-gpios
 properties
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Adham Abozaeid <adham.abozaeid@microchip.com>
Date:   Tue, 21 Dec 2021 09:06:48 -0700
In-Reply-To: <YcHu8qkzguAPZcKx@robh.at.kernel.org>
References: <20211220180334.3990693-1-davidm@egauge.net>
         <20211220180334.3990693-3-davidm@egauge.net>
         <YcHu8qkzguAPZcKx@robh.at.kernel.org>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-21 at 11:12 -0400, Rob Herring wrote:
> On Mon, 20 Dec 2021 18:03:38 +0000, David Mosberger-Tang wrote:
> > Add documentation for the ENABLE and RESET GPIOs that may be needed
> > by
> > wilc1000-spi.
> > 
> > Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> > ---
> >  .../net/wireless/microchip,wilc1000.yaml      | 19
> > +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. 

Ah, sorry about that.

> However,
> there's no need to repost patches *only* to add the tags. The
> upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Not on purpose.  I just didn't know how this is handled.

Thanks and best regards,

  --david

