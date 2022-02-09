Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF714AE7BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245128AbiBIDLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347357AbiBIDLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:11:17 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F01C043187;
        Tue,  8 Feb 2022 19:11:01 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so1025716ooi.2;
        Tue, 08 Feb 2022 19:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4QLpY+NZl5728WnLEOfRJfXQ78UDzx/bgVTEF/QD8Cg=;
        b=38n+esg7eG9z/UoI4ZCirTYHlpBR4jQg+BKRlEI8LPXMk782OsI7dHWhHvkojIY556
         vl6r01heNWn4pzpFxMI27dDD95md2BdZ6PC0P/f1IMGPDuZUDforlO4QLbYvDcF8cDqW
         +pjIFoc81zrGJya+fG/Xw4uwtigXGf4MxKJDbgTRletIeRQ4VQRLA7M2/rRWmD4FJbVT
         5vlF9znvIGSHTncYoQkuTL7KkWm6aX0YOAoudqELN61DRCXYYQzIT2sg+yQtG2V0L78y
         AyBftndbirJ707pdqFp7ep1XxAGPrI3RlYpCy/A78VoOqhtoiBHcSvHxDfdNBy1legoM
         EUyQ==
X-Gm-Message-State: AOAM5315A5TOjQv3pxDuPHdF5MKvr70JLacy+7oI5DmtWHanjdJ1bRbz
        dz5lwcTdPFZK+WjeNVDQ9h9HVoRIdA==
X-Google-Smtp-Source: ABdhPJw0JUU+jlnR9uiII9DzsJeXzBAVPMro9RR5JRMu/AqaBuPNJDbHCsFROHSxYk+l663r1YDeeQ==
X-Received: by 2002:a05:6870:72c6:: with SMTP id o6mr115698oak.184.1644376260463;
        Tue, 08 Feb 2022 19:11:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b7sm6138986ooq.30.2022.02.08.19.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:10:59 -0800 (PST)
Received: (nullmailer pid 3553184 invoked by uid 1000);
        Wed, 09 Feb 2022 03:10:58 -0000
Date:   Tue, 8 Feb 2022 21:10:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: qcom,pmic-mpp: Document PM8226
 compatible
Message-ID: <YgMwwi3M+C0OYwwi@robh.at.kernel.org>
References: <20220124171538.18088-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124171538.18088-1-rayyan@ansari.sh>
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

On Mon, 24 Jan 2022 17:15:36 +0000, Rayyan Ansari wrote:
> Document the Device Tree binding for PM8226 MPPs.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
