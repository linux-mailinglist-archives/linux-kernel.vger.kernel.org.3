Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDDE4BB3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiBRICY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:02:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiBRICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:02:16 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E8F207FE6;
        Fri, 18 Feb 2022 00:02:00 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B787258017F;
        Fri, 18 Feb 2022 03:01:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 18 Feb 2022 03:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=TxBKrdh3UuIAm8KKrIlO9hWYYJOTQOHAA+i6jt
        eteLc=; b=j9xCVl1Cwqx/UXdhmcNbtqPF735DymhO+iQ3W/YQQ3Zw7R+2TGBObk
        6FU2xfGdMdcQB48tIxfSNFsiuOzj9nt8sG2Eui7Zi6fiIi5W1+Oket7ww82S8FR5
        hnpnV/RiV2pdxq1QdQhPONbt5pOKoMHXN+RLGFv9c9LksXP9zqWp/fR6jiD0dH4t
        MGZro4yTgcs4ogXTIKDDSRdOykTVUGIWQ8dRwFR2GXP2duTHECf12V7rc3AOK6Hy
        Myg0tKXCXE86Fe9Sbr381e+Nxu5PcFnJ9kACNB84AA7fKwq4Hugu5pdKy5xN/Pdb
        RjoE3yJjnsQAlLFSqNFnuw6dHXKt7QtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TxBKrdh3UuIAm8KKr
        IlO9hWYYJOTQOHAA+i6jteteLc=; b=ccgGOzqZFlds6+cd+4FBfpzlYKUh+BAnX
        oOuAamGe0JFUDIPb72q46tQX9wsWu8u4qU5D94eu6dmPaRLhYtYBaS5rvQPmvOoA
        phmuNuAJDTdGWJZU2rNZUHJfkKQrQxx9amqcRDWpU3/dvmbn8oCjBkYHsvZl9JSa
        cjsN8weEkEJUAHVlsFmt3fR8yc2fxltsDY8xXdyqkQNAR0nI3YpvRV38ZuGfy3gl
        snAyyEtI2i1mA0oYAOwYY2tw5gHEANUhG/h/yICwIDR6wM9KN3aDdTeFr/xPpbBR
        km6t5pYX7fU+mtd88fgEhMWNZLLXLTfFBD1JYTr4scIIeNLTo4c4A==
X-ME-Sender: <xms:d1IPYtfDT1Ai_NMTD7pkk3Mn5tOETVN1qAhn1Od2doqGPqp5weBNow>
    <xme:d1IPYrOoEyCGriJEWl2jjLRfmyXPwXV44LM6mwA37XufCH8_IdxbuTq3UgCMv6UcK
    1C_NzwUm1Jeuw>
X-ME-Received: <xmr:d1IPYmj-UwibCvIBj1W94ngrnuLYx54OHsQ-BomMS97-w040U7xfaJkPOgHNgnSHW1WUvd-BJfhPZS3x-h29iNn2WftN3sMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeelgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:d1IPYm8uGP8un-u9vi9SCtD15ioNK9ZkW2I841xUrQUqcPfCnptGiw>
    <xmx:d1IPYptDm6Ngl2R8nmSQnOKngaYYM0frbCcONt8ftEDJLRYUCiw5vg>
    <xmx:d1IPYlGno2Wvqa16pFOmepZtoB7W0fjyVd6ArKuRxnYfyIUgzdvdsA>
    <xmx:d1IPYkkwPRKHJxVy8JVz9PPw_KSZGkuBSjjdQrNfOmhPe2zZbyu5yA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Feb 2022 03:01:58 -0500 (EST)
Date:   Fri, 18 Feb 2022 09:01:56 +0100
From:   Greg KH <greg@kroah.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, quic_rjendra@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [PATCH V1 2/2] Revert "arm64: dts: qcom: sc7280: Add EUD dt node
 and dwc3 connector"
Message-ID: <Yg9SdAeXZf7lcnDh@kroah.com>
References: <cover.1645168567.git.quic_schowdhu@quicinc.com>
 <a9b0bcd1c7f2a94006cb9ad098c96d64e9c93863.1645168567.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b0bcd1c7f2a94006cb9ad098c96d64e9c93863.1645168567.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:21:36PM +0530, Souradeep Chowdhury wrote:
> Revert all the changes to add the Embedded USB Debugger(EUD) Node
> in the device tree, the connector node and also changes to usb2 Node
> associated with this.
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 36 ------------------------------------
>  1 file changed, 36 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 96917fe..937c2e0 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2583,12 +2583,6 @@
>  				phys = <&usb_2_hsphy>;
>  				phy-names = "usb2-phy";
>  				maximum-speed = "high-speed";
> -				usb-role-switch;
> -				port {
> -					usb2_role_switch: endpoint {
> -						remote-endpoint = <&eud_ep>;
> -					};
> -				};
>  			};
>  		};
>  
> @@ -2630,36 +2624,6 @@
>  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> -		eud: eud@88e0000 {
> -			compatible = "qcom,sc7280-eud","qcom,eud";
> -			reg = <0 0x88e0000 0 0x2000>,
> -			      <0 0x88e2000 0 0x1000>;
> -			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
> -			ports {
> -				port@0 {
> -					eud_ep: endpoint {
> -						remote-endpoint = <&usb2_role_switch>;
> -					};
> -				};
> -				port@1 {
> -					eud_con: endpoint {
> -						remote-endpoint = <&con_eud>;
> -					};
> -				};
> -			};
> -		};
> -
> -		eud_typec: connector {
> -			compatible = "usb-c-connector";
> -			ports {
> -				port@0 {
> -					con_eud: endpoint {
> -						remote-endpoint = <&eud_con>;
> -					};
> -				};
> -			};
> -		};
> -
>  		nsp_noc: interconnect@a0c0000 {
>  			reg = <0 0x0a0c0000 0 0x10000>;
>  			compatible = "qcom,sc7280-nsp-noc";
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
