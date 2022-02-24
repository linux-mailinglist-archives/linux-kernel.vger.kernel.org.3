Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69984C3584
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiBXTPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiBXTPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:15:40 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ADD22BE82;
        Thu, 24 Feb 2022 11:15:10 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id y7so4356543oih.5;
        Thu, 24 Feb 2022 11:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NTCiOCCJn/25u/gDAaL+aslgvQuySItwfpofAwJoXSQ=;
        b=wXVMNUaU9pw4/1AbrFxqlZ59+YhgzOt926lQ69p4ozHHHYQgLPK4XJkMD30T57cW8o
         dueZoA2I8u7Qv+195YZyo1nLXyrKyZFGHtThVtH3HOMC6JHm1WVH+j2VKJAvY2lTbj/W
         IILk6mgVQ8hx/Ek5pWJ3pri/Q9oe3qSrbvanTLOQ54T1OQ+d0YHdKAlPCIwy4al/YNtz
         WvFK7nY70XXbhKhsFcnHjAXKP01CiJp5QLvyomCPXweePBXU5xGVl+pqVIIThQZLf8nQ
         cJQNT+jneVCvmcEJBu7gq2J71dXs0V7fnawB6fejsAT+1ISNO1xV6JkjwdxRJszAywoV
         qKjQ==
X-Gm-Message-State: AOAM532O2juAi5s93Y+uA/BPpldrPLQ5oEBX9jC7ibdygTwxK6XwyqkC
        J+khSuza6jRLDm2OZuQafA==
X-Google-Smtp-Source: ABdhPJxVSqjNIib1O+EL12DTHVCZEOfigenOk7mTlZRGXCWO/1h2HNKQ/llAkHApckaT6ctOhVx38w==
X-Received: by 2002:aca:3543:0:b0:2cf:95f0:66ad with SMTP id c64-20020aca3543000000b002cf95f066admr8413596oia.113.1645730110019;
        Thu, 24 Feb 2022 11:15:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u3-20020a056808114300b002d51f9b3263sm176500oiu.28.2022.02.24.11.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:15:09 -0800 (PST)
Received: (nullmailer pid 3427138 invoked by uid 1000);
        Thu, 24 Feb 2022 19:15:08 -0000
Date:   Thu, 24 Feb 2022 13:15:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings:trivial-devices: Add pli1209bc
Message-ID: <YhfZPCVRPBgmmasK@robh.at.kernel.org>
References: <cover.1645435888.git.sylv@sylv.io>
 <15a9fcfb5b9592c6d87f12c2a4c77fd069f5cfff.1645435888.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a9fcfb5b9592c6d87f12c2a4c77fd069f5cfff.1645435888.git.sylv@sylv.io>
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

On Mon, 21 Feb 2022 10:42:05 +0100, Marcello Sylvester Bauer wrote:
> Add trivial device entry for PLI1209BC Digital Supervisor from Vicor
> Corporation.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
