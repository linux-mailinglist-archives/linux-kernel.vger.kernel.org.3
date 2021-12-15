Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E8B475E55
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245210AbhLOROe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:14:34 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55839 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245194AbhLOROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:14:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BF63F32003C0;
        Wed, 15 Dec 2021 12:14:31 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Wed, 15 Dec 2021 12:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=+A1r7HvHkmXVbD8VMfn93EfZAE0N
        MScIB8NEJMb0QGE=; b=GTIlVWWuNE9IIxvegpnt5k7A1uVjBFhXsnt9lpRA3W71
        tJ7TdJbFKez1M5WClc9g12kQXqxMgu1iWNQK9zYI68m79IUTWG0L9rllOoitk5Fa
        4x+lGrXNLcFXLEpedkiIM6ucqlWy6vc0alrd5IKrGSLgdQqE2PGfncjCFOnEi1SE
        RCh1zg5hB9uUBzTMYclK0/orBvctrzJllNV0AL3tU39M4flU7VwfLdq52MiH3sDe
        6Be9hL3vfgOlb5zkT34vi4+SMc0v9xzhrx6nlpMPnEvBCpYi/4XloOepjk0fdge3
        Y9z7QwxN0rIvQw71Gq81591bam/vGyviUa932ixDeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+A1r7H
        vHkmXVbD8VMfn93EfZAE0NMScIB8NEJMb0QGE=; b=Q14XKWwxiZ9T6yNj+dkjBl
        RxfuLHMd/8Jzc38u2JbfAUB1uuovBwLbGbh/jSa2O1umiAXNVIAoAkxRRfp/x2qS
        VHg7l8zUiNzha+DiOBkXHaeZl0uCgpG9TGqbAPqhpqttWSmQS09YUMDFsvqhK2U/
        Rm+BSbNY8dr4Q423t0fIEXuBK6bHm69cGxEfcL9WpLcfvtmHCR/m+qnqTLQXeZt4
        4LBOQjnIiocMWE9Cq9NidSNDynn3zV8ZJOigJyi+5B8QoAyqfqZXEIRyKsaLE9uE
        pdVY00LmN8hWLUCPOe8JXiRSWmqrTZ4++P5R8QYxNO8rD3nrMDlTZPhXe0dMz3IA
        ==
X-ME-Sender: <xms:diK6YUhwzB2gpYMoM_NuPQ-pSno--_m4qIDFPOqcBQ6Magd58SNSFg>
    <xme:diK6YdCaQpc3q9hfoEiS02v_VgW5ghF2QsnI2tNRaZn4CMBwIQW_mK0Pl0UjYZmYJ
    DRhrWwj_M0W3dYsetE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledvgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:diK6YcEik03FwuLDXZXsCMCDL358NaNeyk-dMdy6byjN0uTteCR8gA>
    <xmx:diK6YVSeruUTS-LKKuG4PK3TkRvM5ktVnoVZ4Uh-dVEm-MeCau3xgg>
    <xmx:diK6YRymTLefV6jFijNXLdnP0nXgHhLqwP8jgfOKAvhsxpcJ_PoGxQ>
    <xmx:dyK6YUr_B9NI9CWgbIz4rYt4xFh-6zteK96p819IAiCZSbne3U_vPA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8DB972740372; Wed, 15 Dec 2021 12:14:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <7eb0c116-825a-49ea-9534-534e769ade9e@www.fastmail.com>
In-Reply-To: <d4ceb942-566c-43a5-8850-4f98c9f82d9c@www.fastmail.com>
References: <20211209055049.99205-1-marcan@marcan.st>
 <20211209055049.99205-2-marcan@marcan.st>
 <d4ceb942-566c-43a5-8850-4f98c9f82d9c@www.fastmail.com>
Date:   Wed, 15 Dec 2021 18:14:01 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: apple,mailbox: Add generic and t6000
 compatibles
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Dec 15, 2021, at 18:13, Sven Peter wrote:
> On Thu, Dec 9, 2021, at 06:50, Hector Martin wrote:
>> Much as we've done with other blocks, let's introduce generic
>> compatibles so drivers can bind to those and still work with future
>> SoCs, as long as the hardware remains the same. Also go ahead and add
>> compatibles for the new t600x SoCs (we group those as t6000).
>>
>> Note that no DTs instantiate devices with this binding yet.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
> Reviewed-by: Sven Peter <sven@svenpeter.dev>

er... wait... that was meant for v2, sorry *sigh*.


Sven
