Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAED8525147
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355947AbiELP1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355944AbiELP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:27:30 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC46B6C56D;
        Thu, 12 May 2022 08:27:28 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9BFC61C0003;
        Thu, 12 May 2022 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652369247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xe6gof0su9adg1T78nGygOfJDwljHm2NDQAvr9m7iDU=;
        b=UFjVnqD79eYZ3HPa0Iv172QpaHho0LkO+Ptoi6Xc6jTCniR2gbNiY4fPXOX7qbcamAYVJY
        YtXg6K01OIHYKiEo+aMJZC6mkglf4J6bYd19v1vm9XbyyGPIREP8RFbpUbU6wesZp30+W0
        CkgRkZbhy4D9Qn0zQvKRpJMcOi/YPwKn8simKQodtnc4bPUSpU4D2m9/gvTtZv5R/IthpX
        ln33PLd0TjKxCyCYaniL5vzU6f+X7tcp5Vz+i5BJH9uffsbJNyeboMfUVVhiIt4N3c6gpI
        c5bMdkRoKt9D8TZfcRk+pq59HJgaTJOy0ux/pMbxCz0+l6AV/Ru66I2q284WrA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: partitions: Extend fixed-partitions binding
Date:   Thu, 12 May 2022 17:27:25 +0200
Message-Id: <20220512152725.244872-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220503155007.2339847-1-csharper2005@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'33f6106400b60b0e3287efbd0a9f29476d278f06'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 15:50:07 UTC, Mikhail Zhilkin wrote:
> Extend fixed-partitions binding for support of Sercomm partition parser
> (add "sercomm,sc-partitions" compatible).
> 
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
