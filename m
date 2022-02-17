Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498A04BAD5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiBQXrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:47:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiBQXrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:47:35 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7D1FE;
        Thu, 17 Feb 2022 15:47:10 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id h9so11534243qvm.0;
        Thu, 17 Feb 2022 15:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPptcx/vVNbCfS8mL64GHmBqshbakCqLpSIPytHgR1M=;
        b=dU/mzvEBa0ClXa/8cb7vkJ3OjmPq5IhnFxzLyTB8oi/j3dCrRf9KdCqG62oy+c5aHC
         OBUFIcnbqi00XWpQm9jKR3C/89NMCXabhu4zJRW0qjzkwS3eTjnkO5SpYsJBJHG28OTz
         gr8NW4B9mUfyJoY0mhxNP15gtMlZ80JTAc/6uc6mWaqEcIjuug9XSeofdHyvSrAu51e7
         EXB9qVFyvkUst498WOGL4Y+e6vLnhqn/UKc3pj0fK36EWUO6F+Evw/kkiWgkAY6oS+Kq
         FOPROCZ2H1i5tABiXboOR75KtSebwju26z/6OEdmfPsJR5cHAwdnJCx2NnzCdB0dz5c2
         QeYw==
X-Gm-Message-State: AOAM532WHtmrBcEk8+KvYRchp5Pk/Np55lRcnnI4W8brkrWarGejdhZP
        dpa0B8ydy9qZyWjCWmAveMLm6ODVIg==
X-Google-Smtp-Source: ABdhPJzIHjzfj4OyzzRkL5V/l1fMZK8uR3PODJEv/tSK6//NfZ7TfWsGrf8XF6Vv7D7QJ6WmL7RvUA==
X-Received: by 2002:a05:6638:23b:b0:314:a260:1c0f with SMTP id f27-20020a056638023b00b00314a2601c0fmr1909042jaq.26.1645140689673;
        Thu, 17 Feb 2022 15:31:29 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o17sm466925ilg.70.2022.02.17.15.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:31:28 -0800 (PST)
Received: (nullmailer pid 3975641 invoked by uid 1000);
        Thu, 17 Feb 2022 23:31:26 -0000
Date:   Thu, 17 Feb 2022 17:31:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Sam Nazarko <email@samnazarko.co.uk>,
        Chad Wagner <wagnerch42@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: amlogic: add Vero 4K+ bindings
Message-ID: <Yg7azlMf7ZiI+L/A@robh.at.kernel.org>
References: <20220211105311.30320-1-christianshewitt@gmail.com>
 <20220211105311.30320-3-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211105311.30320-3-christianshewitt@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 10:53:10 +0000, Christian Hewitt wrote:
> Add the board binding for the OSMC Vero 4K+ STB device
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
