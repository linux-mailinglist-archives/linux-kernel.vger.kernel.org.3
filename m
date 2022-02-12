Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD3C4B3541
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiBLNNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 08:13:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiBLNNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 08:13:47 -0500
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de [80.67.18.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B6D2656A;
        Sat, 12 Feb 2022 05:13:38 -0800 (PST)
Received: from [92.206.166.137] (helo=note-book.lan)
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1nIsDb-0002iA-PA; Sat, 12 Feb 2022 14:13:39 +0100
Message-ID: <9a89a99872ff2fd67f097224584121e50b8a2f07.camel@apitzsch.eu>
Subject: Re: [PATCH v2 2/3] dt-bindings: leds: sgm3140: Document ocp8110
 compatible
From:   =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Feb 2022 14:13:32 +0100
In-Reply-To: <YgaQAwfYnt6E9buG@robh.at.kernel.org>
References: <20211117091405.7412-1-git@apitzsch.eu>
         <20220207230638.56730-1-git@apitzsch.eu>
         <20220207230638.56730-3-git@apitzsch.eu>
         <YgaQAwfYnt6E9buG@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 11.02.2022 um 10:34 -0600 schrieb Rob Herring:
> On Tue, Feb 08, 2022 at 12:06:37AM +0100, André Apitzsch wrote:
> > Signed-off-by: André Apitzsch <git@apitzsch.eu>
> 
> Commit msg? What's this h/w?
> 
Thanks for the feedback.

Would the following message be sufficient?

"""
dt-bindings: leds: sgm3140: Document ocp8110 compatible

Add devicetree binding for Orient Chip OCP8110 charge pump used for
camera flash LEDs.
"""

> > ---
> >  Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > index f68259619488..1c345cf16d08 100644
> > --- a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > +++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > @@ -18,7 +18,9 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    const: sgmicro,sgm3140
> > +    enum:
> > +      - ocs,ocp8110
> > +      - sgmicro,sgm3140
> >  
> >    enable-gpios:
> >      maxItems: 1
> > -- 
> > 2.35.1
> > 
> > 

