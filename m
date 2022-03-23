Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B2E4E4C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 06:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbiCWFxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 01:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiCWFxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:53:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9CD710D7;
        Tue, 22 Mar 2022 22:52:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j18so549157wrd.6;
        Tue, 22 Mar 2022 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yM/ZLaBQecn/nNfQrSTwZlmNhBqAh/bXcl9J6ztze1M=;
        b=XWSjUsaOy8v0i8lAQyUVEL1deERXlJ9mZ8Hf6VwI6emxl4b9UNoguuLL0KmDVUzTFB
         zxOvsjNurUdXzjfeWR2KCWTg6lJI4ZOT6zljRbRVjpoI6gvJ4ykwyPEJMeBTjbA7SYnV
         cYbLuzoOGMUw+U38AIoANK5yf3gJgIJl0cuj4C3PYpfJGAp3mvbL/jHW5zc05np8XC4B
         5Ustmxl2MoglJUkOZ6sRGBcepm11O6Ll/RQTqN79x4xQxwMSMWZBOYLA7BN/PJa0pPJV
         /MA0fIZ6LLQ/d2GfmMMN9/ql146HtVgJAxWqJQGbd647H7G13Rw3fxM3MOdD9WsPkLcU
         ghgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yM/ZLaBQecn/nNfQrSTwZlmNhBqAh/bXcl9J6ztze1M=;
        b=oGeV9CMuCcB8ESU/S4enXON+bKZw0qqwy+fjIiVipQwlyQDK/HM6LCGOb8iRTkOqWd
         EtfG6ul5xWk/78ckNChg4vffr7z6FYu8WC/FygkNFcN1ZnfLSiRjO0u5kRPMuxEAu6Ny
         A4jFC+Pfi0zPqeYS+6EWBsAx0WyTLmIurfcj6xHNX/7B665IP9DmyacilKVh1OQJFtez
         jfXRPR/pYyWzkctT5AYqXVU5w7ubvlbBDdcjNWaDeL4ICcgv+OWTdTVvNykV0f7rlS7B
         j/hTulVtTvBHwtbvr0Rs8cBipw3t3pytg8xEh3DwDpoU9TaaDVLbE6AAzWiRgtO4fkex
         hJiw==
X-Gm-Message-State: AOAM531cZrpaQMSt+6lirjQu3YZ+9bgKlvFNO3ut7VbJqx7l6m0LKOYH
        Fn3R9xw8AR/D7oluGCpNpRf6nOCYHxO2wDEsLo9M3+oV
X-Google-Smtp-Source: ABdhPJzngM/xjOCtR7JA8jWCOAwfUwrYN206O0trQthtNtsSX6n4hXHzzEVJjKczmRPjrvFD7uUYC9MLStDtA+BA9zw=
X-Received: by 2002:a05:6000:1184:b0:203:ff46:1d72 with SMTP id
 g4-20020a056000118400b00203ff461d72mr17031854wrx.165.1648014739458; Tue, 22
 Mar 2022 22:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220323054001.17344-1-diego.viola@gmail.com> <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
In-Reply-To: <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Wed, 23 Mar 2022 02:52:08 -0300
Message-ID: <CA+ToGPH+FQ-6QM6MWt6Zoe_pTyL6LTn9-=-694f7xLkSVCCr1Q@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: fix "it's" typos
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 2:45 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 3/23/22 14:40, Diego Viola wrote:
> > Use the contraction "it's" instead of the possessive form "its".
>
> Well, while at it, let's use proper formal written English, so:
> s/it's/it is
> s/isn't/is not

Fine with me, do you want me to send you another patch with those changes?

Regards,
Diego
