Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65E14B23CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349280AbiBKLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:01:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349238AbiBKLBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:01:00 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C1AB8D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:00:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3FF945802DE;
        Fri, 11 Feb 2022 06:00:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 11 Feb 2022 06:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=eTq08rTzfj5KkcaJxtUYdNoUyR1h3Gj7HSsSPr
        JULK8=; b=JekeCQkcPUuaB4oTYa2ThcM1ktzDr8IZ3F17aQJsZAfd44RY+H3mvR
        4PBBxRGZawhzeq9DpMNNkcYVyPbyVKClFWho5gsadPQExfXBuR10ukiCn+cd7zUX
        kmU/jESuZ3Ravq859m0Z3LVHHBXR/a798bGqlo/Fhf4IL2kpoFYCrkuLitSSnYh5
        JAlc+eaU/1EHEyoyL7Kl1wn/EMPdXOxibBqgYf918PN8WzjrpUaZSakvjgZE14M4
        Wp6w6N/iYLCS+WMV2BBdnvp/YPDb5moI9opgRVrkczws8BxzlaiW41a7eh5WscXZ
        gArTobkc1/Pg2EHUENcFcTlbh7B0n5BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eTq08rTzfj5KkcaJx
        tUYdNoUyR1h3Gj7HSsSPrJULK8=; b=Se8UFglJyvJEwTyLT4CIzb0hVo27tMdFv
        Rg490LB3tY0VTNjBpNMf4G5fDirdaSDwHfmTA2PW2q+SaBUSIg3l2/etPg6cz/Vx
        lb37OYp50Jj+NlFIWHmdVxAPoGTe8gEn1eDcKvRfkLOS2ur6VyKuvbVLgV9sPYYo
        nGLBTDSA/grwlTkv9Q1AleoumvWFChXc8XexsDFuCMVYRxSatvqihcqIBP/pSyNv
        rlFi+k1JXtxAwQ4HKr5XY7vkKscBx3NxGkCsPQS1mWsj+zs9Dk0bKRJgu5wINOdN
        fk+8gTisOoIqtZJZ/7Ejx7UXwTt6HxvU0fFiYOu0v89ChGIiftC/g==
X-ME-Sender: <xms:50EGYpit175PhntoWGSnoL7iTOgfC02A66WBdjWA8BmYLzY-1SREew>
    <xme:50EGYuCV4Sc-JWeKCXsBthjskzi2Uius3mDDRwrkh_MVx_c1ExV9-0ZDV6vEZ1R-i
    s8PnwDMZfgN4g>
X-ME-Received: <xmr:50EGYpFolAnnkTyA2T8ImawgmE8hT2SPwa1Xzjk6FxDxyTmNeFRAymtUu51NSQYCuaDDhhA2HSXZOKifeWpnMmgxkK0c9Udm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:50EGYuQ3stLp0XVWz0NwbphnIA-rya3fzFrb6SV4rkt_IUhNVTT1bg>
    <xmx:50EGYmxojE5JTx9ZzhVfRTXOqQ0fXDLVHid7_FSWyGW1xiLb2JFVdg>
    <xmx:50EGYk4aEAQwtdyNLiAA8lXXQWFy_GurtIn69WfRYLWxlhmRkDYOOg>
    <xmx:6EEGYudPd94MrZgRoyBviUxZQxKD3oGYPtV58Fo2zA0_pVf2KL-ciQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 06:00:55 -0500 (EST)
Date:   Fri, 11 Feb 2022 12:00:52 +0100
From:   Greg KH <greg@kroah.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_psodagud@quicinc.com, quic_satyap@quicinc.com,
        quic_pheragu@quicinc.com, quic_rjendra@quicinc.com,
        quic_sibis@quicinc.com, quic_saipraka@quicinc.com
Subject: Re: [PATCH V6 6/6] MAINTAINERS: Add maintainer entry for EUD
Message-ID: <YgZB5AM9rOPvA9fm@kroah.com>
References: <cover.1644339918.git.quic_schowdhu@quicinc.com>
 <50cc73b4432c3d118361e6c9d47a9b0f7682e8ae.1644339918.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50cc73b4432c3d118361e6c9d47a9b0f7682e8ae.1644339918.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 11:24:29PM +0530, Souradeep Chowdhury wrote:
> Add the entry for maintainer for EUD driver
> and other associated files.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b84e2d5..f86ec0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7227,6 +7227,14 @@ F:	include/uapi/linux/mdio.h
>  F:	include/uapi/linux/mii.h
>  F:	net/core/of_net.c
> 
> +QCOM EMBEDDED USB DEBUGGER(EUD)
> +M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-driver-eud
> +F:	Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> +F:	drivers/usb/misc/qcom_eud.c

This needs to be in sorted order :(

