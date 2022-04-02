Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1194F0649
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355107AbiDBUtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354526AbiDBUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:49:28 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91C08EB6B;
        Sat,  2 Apr 2022 13:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648932433; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ieoQ+1F9QqxAUvrZhPF0rgGk0EwhB5RtS6pMTubMGr8AHz/j2iFpM4/kQ4iYRMXp1zMDC65iBKDDM4sKO+3wRN7bNPChNQWEWnyQOzm9QbNS/yQnk2z+gaVAoJcPjzumJtoaoSQXu2cPEWPgVXxA26zzuD6RYQ3aUMipOAU+E2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1648932433; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=T2VB4iuxFhvyIIjSNI2uILloxGm+ik5QN3BaO7fUzg4=; 
        b=jGwQlae82zpSK15K8o724kK8hDhq0W+V1syZ2ymQ5f3+bV3yaq2rPOnP5fXq0tWz9/yehZdhMEHm/bS+mUqI/7UoAG+xzwp9zbtTnXv96ulj1UaFDwo8ungUmSLSbVG79N0Ju6GvSVZ9sY/HPCMoCxt400O7BlvcvdgOL8vNwMU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1648932433;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=T2VB4iuxFhvyIIjSNI2uILloxGm+ik5QN3BaO7fUzg4=;
        b=Xu8Gw0so92pJeSvS8yqE5oOS/BD0T7X7rrB/d5YAhJvSgnuOuGxERt+3itnIzNR5
        NUibouoqvztQnq04eyG/m1HncaqV+hoe6XgQe0hRhkQx/QFrInbNU/oPPB/JnyvxGBB
        WXtuQU36VcWPhbNn1Dv7deitC6l73BBaZddPZ2PU=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 164893243059986.29744518670248; Sat, 2 Apr 2022 13:47:10 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH v2 4/4] dt-bindings: arm: bcm: add bindings for Asus RT-AC88U
Date:   Sat,  2 Apr 2022 23:46:22 +0300
Message-Id: <20220402204622.3360-4-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402204622.3360-1-arinc.unal@arinc9.com>
References: <20220402204622.3360-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Asus RT-AC88U under BCM47094 based boards.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
index 8a97ee048053..8b7e87fb6c34 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -64,6 +64,7 @@ properties:
       - description: BCM47094 based boards
         items:
           - enum:
+              - asus,rt-ac88u
               - dlink,dir-885l
               - linksys,panamera
               - luxul,abr-4500-v1
-- 
2.25.1

