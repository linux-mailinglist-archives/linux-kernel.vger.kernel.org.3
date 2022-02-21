Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1C4BEC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiBUVC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:02:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiBUVC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:02:26 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A312A95;
        Mon, 21 Feb 2022 13:02:02 -0800 (PST)
Received: from g550jk.localnet (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C60EDC83FC;
        Mon, 21 Feb 2022 21:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645477320; bh=vTYTx2kZKL4SDNQhmOyoW1PmbnmhmCHsmJ/aMNA2yhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LxIj9DM7hxfCALbL8mfAmxoatI7QL3B9dmIMd85IyiH21dwg0OycyTpw000IV19vS
         bSEvookwcBwB8gW5q40t74V5wS1quP0oqx1bBuhXGZxgqwdJJ6Agxxo0itOVkj3E/B
         KmaD4LBd8WSjJAkQBBE5LW93rlmvemGtG0xWdpUw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: mfd: qcom,tcsr: Document msm8953 compatible
Date:   Mon, 21 Feb 2022 22:01:59 +0100
Message-ID: <11925600.O9o76ZdvQC@g550jk>
In-Reply-To: <YhNRweYMmkaSKJX7@google.com>
References: <20220220201909.445468-1-luca@z3ntu.xyz> <20220220201909.445468-2-luca@z3ntu.xyz> <YhNRweYMmkaSKJX7@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Montag, 21. Februar 2022 09:48:01 CET Lee Jones wrote:
> On Sun, 20 Feb 2022, Luca Weiss wrote:
> > Document the compatible for tcsr found in msm8953.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes in v2:
> > - no changes
> > 
> >  Documentation/devicetree/bindings/mfd/qcom,tcsr.txt | 1 +
> >  1 file changed, 1 insertion(+)
> 
> This is already applied.

Sorry, last week you wrote[0]

> Doesn't seem to apply.
>
> Could you please rebase.

and it wasn't part of linux-next as of yesterday.

I'll remember to drop it if I have to send a v3.

Regards
Luca

[0] https://lore.kernel.org/linux-arm-msm/YgujkzAezfFBNRDP@google.com/


