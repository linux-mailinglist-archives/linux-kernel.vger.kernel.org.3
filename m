Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC725679EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiGEWGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiGEWGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:06:39 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6065C19C01;
        Tue,  5 Jul 2022 15:06:38 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id EDDA3D0A87;
        Tue,  5 Jul 2022 22:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1657058766; bh=eXM/PactU0SWohQdnU6JM3exuAXvUMJXVlduTn27Kac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xzzqXu1cMZG1tQK66TdZI9aRVAxYUEgTNsvM+GA79k0eZ4XXF5ofXN+lpPdBQtf0h
         HpQtJE+JXT5994OTOrxAimIzpDtuOpz/dM/k+mmUYL0d0bBAlitfWjbY/AQ7QF8qkC
         PVegjoJGKUrSDulCe5zGGio9HSe8JElT+EzPx21s=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: qcom: msm8974-*: re-add remoteproc supplies
Date:   Wed, 06 Jul 2022 00:06:05 +0200
Message-ID: <12009239.O9o76ZdvQC@g550jk>
In-Reply-To: <Yr5mua6i6WxoAlzB@builder.lan>
References: <20220606160421.1641778-1-luca@z3ntu.xyz> <20220606160421.1641778-2-luca@z3ntu.xyz> <Yr5mua6i6WxoAlzB@builder.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Freitag, 1. Juli 2022 05:15:05 CEST Bjorn Andersson wrote:
> On Mon 06 Jun 11:04 CDT 2022, Luca Weiss wrote:
> > As part of a recent cleanup commit, the remoteproc supplies for adsp and
> > modem were removed from msm8974.dtsi and now need to be set in the
> > device dts. Do so.
> > 
> > Fixes: f300826d27be ("ARM: dts: qcom-msm8974: Sort and clean up nodes")
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > Bjorn, could you please pick this up for -fixes so it lands in an
> > upcoming 5.19-rc?
> 
> As reported by lkp, this doesn't build. Am I missing something?

I briefly mentioned in IRC, maybe you missed it.
Castor is actually still missing pm8841 regulators upstream.
I'll send this old (rebased) commit from you to add them, is that ok with you?

https://github.com/msm8974-mainline/linux/commit/
d01e20807a00e78570abf3dd91bea555dff06fa9

Otherwise we can just keep castor out of this patch for now and add it later, 
I don't really mind either way.

Regards
Luca

> 
> Regards,
> Bjorn




