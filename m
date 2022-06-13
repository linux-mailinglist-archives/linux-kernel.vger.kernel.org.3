Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE154914D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376465AbiFMNXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 09:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377251AbiFMNUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 09:20:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD66A066
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:23:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h5so6764214wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ftbGLeiB2JlBpoGZ3wbFTZazHN6xRtIZim0EkYzsO0Q=;
        b=iB04vWC9FzI1WYr9ij3UzK3+YE+EMwP1iTYCLyegFM7Xj3/q8BDDXuMhk4rXl5Rp+C
         zAv6KAYz9Dgn7zy6gkiH2J6ochM3iiDetyjgfdgkFNb/BZmL/Dq6ntF58L0VTozF7xaJ
         8Hsh5pgxwtvGmGEksP/HHEiI09wU8YKVzl3SR93sTHHX082nCS5mHDIdoKdAW+7j75My
         u5d7/nPmOjX+ZgaXHTTV8DTaAuoysO9apmgFo9z/t4MzuSJU7YxeP2t2Es1MZKNdgvse
         FH6DEOBr+hUsTKYkrLtmZlkrHNOsvduD+Ya9ILeOeTitmQrOpRw0vRN0zXz3js+pRWVC
         ox9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ftbGLeiB2JlBpoGZ3wbFTZazHN6xRtIZim0EkYzsO0Q=;
        b=bc4CoQtIjuN+avB6wsh597hTFQoJQeLONjXaCLe3qDZoHH9s3bsk+s2FzmuOv+urLg
         2TAm1pv1LIkP9q2MRb9sC7taDBwBO4KYd114vdgvwEnzejo1HBj0U8/3z+NN61vhzIbc
         wlALXw9Xu4omtedygfY/TjXSaC5KGyUkLxY3O4eaWdY2V7QdtsnVwKSQnsz9lYxNaIE9
         nhTnx3X7xYMozwBmDDX2dPlKU+mFRBTDn8Q4bflUKlqt3q51TN/qidCcPG54vMbmfQSJ
         pZ9mc821RbgT6DOft9Vyzhqx9T8fFJRQruf+wpybQfSDyrzsvALze3Y7TApKRtjxBYu/
         EaXg==
X-Gm-Message-State: AOAM532OCQVnhvLRyryyqUi+UgmDdcgOCsZFHExQaegLct16uzKYZZmr
        laG7do+7ft7DUoPJd02EubcviQ==
X-Google-Smtp-Source: ABdhPJz/XnZLu+IhNH+tzt4F0AQVXRg8Kj57/I/QA3bryB4W9ygJ6qK+EJFE/lcc0ZEZD+zhe66+xQ==
X-Received: by 2002:adf:ce03:0:b0:210:32ec:50fd with SMTP id p3-20020adfce03000000b0021032ec50fdmr56565196wrn.407.1655119388347;
        Mon, 13 Jun 2022 04:23:08 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id g15-20020a05600c4ecf00b0039c4945c753sm13769058wmq.39.2022.06.13.04.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:23:07 -0700 (PDT)
Date:   Mon, 13 Jun 2022 13:23:04 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 00/33] crypto: rockchip: permit to pass self-tests
Message-ID: <YqceGFafq7QoT+8w@Red>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, May 08, 2022 at 06:59:24PM +0000, Corentin Labbe a écrit :
> Hello
> 
> The rockchip crypto driver is broken and do not pass self-tests.
> This serie's goal is to permit to become usable and pass self-tests.
> 
> This whole serie is tested on a rk3328-rock64, rk3288-miqi and
> rk3399-khadas-edge-v with selftests (with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)
> 
> Regards
> 

This is a gentle ping since this serie has now, no comment to address.

Regards
