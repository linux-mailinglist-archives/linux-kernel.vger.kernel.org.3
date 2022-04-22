Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC250B07C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444326AbiDVG05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389148AbiDVG0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:26:55 -0400
X-Greylist: delayed 199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Apr 2022 23:24:01 PDT
Received: from mail.intenta.de (mail.intenta.de [178.249.25.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A200D506DE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de;
        s=dkim1; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Message-ID:Subject:CC:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RVntfVqi519wtvZXHL65n9+NRhO1kPJ2cT6AfaC/rfY=; b=XyWrhCf68r/la7lTWfNJLa0llN
        SUXvYTEEf4vlakphQVTGORazRwB8vhpsKrJVuQrphZ+tqC00A8XxeIEogXVLCqFOurtkbgLkimArW
        ztTsHJFiFlNghJZ5vUJNFbPDNYEpPzv/mSiiCiaRQS96vuM0VmqYdjnVqGJHyxhzbtEESCgB2wVAb
        BD7M1tAw/YYW/qwZwX6zDvrXATlf65FvWGKDzJ4Rg39iF+/+XHYysPuz3nffMTe4gBAL2t2CZ88iY
        6PLGjBWoPrQxPRZAlJYF8DNJAAUWTBgCjjxj156nkdqDxcHphYnf+mx7IpYJFVtsqYAVHBY6cg7iH
        Ztc9kVmQ==;
Date:   Fri, 22 Apr 2022 08:16:55 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: mfd: da9062 can be a system power
 controller
Message-ID: <3a0838f71653f57be9a866c96dda5921cb10a653.1650606541.git.helmut.grohne@intenta.de>
References: <ca76e2bb2f5d47ad189fa1a40bb6dd8a5dc225d2.1650606541.git.helmut.grohne@intenta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca76e2bb2f5d47ad189fa1a40bb6dd8a5dc225d2.1650606541.git.helmut.grohne@intenta.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EXCLAIMER-MD-CONFIG: 0e788d66-80ec-4ac3-b2f1-4d8c6f55fd77
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9062 can be used to power off a system if it is appropriately
wired.

Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
---
 Documentation/devicetree/bindings/mfd/da9062.txt | 1 +
 1 file changed, 1 insertion(+)

This series effectively is a rebased resend. The earlier posting was
https://lore.kernel.org/all/20200107120613.GA746@laureti-dev/. Back then, this
patch was Acked-by: Rob Herring, but I'm not including that ack here, because
this patch required a non-trivial rebase.

Helmut

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
2.20.1

Dipl.-Inf. Helmut Grohne
Research and Development
Application Engineering
 
Phone: +49 (371) 24354 0 ∙ Fax:  +49 (371) 24354 020
helmut.grohne@intenta.de ∙ https://www.intenta.de
 
Intenta GmbH ∙ Ahornstraße 55 ∙ 09112 Chemnitz, Germany
Managing Director: Dr.-Ing. Basel Fardi ∙ VAT/USt-IdNr.: DE 275745394
Commercial register: HRB 26404 Amtsgericht Chemnitz
