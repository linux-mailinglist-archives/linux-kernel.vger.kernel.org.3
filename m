Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49040547BB4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 21:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiFLTSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiFLTS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 15:18:29 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0CF1F2EF;
        Sun, 12 Jun 2022 12:18:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D12443200583;
        Sun, 12 Jun 2022 15:18:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 12 Jun 2022 15:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1655061506; x=
        1655147906; bh=ivdZwOckeXvfhXGcxh8uIbI66ARKA3UmExKTTTKcUVQ=; b=r
        aOMHZgqyNF5/AiyfBn+rIUDSoRMdtRmjbccukjywoEuKKI6TUfhWV5gCELygiMKd
        I1EU4acQMZrHjtkVL9ZfHza04Ru6fPq2qezc1A1KUSjWoiZwKGsCp5Pv9c5U2/0w
        Nk4T/+gWdgmNdDqmIUuZlu4qlgcpYdjnSteF2IRh9vgR28cPmYj2VzcW0QqnETlF
        OEZYwIJ3O+LbKQXwv8cL6Se5qO7RG3FcyAeNefwxhXSXTSxAqnrYXO/D89dZR+Zh
        TUYqhTsXSCaz8kUX+gk7wLd0n1OwyS7nnuYlDe1UgeoFO5xsBIXkc8++DkS6aaEf
        xTm3O9JeC/yJSL07TEz5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655061506; x=
        1655147906; bh=ivdZwOckeXvfhXGcxh8uIbI66ARKA3UmExKTTTKcUVQ=; b=O
        dhwNJhGanfy8JeqNuWZ4eSBG437vai7vVN6QviGTRsiQeKgGbwz49YqXPkzFeIjB
        lza5EkdZVR0JW+zntUBUS5nL1cj8f1DEbnnh+wOwSN11UKx7U3PC2oqpq+vvF4N0
        Gfh9BZMr5hjCM9H01kg8sxdobEqYTIptK765L/IjEUNpUkDArbXWQ75wGadu/al1
        J0fSLxHADbVSasA87bJeoUE3LdT4FlR6T/OmbVhIfnQj3XCyO0fPwbfdDQVKYzQV
        NbJVQc+qTiSkWb9auRozu0nEsRAGBUuqNli7DcU5H+u0wJVthOXvtfAsbrS3DeOj
        t4Afk0sSPAPTKb/AtQt4g==
X-ME-Sender: <xms:ATymYlzxFmf0uaN2InajGdBujfQlih6cjSK3nNVppmaxA-I9MCXcsg>
    <xme:ATymYlSIYxKyObtvBUP0UgrY_a8YcrDQo6Dk_t4U0UZRpBjEfvMeuBdWX8qQQImpU
    yK3HM1Le34ovm2OYg>
X-ME-Received: <xmr:ATymYvXbrL21uaXAiWgpYmivq9epTczXFyRnZZNf2prjDGwYHwkrBP6ucDTdRLJhYD77vap-LM2ZSNqZWAjpj2efrwGwE7zo9SbjsLSQn48KUmS5n6u4CwGbYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudduhedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ATymYngx95DczDWiY7iNpCCcGo8OZnq8Fb4DK54FhVx8Au7ej_0kdQ>
    <xmx:ATymYnCklbbZ7WBhGYsGwU7pD4nZJbFpxGnoeOhDZLggZUbXPAFNRQ>
    <xmx:ATymYgJAmmeoCVQRvoCtxowOc76yJVi8raVZb5sY3YWk1n2_m3K6EQ>
    <xmx:AjymYpQ9Yo4Qsa7RZf_EWaH19LuO23mAer4jPFaVQLXqL7rOiZQPGA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jun 2022 15:18:25 -0400 (EDT)
Subject: Re: [PATCH 3/3] riscv: implement cache-management errata for T-Head
 SoCs
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, robh+dt@kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org
References: <20220610004308.1903626-1-heiko@sntech.de>
 <20220610004308.1903626-4-heiko@sntech.de>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <2039a18c-5f4f-f33e-eed6-c89f4561af25@sholland.org>
Date:   Sun, 12 Jun 2022 14:18:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220610004308.1903626-4-heiko@sntech.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 7:43 PM, Heiko Stuebner wrote:
> The T-Head C906 and C910 implement a scheme for handling
> cache operations different from the generic Zicbom extension.
> 
> Add an errata for it next to the generic dma coherency ops.
> 
> Tested-by: Samuel Holland <samuel@sholland.org>

v3 breaks Ethernet on D1, because the packet tx buffers are not aligned to the
cache block size. See my comments on patch 2. With the changes suggested there,
all functionality is again working.

Please drop this tag until I have a chance to test the next version.

Regards,
Samuel
