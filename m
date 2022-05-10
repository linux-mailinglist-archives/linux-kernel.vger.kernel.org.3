Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C755522286
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348055AbiEJR3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348051AbiEJR2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:28:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6191F2725C7;
        Tue, 10 May 2022 10:24:38 -0700 (PDT)
Message-ID: <20220510171003.952873904@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652203476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=alg1dNfGEF+UOGYgEKRiNxEU+zRiaszEcPcnlg5R3MM=;
        b=BMaj/bpbL4Tw5Ilj60CSGtOwaLOhirzsmKAjz2IXttl+NeBDtggpYOZ7aQIyqSqesNudvl
        zuStG1X0AXo4PKpXyUVpIzOuItLUCbINkpH8TCnJjaEDLkv+jOh+CJJyPTrxDu4GBLuTig
        TPxmGcftrtNghR7rtG7UgGIs6k7m66+fAajw/NQaHkpNE1OM9p1eZAa8KQRKTGbNw6KVkD
        74dPMeLHa2Fxb9YHzM3WR7ER2fH8bYaZv5seTD9bKWgcPZkqhXIYiAzzrzmNZ5pjhdbRFw
        ouHXG1tE/yvUev1TiV01O3BbrTTHdtprzIr/Syx2ggviM7vofV6DIGt5X4zDGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652203476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=alg1dNfGEF+UOGYgEKRiNxEU+zRiaszEcPcnlg5R3MM=;
        b=JKhTDxs/J2Eem6MIBktADzgxHhZ4QGoep8I1yCzEmmlEr11hrjeyvX6Q86UHSS3qmue4mA
        49U7Jb2/VqcTY7BQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org
Subject: [patch 00/10] clocksource/drivers: Convert to SPDX identifiers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 10 May 2022 19:24:35 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29udmVydCB0aGUgcmVtYWluaW5nIGhvbGRvdXRzIHRvIFNQRFggaWRlbnRpZmllcnMgb25lIGJ5
IG9uZS4KClRoZSBleGlzdGluZyBsaWNlbnNlIGluZm9ybWF0aW9uIGhhcyBiZWVuIGFuYWx5emVk
IGFuZCByZXBsYWNlZCBieSB0aGUKY29ycmVzcG9uZGluZyBTUERYIGlkZW50aWZpZXJzLgoKVGhh
bmtzLAoKCXRnbHgKLS0tCiBiY21fa29uYV90aW1lci5jICAgICAgfCAgIDE0ICsrLS0tLS0tLS0t
LS0tCiBqY29yZS1waXQuYyAgICAgICAgICAgfCAgICA1ICstLS0tCiBtaXBzLWdpYy10aW1lci5j
ICAgICAgfCAgICA5ICsrLS0tLS0tLQogdGltZXItYXJtYWRhLTM3MC14cC5jIHwgICAgNSArLS0t
LQogdGltZXItZGlnaWNvbG9yLmMgICAgIHwgICAgNSArLS0tLQogdGltZXItbHBjMzJ4eC5jICAg
ICAgIHwgICAgNiArLS0tLS0KIHRpbWVyLW9yaW9uLmMgICAgICAgICB8ICAgIDUgKy0tLS0KIHRp
bWVyLXBpc3RhY2hpby5jICAgICB8ICAgIDUgKy0tLS0KIHRpbWVyLXN1bjRpLmMgICAgICAgICB8
ICAgIDUgKy0tLS0KIHRpbWVyLXN1bjVpLmMgICAgICAgICB8ICAgIDUgKy0tLS0KIDEwIGZpbGVz
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDUyIGRlbGV0aW9ucygtKQoKCgoK
