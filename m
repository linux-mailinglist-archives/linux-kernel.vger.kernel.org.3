Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAAC55E3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345954AbiF1MsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345948AbiF1MsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:48:08 -0400
Received: from mail.intenta.de (mail.intenta.de [178.249.25.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4C91182E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de;
        s=dkim1; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Message-ID:Subject:CC:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EF7HWvqhWpKU7bA7LZSnMlfunbzGQc4QRNwktShveWA=; b=YfueN5MEIMqupOWNbkZOmGb++a
        2iKc9RwP3pV+lhiXR0qvbZ6dfHLqjfJ22xorfSSQmI7negpFixbaDfWe2sR8tArLVRbf6olML4cCs
        mJrWOm48me3W45uHmKYth1Qj8YyzUtpECip6fAdhbYM90z1dAHjDxPD/kmkhfPe2v5E/rUeGI5rXA
        B5TBiJTsfGoqvSqElVyUype30VT/U7pi8JMMZ3WaAroBLByTzhvx77QXtMFcXBgSk3fjmpaCU8Gg5
        4F8RSQdEKjZyO1lKB31K0IUgfFsTLGL6vwZ5jVOjc+gKRBQNgXgBu8LPOJiq2V5/j6GaCURUXGjEB
        6I2Q+HRw==;
Date:   Tue, 28 Jun 2022 14:45:44 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 2/2] dt-bindings: mfd: da9062 can be a system power
 controller
Message-ID: <6c889262c7f1e07bf30f9c035ed5beffdccec4db.1656418366.git.helmut.grohne@intenta.de>
References: <bafccf43111a24e20fb36c46740d650dedda04c0.1656418366.git.helmut.grohne@intenta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bafccf43111a24e20fb36c46740d650dedda04c0.1656418366.git.helmut.grohne@intenta.de>
X-EXCLAIMER-MD-CONFIG: 0e788d66-80ec-4ac3-b2f1-4d8c6f55fd77
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9062 can be used to power off a system if it is appropriately
wired.

Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/da9062.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index bab0d0e66cb3..4861c3ad97e9 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -41,6 +41,7 @@ further information on IRQ bindings.
 
 Optional properties:
 
+- system-power-controller
 - gpio-controller : Marks the device as a gpio controller.
 - #gpio-cells     : Should be two. The first cell is the pin number and the
                     second cell is used to specify the gpio polarity.
-- 
2.30.2
 
Dipl.-Inf. Helmut Grohne
Research and Development
Application Engineering
 
Phone: +49 (371) 24354 0 ∙ Fax:  +49 (371) 24354 020
helmut.grohne@intenta.de ∙ https://www.intenta.de
 
Intenta GmbH ∙ Ahornstraße 55 ∙ 09112 Chemnitz, Germany
Managing Director: Dr.-Ing. Basel Fardi ∙ VAT/USt-IdNr.: DE 275745394
Commercial register: HRB 26404 Amtsgericht Chemnitz
