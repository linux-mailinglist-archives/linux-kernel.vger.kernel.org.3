Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2C4C4123
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbiBYJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbiBYJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:18:44 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87406BDE6;
        Fri, 25 Feb 2022 01:18:11 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 347645804B6;
        Fri, 25 Feb 2022 04:18:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 25 Feb 2022 04:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=pAGnV49gtN2kk2W/BTSquMkAs9VDwMj0yG46gB
        KI80M=; b=Zi2Ldg5F/dTDPqVzQIVt3s6/Eu9HHa3KImYXXbXOybc41AptqB7v8k
        zsk2+suAvpQrgXbgk2R4xjlQPZpu/lRTvbW6jEUiBcgXlcM2qhke6rP5H5Mv8fnF
        PnCwdis2JCYul+DQ9/J7+Hjm1qJGnIrsUqnIXeXrRDEmBiahd3pcjRk7rYG1siCL
        3EDXrR09mF9TKkn5m2gJoAa91NGHT0DfSHNm1R2oKD2+Fo0Abc/sY+3isqeRR0Lx
        P6sAGANFdlM9XK0MnMcfS/DrZ7Kej2yoSE00tCYYanushAGJqRkRjR5RSAwZgNBZ
        +so9s+A329U5Qv0+FRLUwn2FHT1MS+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=pAGnV49gtN2kk2W/B
        TSquMkAs9VDwMj0yG46gBKI80M=; b=ME/FXKvBK4CBbFyqRLXHKvjy7z+9jg+H+
        H0GNryoWipjy3Wm6VT8o63lMlTC6fWvarNDs1/XHDV1UiaFB1SZQHrXzuuyvRl3F
        09zkIfhYRxyOCHXmOTbubGCErMK5TT12r0qUbdsiZXemMCtfBgWFLZqf9vELvmmD
        uSzEYtA4qFc8E2hUn97+BAy8Y5wg0XJxdbzp04y/nz2cDc7+tienm+iE27CVf+Yy
        +jMG36k0gwAbF8seEef5SkqeuEg8pgibIwICuv5xzgLcHJi+04doLPt9MgXxyCB6
        CfztoRYFrLfc9sH5yaVao9Dmf82+PDvIt7ggDuglUb9jc7mTxYTDA==
X-ME-Sender: <xms:0p4YYhEA4ukiUPvHVz2C-iRwbU0PhB4zukhJfvQ6LovJZOOjjHK5tA>
    <xme:0p4YYmVp67ZyQgNxrmoqwxLDNEB4YzsMa2pW3EuQBLRXcZ0uVveb_PviH33US-sp-
    ZqJnWWez9A_gg>
X-ME-Received: <xmr:0p4YYjL2aBmb7iMYqPuFZFf3Fjd7feZehVLI6044sjs4UCnURAUk7IzKN8osL18SiVI7J4cU-sZ_YfqmYGfj6DJro9Y4Qs3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:0p4YYnEr3bXy5YuZhMAOu74D2Ftl3esNmGtq8dG-rCjnyjoX71_iDg>
    <xmx:0p4YYnXJomowcdjNWKsgauUqi5CUw1gY9C2v5tCSX7dwD5aLOPuJmQ>
    <xmx:0p4YYiOBEVcpeKTGlEN9rGyrY6KKS5o5ySoRjLa9bO5npZvW7c0z1g>
    <xmx:054YYuPRGX3MgUfmuThC0RnN4op8e4p85tBSXuoRM4fq1dm-7r8pUA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Feb 2022 04:18:09 -0500 (EST)
Date:   Fri, 25 Feb 2022 10:18:08 +0100
From:   Greg KH <greg@kroah.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, quic_rjendra@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [Resend PATCH V1 1/2] Revert "arm64: dts: qcom: sc7280: Set the
 default dr_mode for usb2"
Message-ID: <Yhie0KB47Mk/j8b3@kroah.com>
References: <cover.1645177190.git.quic_schowdhu@quicinc.com>
 <d6210cac1f4d4e16ff07689b3fbb09ba24a9c712.1645177190.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6210cac1f4d4e16ff07689b3fbb09ba24a9c712.1645177190.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 04:13:45PM +0530, Souradeep Chowdhury wrote:
> This reverts commit c18553956f34819e224a79c9890eba2ba0604e15.
> 
> Revert the change to set dr_mode for usb2 in case of
> Embedded USB Debugger(EUD).

Why are you doing this?  Changelog text needs to say why the change is
needed, not just what it is doing.

thanks,

greg k-h
