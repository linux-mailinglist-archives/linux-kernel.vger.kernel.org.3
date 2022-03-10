Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5770B4D5584
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbiCJXe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344799AbiCJXep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:34:45 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28EA1520D1;
        Thu, 10 Mar 2022 15:33:43 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso8723427ooi.3;
        Thu, 10 Mar 2022 15:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mMcGjRsIiT+Ovsq+iXrTNfC/ZKe9wCeHYBkp/8KF7YE=;
        b=CylYORRUoK6QKLA7X1QdCa43ij4opUcyid3YJrK52gClfpFjYCgKApKR/U1gBnIAKn
         7YJSYpRfHYJyHv2reE80mpm8ufljgGub2NE/pMc5LfsrOrZwgK3SdcWYfC2TpAZtmiVO
         NCNXLv0C8H9r+9tfLABIi9AtAbyMPYa03eu3VHR4kSkjtclq4XoUgPW9V03xEm03AqON
         Y9o+INLn/ixo3q2dih2gX+dPesTBgdIojxerhifmXfXD2CPX+2F+ulaJur7lAX1LDiWR
         S+YB3je7VpEy1yjDtXsV080pIhRubv658aqoRZxMBiKMk8TIGJRFxrgJA9QgMfxqBEfB
         ujMg==
X-Gm-Message-State: AOAM530c6kE7tZ+i7W2gL50Ccmh+VKRzRFkv1NLPLjaVMyV7523MxjHV
        he3PTKaXh+3XvaAbS9Bejw==
X-Google-Smtp-Source: ABdhPJwZL226YGWciO/E+md1fMIxHYJLbzCMP6BUz75y4bhrEx+2JfZJLfAOLzljUBBFQ4C0zfiYjg==
X-Received: by 2002:a4a:d047:0:b0:321:1ab0:e461 with SMTP id x7-20020a4ad047000000b003211ab0e461mr3517317oor.20.1646955222961;
        Thu, 10 Mar 2022 15:33:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 4-20020a4ae1a4000000b003215cb3d53dsm1201015ooy.4.2022.03.10.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:33:42 -0800 (PST)
Received: (nullmailer pid 2320068 invoked by uid 1000);
        Thu, 10 Mar 2022 23:33:41 -0000
Date:   Thu, 10 Mar 2022 17:33:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, erkin.bozoglu@xeront.com
Subject: Re: [PATCH] dt-bindings: pinctrl: rt2880: add missing pin groups and
 functions
Message-ID: <YiqK1SVqnYT5QAJA@robh.at.kernel.org>
References: <20220310140542.7483-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310140542.7483-1-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 17:05:42 +0300, Arınç ÜNAL wrote:
> Add the missing pin groups:
> jtag, wdt
> 
> Add the missing functions:
> i2s, jtag, pcie refclk, pcie rst, pcm, spdif2, spdif3, wdt refclk, wdt rst
> 
> Sort pin groups and functions in alphabetical order. Fix a typo.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> I didn't know the order to put the missing groups and functions so I sorted
> them in alphabetical order, let me know if it's not ok.
> 
> Arınç
> 
> ---
>  .../bindings/pinctrl/ralink,rt2880-pinmux.yaml        | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
