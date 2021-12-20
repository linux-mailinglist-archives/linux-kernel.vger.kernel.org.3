Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6380347AF94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhLTPPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:15:10 -0500
Received: from ixit.cz ([94.230.151.217]:43688 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239703AbhLTPNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:13:23 -0500
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 509762243C;
        Mon, 20 Dec 2021 16:13:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640013201; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=KrX7y60poYGBCDm0ycPvzme2bfekqQewMZgSm+ZbFeU=;
        b=EgzYxS5aV8QckJ0t+JLOTVIuzL3NBmmHoDKTt75i+STRXVbKXdyCvGhI+fpKgT/PK5KH24
        54HmSsHkbeojqoAmhKtBIjx5UY0BIrhwRprXNGltyr/NV/s1RKB/xGGrEHiA8yGVnebgcI
        +OaPam8/3g/JiKGnkZgaaYu/eD/+pq0=
Date:   Mon, 20 Dec 2021 16:13:14 +0100
From:   David Heidelberg <david@ixit.cz>
Reply-To: 20211110105922.217895-4-bhupesh.sharma@linaro.org
Subject: Re: [PATCH v5 03/22] dt-bindings: qcom-bam: Convert binding to YAML
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Message-Id: <2A6F4R.O6RS9WA32JJ91@ixit.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some nitpicks:
- `description:` -> `description: >`
- you dropped part of example, wouldn't be better to keep it there?
- remove `binding` from the title

Feel free to put:
Reviewed-by: David Heidelberg <david@ixit.cz>

Thank you
David Heidelberg


