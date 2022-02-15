Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D224B785E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbiBORqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:46:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbiBORqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:46:20 -0500
X-Greylist: delayed 68607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 09:46:10 PST
Received: from hs01.dk-develop.de (hs01.dk-develop.de [173.249.23.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B922DE6859;
        Tue, 15 Feb 2022 09:46:10 -0800 (PST)
Date:   Tue, 15 Feb 2022 18:46:06 +0100
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: dt-bindings: ps2-gpio: convert binding to json-schema
Message-ID: <Ygvm3qzBZjY66zLq@pollux>
References: <20220215165113.52659-1-danilokrummrich@dk-develop.de>
 <cce2459e-cb6e-898c-e130-e818bd427ef3@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce2459e-cb6e-898c-e130-e818bd427ef3@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Feb 15, 2022 at 06:01:19PM +0100, Krzysztof Kozlowski wrote:
> On 15/02/2022 17:51, Danilo Krummrich wrote:
> > Changes since v1
> > ================
> >   - binding as separate patch (driver patch will be sent outside the scope of
> >     this patch series)
> 
> Bindings patches are not a separate series, but a separate patches
> within the series, so driver should be posted here as well.
The changes are not dependent, as if a new property would have been added,
which is why I removed it from the series. However, they're at least related.
So if it's preferred, I'll add it to the series again.
> 
> Best regards,
> Krzysztof

- Danilo
