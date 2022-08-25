Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5215A08BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiHYGQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiHYGP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:15:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F19F8CA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:15:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k22so3751893ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QfntWEQSpTDyvI8gHYn0S5Jpd2fjYD1CiZx7MTC/KrE=;
        b=DvcAOKz8GbCyAUdmQkk9/3dFgH47rjnGUVOltexjeECkSMon4HqpDRiFYLAKXcYlJZ
         WA2yFT/Hl1GydqsB2axTuFnm5AGm+lX0jhSB8DfbLBec45/3XkFohFAqxWJp0kb260c5
         f8N9jtLxxP7yz9QS/fdPFg9dl/ZnexVQFWjXEWpct3nR2fW5pegVGudCijwzJq+h6Rdi
         eWEqMwPN+UNQoB7MZCRKxWcF1Fkf6gU0AJm4rF5uoWcTEcTQ6cglJjlw+NJME20DWHoa
         yyO+i4V2VvjMAfR1Dc3U0QFcgVlBs7Z3qtTFaYsVELfbcR+Ur4vzqBO/tgwYSSb9UxfO
         nZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QfntWEQSpTDyvI8gHYn0S5Jpd2fjYD1CiZx7MTC/KrE=;
        b=LSmcX+13wvBYy9g6TtV31DwveyJlaGXVX/pzT118oSbtQqJ9hl0tKiiW6y6ALVQYEf
         AXKPweURiBv7ZgK6IgnF7+2nec2Xy3e00kb6LH4vEV7Np/3v/tUmx8nOoKE9c+VMKxUf
         aNPPTduvkuQGhcQmolYlmc2uWqAVXsWyh/+khKouWg9O93HN3Wff0FFO+H204gv1EAMR
         fKfY5wxBYGes7o7pJAM2FJxJ5GGqC1+ld0d3TR/9KD3+0rwfLN4YCruhdH2WT0w+YN4p
         5kjrtJzpL9Qlv6Oo3BnU51rwoSD1DL5iKKc5ZUOFuZoBsR2OonQGp1gO0tHSi/5OLm+0
         k4zw==
X-Gm-Message-State: ACgBeo3DkRC064EV0lEbx+vohY9A+KlXgt+rwRqXdUjN+tFCsWg1I7M2
        6ggyqlf34nMyJytTMkwy4/QChw==
X-Google-Smtp-Source: AA6agR4+sOKC06+N9A+9hxnC1nzfJP86yWP8N1RKdOPXieGnNCPeH85sdxO03GEFWs4prufMigm7BA==
X-Received: by 2002:a2e:bf23:0:b0:261:bd22:b2ba with SMTP id c35-20020a2ebf23000000b00261bd22b2bamr625734ljr.438.1661408156648;
        Wed, 24 Aug 2022 23:15:56 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id t3-20020ac24c03000000b0048af749c060sm316214lfq.157.2022.08.24.23.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 23:15:55 -0700 (PDT)
Message-ID: <a66d7c9d-7859-90af-8e93-ae2fc03b767a@linaro.org>
Date:   Thu, 25 Aug 2022 09:15:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 2/7] dt-bindings: net: dsa: mediatek,mt7530: fix
 description of mediatek,mcm
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
        Daniel Golle <daniel@makrotopia.org>, erkin.bozoglu@xeront.com,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220824104040.17527-1-arinc.unal@arinc9.com>
 <20220824104040.17527-3-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824104040.17527-3-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 13:40, Arınç ÜNAL wrote:
> Fix the description of mediatek,mcm. mediatek,mcm is not used on MT7623NI.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
