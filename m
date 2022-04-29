Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A353514F85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378503AbiD2Pf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiD2Pf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:35:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA16443DC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:32:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y3so16094157ejo.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CxIK2BS66/XSrDJiP6Yt7UmjlXDbEsdmBMV4jeqTYB4=;
        b=E5xcQzYCJinBkCqDCJVbzR36vn+R6S5qJXxBDi05rs0AtaIMp8rBilIkCDLnzVla8V
         Qknclo5HZRmCxpMm3hF6nueKWM4Ti58SZd5W6cyWpmh4OYGj73Y8H5+jaA7mIKZ7Zs4U
         X2bjBgB/dD2+htc7DRqx+Ox6AxfEBfH+OcFyYlzuidkzvdxFJ9yBiNqErUsugCP3YBj4
         ZNUeTM1MRHfetBK4/yX6cXH9bMqRLighqwBkrhZ99tiArSDwP6Dzgb6y8pzSlZS3rTmJ
         2f7psuE0ktpEuV8IZIYPCkHr0VAu8blptRWIttRsvQkWpwxPiiv0X2qEKKk6TTHQtJfV
         Q1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CxIK2BS66/XSrDJiP6Yt7UmjlXDbEsdmBMV4jeqTYB4=;
        b=DcUhbxqFzxL8ifBSYhZNhU3Gt5MlPusM7tuoTaSB+NtqF0JdYQioYz64xOVKrlhoxq
         flOeKHh3t0x5Ij4c8aATT8q4dEe5sTrzDqFdxWPWB1i02o5fN2f75sLTQ8cqrnQNOEK6
         6D2lF7o2PxmyP9+OPNjVbNC7FIbNbPcGBOoO/TPvj0Xb6nSlFvElUXVWkdrjC96uYdLU
         xdkAxfD5aOia6+c7Jfb0UzxNmJZh4IdQGNCcJmidjTl49nObT0DRlfo4O+hBHsgi3k/G
         2BGcf+WalELjiVpRIkcNao6V0nc6fSmAXfeo8Qht5FS7N3QZfI28d5mdktrdjGRQXwOw
         AasA==
X-Gm-Message-State: AOAM532CJZPKrgzowUdT3c4DpkFrsDt4z3RYYCflJBxzhk3Ubb8OPoPA
        YYWKjgbdX7QlDwt0bTtVlXM=
X-Google-Smtp-Source: ABdhPJx2xpS59apduiN7PTuBQBoynkI/bvGG3RrPNY8RNFnaEKFAq5lC9hn1Rb9whfcDv/OzqZWHZQ==
X-Received: by 2002:a17:906:b50:b0:6f3:ce99:3c39 with SMTP id v16-20020a1709060b5000b006f3ce993c39mr12005703ejg.52.1651246327030;
        Fri, 29 Apr 2022 08:32:07 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f1b:f037:b0af:cce5:5488:7b95? (p200300c78f1bf037b0afcce554887b95.dip0.t-ipconnect.de. [2003:c7:8f1b:f037:b0af:cce5:5488:7b95])
        by smtp.gmail.com with ESMTPSA id qp24-20020a170907a21800b006f3ef214dfbsm736419ejc.97.2022.04.29.08.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:32:06 -0700 (PDT)
Message-ID: <1d70d285-c839-8e5a-e3f8-d5184acdf769@gmail.com>
Date:   Fri, 29 Apr 2022 17:32:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/3] staging: vt6655: Replace VNSvInPortD with ioread32
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
 <7a5f7f98379fb2af2741f613f5ddda53e5d4813e.1651036713.git.philipp.g.hortmann@gmail.com>
 <Ymjaxby2vDJYz6KA@kroah.com> <b3d6b773-4ca1-a72e-933b-455c5d2b91c9@gmail.com>
 <YmwDZi3mmWRHzKAT@kroah.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <YmwDZi3mmWRHzKAT@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 17:25, Greg Kroah-Hartman wrote:
> And for a big endian system?  Do you get the same result?

Just looking if I can buy one.

Can you propose a low cost big endian system with PCI bus?

Thanks for your support.

Bye Philipp


