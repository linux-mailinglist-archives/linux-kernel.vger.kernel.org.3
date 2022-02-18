Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C564BB3C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiBRICR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:02:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiBRICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:02:12 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B7A1AA89C;
        Fri, 18 Feb 2022 00:01:55 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id B6C2658017F;
        Fri, 18 Feb 2022 03:01:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 18 Feb 2022 03:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=wkcSQ8FpO5eoDsVGH3ed8TbQbskSmxyIS38SCF
        5Bh64=; b=oNbfQApvvRqdF3yo/fQmi0UTrg+2Mc1VMer4KIrkrZ/YsXife4bPjp
        q2xmSImJ7QYDGbvevCxm648cUvaQQmq30SNcKRG8u+htmrjmstuq+8KtKUTQc0y+
        8x0BmjdtFnIpM8V8QSrFsLfSTl++5qPrWKGUUzwfdx8s+EqSAPApK7bmi1OUiUJ8
        CattKDdMwy2q6R5t+dCROuNqeNOgLHwYcndg3t5wqfXViVZ4+aqa8fG1znSH+5iZ
        QxZOH/Jd9sVufndKGJy5LWCNyC5g9E5KueU7byFeb03J1KzigOn9Tj70yrN+7uq+
        eNTqiV9wjZnstIRa+2uOm0toJueWS0SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wkcSQ8FpO5eoDsVGH
        3ed8TbQbskSmxyIS38SCF5Bh64=; b=fKdcb7b+HXcQe+pT6jnmvUJBkgnP+ok4S
        VpJtiNfetovGUQKhW5mN+NNJaCbDGisiCZ/APcNuEtSTQKsNF2lAcNvwYRZ31K2x
        byFSeXAdjZ2zAJdvsQDeW7Q5bq53VjEJ8OviJ+fOSckg6w35lzq3ui6df1/01FQ8
        oADfOAi915Q7nekPqtSdXsxf73m08TshtSpGNWTP6NM13IE0xVo2qRiKcyuOlq/y
        sp079emMx4O9ESQeUF7CkzAHQsTcj5MJaBKMj/u4ik4Kquv2S1b2AWuXMCL9avUy
        HfdLBX68U68DwziNN7U811oYBM1RMEcezZrKJjzEuQWKnhebjzwUQ==
X-ME-Sender: <xms:cFIPYsRXY-78XAwn7CJWZfTFs1Y-RsCuaMFVq9hLvYPcaYdReXbSTw>
    <xme:cFIPYpySzOnf8iA5_SpkfD_EG15x4m-CpUOqg2uoECwJT6ab7ZYTMyMhXYI5sGHG9
    L5HN0bGsLwZdw>
X-ME-Received: <xmr:cFIPYp3sAr-alkSOT1g3Z67nYTAIrBjQDGn_2ZMNTAY-yyAmlKXBKia9zAfKBfD73ltxQ7u8SNnb6vc3wuLHIhyhYM2yjdF7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeelgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:cFIPYgA5c4BqC114YgMAgFETT10AEmQ3qsefdV-fGtLK-vwNsxCG4w>
    <xmx:cFIPYlgJif6DJ8a71CdG8uXZcpbJn10x1YbS7aToVt5tm0jiMesWzQ>
    <xmx:cFIPYsqmxOxU_zSlqZHOr5QW16-N4KQzz6J8tI4uehOw3A1C5Bawog>
    <xmx:cFIPYubh4fthAwVjP7Yg5sHSFo6m0f3EmEXPZl5cJNO-KGbb6jbzZQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Feb 2022 03:01:51 -0500 (EST)
Date:   Fri, 18 Feb 2022 09:01:48 +0100
From:   Greg KH <greg@kroah.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, quic_rjendra@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [PATCH V1 1/2] Revert "arm64: dts: qcom: sc7280: Set the default
 dr_mode for usb2"
Message-ID: <Yg9SbHo/T8KB0NiR@kroah.com>
References: <cover.1645168567.git.quic_schowdhu@quicinc.com>
 <9a2f9da9fdc1893863f70b4294c7011bf739dd92.1645168567.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2f9da9fdc1893863f70b4294c7011bf739dd92.1645168567.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:21:35PM +0530, Souradeep Chowdhury wrote:
> Revert the change to set the dr_mode for usb2 in case
> of Embedded USB Debugger(EUD).
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index f40eaa5..9b991ba 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -61,10 +61,6 @@
>  	modem-init;
>  };
> 
> -&usb_2_dwc3 {
> -	dr_mode = "otg";
> -};
> -
>  &pmk8350_rtc {
>  	status = "okay";
>  };
> --
> 2.7.4
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
