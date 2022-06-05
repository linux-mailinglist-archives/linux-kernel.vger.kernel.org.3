Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43853DEC1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351744AbiFEWtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351733AbiFEWtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:49:17 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366C31932;
        Sun,  5 Jun 2022 15:49:16 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id l1so9274803qvh.1;
        Sun, 05 Jun 2022 15:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HPeLNf7+1CydMZ7pFSF+BZTDsbQcA2hSY+Z3kBqc6sI=;
        b=B8PLxod3WjuO8bYtWadYoSHsxVR4uILFbBgNV6vFPXpOzqSnZGZyXvpbh8y7pYdOjJ
         FC2Ok7CxuHiqPVf70NJT+cdD1zEM6dmNpGcX/k32rc5u+1ibcIyoqYeXNM536zMufvjN
         z4UyHmvj9Zxvg4VbUKc1+e7XX5tkyC4a9Woa8H7KvlVvJ1MSRp+lttAlOnaHaVxV1WHu
         qWPpjh46Ya+GXlg+4r4whv3U/ja6+iMOjR3xXgHNww1jIS2kAargJ0hh9FHUipkDVerc
         sm79Gqm5N6XzciuBNkOl67/tououiZLKHq2zNivLobtmgJvkzoyV0ML4fnJel48pg74R
         itJA==
X-Gm-Message-State: AOAM533+UObigIPpIYZlW+oq3fAOjLOd3I82d6S0YVKOPMaSqaNTVNEF
        mS8TU0Mq3qx/WnUTe7yfJg==
X-Google-Smtp-Source: ABdhPJz/rcCdih6uOCQ6GFJpLCy3wn2x255TxS5kBmY6lIQIp5CFJQdOy+KBWYaEP4hjYSskjlu1Vw==
X-Received: by 2002:a05:6214:5a81:b0:467:dcbb:ca64 with SMTP id ln1-20020a0562145a8100b00467dcbbca64mr10977914qvb.116.1654469355607;
        Sun, 05 Jun 2022 15:49:15 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a258c00b006a6aba966f4sm4726825qko.0.2022.06.05.15.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:49:15 -0700 (PDT)
Received: (nullmailer pid 3673615 invoked by uid 1000);
        Sun, 05 Jun 2022 22:49:12 -0000
Date:   Sun, 5 Jun 2022 17:49:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-pm@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        wens@csie.org, sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        brgl@bgdev.pl
Subject: Re: [PATCH 02/10] dt-bindings: mfd: add bindings for AXP192 MFD
 device
Message-ID: <20220605224912.GA3673558-robh@kernel.org>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-3-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603135714.12007-3-aidanmacdonald.0x0@gmail.com>
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

On Fri, 03 Jun 2022 14:57:06 +0100, Aidan MacDonald wrote:
> The AXP192 is another X-Powers PMIC similar to the existing ones.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
