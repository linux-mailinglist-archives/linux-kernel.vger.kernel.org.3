Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48B35B002C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIGJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGJSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:18:22 -0400
Received: from ixit.cz (ip-94-112-206-30.bb.vodafone.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E3596745;
        Wed,  7 Sep 2022 02:18:18 -0700 (PDT)
Received: from [100.83.88.146] (ipb218f8d0.dynamic.kabel-deutschland.de [178.24.248.208])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id D34492007F;
        Wed,  7 Sep 2022 11:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1662542296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFhsnQr+dDz1VS1i28hNPASrpJenpNV9xRvWHTJSoxk=;
        b=r3/WMnC3wSInggZ915/RUaPtkbYiSurP/pa839ONbnx0W1qNEjneYg0nizsYeBnVXMU+9y
        ByzBUmlcjPxrjbKfrHgVTGy0jHLpyB3INV5P2ZXkco2cI4mhCgoiu3AOLg4dsXFhRjCsve
        2Zcbz6ifdDoO9ZtKAu4pmDTINh20atM=
Message-ID: <b1032180-aece-283a-b983-2ef57284aefd@ixit.cz>
Date:   Wed, 7 Sep 2022 11:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: elants_i2c: Add
 eth3915n touchscreen chip
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20220907054805.v2.1.I1168feec10de16e0f130dfe72ce7976762597dba@changeid>
Content-Language: en-US
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <20220907054805.v2.1.I1168feec10de16e0f130dfe72ce7976762597dba@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: David Heidelberg <david@ixit.cz>

On 07/09/2022 07:52, Yunlong Jia wrote:
> Add an elan touch screen chip eth3915n.
> This chip requires more delay time than the eth3500.
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.com.tw>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v1)
>
>   .../devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml   | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> index a9b53c2e6f0ab..d28625372f5ac 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> @@ -17,6 +17,7 @@ properties:
>       enum:
>         - elan,ektf3624
>         - elan,ekth3500
> +      - elan,ekth3915
>   
>     reg:
>       maxItems: 1

-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

