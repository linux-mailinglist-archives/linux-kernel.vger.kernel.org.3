Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0DF54289A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiFHHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiFHHyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:54:24 -0400
X-Greylist: delayed 920 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 00:21:39 PDT
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C8118E44F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654671917; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=EwX9GHj36baFZECDvbfvU8mD912tZ+9/+KGQTTtvObKU35dhQ0kSaPkKMjR7WRpTO6A7Q+M5wYVzGb6JLyuZFygwIOZPdxj0PVAXBTixbJh0XwBQUOHd64GL+Uut/fFAJmP52dYib6yXfwi8e0XjiZuLoqUKILvjllpAhyh3Hhw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654671917; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=4qHioTwosoMtsVC5cf0hSqO5QmqpfNid/SOhD8fTy7Y=; 
        b=GdcGV3gzIoJEsQr7znI/Gf1ba4EPwrnQywrEfjnkN3/n1UCi1MCAV0nwXBtr7a6pFkKH/RlzVaGGIeHZPIpXnPgn92aCq+Edd8EEgXeB4iDjTZVbaoi/Zv/tJJW7jW/3Z3iOeemrnRsldJYYGFmHFn0ryGhF++xuudo+F/4qIu4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654671917;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=4qHioTwosoMtsVC5cf0hSqO5QmqpfNid/SOhD8fTy7Y=;
        b=byVdaaJj/CFCY6LvkPczj0FZUgIyfzT1CfhzFmF164613R0xCJ1voYda6Tk+cUBA
        7hTddmz0vMKq8GLGzA8sHKK6NI75Ks1qOeIQ4Fnbd03UWAdDiFKIw1HAmpl15pvsjd8
        edRTAUMtbEoxVzeU8rt9aSMsFPFZckayGjDMjN64=
Received: from edelgard.icenowy.me (59.41.163.66 [59.41.163.66]) by mx.zohomail.com
        with SMTPS id 1654671914833265.775927181988; Wed, 8 Jun 2022 00:05:14 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/7] mailmap: update Icenowy Zheng's mail address
Date:   Wed,  8 Jun 2022 15:04:46 +0800
Message-Id: <20220608070452.338006-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220608070452.338006-1-uwu@icenowy.me>
References: <20220608070452.338006-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the SMTP provider adopted by AOSC applied some more restricted
rate limit that is not suitable for sending kernel patches, I switched
to a mailbox hosted on my own domain name now. In addition, there's a
single commit that is pushed to the mainline kernel tree during my
internship at Sipeed the last year.

Map two AOSC mail addresses (both aosc.io and aosc.xyz domain names) and
a defunct Sipeed mail address to the new mail address.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 825fae8e6b7b..b4065082029e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -150,6 +150,9 @@ Henrik Rydberg <rydberg@bitmath.org>
 Herbert Xu <herbert@gondor.apana.org.au>
 Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
+Icenowy Zheng <uwu@icenowy.me> <icenowy@aosc.io>
+Icenowy Zheng <uwu@icenowy.me> <icenowy@aosc.xyz>
+Icenowy Zheng <uwu@icenowy.me> <icenowy@sipeed.com>
 Jacob Shin <Jacob.Shin@amd.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk.kim@samsung.com>
-- 
2.36.0

