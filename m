Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3666F544710
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241467AbiFIJPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbiFIJPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:15:42 -0400
Received: from mail.shift-gmbh.com (mail.shift-gmbh.com [85.10.195.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9051A046;
        Thu,  9 Jun 2022 02:15:37 -0700 (PDT)
From:   Alexander Martinz <amartinz@shiftphones.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiftphones.com;
        s=2018; t=1654766135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3C0P7njZbEY2mv2K04P5MzImLsWwwilysYXKw/K0dJc=;
        b=g1uhscyUpcEDF+FG2zbBdF7RR9E4gRfIrE7QVEY+50XKOD+7ZFFr6zbOTKdiURHLKieYjR
        OR9isjvF9jzul6OH7NuidmLnuApljWNdHD/t3xLzAaPNTHC+AHPzsbUUj2Id0U6886CiWE
        P5RKMEQ6iNJuby3fRMwj4pLKYhj8cyzFBuaWOIWmVlogSg4/tjTPaBQ+lGSSrp4EIymVyA
        RSFsEIn0CC/vMy45HzoLixgPgGChLO6tXuH0SKY3VdnbnqaEgNIiF72v02Bc15CWQsEH6P
        DYMdfQ8hU5xAtNIt3cR83BocNlwPLFfrLVs851OWsx9oonE7qDpVefLh1RjSww==
To:     me@dylanvanassche.be
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, krzk+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Alexander Martinz <amartinz@shiftphones.com>
Subject: Re: [PATCH] arm64: dts: qcom/sdm845-shift-axolotl: Enable pmi9889 LPG LED
Date:   Thu,  9 Jun 2022 11:15:26 +0200
Message-Id: <20220609091526.132133-1-amartinz@shiftphones.com>
In-Reply-To: <20220512054439.13971-1-me@dylanvanassche.be>
References: <20220512054439.13971-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=amartinz@shiftphones.com smtp.mailfrom=amartinz@shiftphones.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-12 07:44 +0200, Dylan Van Assche wrote:
> Enables the RGB notification LED on the SHIFT 6mq (sdm845-shift-axolotl)
> with the Qualcomm Light Pulse Generator bindings by Bjorn Andersson [1].
> Patches are merged in for-next branch of linux-leds.
> Tested these changes on the SHIFT 6mq.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/commit/?h=for-next&id=a8e53db46f19f67be6a26488aafb7d10c78e33bd
>
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>

Thank you very much, Dylan!

Reviewed-by: Alexander Martinz <amartinz@shiftphones.com>
Tested-by: Alexander Martinz <amartinz@shiftphones.com>
