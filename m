Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C24E5464
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiCWOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240637AbiCWOkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:40:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427F77CDF8;
        Wed, 23 Mar 2022 07:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0CABB81F54;
        Wed, 23 Mar 2022 14:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF31CC36AE7;
        Wed, 23 Mar 2022 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648046360;
        bh=7hScU2wmlNgM/yQ8a4259GS5BdEa/xV6MFfLX6ni2K0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rGUjVHiwFih154F83bEJSn4pAvwlxs0HZ959xjNYb1dfz66dbs52/zIKe9ZkvOxSL
         ABB1VbMccyZ3DNukWHfVl31bXum+b650tADAiJowQ3l0/vjr9pf/pLhKQa2g938vc4
         p6CJJr3LXDozl2Irqa02DW/bNdcWFdV2HG1yxoizOE0PtjldMlylhiePt3eohsMH1A
         4RszRhFsCEfqHkaid7K8oVvNhMZLEAtd0I0OcezIbcbtTubaUK5XWnMYWvJeZWKVNH
         4BbdlWIS12j7Lq4Mspq/RZyPXVSo/LZEgOIgDl1ojcM0kBtE70nVBXY2kPJLOqyqtW
         7672ie+TjiiKA==
Received: by mail-ej1-f51.google.com with SMTP id p15so3257740ejc.7;
        Wed, 23 Mar 2022 07:39:20 -0700 (PDT)
X-Gm-Message-State: AOAM533iNqFw/QhkVTFWvSi+IjjSF/HDex3qd3NR8/lwO76A0YTpjjrQ
        aSugkG1dmsWWHof6bpMmqppiU/QUf6qjEmWeTA==
X-Google-Smtp-Source: ABdhPJw2vEInYJhzD6Sf81xfPAK8TCv4R6vkavYp+uogbKSt/3KF5JGasr6aiXQ1YYxZKamMelaTIzKIIlvJ+HwzOfc=
X-Received: by 2002:a17:906:58ce:b0:6da:b548:1bbb with SMTP id
 e14-20020a17090658ce00b006dab5481bbbmr307806ejs.14.1648046359044; Wed, 23 Mar
 2022 07:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220308155735.54146-1-alexandre.belloni@bootlin.com> <CAL_JsqJXz01F_+-xg8VfAOQ=-C96NVa1KO+nRbXf9mq289kmYQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJXz01F_+-xg8VfAOQ=-C96NVa1KO+nRbXf9mq289kmYQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 23 Mar 2022 09:39:07 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq++eqGS6xJ6EgwXe2RpZYgbB30kfTvZQx=sGmb-LgVWXg@mail.gmail.com>
Message-ID: <CAL_Jsq++eqGS6xJ6EgwXe2RpZYgbB30kfTvZQx=sGmb-LgVWXg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: rtc: at91: rename rtt bindings file
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 3:05 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Mar 8, 2022 at 9:57 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > atmel,at91sam9-rtc is a confuing name for this file as it is documenting
> > the RTT used as an RTC and not the other regular RTC (atmel,at91rm9200-rtc
> > and atmel,at91sam9x5-rtc)
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  .../rtc/{atmel,at91sam9-rtc.yaml => atmel,at91sam9260-rtt.yaml}   | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename Documentation/devicetree/bindings/rtc/{atmel,at91sam9-rtc.yaml => atmel,at91sam9260-rtt.yaml} (100%)
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> > similarity index 100%
> > rename from Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> > rename to Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
>
> Now failing in -next:
>
> ./Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml:
> $id: relative path/filename doesn't match actual path or filename
>   expected: http://devicetree.org/schemas/rtc/atmel,at91sam9260-rtt.yaml#

Still failing...

Rob
