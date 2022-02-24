Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047284C20C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiBXAlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiBXAlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:41:20 -0500
X-Greylist: delayed 494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 16:40:45 PST
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21C72D1FE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:40:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 94B3E5C00B3;
        Wed, 23 Feb 2022 19:32:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 23 Feb 2022 19:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=nf5v9flhJ1/35f
        JJsCo6upNHW6tvn2iWHZH/A+ZwQBg=; b=evv/LeK16QlL3GjRaqAJEve75MJGTm
        0s1X7DWU0oCwRCmdoWFtYVsnJ4AR1j4x9II/WxMSQSQTYfAxgeo+zjV7xZelFIy5
        JS1NmECDqJz6NRx3I9t6spm2KQoxBRfRJF+Cut7TlNMCPYTQ3KWriSjB8pZsLpis
        pbjtCZ118uKNZuR2+2KXx9yoxicIqoSPq1a7R8R5hqGsAUbzSshyPmCdRIy//Xfo
        1oDHzCLDswQPqampldY3rTDAKgMMAQtTyhRhq29HzjviPVV4bJSCZHwN+4lbxiy7
        HbvtKpZalmmW5Oj+9UTO7ihnNdO410lzel7UBD4HkB5iuHzGAIlro/gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=nf5v9flhJ1/35fJJsCo6upNHW6tvn2iWHZH/A+ZwQ
        Bg=; b=KPV2Akj6JeP9AMwf5j+RJmb5AdCsVUlDymKb+fjS4Esv11r4HoNEdicsL
        6PJFB9rEgWT+gRnpOOnkj2wGcYkvXBnBsFH8gffx475IpA+tFkc4yEVCp1afZFG3
        e0HpaVOvLV1iaRHPmS54bKpxY5nds5AzMmOjxqWANYpHpYzFNy7cXZJa7czoYR28
        MY7MDbwiSBf92aq0aPJoHqO3ipE7Qn1En9TFAQntkTawfMhyphzZPO/Jj4Pm3EDr
        AloUMQriE2uRDu56kWK23R9jbzsu17t8ULIRxYZM5ZBiOWzNMF5B0NDxtCm4ob50
        e8RgX+ijwxUzt9Ppmvv1jSFXIpJUg==
X-ME-Sender: <xms:HNIWYnKmV0kvcuRBjKLJ7MxCBZOEuR5XAYjCSS2fKAWiKeLE7HcAjA>
    <xme:HNIWYrJm6o5lmGIrXeynVNdqzLQ_UDr0eJ_vGbasKx_MzBhpzhXYHgY3AAUQG9Uw4
    osyg-wjTigm58KXqA>
X-ME-Received: <xmr:HNIWYvv9iXEkfcvgkMjPEJiO0Y4zurKUa9M4DoT8Dak-fhFuuDTessB1vlXAcCmwWGmh9KScolXJTLz3nY7RBJn5mYQ5oTsQzxWOMJp-kUaqpfoo6kIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledugddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepkffuhffvjghftgffgggfgfesthejredttder
    jeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhssh
    gvlhhlrdgttgeqnecuggftrfgrthhtvghrnhepfeffgefhlefgtedtleehfeekjeejteej
    jedtvddvgfejveelieevfffgfedufeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:HNIWYgYSOGQaa1nred7y96aqSvYWVkyUncVQDSGDeLlmFXmxXbT0ug>
    <xmx:HNIWYubU3BnY-TGAeax4xLYdBy5KEyfp00d9DReRbqkMiWfG0-XCGg>
    <xmx:HNIWYkDmO6OHUqDIBoN8-V-nR9wHw-uvUa20FikZr3Aqckilysri0A>
    <xmx:HdIWYm4BY1kgY3F_Qz6y-at2XRgkoiLPh37djwu0Og5NwgrEguUuOg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Feb 2022 19:32:26 -0500 (EST)
Message-ID: <b7adc31a454cf89cd04eabe36399bf2b3ce4fb23.camel@russell.cc>
Subject: Re: [PATCH] powerpc/module_64: fix array_size.cocci warning
From:   Russell Currey <ruscur@russell.cc>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     kernel@vivo.com
In-Reply-To: <20220223075426.20939-1-guozhengkui@vivo.com>
References: <20220223075426.20939-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 24 Feb 2022 10:32:23 +1000
MIME-Version: 1.0
User-Agent: Evolution 3.42.4 
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-23 at 15:54 +0800, Guo Zhengkui wrote:
> Fix following coccicheck warning:
> ./arch/powerpc/kernel/module_64.c:432:40-41: WARNING: Use ARRAY_SIZE.
> 
> ARRAY_SIZE(arr) is a macro provided by the kernel. It makes sure that
> arr
> is an array, so it's safer than sizeof(arr) / sizeof(arr[0]) and more
> standard.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>
