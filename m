Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E925794AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiGSH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiGSH5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:57:17 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E526F2AE39
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=2cIAQ8Q87Su0xZjwFvxWnDl7yaVEuz+orMsRxOWQtYs=;
        b=A9TzvSRl9qa2gKDkZ7WTu/eJU9KIqJ4YckBWNGrnnbkd0WWETmYLn9/hpUxq2tLMoNWw0zf4yZDRw
         gnZIpUFk57ynNZw2Qj5ydTQfpDrwEgKj2xndN9bWGfd76nHAL9C1olbZblsWM3qVXBIcJaFhXrwCZP
         TP+BgeLM3xL09ajysK1R1okSt96o6C/jbdd4Zmxn//yk7c7AB9M17lsfRXLtrmTY+JzHgHlkwxSahH
         KVKyfbdAnNz4j3ueJuzPHXwxdh1l8sTdOKWSc9kf8stZN0T7TPaQKw/G2vd35xXaa5MLDDfL6FYkB5
         8MkwwssYPsQquP+qoV7ETWXW418du/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=2cIAQ8Q87Su0xZjwFvxWnDl7yaVEuz+orMsRxOWQtYs=;
        b=Ckq/4EfNAN8crPZdNPERFvfDyFnaOOKE8TbiBV33dgGS410bjTk0YIy/DNH+aJ+P2sHF0MpiOAfNw
         v3EpcsTCA==
X-HalOne-Cookie: 45e94343b7d45f836c1765849a42fe61463e522e
X-HalOne-ID: 65e9548c-0738-11ed-a6c8-d0431ea8a283
Received: from mailproxy1.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 65e9548c-0738-11ed-a6c8-d0431ea8a283;
        Tue, 19 Jul 2022 07:57:13 +0000 (UTC)
Date:   Tue, 19 Jul 2022 09:57:11 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        phone-devel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/4] dt-bindings: panel: Add LG SW43408 MIPI-DSI panel
Message-ID: <YtZj1yV3blLOJH62@ravnborg.org>
References: <20220718213051.1475108-1-caleb@connolly.tech>
 <20220718213051.1475108-4-caleb@connolly.tech>
 <YtZKylMu4jEa/oDp@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtZKylMu4jEa/oDp@ravnborg.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caleb,

On Tue, Jul 19, 2022 at 08:10:18AM +0200, Sam Ravnborg wrote:
> Hi Caleb,
> 
> On Mon, Jul 18, 2022 at 10:30:50PM +0100, Caleb Connolly wrote:
> > From: Sumit Semwal <sumit.semwal@linaro.org>
> > 
> > LG SW43408 is 1080x2160, 4-lane MIPI-DSI panel.
> A few things to improve to this binding.
> 
> 	Sam
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> > [caleb: convert to yaml]
> > Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> > ---
> >  .../bindings/display/panel/lg,43408.yaml      | 41 +++++++++++++++++++
> >  .../display/panel/panel-simple-dsi.yaml       |  2 +
> >  2 files changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,43408.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/lg,43408.yaml b/Documentation/devicetree/bindings/display/panel/lg,43408.yaml
> > new file mode 100644
> > index 000000000000..0529a3aa2692
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/lg,43408.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: LG SW43408 1080x2160 DSI panel
> > +
> > +maintainers:
> > +  - Caleb Connolly <caleb@connolly.tech>
> > +
> > +description: |
> > +  This panel is used on the Pixel 3, it is a 60hz OLED panel which
> > +  required DSC (Display Stream Compression) and has rounded corners.
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: lg,sw43408
> > +
> > +  vddi-supply: true
> > +  vpnl-supply: true
> > +  reset-gpios: true
> > +
> > +  backlight: false
> > +  power-supply: false
> No need to say anything is false, this is covered by the statement below.
> Also, the driver uses backlight, so it should be true?
The driver do not use backlight from the DT so disregard the last
comment.

	Sam
