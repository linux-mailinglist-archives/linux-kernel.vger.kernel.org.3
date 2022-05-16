Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E3F528799
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbiEPOwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244767AbiEPOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:51:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E442ED5F
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:51:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m1so20880179wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SeZl4TVtX1UvBbSN4DhYGcCc+k3YwY/2lrXCgjw02qc=;
        b=h6NL8HuUSflgfv5huQkfVvIRc6fUYJb5sAuaO7I8feGeCkPg0F/xpCzggKTOIk+bTv
         taj297i3yCFnsulWdVt7u0uxpXOMiXB4Elalif58X2dLyFgQqFgnZZIOpDjuCEbMdP8Y
         nL6x5SLUASyLD+e+SEUoMYFHaBhpNEl2BNXvC0Vg6NCOnnXIiZQ2OycdwYa/knil5MzN
         FY7EqNfy4IH407IqKW+fEdDUEiqPbO7jT2kKKwP6xLqZuPw0VXOkrBDjbi3stypRLtzk
         rWJ867Q5ShxOHBG1aKtYiZoObTWmuO1ULMbM349xI56L9dC99UDoJOWUUWcfWFhTASqk
         Hbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SeZl4TVtX1UvBbSN4DhYGcCc+k3YwY/2lrXCgjw02qc=;
        b=T/nctEzNvH2RhfIBxbFr3g4WE1K6Q5ai5gTkIQCTbkgy3Kb7WGfUdH8uRLoKfu2kOb
         jaudynI87cHgfGSwUTnra0eiA3lElIh2deYs3ov7zL+w2yiPo3Loy50P6AinyQKS1LRn
         fXYTtX3YagPUqElCOQEN0mvHOPUMmFi/iCen/bBx8n2NcuZETQsx2T+uVGLNcPp/4JsE
         nK+SUeOMDegD3Ibo4PHFvluX/xtnGr7GG6MpXhN0+RS4VTZGRVoTXrpvs24k8+5rnQnc
         bv59Js3mpS6UQ/6pZ5g2QFBu9Tr6qErBw0E3TYjWQME4hz9gYILVsKYYat778OAfjiia
         ZRWg==
X-Gm-Message-State: AOAM533bl9NovDUpv2TUUCAxX0tLzvuJvgcxLHOwlbGXyBshI/iQGihA
        BAdqvJJvb28XICcf8xHnQFeRj8TxD32hvACjYAQD8aoDQ/o=
X-Google-Smtp-Source: ABdhPJzMzMr8ZzyXjKRhmBkpNsByEBkHR9dp9V43tCWcNmr/M1lYQjyktipm65mjD4OZC+eiNGr2AjWR5PdU+b1li7o=
X-Received: by 2002:a5d:64a6:0:b0:20c:64ef:c9cc with SMTP id
 m6-20020a5d64a6000000b0020c64efc9ccmr15455360wrp.190.1652712708081; Mon, 16
 May 2022 07:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <c3480ba47ac9761903485ebfac127f297053d4da.1634289461.git.michal.simek@xilinx.com>
In-Reply-To: <c3480ba47ac9761903485ebfac127f297053d4da.1634289461.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 16 May 2022 16:51:36 +0200
Message-ID: <CAHTX3dKJg6YLdOaz0uSY3fhcJ2KF2vXAYqBdePRQuE680WzjWg@mail.gmail.com>
Subject: Re: [PATCH] arm64: zynqmp: Fix comment about number of gpio line names
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p=C3=A1 15. 10. 2021 v 11:17 odes=C3=ADlatel Michal Simek
<michal.simek@xilinx.com> napsal:
>
> ZynqMP has 174 gpio lines connected to PS controller but DT is describing
> them from 0 to 173 not 174.
>
> Fixes: 7a4c31ee877a ("arm64: zynqmp: Add support for Xilinx Kria SOM boar=
d")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index 550b389153e6..bb2602dd2805 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -285,5 +285,5 @@ &gpio {
>                           "", "", "", "", "", /* 155 - 159 */
>                           "", "", "", "", "", /* 160 - 164 */
>                           "", "", "", "", "", /* 165 - 169 */
> -                         "", "", "", ""; /* 170 - 174 */
> +                         "", "", "", ""; /* 170 - 173 */
>  };
> --
> 2.33.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
