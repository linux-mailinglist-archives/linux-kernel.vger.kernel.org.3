Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D54E30E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352801AbiCUTqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbiCUTqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:46:36 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D672E12;
        Mon, 21 Mar 2022 12:45:10 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id j83so17378174oih.6;
        Mon, 21 Mar 2022 12:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TAjWLBWhBHjCUb+VIfbAKdSt9gXhVpt6cPap/7gcaLE=;
        b=T9tNkPvgm4n/7jmhqarxKsZTSVfFizrNTitTd3JY0n4rzKiuzL4sDiYEGjQyrKAtir
         bN718MtP/4ZnRJgVh9mBzGM38Y89GnOyMF9t17WGN5mceXF5pVZ+a2V/29JYPC8iUVJd
         r7Z2kO0GXo2BfKHKU+/YwmyjFVrb6F6xoqhOk5PtpGqSyIJ8kiGLOi3T4dbmDSdbIxt1
         QEbj6sc8WgBwisDaR8izPFnVWeheKNdMhBCV2RoSyn7IELxnfn+sAZqAdt8xJzXKpuIr
         oIm9XMMoeoc8qSnylFOdvXd9bRM/xXe83PmeYIRN5QcZqwxqT7R+UNGhYoHxw4aqsKXL
         +Htw==
X-Gm-Message-State: AOAM5319k/0ak7XmwheOvT1JHRsWPMujj6I9HEYblmt5RYprnMo/sv47
        09BmMlb8gQ9RGadagiYASQ==
X-Google-Smtp-Source: ABdhPJyBgzvN0GnnOtwLOq9oZTWqIpLkZn6zH522PjA2WIR9UZy8zCfvhj25OCnlkKnX0nFyxzagkg==
X-Received: by 2002:a05:6808:912:b0:2ec:cf83:6137 with SMTP id w18-20020a056808091200b002eccf836137mr384391oih.227.1647891909394;
        Mon, 21 Mar 2022 12:45:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm6526127oak.12.2022.03.21.12.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 12:45:08 -0700 (PDT)
Received: (nullmailer pid 431535 invoked by uid 1000);
        Mon, 21 Mar 2022 19:45:06 -0000
Date:   Mon, 21 Mar 2022 14:45:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: add
 microchip,lan966x-cpu-syscon compatible
Message-ID: <YjjVwhFCYRX3Alhy@robh.at.kernel.org>
References: <20220313003122.19155-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313003122.19155-1-michael@walle.cc>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 01:31:22 +0100, Michael Walle wrote:
> Add the Microchip LAN966x CPU system registers compatible.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
