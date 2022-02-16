Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEE34B8914
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiBPNRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:17:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiBPNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:17:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9709F6CA6E;
        Wed, 16 Feb 2022 05:17:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 777D11F42185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645017423;
        bh=f4XXx+wOAjUOBGwOCR5FVHuFNf8F4WH2Bqh0nBJhIc8=;
        h=From:To:Cc:Subject:Date:From;
        b=cZ9IYtexXszwQRGRIjjP1zhAA8igG1syyugter36rQnLdh/GTL+6Q9qmrAESGJKiV
         whrw97UvgT0ZZ54zNxN/KYhQZsx+KXYMCz6QAuIhTuTy2Ia8XUq9mi3nQPy4zmvgAd
         KuhTOz1ODUVlqP9Mu4QcCbxN8d2l6Te7p0DQ+ULS7v1Jbtq/jgml+bC8zonbqYriHr
         i1xdLol3TfwURbwjSUdGF3KdusUYqbSPdBuMKtI+czcMvlCBcNNy5YWG0umr6Dtnxs
         BBec+1BRAClk0llxFrL4G4qNIU1pTVI57XieBP+X9U12lTWB5JzRp5PGG3TOG0221l
         zuL2miV3JlFUQ==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 0/3] spi: amd: Add support for new controller version
Date:   Wed, 16 Feb 2022 10:16:35 -0300
Message-Id: <20220216131638.65472-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

This v3 has a small change at 3/3 for making it work at COMPILE_TEST.
Could you please replace the patch that you had applied on your tree?
Thanks and sorry for the trouble.

This series do some cleanup and add support for new controller version,
AMDI0062.

Change from v2:
- Keep ACPI_PTR() for ACPI dependent variable, making it suitable for
compiling test.

Change from v1:
- Replace `if (version == 2)` with a more extensible switch case.

André Almeida (3):
  spi: amd: Use iopoll for busy waiting
  spi: amd: Remove needless rom_addr variable
  spi: amd: Add support for version AMDI0062

 drivers/spi/spi-amd.c | 87 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 16 deletions(-)

-- 
2.35.1

