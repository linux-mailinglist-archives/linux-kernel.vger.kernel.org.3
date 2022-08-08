Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D099F58C3E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiHHHYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiHHHYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:24:20 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2CD10DD;
        Mon,  8 Aug 2022 00:24:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BCC25C010C;
        Mon,  8 Aug 2022 03:24:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 08 Aug 2022 03:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1659943453; x=1660029853; bh=cfXKwT2L2W
        iIMULrPjrMghFNOd45gLJ8rGZDCFh9GPU=; b=Yxus/l2iuHs/pwJkTM5C2gwHgL
        UrFT8YFfm0lEgdIxeujotqg9e211oeMqw1iTPt5eHJtNmiPbXkSMkhP/M/d0xfi6
        32BnX5MwKINQ299Z8EjoTH6Qo3uzAL0yQNp+CL4BbmnNFAOXgHIViwQ5gzHIOoFX
        rF7EnTDAwwNOaHb84ds/aatwnUJbYCz195mKMxTNc5lYvYPoQ5WRYjUIGb5vrzPR
        ApqgH/sU3iRE1hWJNfsTenoVwRKCK7Su48oHa5v5j9d9Uhe78DsDb/T75T9+ex+i
        HHL0mcmZmUCZ4Nm+Qh30R5dDDMtRNwrhZJc48gwZNfBUfGOdh22iID48qFmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1659943453; x=
        1660029853; bh=cfXKwT2L2WiIMULrPjrMghFNOd45gLJ8rGZDCFh9GPU=; b=C
        rxpsC7Yb13DKjBueJjjiYgKO9XsT4cFdLaILTPN9er+gboMsVHqfCnn75oteoJ+S
        o/vx5xd+du0zwxLCdEypAheFShKgLZnt+JDEv+f6oa72sctaqGXwK/2zYcONNon6
        j6Wx2iaq7KFZu95Saeyodpd0OjEL1F6LZl9vf0milcS83keP3RQZrZdL8Gw+/5yT
        Y4yEXkbeH/BtHDIQX7d26knJtwWbtL5HZQYxP5cRhSK4qTLrvrsjfQIkMPAa9o3m
        kARXmoETQ8437f9GxYStnZ5/wLSruPIhWZbFpelZHkC+P53UtSTWQWHRCuRtTO/4
        fqXn/kXl9z3IiifxQceOA==
X-ME-Sender: <xms:HLrwYgB62IxBquFN-LI7ebW5i4FFdTztOfuh0HaW8NSspyWZpEjPuw>
    <xme:HLrwYigOvjW2NutFojZXfH8WkDUJjggmUe3GFBbDziAH37yE1U9TL0ISfLfKQ9DaW
    IC2kqxmqmCljPQDkw>
X-ME-Received: <xmr:HLrwYjlP5FbLSr5uzkG5xcYlRZ8aWT0Qn_Mc8M2aRIdWxzsTyILkPAqt3ww7LZQTk6ZzRTWtfrHNS4Ppx2Vn4tVk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepvfho
    mhcuhfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruh
    hkqeenucggtffrrghtthgvrhhnpedvgeehhefhtdffuddvtddvhfdtudeuhfejhfetvdeg
    teelfeduheejfefgtdekieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhomhesthhomhdq
    fhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:HLrwYmxd0tnTDdadZDzkGmBfDKfDMsTa--QtOxp2g_Sf5pmicu5WTg>
    <xmx:HLrwYlSTVMIk-abDMxsck8i9-PWeQDPDlSQYUn8mKDKLeVkXPp6Rdw>
    <xmx:HLrwYhbPtuQaSXKNA5d6fjfQhWw6Z7kzi2QeGU_hCZ6yLJ5q42VUVQ>
    <xmx:HbrwYhqO5YY-HidK0Q7p-sb0UFfuB3VhDqvkkKDlxA43D4sOz_Zvdg>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 03:24:09 -0400 (EDT)
Message-ID: <88cea6f0-c76a-a1e6-48bf-1c0598df4df6@tom-fitzhenry.me.uk>
Date:   Mon, 8 Aug 2022 17:24:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Caleb Connolly <kc@postmarketos.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     megi@xff.cz, martijn@brixit.nl, ayufan@ayufan.eu,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
 <f9cbc047-f30f-e711-3213-56fcbb7bbc8a@postmarketos.org>
 <9a168a20-1fd1-5d73-1d33-bd2f054d60d7@tom-fitzhenry.me.uk>
 <cf320916-c88b-0c4a-7515-24318f1b85b2@linaro.org>
Content-Language: en-US
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <cf320916-c88b-0c4a-7515-24318f1b85b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 16:38, Krzysztof Kozlowski wrote:
>> I agree authorship is important, and thus Kamil, Martijn and Megi are
>> listed as Co-developed-by in this patch.
> 
> But you miss their SoB... Without them you should not send it. It does
> not pass checkpatch, does it?

Sorry, my bad. I see 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html 
lists to use checkpatch. I had read this but had since forgotten. I will 
ensure future patches pass checkpatch.
