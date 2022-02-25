Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8372C4C4101
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiBYJMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiBYJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:12:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C6E673C0;
        Fri, 25 Feb 2022 01:12:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01563B82C91;
        Fri, 25 Feb 2022 09:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CA3C340E7;
        Fri, 25 Feb 2022 09:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645780318;
        bh=t0jy4qpB4w9g+G1LKwCTnG1XlrLlJoe+llPCFjMaO00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBK1jeOZWu75/kRVG76Kj+91pqiNXrshuPp2tRusz2zKpRvrSigivtyqHpw8tnJxV
         +sdVHAf1cc1MJUD5fdbq9FBjKTMNjqqE6kOX1TzEOY7d+nh2qSSI8ZQJaS+mvTCEmd
         sGY/7VYcIl2hq52PtF1b7Q+c0COAx4HtfXEsshSk=
Date:   Fri, 25 Feb 2022 10:11:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] dt-bindings: usb: qcom,dwc3: Add msm8953
 compatible
Message-ID: <YhidXLh5akwgqnDm@kroah.com>
References: <20220220201909.445468-1-luca@z3ntu.xyz>
 <20220220201909.445468-4-luca@z3ntu.xyz>
 <Yhfmgm2i5h7zEuvA@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhfmgm2i5h7zEuvA@builder.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 02:11:46PM -0600, Bjorn Andersson wrote:
> On Sun 20 Feb 14:18 CST 2022, Luca Weiss wrote:
> 
> > Document the compatible string for the DWC3 controller in msm8953.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> Greg, can you please pick this patch through the USB tree.

Will do, thanks.

gre gk-h
