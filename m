Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E615578B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiGRUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiGRUCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:02:13 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2672B1277A;
        Mon, 18 Jul 2022 13:02:13 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id h145so10188742iof.9;
        Mon, 18 Jul 2022 13:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hsva2XeLTXYA3pmbulVo9SFnlL5NoziYrhGMsppBEB4=;
        b=SLI1vPma8/gqLdzYuSTcnBGD+uNU3nkN4N57tS9KbRe2o7emGkbMzjsvvsjLUhSGNr
         R0S6iszGCkniK2aYxuUOqWvMgNp50xXWDg9A2IFw/55XRz94g1VDEu4hM6/ZRxZix5qd
         vMJvkuoaoTWkAupADiIe7bPjFQ/RjtzbLgrVS/KEbK69MUek/CLZchjRA3Eu2Zd8ti08
         CWndhDpZ/CkJJ0/axWXOKZaoeABHvsHjf/zILz1nhT5mlZJBEL/dfsMOGJtj3R34pVNl
         +vKR95x8fBmNT8ZfodyaEbXFRSVDXhgzmr+Yn5c5wKqIyuFtFvx+0+O8G4/OmeitpRSs
         eR+g==
X-Gm-Message-State: AJIora85EPA0r4WDfSGGGZEttyxBa8Yfz7m4fc25DHhvqhLJLnC9XicQ
        Rw2h91n/Mpf795hC0BPT3w==
X-Google-Smtp-Source: AGRyM1v0S+9leHvsXKTlm7rkpwJ0N6xwue0xbSBj2n+6jLJwGXlQ5dDvSMBrvu1VKXfzRlI9M5F3mQ==
X-Received: by 2002:a02:3f5c:0:b0:33e:ff53:a40e with SMTP id c28-20020a023f5c000000b0033eff53a40emr14913871jaf.230.1658174532365;
        Mon, 18 Jul 2022 13:02:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l40-20020a026668000000b0032e3b0933c6sm5764580jaf.162.2022.07.18.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:02:12 -0700 (PDT)
Received: (nullmailer pid 3451017 invoked by uid 1000);
        Mon, 18 Jul 2022 20:02:10 -0000
Date:   Mon, 18 Jul 2022 14:02:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: arm64: bcmbca: Merge BCM4908 into
 BCMBCA
Message-ID: <20220718200210.GA3436421-robh@kernel.org>
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-2-william.zhang@broadcom.com>
 <ca8c3003-1bcb-6658-592c-566609fd7bd2@linaro.org>
 <94b0ab39-279d-d3c2-98a4-054c10ad041c@broadcom.com>
 <c40f20c7-59ee-99f4-9a11-e928b41eda9f@linaro.org>
 <6efb1cfe-6129-276a-eeb3-44147304d211@broadcom.com>
 <e4356c5e89492eb690e3dc863ba281bd@milecki.pl>
 <85219d59e2906534409fc24ad2e5e4c9@milecki.pl>
 <147bc812-3971-9832-fb39-5545e280f562@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <147bc812-3971-9832-fb39-5545e280f562@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:37:18AM -0700, William Zhang wrote:
> Hi Rafal,
> 
> On 7/13/22 03:58, Rafał Miłecki wrote:
> > On 2022-07-13 12:50, Rafał Miłecki wrote:
> > > On 2022-07-13 02:57, William Zhang wrote:
> > > > On 7/12/22 11:18, Krzysztof Kozlowski wrote:
> > > > > On 12/07/2022 19:37, William Zhang wrote:
> > > > > > > > +      - description: BCM4908 Family based boards
> > > > > > > > +        items:
> > > > > > > > +          - enum:
> > > > > > > > +              # BCM4908 SoC based boards
> > > > > > > > +              - brcm,bcm94908
> > > > > > > > +              - asus,gt-ac5300
> > > > > > > > +              - netgear,raxe500
> > > > > > > > +              # BCM4906 SoC based boards
> > > > > > > > +              - brcm,bcm94906
> > > > > > > > +              - netgear,r8000p
> > > > > > > > +              - tplink,archer-c2300-v1
> > > > > > > > +          - enum:
> > > > > > > > +              - brcm,bcm4908
> > > > > > > > +              - brcm,bcm4906
> > > > > > > > +              - brcm,bcm49408
> > > > > > > 
> > > > > > > This is wrong.  brcm,bcm94908 followed by brcm,bcm4906 does not look
> > > > > > > like valid list of compatibles.
> > > > > > > 
> > > > > > For 4908 board variant, it will need to be followed by
> > > > > > 4908 chip. Sorry
> > > > > > for the basic question but is there any requirement to
> > > > > > enforce this kind
> > > > > > of rule?  I would assume dts writer know what he/she is
> > > > > > doing and select
> > > > > > the right combination.
> > > > > 
> > > > > The entire point of DT schema is to validate DTS.
> > > > > Combination like above
> > > > > prevents that goal.
> > > > > 
> > > > > Best regards,
> > > > > Krzysztof
> > > > Understand the DT schema purpose. But items property allows multiple
> > > > enums in the list which gives a lot of flexibility but make it hard to
> > > > validate. I am not familiar with DT schema, is there any directive to
> > > > specify one enum value depending on another so dts validation tool can
> > > > report error if combination is wrong?
> > > > 
> > > > This is our preferred format of all bcmbca compatible string
> > > > especially when we could have more than 10 chip variants for the same
> > > > chip family and we really want to work on the chip family id.  We will
> > > > make sure they are in the right combination in our own patch and patch
> > > > from other contributors. Would this work? If not, I will probably have
> > > > to revert the change of 4908(maybe append brcm,bcmbca as this chip
> > > > belongs to the same bca group) and use "enum board variant", "const
> > > > main chip id", "brcm,bca" for all other chips as our secondary choice.
> > > 
> > > I'm not sure why I didn't even receive 1/3 and half of discussion
> > > e-mails.
> > > 
> > > You can't just put all strings into a single bag and allow mixing them
> > > in any combos. Please check how it's properly handled in the current
> > > existing binding:
> > > Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml
> > > 
> > > Above binding enforces that non-matching compatible strings are not used
> > > together.
> > 
> > I just noticed you're actually removing brcm,bcm4908.yaml in the 2/3 so
> > you must be aware of that file.
> > 
> > So you see a cleanly working binding in the brcm,bcm4908.yaml but
> > instead copying it you decided to wrote your own one from scratch.
> > Incorrectly.
> > 
> > This smells of NIH (not invented here). Please just use that binding I
> > wrote and move if it needed.
> 
> Not mean to discredit any of your work and I did copy over your binding and
> combine them into one SoC entry to the new bcmbca.yaml and add you as one of
> the maintainer to this file. As this change would certainly concern you,
> that's why I sent RFC first.  As I explained in the cover letter, the
> purpose of the change is to reduce the number of compatible strings and keep
> one entry for one chip family due to possible large number of chip variants.
> But since there is no way to validate the combination, I will copy the
> existing 4908 bindings as they are now but I would propose to append "brcm,
> bcmbca" as it is part of bcmbca chip. And for the other chips, we would just
> use enum "board variant", const "main chip id", const "brcm,bca".  Does that
> sound good to you?

If you want fewer combinations of compatibles, adding a genericish 
"brcm,bcmbca" is not going to help. Is there much value to adding it? 
What can you do with that information (and nothing else) is the 
question to ask. 

Rob
