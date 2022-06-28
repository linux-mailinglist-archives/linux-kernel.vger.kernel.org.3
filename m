Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E055E271
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiF1IA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiF1IAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F53213D5B;
        Tue, 28 Jun 2022 01:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B12496104E;
        Tue, 28 Jun 2022 08:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A9EC3411D;
        Tue, 28 Jun 2022 08:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656403224;
        bh=aijp6DmSOsxg3ML/b3u+5AynjVUvqqeBYGfLP419iiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9hPPftkQRDi9dE8PgfFfmgGI4uMPXNZzI9LIXJm4MIyHQ/gwgVjhbVI2B688IhyL
         v3qyt6Mzj6i7CXBlnkwDp3t4hyZ37hT0ndseXrxS0ewM2wloO+zasMTkrQOXAArBHT
         whmR+vvGy0UFnIHU2H/5tetzqn5ovHGOzAtNcyRAABhyLRBzh8DkpQWmDvgoE1vUeL
         k6OnQzAEljTP9b5fD4o+I4RD2i4bmx5z3F8d2MofYYvxhvqnpOJshicCQc0E4fdw7X
         GxhlFVb0tFx+c5AhwFRKJvUYwt+/qKQuFmlKV7/XLo9z3gebxkeH4jbdF14by3jDec
         Qhd/Z5s8kCCQQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o668y-0005xl-Mz; Tue, 28 Jun 2022 10:00:21 +0200
Date:   Tue, 28 Jun 2022 10:00:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s
 devicetree
Message-ID: <Yrq1FAscp+jE7GQs@hovoldconsulting.com>
References: <YrMVqifgV4kZaP7F@hovoldconsulting.com>
 <20220622132617.24604-1-johan+linaro@kernel.org>
 <96394aa2-aefc-63c4-d86f-15c06d092d75@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96394aa2-aefc-63c4-d86f-15c06d092d75@somainline.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 01:38:47PM +0200, Konrad Dybcio wrote:
> On 22.06.2022 15:26, Johan Hovold wrote:
> > Add an initial devicetree for the Lenovo Thinkpad X13s with support for
> > USB, backlight, keyboard, touchpad, touchscreen (to be verified), PMICs
> > and remoteprocs.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Krzysztof's tag wasn't here in the version I posted.

> > +	reserved-memory {
> > +	};
> You still haven't explained this weird node (I don't believe
> the thing doesn't mind you poking at 'secure' regions, and even
> if otherwise, it is unused for now).

It's just unused for now, so sure, we can remove it until we need it.

Johan
