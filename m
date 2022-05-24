Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB553288D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiEXLMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiEXLMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:12:06 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB33F41335;
        Tue, 24 May 2022 04:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vPiOBQTYIlgv8Wq39bAFsqHeQ+D55jP4a/U6bSokA/w=; b=BdQvsqxY+G8dCM2+6UzTp3hiSt
        vtF4GQG4xicivAqswpj/djRIxSItr7bhNJNU3AAAWY2UdxQCOqjAXOJxtLIR2GhJEgt4uStuE6XW3
        YcbURc2CHbN3Z2JYYvjjmtZBfaDKSrLauisEzJmxwepUpOhFEXmOQQrtSiSCPXku8nF8=;
Received: from p200300ccff1692001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff16:9200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ntSS9-0008BC-7d; Tue, 24 May 2022 13:11:53 +0200
Date:   Tue, 24 May 2022 13:11:52 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: use generic node names
Message-ID: <20220524131152.3d749a9d@aktux>
In-Reply-To: <20220524093136.7980-1-krzysztof.kozlowski@linaro.org>
References: <20220524093136.7980-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 24 May 2022 11:31:36 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> index 7fe1966ea28a..93f601c58984 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> @@ -127,13 +127,13 @@ examples:
>          compatible = "gpio-keys";
>          autorepeat;
>  
> -        up {
> +        key-up {
>              label = "GPIO Key UP";
>              linux,code = <103>;
>              gpios = <&gpio1 0 1>;
>          };
>  
> -        down {
> +        key-down {
>              label = "GPIO Key DOWN";
>              linux,code = <108>;
>              interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
hmm, what about changing
patternProperties:
  ".*":

to enforce this format instead of allowing anything?

Regards,
Andreas
