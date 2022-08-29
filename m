Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8055C5A4EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiH2OKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiH2OKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:10:38 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9AF6BD69;
        Mon, 29 Aug 2022 07:10:31 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id z22-20020a056830129600b0063711f456ceso5963602otp.7;
        Mon, 29 Aug 2022 07:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=opbj1lT2rqww+Ko38iiUdytadU+k9CoQLS7KnrXSbyY=;
        b=wbQbQl9+s2rVlBIofj2GiXT37b2zWTDhTmTcchKG7EIJvuRm4V0C23ExIvweNk/P5v
         NM9DTrkW1fu7MSET6QkwIVaZfN06z5GYxSpAttJSoADwTaOH+vdNooBI4ZWNiUTAXCRe
         T39xcUx0wox8tT+ggOuSHwuitD5C5kyPEF1rapK0qA+BssbcQc6rall9CN/lmDAZVG5S
         QeCR0ZF4nGangKBkzpMi4rXLy93NWcrSLtdy/Rr5eJGqBRsjHLaifLpYf/zUZeQsWbQc
         Z+raDVLMimDok94WonC107/7hGE4zgy+vXHXy+0Rt6+D8Lah7YKqmncpkIWtrx1Bh5Hg
         Q2qA==
X-Gm-Message-State: ACgBeo1gj1GxFjI8RC8StcDpqA7BjlP2Wvh0pAKmMX6PYlVNMOVkmsu/
        i0jit8CUl1MsRFLozi+BQw==
X-Google-Smtp-Source: AA6agR7WIHe/AiLYD102e5d5uKFjLIhVyxUpACShz6LmoyBGjUcs44MJ20snIPOKxNFUVwlVnmhpXw==
X-Received: by 2002:a05:6830:3914:b0:638:f80c:e964 with SMTP id br20-20020a056830391400b00638f80ce964mr6530478otb.220.1661782231113;
        Mon, 29 Aug 2022 07:10:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a056830070500b0063b2875246dsm2805095ots.49.2022.08.29.07.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:10:30 -0700 (PDT)
Received: (nullmailer pid 1485236 invoked by uid 1000);
        Mon, 29 Aug 2022 14:10:29 -0000
Date:   Mon, 29 Aug 2022 09:10:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220829141029.GA1470207-robh@kernel.org>
References: <20220823145649.3118479-2-robh@kernel.org>
 <99dfcc39-ab1b-1b24-c6b2-67de5509f5ac@linaro.org>
 <20220828180050.51c3e857@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828180050.51c3e857@jic23-huawei>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 06:01:41PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Aug 2022 15:04:33 +0300
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 23/08/2022 17:56, Rob Herring wrote:
> > > In order to ensure only documented properties are present, node schemas
> > > must have unevaluatedProperties or additionalProperties set to false
> > > (typically).
> > >   
> > 
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Applied to the togreg branch of iio.git and pushed out as testing for 0-day
> to poke at it before I push out as togreg for linux-next to pick up.

Thanks.

> Side note. Some odd entries in your cc list...  alsa-devel?

Blame MAINTAINERS:

STM32 AUDIO (ASoC) DRIVERS
M:      Olivier Moysan <olivier.moysan@foss.st.com>
M:      Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
L:      alsa-devel@alsa-project.org (moderated for non-subscribers)
S:      Maintained
F:      Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
F:      Documentation/devicetree/bindings/sound/st,stm32-*.yaml
F:      sound/soc/stm/
