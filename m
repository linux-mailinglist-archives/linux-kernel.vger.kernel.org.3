Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9156C9BC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiGIN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 09:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiGIN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 09:57:49 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96392491DC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=DW9E7LotanhEdCfJgAU6YAugMIE+y2/N10PXcxYE6NE=;
        b=X96BNvwEPYU/AWi0AnnSY1C6yji6n/MVkb6zkHy4NzLKPi5OFUguq2LXwPy+Azaq4S0Ktw4hezr7D
         jMZ2lIDC7DGxIRIrM4lXOZ1FBVFZ1WlWOOUiOGhSI/Keq4db8hnydASNNX0uj3FA8AsEd6luigibBH
         s/lazen9sCJXGBeSGN3Mn44NYg4OUM4+UlB1AcVa7KW+do4282w7bauf06/nBgkfxmNWkpaSrBwQYF
         iEjorjffiH6jO1O4EwitLDNpr2YOLkEQtXKW4NyX4B7+eYG76fyWPwA61uFSwKTvb7YWVZefQawOFB
         EPAufF/qBix636CHHSOOrL7J59RPD3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=DW9E7LotanhEdCfJgAU6YAugMIE+y2/N10PXcxYE6NE=;
        b=D8hno8mT5l4KSmvyvEpmfVmAuoT1KBF3FopG8zYqg/11I0aqr5Z4HhzZwyYpnZfRJCjiPp5QLWJ0n
         7DMejwZCg==
X-HalOne-Cookie: 384c07829e1e26af4942da55cdb9b473b8d8ec02
X-HalOne-ID: 1c761a6e-ff8f-11ec-be7e-d0431ea8bb03
Received: from mailproxy2.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 1c761a6e-ff8f-11ec-be7e-d0431ea8bb03;
        Sat, 09 Jul 2022 13:57:46 +0000 (UTC)
Date:   Sat, 9 Jul 2022 15:57:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] drm/panel: simple: add support for the Samsung
 LTL101AL01 panel
Message-ID: <YsmJWYP2Q10zRUC/@ravnborg.org>
References: <20220516193709.10037-1-martin.juecker@gmail.com>
 <20220516193709.10037-2-martin.juecker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516193709.10037-2-martin.juecker@gmail.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin, the patch looks good.

On Mon, May 16, 2022 at 09:37:08PM +0200, Martin Jücker wrote:
> Add timings and panel description for the Samsung LTL101AL01 panel.
> 
> Signed-off-by: Martin Jücker <martin.juecker@gmail.com>

Applied to drm-misc (drm-misc-next).

	Sam
