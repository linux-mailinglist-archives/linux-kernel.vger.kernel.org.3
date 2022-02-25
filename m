Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA814C5001
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiBYUp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiBYUpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:45:52 -0500
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F751FEF9C;
        Fri, 25 Feb 2022 12:45:15 -0800 (PST)
Received: from [10.0.0.111] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 3185120056;
        Fri, 25 Feb 2022 21:45:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1645821913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4i5elKgbepnJ0t2xjTZt4bJqTmNRYyzdF9yJBgoWMFo=;
        b=i8lhg4oPlY4GalyLXY4GI2/yhh03+A5fpPm3oL6x8IJc3NqoZkDMFlQ7C4WBwmBo1987P6
        bqfYYaQTWoIE2OYKKCofRtG0zg3Lhq+h3PmGMjgUnnBMhJlRXl0cbZIWeaRY59v5syqDOT
        vOYcpTsDwb3nn8HgIVOxFllbv9EJ7Pc=
Date:   Fri, 25 Feb 2022 21:45:07 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: add qcom,tcsr bindings
To:     ansuelsmth@gmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Message-Id: <7BOV7R.G732UOG2LM5N@ixit.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/GPL-2.0/GPL-2.0-only/
David


