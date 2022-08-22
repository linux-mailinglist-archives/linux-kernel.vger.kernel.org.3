Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B859B70E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 02:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiHVAdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 20:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiHVAde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 20:33:34 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12613EE3F;
        Sun, 21 Aug 2022 17:33:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7435A5C00FE;
        Sun, 21 Aug 2022 20:33:30 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Sun, 21 Aug 2022 20:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661128410; x=1661214810; bh=27h43v4nBT
        AlRXCBZnK4UG8wbYzUzFCpxbi0BMYrkbM=; b=Lc2jpMR5ay89ru7Qj+gW2zMRXV
        D7lvXBFEaVaJ7MUM8mGTC3F6Bp0dxWKK5/e7X221AX+rTnZt76/Mv1betZBnHBZH
        JQud96s4tkPI2thDQqUq/FwzPcBrtwjX3P6wEfuYvTXT9qIrVr3T+jglTQhr3qlU
        FckvCctyWfcVYciIiuejKxrJqpAhoSsllq372abYk1N7mlmTxgHIej4C+1xwfjqC
        gN8QXQyUCRkEXPfnPhnLUXiyX69KAOuLeTXtFoaEddc8c2ghnMvPkDerfdxSCscu
        lDpJYpa5K8WBEQKC3VFgphBhcZksLyyPTrBdglHKJ4uXLJt14iVxbs/dueiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661128410; x=
        1661214810; bh=27h43v4nBTAlRXCBZnK4UG8wbYzUzFCpxbi0BMYrkbM=; b=l
        592CXRTNKqmCcnghN5YrbqfnlJAqYJ5/f4sKVN1/fZRVJTRZcezwsSabP7rJWqxt
        jZTXUFtLTFQVZqIv3V8HZ9aQ3lEi3WDYa/IZB8H/IonbvATHrmlLh3EdE4mG3zn6
        dA3hvkeHRSBOTMf0v27ytrZY/TSjmk3JBN4nrJDsn9RNgVS58YltAIe/51MK6ciU
        Gf+VIMtkiu9JVdAnSSit6BElF6hiNcvsk4hheWCeZ2Hx5RFTpQhyn9FRhy8YfaUT
        J4Ukb1eVnO/3JWzuf7K6fva5uarQMoXsRebPFVYRXx0RJLg2EgUA2+vHXsoWCCLs
        cBszWecnTWMss65I1dy8Q==
X-ME-Sender: <xms:2s4CYzK0yxz3h5fegyVUgvhdbPTHwu-RseMyvjOifmJ0dt7BQFFAZA>
    <xme:2s4CY3LBrggaoLgaey-MTQx1gY2NT3OkGG8smH2aFi-iOV3vZJc1wrF75MNYGzWYS
    ZH4LwwsGf_QtKm74A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfvfhomhcuhfhithiihhgvnhhrhidfuceothhomhes
    thhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqnecuggftrfgrthhtvghrnhepiefhge
    eikefgueejtddvueevheeikeeghfehtdffgeeigeeujeeggeffjeeuvdeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhomhesthhomhdqfh
    hithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:2s4CY7shrdwtyrF2g4MZ2GcrsHjKOAkhXsxcJ2KY8A2AHUz9Qu_RqA>
    <xmx:2s4CY8bKTAnnU2CiV9FQNKUa_6SCj5kmqqv2DoX7tLgMuMth4fUU3A>
    <xmx:2s4CY6b-q9ILy9zViLhBQOTv1fj5OU77D_2zl_pOVIeysl6lazwedA>
    <xmx:2s4CYyrGoIsoIW2e0LZWSTQRT-FAIs6Y6x7ffKyWbN8xPEAcvuCgng>
Feedback-ID: iefc945ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2B1DC2A20075; Sun, 21 Aug 2022 20:33:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <81f06224-2472-4696-b56a-2f4286902d0f@www.fastmail.com>
In-Reply-To: <20220821001114.ahnb4f6hcykt5nrm@notapiano>
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
 <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
 <20220821001114.ahnb4f6hcykt5nrm@notapiano>
Date:   Mon, 22 Aug 2022 00:33:08 +0000
From:   "Tom Fitzhenry" <tom@tom-fitzhenry.me.uk>
To:     =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <n@nfraprado.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add initial support for Pine64
 PinePhone Pro
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2022, at 12:11 AM, N=C3=ADcolas F. R. A. Prado wrote:
> Indeed booting from the SD card also works with this minimal DT. Also =
confirmed
> that eMMC, thermal sensors, power button, regulators and UART are all =
working.

Thanks for the testing! I will include your Tested-by in v4.
