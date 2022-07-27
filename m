Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92E2582451
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiG0K3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiG0K3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:29:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A4B45F6F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:29:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bf9so26368248lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C8/pL5RbrbSs+hHHBvRwGZbpYLdGvRQCLQtimUHaY/Y=;
        b=aEvVN8nlbsucKUUCJ/wUHJHSxHoLOa1riYAfbTUcji+KGxjKo9NUlmDFicJ8ogDpCl
         hMkK48WPOyIp8xI0oAvv3I8h3IrytxEr39XHdhKL/7ZUUG+/y5f2OxlKay0DfkAGdRQp
         N2nMntakv/nGUJlAmGxgOyUqTcPt03uwToXKvUh8SoNvTUIG7NPtBuFsExp66abTwW2V
         xdLYEHHweN3rL1XAL3L0kt/DdUkYeAdk/uySuf+B76Mu3lnzxHQAAfXvLCYxu/uAD4SB
         zcecCzzrdvFntUwwFrbRfekPUx5p6IWlfgTs0n3WGY6lrL4dWKOok5/Y/BbPpN5wHjAQ
         NkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C8/pL5RbrbSs+hHHBvRwGZbpYLdGvRQCLQtimUHaY/Y=;
        b=bT+gYTDJDDCJBpssXZ8uCs1iyAiCNCyi+x3Jom5N0v7r2KJoNDHwxh9f43EnvT3KQp
         obgDqPBGNJjkfMAc5P+bT8v9Bj/i0i639fbdu59TnVMZuCuQiIG/Ioo1GzI73G94JTJ6
         APF+ZFhrES7u/I0r0Va16uIShcoXHGrUl3HwlxY17pfolcJZmWE9W53eDaz1sk76eFIi
         rGhedv6fQAQUWEmB855wjYdkvKRUB6L74FCYrm7uJHYHXpbwNHf7Zrx+otkZ7k5WBXaN
         N9x9rRFiKk3sIixg6x68Ye20ZYQoryrePncSm6yhupfKiAWi0gb59z4VWGWrl+cxFaNB
         AnPQ==
X-Gm-Message-State: AJIora8Lbi9U7nAMxX6ZKkwlQale1QchmIVYKXHq3is4VuA6zwdi1gyz
        vJ9KD6DP0BAofrEc9BiEz2gwxQ==
X-Google-Smtp-Source: AGRyM1v6ECH8DolGJTGZAMrGuB6MutvHtE6E/y7iHHFanSZqIcdESQaJ1Av1+9ir3yDaNGXwjrHh/A==
X-Received: by 2002:a05:6512:22c8:b0:488:e69b:9311 with SMTP id g8-20020a05651222c800b00488e69b9311mr7492057lfu.564.1658917790652;
        Wed, 27 Jul 2022 03:29:50 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id q12-20020a0565123a8c00b0048a854462a4sm2119726lfu.214.2022.07.27.03.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 03:29:50 -0700 (PDT)
Message-ID: <a8c778db-f52c-45cb-c671-556b24f3cb46@linaro.org>
Date:   Wed, 27 Jul 2022 12:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH net-next] dt-bindings: net: dsa: mediatek,mt7530:
 completely rework binding
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Sander Vanheule <sander@svanheule.net>,
        =?UTF-8?Q?Ren=c3=a9_van_Dorst?= <opensource@vdorst.com>,
        Daniel Golle <daniel@makrotopia.org>, erkin.bozoglu@xeront.com,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220726122406.31043-1-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726122406.31043-1-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 14:24, Arınç ÜNAL wrote:
> Completely rework the binding for MediaTek MT7530 and MT7531 switches.

Rules are the same for schema as for driver - one patch, one thing. You
mix here trivial style changes (removal of quotes) with functional stuff.

Patch is unreviewable, so it must be split.


Best regards,
Krzysztof
