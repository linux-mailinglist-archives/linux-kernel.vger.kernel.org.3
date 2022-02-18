Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E424BB3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiBRICn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:02:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiBRICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:02:42 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7621FECA;
        Fri, 18 Feb 2022 00:02:26 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D591658017F;
        Fri, 18 Feb 2022 03:02:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 18 Feb 2022 03:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=qxZlwWOELa9hmMK2f9JovpGKkCVtpGkOBIhzWj
        Bu+6c=; b=EU+lGG0AouUc2YwgXrf0qG3sULD7uitvucLCLyk/FJgIy5+McCYhMl
        2wfyuKjcHU9p2SUFtlOEXdFaPo01ZZ62RKPgXW+W6t/uH70oY2q1SKwxV4bw3hiB
        zEmRO9q/u1ETcm3a6Hlpea4aq1NFcdLnmiKIjdlIirI6RNgVMSiKFwl7OTl/5a0R
        3rclXsjJwT8Bv8JSZTsjaTkUL581s8cEzs64CB5NvgxUpfh5eWGw7K95aE6chxhn
        JR5GtHqNrRRgis+RJmOHv/NJWHEmMmJVwXVwgOpGMhsLi4hSTIi7+0hyRgw/U32y
        RGbXK6LEquTSTRdSqeERYJjYA87IXZsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qxZlwWOELa9hmMK2f
        9JovpGKkCVtpGkOBIhzWjBu+6c=; b=fV+EzLTDenA5LvW5gpb7A1xqet9sFHlNE
        Nzt+VZIXwPesZcDkR97unfOPXBZ0h7CB5CejKCxvn3yeOFidyPUFU8pJnFOReDn6
        bwEm/f4YavHqOSX1278qT2SqgKwhwwb8/Hsxo2mjFNgC5mNZsU0J3F9BUDNJIH8h
        gW/Ptp/U60JfdI+IOsqhNmDO2JrOvUblVcaHSDj2AAA6xvuufTyL0WgzN62YLFGB
        OEYKxXapPRQKgcGMMD8AMUgv6PEHDAs/KxC+Yj5S6dHp7wMSFKQ71B83w7EMA4Pk
        9cM0wQExrRCtzVlgbI5+yyZV1uEzEvH7SkOeKQKn67OPfJ9MuKWog==
X-ME-Sender: <xms:kVIPYrDiTY7bEBPNw0J5kfIoFeIxVQ1OyIU_3KATrIt2xUEDUCPEdg>
    <xme:kVIPYhjBCXN1hkI8A0vskJKdfTfPfeN4czDTU31NUTqm9XvV_SUxabvR-WnSWzf3J
    LTiy9lRG9z-9Q>
X-ME-Received: <xmr:kVIPYmkfI4gjgUF_O_2-WmiiCr5yZDVTa-5-3fXNVfs-0u8vKbt7pduCOR6jjqMTchF3ZeYCdaru9VxmjhstWzUbivavgOgB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeelgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:kVIPYtwh3Myk2UKJ464OMqKG3XOGSyOENTmqS4zqKbgnhsbZVDSRyg>
    <xmx:kVIPYgTXOTvkdgU7dg6IZeL-o4i6_SpVl_8Euv6PgIIrrMd6hXaDrQ>
    <xmx:kVIPYgbBZF9wBUwBXvSlvb6udO-K7IUqKcsRk04Qv4D2oyZvNLoffg>
    <xmx:kVIPYhJc-g0DblSGl1v5-zFoNefX4wW0nnwEmqfF70aL_kaf9cICmg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Feb 2022 03:02:25 -0500 (EST)
Date:   Fri, 18 Feb 2022 09:02:23 +0100
From:   Greg KH <greg@kroah.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, quic_rjendra@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [PATCH V1 1/2] Revert "arm64: dts: qcom: sc7280: Set the default
 dr_mode for usb2"
Message-ID: <Yg9Sj508nRsE1B+o@kroah.com>
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

Also, please use the normal format for reverting a change with the git
id and the like.  This is an odd style :(

greg k-h
