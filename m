Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B85A808D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiHaOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiHaOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:46:33 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 07:46:29 PDT
Received: from smtp-out-04.comm2000.it (smtp-out-04.comm2000.it [212.97.32.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6A4CD787;
        Wed, 31 Aug 2022 07:46:27 -0700 (PDT)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-04.comm2000.it (Postfix) with ESMTPSA id 99D4CBC3523;
        Wed, 31 Aug 2022 16:09:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1661954951;
        bh=WFwevAUNYHXoiwaArC/0UBzceD8ZT+ESgHntaya0Irw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hwUBejTQyeYqeMyOJi+A720R5zpJOEOuTQFcM7Hlun0+1LmhBtsfxwqklNevyUjbr
         2ijTkaoefKNbJ1CD4BxinA1kb82Vx4QXrZEICkWwUsAWSnlK1fxxcW2HIOUU7L/eHu
         fe1RsjWZuH9dgQ0VlZxF3ojL1Kv+WxJFQE5xKnDhiR2gRUxHfi6IoO7YBylw5vLZPU
         pQ1RVO4xDcC6viPWDyaQSnXQrPUzyII4xc86SuxI9OjYp8Vl9IJREHvnmfIdmSMkMk
         Lzc1ya2R9V1O/ZpvS8DTfh1trNdi9iRxUxWFA7ANDsC15SxL1c2ahTiPW4dMvepGwi
         IE+Eyl5EgBs7A==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
        id 5A6EB7F82D; Wed, 31 Aug 2022 16:09:11 +0200 (CEST)
Date:   Wed, 31 Aug 2022 16:09:11 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 0/2] Input: touchscreen: Minor colibri-vf50-ts cleanups
Message-ID: <Yw9rh7L3QecetL7m@gaggiata.pivistrello.it>
References: <20220712101619.326120-1-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712101619.326120-1-francesco.dolcini@toradex.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Tue, Jul 12, 2022 at 12:16:17PM +0200, Francesco Dolcini wrote:
> Hi all,
> This series introduce some minor cleanups on colibri-vf50-ts, allow using it
> with any IIO ADC input and fix a couple of mistakes in the dt-bindings
> documentation.
> 
> Max Krummenacher (2):
>   Input: touchscreen: colibri-vf50-ts: don't depend on VF610_ADC
>   dt-bindings: input: colibri-vf50-ts: Improve documentation
> 
>  .../input/touchscreen/colibri-vf50-ts.txt        | 16 ++++++++--------
>  drivers/input/touchscreen/Kconfig                |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)

Just a gently ping on this series, anything I should do?

Francesco
