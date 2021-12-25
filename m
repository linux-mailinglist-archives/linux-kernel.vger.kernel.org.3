Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06647F394
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhLYO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:58:06 -0500
Received: from ixit.cz ([94.230.151.217]:55888 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhLYO6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:58:05 -0500
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B4F292243C;
        Sat, 25 Dec 2021 15:58:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640444281; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=/LnLMxqfZ7m239b7PJ+Ig6oQYO7elvpQqGQ3CYEemms=;
        b=roVJfviBv3coP/BbjRNHUaOckQ7XDEQ1iZwLyLUi2Z9tV7Y83bPMYrzrY+tY93PfOkqIle
        viKroG6j/lLLIKq7Q9hGDsjYoQaqeeW7H1VJg59wUO4g4z+gUBwCOH2+EjMhjSZ1dmy4ei
        ltekRHlhWA4+NZm6KHMfR6scMaC2PHw=
Date:   Sat, 25 Dec 2021 15:57:55 +0100
From:   David Heidelberg <david@ixit.cz>
Reply-To: 20200622075956.171058-5-bjorn.andersson@linaro.org
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm8250: Drop tcsr_mutex syscon
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Message-Id: <JWEO4R.7M77VCZXYS531@ixit.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

any particular reason, why you did applied this patch only to sm8250?

Is it safe to convert rest of tcsr-mutex nodes to new schema without 
additional testing?

Thanks
David


