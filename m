Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104A64C4128
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiBYJS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBYJSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:18:53 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDD824FBA2;
        Fri, 25 Feb 2022 01:18:22 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id E1F5A5804B6;
        Fri, 25 Feb 2022 04:18:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 25 Feb 2022 04:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=FX2A5mROcHA+clXESla3Vvycg0OLSU6abMHavk
        eJOIg=; b=oiw/3bwgh8kqVwbPPYyY9kdisE2C/vLxKHgP5Pwr3+W2obOG6+Wmg9
        meL5i4jw7aGSEFv7fjzvXyQmfUYlCuTg7kAieEHtknl6mV6G/yqVRrzIpUSenk+4
        gnynEyA/OLEFQ97ojVxvjs/QZU/M0yVc5kqXqWVFdbNLxU5gcbutrUr48uFwoPLS
        dMPFF6zdpLPF/VpLlGji2B/FMJWWbkAGdcNzKuUtjqI9YyuVdYyjnueklzgJtbLK
        fDOiRdCr+pLgDoNSY/Ljc4dW6CnZ9t5SoHW99scFYbERWWDWljW0+AsDj3S/LWQP
        eGs8OGGu/NN5X5XMD/DzeCFyItZSyRww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FX2A5mROcHA+clXES
        la3Vvycg0OLSU6abMHavkeJOIg=; b=fV40NxMvQ7r4Tp7PHb4kMGq634spoWuTj
        vaQgj5Kty78QA4f06NnSRO8zy4xLQYu7QhgZWzwsX9yhCJ0fHVWT/VKGHKKqeZWR
        Hux+jzUJ9fmxPnWCZvo+c++9vk71UYixUW+YHGLn/JLU7dSZPhom7Bi22Xu+55wi
        OcfmIkX8oW68+0M029sQ6o1WtGAPn8ooOOkWL1vEsWTP6n1qpuBe8jB/jjkCPpyM
        F79hMTAtrMMFxz7cKy4Rj8+pwQRnYgptxIzbR+sqPK2IFBrNY05ipM7QSP+awNNt
        oqtwkxxO5dPA8byeFkEUsic45azzj5fMQeRNE0/ITEguOYp9BQdTA==
X-ME-Sender: <xms:3Z4YYi4PrI1z-g42JXvi9__WUnhUkIx2Ney5cFkA0k4cnKTBeUeFxg>
    <xme:3Z4YYr7mQxK-h3OnRFGY1v4QKP7SGP23tR13Cc8DeKhQ2-IoRFgEZmbGUOZukTxxM
    1Vo4RqeXPnh3g>
X-ME-Received: <xmr:3Z4YYhdLwDrNTmSFOe3QCTZ1ruKPamN3kNpxCRYB1LQWEuI9Zt02Cj3bxZeP96ICoZUse9in3Wyx89LbeE5hmiLpfolz8L6C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:3Z4YYvIObjdH1IUIhyC_6vuFaix4MvXOwxgpRUeT66OzyF-heDDGeg>
    <xmx:3Z4YYmKNpVp-6jSYpVM4xH9q1q-4nnmXsFdNiYLEwA4aNj6QDp1zrQ>
    <xmx:3Z4YYgzbwShnnnrNduMEUU2vuOP609O2bPekxy9h8ifb8yU7IOSgtg>
    <xmx:3Z4YYrCDUAUATHLuPVqjpdjswDMk1oW84b8lgybdSb2qfK-icA-5Yw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Feb 2022 04:18:21 -0500 (EST)
Date:   Fri, 25 Feb 2022 10:18:19 +0100
From:   Greg KH <greg@kroah.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, quic_rjendra@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [Resend PATCH V1 2/2] Revert "arm64: dts: qcom: sc7280: Add EUD
 dt node and dwc3 connector"
Message-ID: <Yhie2/fNhHQ7QMHZ@kroah.com>
References: <cover.1645177190.git.quic_schowdhu@quicinc.com>
 <2bf8d74c1871b0e06de53f800fb77484677e610a.1645177190.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf8d74c1871b0e06de53f800fb77484677e610a.1645177190.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 04:13:46PM +0530, Souradeep Chowdhury wrote:
> This reverts commit a0c68e493007a8c72b6b00f6ac95590a86edc937.
> 
> Revert all the changes to add the Embedded USB Debugger(EUD) Node
> in the device tree, the connector node and also changes to usb2 Node
> associated with this.

Again, why?

thanks,

greg k-h
