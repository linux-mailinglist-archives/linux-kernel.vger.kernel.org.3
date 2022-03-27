Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E154E86D2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 10:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiC0IGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiC0IGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 04:06:32 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC43231DD3;
        Sun, 27 Mar 2022 01:04:54 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id w25so13695539edi.11;
        Sun, 27 Mar 2022 01:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IHOIaMurWc7F9ZSw+uYgY5lnqAhPhqRFB9rnEJSiWNc=;
        b=XRLf+KToX5ieK1+FLwI+C6RLEWPd566JOa4H5F3zZRhjMONVoBhH/ZTesY0iIL3UFU
         fsgJRP1XlHVoV6D1T2msy9aa17H+RuqDAhUURErwz2mxTWS3DQZoyHVaFm210J5wQ91y
         cWXCNQiYgtyaAkPEJHFsiFSwe+wlgu7AJqf4o7B2gbXCIC0PG+f8PX1fdYIne+Jf8rn0
         bRrZSywDNPkRuP739p+OtIHOur+9TSOXxOtRrdkCQMyRepyNpkFAZAo1XgGa3h3a1Ko7
         0VgEg/zU4hlJR6BPVMNlLIVRaQjZT2/LoIxQhujDYe/+9ZmoegG25dzgAm1nzhfufQfX
         Pfww==
X-Gm-Message-State: AOAM531DlJpP9DFv4q/69r00Ovj6vcvxoaXW/8vEsb3Q/o+wnCFllOB/
        +CXNzfaOTNWajUpg4rEJf3o=
X-Google-Smtp-Source: ABdhPJy4EOHN+HJ/Npv5WtakVNt4K3GvTHkNtyBVRFi8JZFEELjsIEw1eNOVaTJKMRJ2z5r3pD5F7g==
X-Received: by 2002:a05:6402:5304:b0:413:8a0c:c54a with SMTP id eo4-20020a056402530400b004138a0cc54amr9137498edb.172.1648368293151;
        Sun, 27 Mar 2022 01:04:53 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id y16-20020aa7d510000000b004197c1cec7dsm5403354edq.6.2022.03.27.01.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 01:04:52 -0700 (PDT)
Message-ID: <c7714450-0b68-7041-dd46-072d45efc753@kernel.org>
Date:   Sun, 27 Mar 2022 10:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 2/3] arm64: dts: rockchip: rk3399: use generic pmucru
 nodename
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220326102712.20906-1-jbx6244@gmail.com>
 <20220326102712.20906-2-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326102712.20906-2-jbx6244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 11:27, Johan Jonker wrote:
> The cru nodenames should be generic,

"The node names"

> so fix this for the pmucru node.

Wrap description like in our coding style:
https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L588


Best regards,
Krzysztof
