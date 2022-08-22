Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0059C5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbiHVSRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiHVSRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:17:05 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523C4474D3;
        Mon, 22 Aug 2022 11:17:03 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id x10-20020a4a410a000000b004456a27110fso2067114ooa.7;
        Mon, 22 Aug 2022 11:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wr3T6nwiPR4God23X0ht/yMOkWjJEmi2UiAJmbegkhE=;
        b=h8AvtHk6UuRn2JkKlpN6GUgSpQjXFvMAbwgRegIueNqkAXG9ob2kwsTNihDMNYAbQf
         VfSucMvpCeyQelzZSZPaSHsi5PN/cPz+1dccQfFRtZi6oKI6A4+Fy0PxyEgLWVlpXcgP
         +cNK2tL7hMOYx3rTADNARdp0O1ekYuvnnWm2Sm7Bsf/Ui8IU/13Z5j7ockm4pcXlZAlN
         lU7cv0ulwLHsGNg9rtoebkOlP9FCOAAuOv3++SOkdrWWDz9Aw/OT55DxjmleUFTVjYea
         Sd4Q5MAc9yAy5s2j/3nT3V023dlt8f4Y1dsJFM/taUByhVJ5YxL9TZyKtjteZaNlIFW4
         rnsw==
X-Gm-Message-State: ACgBeo31cdDmbr8y6+/onR6xDDQArWvVWce/sJHJN3Fbm0/jERme2TLN
        ++kYVq5KwkE3NzqN4bZP5IeUhrqZkw==
X-Google-Smtp-Source: AA6agR6nHv8gJmC+y1eURVamETu/QjYWblwoWLkiI+7mNBESQfIyR8fe5y0cu7lv017LP9cXqvnnWA==
X-Received: by 2002:a4a:a681:0:b0:44b:35ac:f06d with SMTP id f1-20020a4aa681000000b0044b35acf06dmr15153oom.9.1661192222976;
        Mon, 22 Aug 2022 11:17:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 3-20020a9d0b83000000b0063706889f89sm3051383oth.8.2022.08.22.11.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:17:02 -0700 (PDT)
Received: (nullmailer pid 97102 invoked by uid 1000);
        Mon, 22 Aug 2022 18:17:01 -0000
Date:   Mon, 22 Aug 2022 13:17:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: lan966x-otpc: document Lan966X OTPC
Message-ID: <20220822181701.GA89665-robh@kernel.org>
References: <20220818164405.1953698-1-horatiu.vultur@microchip.com>
 <20220818164405.1953698-2-horatiu.vultur@microchip.com>
 <550e652e-4541-c1e6-33a7-d5555f0cb266@linaro.org>
 <20220822060456.sl343a3a3uifini7@soft-dev3-1.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822060456.sl343a3a3uifini7@soft-dev3-1.localhost>
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

On Mon, Aug 22, 2022 at 08:04:56AM +0200, Horatiu Vultur wrote:
> The 08/19/2022 09:52, Krzysztof Kozlowski wrote:
> 
> Hi Krzysztof,
> 
> > 
> > On 18/08/2022 19:44, Horatiu Vultur wrote:
> > > Document Lan966x OTP controller.
> > >
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: microchip,lan966x-otpc
> > 
> > No wildcards in compatible (which will also affect the file name as it
> > should match the compatible).
> 
> Ok, I will replace lan966x with lan966 as the SoC is defined (SOC_LAN966)

Pretty sure that's still a wildcard for the SoC family. 9668 or 9662 are 
the ones we already have. Yes, there's already a bunch of 966x 
compatibles, but that's not a pattern that should continue.

Rob
