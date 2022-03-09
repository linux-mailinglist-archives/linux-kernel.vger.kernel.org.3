Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970734D2B17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiCII7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiCII7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:59:00 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1DB3BBDF;
        Wed,  9 Mar 2022 00:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646816281;
  x=1678352281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aS8+yoDb2DbWhQsnTch4ovl6vT322ncAewYFCGHb4qs=;
  b=aQTgtdZzNZen1nVSuL/3mA2bvsC2o7n1hB3BwrwuoMJ7eJroYiQJkfCr
   LyagumiVK5nTlLIxRyOaUnXpmWzhsrFjr3UAtR546dF04SOQeh+SKZG98
   CRkPJ6rvrKMJB8YOCj7+No6ph+OvOMiWswPHCoyj/3qzCxA/27O63Q5wA
   M+ef149fCFhijyd1zLqgzYb4+I8zwuZ07+SJy+i/qhlboY0TWJ8lSVyTM
   FNbBqVn9mdRJBTHSFFKHzY90znSFzmlra3VP9ZJtdDzBkZteG0xnSADfw
   QcQWpSUR42jcwqKpFK0KZEFcvp/Dvs08AuMxMsEozB1wkfDt4vjUEZFng
   g==;
Date:   Wed, 9 Mar 2022 09:57:56 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: samsung: Add ARTPEC-8 UART
Message-ID: <20220309085756.GA18220@axis.com>
References: <20220307085053.1636475-1-vincent.whitchurch@axis.com>
 <20220307085053.1636475-2-vincent.whitchurch@axis.com>
 <CAL_JsqKBDOu+63YrDCX51-zoTPu1utiPxXYmihL9kMvrpD3ctA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKBDOu+63YrDCX51-zoTPu1utiPxXYmihL9kMvrpD3ctA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 04:41:45PM +0100, Rob Herring wrote:
> On Mon, Mar 7, 2022 at 2:51 AM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > Add a compatible for the UART on the ARTPEC-8 SoC.
> 
> Yes, the diff says that already. Perhaps some explanation why you are
> adding another vendor SoC to Samsung UART and how the h/w is
> different. I can only guess based on having just gone thru this with
> Apple.

The IP has been customized for the ARTPEC-8 SoC but is closely related
to the variants used on the Exynos chips.  I can add this information to
the commit message.

The choice of the vendor prefix is similar to the solution chosen in
this patch:

 https://lore.kernel.org/lkml/20220125031604.76009-2-alim.akhtar@samsung.com/
