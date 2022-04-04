Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64B74F1E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380015AbiDDV7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379830AbiDDSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:12:41 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3928A3EA8F;
        Mon,  4 Apr 2022 11:10:45 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso7765381otj.7;
        Mon, 04 Apr 2022 11:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G0RgFfB88IxA96E+rK9rj+vt/jiIu7zVdnRSF6wl4nk=;
        b=Y5IUnBGGiIEQBWlfWICMkv7QzBJJVfJWfKPT6Od8iV+qo5ErBC5D7mvoNernoC5wxH
         gYZ5jG+E8lmhGtIzzNoHangK79EvuB5jA0L7wNxqxX0Q8gG1GJV8OYvaWlEYNOmXoe1h
         ZqeABAXTFYqygdA3Ul2rD5b9K71UebZ7YP1JeNVWA5wwYVHED3W2mlquG8zB4BWfh+UJ
         2oc+E+JU1jPDzz39MHe54KFX5kAnNYHVZZXAx94ia+HcIYX7ugNBlrvPxARg6+++TN8A
         EwcTdEhA6DspM6NnpHxDx1USufw8OW8MjTl1VxkcO1L1Hw8gIzX9RY5kzfTzwgmS4pH8
         AivA==
X-Gm-Message-State: AOAM531cDdyG+2iqLjpnzf1cFSlCmDiqwYsXxqCgnv6reQA3au+i5A4l
        ty9ugGM5tNAfPcSi6HHksg==
X-Google-Smtp-Source: ABdhPJyz+du1PDetPMb0yA4IHexN+hr9rTsyusvv+hG1hp5UpyCr1hKgkqUziVw9bZUCG92xFnwWPA==
X-Received: by 2002:a05:6830:1e8d:b0:5cf:b0e6:82ed with SMTP id n13-20020a0568301e8d00b005cfb0e682edmr308936otr.177.1649095844556;
        Mon, 04 Apr 2022 11:10:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e7-20020a9d2a87000000b005af548abe73sm4957784otb.4.2022.04.04.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:10:44 -0700 (PDT)
Received: (nullmailer pid 1646653 invoked by uid 1000);
        Mon, 04 Apr 2022 18:10:43 -0000
Date:   Mon, 4 Apr 2022 13:10:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dongjin Kim <tobetter@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rockchip: Add Hardkernel ODROID-M1 board
Message-ID: <Yks0ox5gDKhEe6ka@robh.at.kernel.org>
References: <20220329094446.415219-1-tobetter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329094446.415219-1-tobetter@gmail.com>
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

On Tue, 29 Mar 2022 18:44:45 +0900, Dongjin Kim wrote:
> Add device tree binding for Hardkernel ODROID-M1 board based on RK3568
> SoC.
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
