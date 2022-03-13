Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF464D76EE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiCMQht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiCMQhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:37:46 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC422C11F;
        Sun, 13 Mar 2022 09:36:37 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2AB3F22238;
        Sun, 13 Mar 2022 17:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647189396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iEjq0imQFykd7GI4p10NRKGPfBCDMMpKEt8LIz7yMt0=;
        b=KQXq5foh3TIjzuxmkMUH+N6td37iTqIQ2xkvE31VcfXQ+LWRwnsquCVudUHZbyWc8fzjMZ
        xW81Ad/1a//eNJOz6Bgaw/tsDqk1WJeFTVlh3jtNTFtJ6Z5QFd/bTzrowocsnMP7UapBE4
        wfPagK+PxnXFlwkyUTR5Y8ykQ40AcbQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 13 Mar 2022 17:36:36 +0100
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v1 8/8] dt-bindings: pinctrl: convert ocelot-pinctrl to
 YAML format
In-Reply-To: <869d4fda-e943-1817-17cd-df7b323a1fef@kernel.org>
References: <20220313152924.61931-1-michael@walle.cc>
 <20220313152924.61931-9-michael@walle.cc>
 <869d4fda-e943-1817-17cd-df7b323a1fef@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b5a33a3441f829638740204e0c4dc938@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

wow, you're fast!

Am 2022-03-13 16:55, schrieb Krzysztof Kozlowski:

>> +  reg: true
> 
> maxItems

There are up to two address ranges. The second one is only needed for
particular controllers (the sparx5 and the lan966x).

Is the following snippet the correct form?

   reg:
     items:
       - description: Base address
       - description: Extended pin configuration registers
     minItems: 1

-michael
