Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A264C559EED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiFXRCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiFXRCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:02:20 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFAB62C01;
        Fri, 24 Jun 2022 10:02:18 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BFE93E0009;
        Fri, 24 Jun 2022 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656090137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dx96b+PCiQLDVyDNyaIZFYtaUKeJSzZ4TH7iZMwSCRo=;
        b=TGmNmhPaJw4/nulvgGTmcHGzivvt21fLm6mQAAL/Vdao0UMVzEHRml1A6eERd2MxTsdMYc
        4qVrSIg6IqxU0nqSopC6VdvE4yXh/ImbYTwCWYS7u9KexjyJ0JmvvMIz1/tVTebYI5gbud
        TW6tc8pDP9xAu5znNia0nuj06EbicSw/4sJTHIWLRPwaTJUieIbtF35CX5vs6kl6JJRZRI
        r+pDGRRzkRaG8cMNJypjoZCzR0UfjGRHNpggwTEqKmRFJgzxZkFDTHomFWoQPfJyEgPKYs
        o6eB/t8zdTEiSeWQdPrarWSVYiW8cWpEfSeHCXhnA2Rpyv1X5xWtppiBv2pghg==
Date:   Fri, 24 Jun 2022 19:02:13 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     krzysztof.kozlowski+dt@linaro.org, a.zummo@towertech.it,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        allen-kh.cheng@mediatek.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/1] dt-bindings: rtc: mediatek: add mt6358 and mt6366
Message-ID: <165609010351.26598.10943773061528441669.b4-ty@bootlin.com>
References: <20220428092726.25814-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428092726.25814-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 17:27:25 +0800, Allen-KH Cheng wrote:
> Base on tag: next-20220427, linux-next/master
> 
> changes since v1:
>  - correct wrong compatible order for mt6366
> 
> Allen-KH Cheng (1):
>   dt-bindings: rtc: mediatek: add mt6358 and mt6366 compatible
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: rtc: mediatek: add mt6358 and mt6366 compatible
      commit: 31d399dcb74ec6f0e51414b2a251b58f9a1ef87b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
