Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DDD48E76F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiANJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:25:14 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38539 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237310AbiANJZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:25:13 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EA975C0181;
        Fri, 14 Jan 2022 04:25:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jan 2022 04:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        jkIcsTRJpq5h4+8FEvPP1ydZO44aBTg/S08RqPx/CXo=; b=SMnoU/NR0yrdWUSt
        HpV1LkLanzcPgF8KEh3lPFh60n6kbiHjsTeA1S78AwU02QonYyKlnY8K+dscSHDY
        CpZA9CELoKxvR+WPrQf9MJBG+30SrNFRUjBvYQFBjJ/hy4nr2B5aV65Xjlm2CVnQ
        WI3MkfVNBLbN4fngfQAh/mGCZOb9V5sPU5Buq91+JYA9Nta4wvzVej4Dj4oeF1wn
        tk1Eliud/EFgJjVcNn8ayzJ6ZrI1xxHlbpjdOpy1ZeGa2zrmHNQ57MwqxezaxXhm
        EbCuAg9MTx0l7Z6jDaK2rGCaQwjyIIDD+CtPLeN2UoxeaRZSraImNa4EhXQQB2he
        dbTh5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=jkIcsTRJpq5h4+8FEvPP1ydZO44aBTg/S08RqPx/C
        Xo=; b=l7LjrJnNBfAKQAe2LJywd74qGhtUo0APkghslLN8slOF6OIO/xmE68rMZ
        GtsFjVE1c1o7mton8v1uIgvNGqtRLRQk923UZVhcXjQAFIJtfeK1MfzRw1MicciK
        3E1FrVuLNO1AoP2Wg4I8qO0sD/yp9uQX3za8+IcFvaqY4abmOuRaKILxchdWZrsC
        +mtB1TtTJj/RSJ10mwyt7+AHvRYCqA1fegT3odZJSLl0Ids9hf9DN2unLusDOfjI
        /v4cF+e8SK0td/ux3xm5ZXHhb3OZrheEGbjZ0KY/gjd//pj6wg3GegkXduBMqNIz
        QMTH5rn3PVgaFFTz9u+F+29cs7rhw==
X-ME-Sender: <xms:eUHhYZ2_S0jo6IwcMYUtRIByFWkX7ZSbtw7jtB3l2QGHcW_qXsgwhA>
    <xme:eUHhYQHAGelgNAStZf2Yu3HEL1_l3uqzee-tVF75Dtk8MN6zv20i4hilk7VGoUMd2
    IoECIcW72BgY-EkbPo>
X-ME-Received: <xmr:eUHhYZ7-wzghir2A4edhTOzZT5uxfEi0LvoY71KYAnBoC5UZy8ela086dUxxjf-ZFq9OWfAYhUnRzcqqpJlVh1DnAkmYysRAt2Y3lac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:eUHhYW3JwET1wnRbkZJAzatEz5z5VtaVAiv0PKkRHvX854-eS9bGrg>
    <xmx:eUHhYcF1ze3CD1WYbVN8z_lyUTUILdJPzPEmyh4oOHpBHg-UiFt_ww>
    <xmx:eUHhYX8lGUVMA388DzxGOVA-JsFwp2EsARW9TRhU21P5dVQzHR4EPw>
    <xmx:eUHhYROP_q2SeBYz-kTKoHp7XWGrzitbchDipIrA7SB2n0Fj5aLstQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jan 2022 04:25:12 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mans Rullgard <mans@mansr.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH] ARM: dts: sunxi: h3/h5: add r_uart node
Date:   Fri, 14 Jan 2022 10:25:10 +0100
Message-Id: <164215230543.14932.4092617393834141243.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112173327.26317-1-mans@mansr.com>
References: <20220112173327.26317-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 17:33:27 +0000, Mans Rullgard wrote:
> There is an additional UART in the PL I/O block.
> Add a node and pinmux for it.
> 
> 

Applied to local tree (sunxi/dt-for-5.18).

Thanks!
Maxime
