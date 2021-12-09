Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB446ED24
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhLIQik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:38:40 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:44637 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233322AbhLIQij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:38:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7D4FD3201E5F;
        Thu,  9 Dec 2021 11:35:04 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Thu, 09 Dec 2021 11:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=/e88EbDdXsuP52MMub+jSVQ7BFtV
        yh6OPrdW20e5hGY=; b=TVZvqq3u6iz/ZaRSOwU6x+1owKQNRCTZH3yOocrG+EOd
        z5NR2onPA2Yq2G72BVrlDFXr0FeepmEcA71DFXNrXIkKabK50VAweEx6/oQAVauG
        EEx82SDYsRqoWQZilc9+HuHbtFboyO7ywoz+hPkT2OL6f8IpYUaNAyXgUa6eYefD
        nRO7w+RyfeDuvlHLM6+WVgiNbfdeiWqFHiQ9pIzh7/nmLpkm4/QXXy4l2ysZE8Od
        hESuXnGieJ0z7BWB+G+TscV6OrIek/HdJvDG06vaG/E7H+/hGWgiZ8UnYXIProC3
        qgsFP6Vtjp6JtMT1F9GzHj6UlpbK5e4BOb+PV0dSNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/e88Eb
        DdXsuP52MMub+jSVQ7BFtVyh6OPrdW20e5hGY=; b=S2ehSz91dwQ7M6SHUEIgBJ
        tu6UEcBUssIRIpU82dgzPYx9Q80YoLL0QfP9jBZrpagu8f3riuiQ6Eps/vhGLrG3
        jL9RheNmqfB3/kZdAro8OVSEpyn7h6SLLztI6KZxmdC94h1WKkQWtbBeAOW7uj11
        EES1RCo3gfDeuBy8xlegi05T/OCYn7nPpEv+HHzOYiydxrZdNVH4X5j2oOcZGwDk
        fkaJBUjrQKq0FGkF7t8fqx6qFKQxCxztKVRRhQjXIXPRokHq9GodKSBvBNhzpreZ
        v7Y1xTK2ru2j3EqsEm9xIsvhZ5aou7XZz2eMldHsX35YFytNvdXB3+m6AkY1JIDw
        ==
X-ME-Sender: <xms:NzCyYeJPdyEVqlVIRfkmieNsB7eJ9PfAOG7L4QwQyFzl92Wu_OHsEw>
    <xme:NzCyYWIr4FkctHszNZlzGtOFYoiD1eNK4rHxu6VvNXg37e-icdXTjJoAU55QzQQZM
    YJYuonbyq24zoLPBos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedtgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:NzCyYevcJJ1gdsCRtbyTeMIiR3adWIHvp4FqF8Qe7RTIG0Gv7ZgL4Q>
    <xmx:NzCyYTaetL68F-j1sZ5bWCZ4A6N1RN1pIQPJ3ri26hYUUOGnz0ZD6A>
    <xmx:NzCyYValF2NEm1Rg91K6s1bNfwaAL4aWpWy_Me34Wqm1W4IXZxOfhQ>
    <xmx:NzCyYYyZhaag6RzuShXHmu6qAlZoHMUHDBeJeTufgQYvNEh29H7JGw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4EEAE274050D; Thu,  9 Dec 2021 11:35:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4506-g4374de3f18-fm-20211208.001-g4374de3f
Mime-Version: 1.0
Message-Id: <338871e4-f856-44dc-9721-8cfd2f2382c2@www.fastmail.com>
In-Reply-To: <20211209051001.70235-3-marcan@marcan.st>
References: <20211209051001.70235-1-marcan@marcan.st>
 <20211209051001.70235-3-marcan@marcan.st>
Date:   Thu, 09 Dec 2021 17:34:43 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        "Marc Zyngier" <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: i2c: apple,i2c: Add apple,t6000-i2c compatible
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Dec 9, 2021, at 06:09, Hector Martin wrote:
> This block is compatible with t8103, so just add the new per-SoC
> compatible under apple,i2c.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Sven Peter <sven@svenpeter.dev>
