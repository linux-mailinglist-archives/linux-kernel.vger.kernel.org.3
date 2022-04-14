Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B235018A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbiDNQMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347424AbiDNQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:09:57 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCD2FA217;
        Thu, 14 Apr 2022 08:53:15 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id z2so1457102oic.6;
        Thu, 14 Apr 2022 08:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJBwSvQ9K7ADQjEr30YYPw9oyPFj+rQRKPrYGiFxjgk=;
        b=LGzQAwcXRa8LbJPwYUv/uF1ytkuMvrYiI7rOzNZXAL8PJTaEABkfF0RjhTH8PgG7le
         6BpnpFyR+HZErLM5Tgo7/nFESlz85BjhVe1bQm/6K+ta8YTAskP9xQEB0IU8CWAxszZp
         hlCbvJMF7O2WyujL4PFAl1NsS0X2zdzDGRv4SzedSTLYFs+yulT7Vyhw6hqMXT5wVVgJ
         8O4ESENypdW2m/FNUpq7oZnJ2TkcfPJlJfpxxAEJf4z+SKNeBjhwMU7AMUcxck3+pIw7
         xB+cMdnk5HcDEQqHrDRA5cKiE2gcz9WcDsrgH9d9uBFEwFejS5gRYsn7+RJiOZ0bqfaQ
         puig==
X-Gm-Message-State: AOAM530THVJDNx8Pjr/YvatsX+hnGcD9IF7JQNj2awaMgqTMdK++We4w
        lGtEWcIq/eUp313scx86JZq4em6XRQ==
X-Google-Smtp-Source: ABdhPJytijnI1Q94voFZOf7ePryvYTbB8w+h0jGC4akXV6bQy4qDmrmXfy7hz3oBnTTMo4w9MDK58Q==
X-Received: by 2002:a05:6808:151f:b0:2fa:7d82:62a3 with SMTP id u31-20020a056808151f00b002fa7d8262a3mr1600273oiw.293.1649951594346;
        Thu, 14 Apr 2022 08:53:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r8-20020a05683001c800b005cdadc2a837sm130913ota.70.2022.04.14.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:53:13 -0700 (PDT)
Received: (nullmailer pid 2123568 invoked by uid 1000);
        Thu, 14 Apr 2022 15:53:13 -0000
Date:   Thu, 14 Apr 2022 10:53:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Add TI K3 RTC devicetree bindings
 documentation
Message-ID: <YlhDafvp34uv+X5/@robh.at.kernel.org>
References: <20220412073138.25027-1-nm@ti.com>
 <20220412073138.25027-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412073138.25027-2-nm@ti.com>
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

On Tue, Apr 12, 2022 at 02:31:37AM -0500, Nishanth Menon wrote:
> This adds the documentation for the devicetree bindings of the Texas
> Instruments RTC modules on K3 family of SoCs such as AM62x SoCs or
> newer.

'devicetree bindings documentation' in the subject is redundant. You 
already said that with 'dt-bindings'.

Rob
