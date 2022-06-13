Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D3548DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbiFMPIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242851AbiFMPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:07:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DDE53A68;
        Mon, 13 Jun 2022 05:14:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o7so10810383eja.1;
        Mon, 13 Jun 2022 05:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZOSb9pg1CC7QiA6hpPCF1GAL0i7t8dmmtte682l7O5g=;
        b=aEDGa3kWtRRvzYp+rcI42ukVWyZtgRs6xli28Pg17OiS+14bbfLbvcpNZyBXlOBy4a
         Shl6VbaReFerfActKevQ8vxfh/kGbp+raKiJo9THOkPTf4nrC/9upPrni0UtVxJ6AbeF
         6+2T6beOnxnONkX82dPAMeIgHEx8cYGW0pweHB0wH0y30jmkhVrHwsxXPfmAXsuQgOKG
         aAj/nfiIgeWjwPcrXKWOq07xUUtJEzfcdhO1r5L5BS+njZ6fVXZONWOZe8wGjeeSsCwQ
         ENxV2aNa7IVLVMQdMkn1PFOfhxMwSFPrJ/QkhrAnXYSvjsbyA6TcGmwQRdMzDNfxZ6uj
         Z4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZOSb9pg1CC7QiA6hpPCF1GAL0i7t8dmmtte682l7O5g=;
        b=IUwCak5EdiSp8a/OOdmxNGe91Ib93NL8qNBkmuHpsPI4OOrogAgRfCQHktUYw/PgmB
         Gx1dmBELtffw/XlE4/LVb7wnq0KfCXKeXZfYVzsgcvjUrYli4ns//5CqUaewIROZEQv/
         dcnZU9CnYt/ClgggqI22oYEP4BdE1uavH9MJatNa3i6Jhq03pBLZjiq/LoaIficJpI5j
         ZpmQhi2/v9C3Or+IDHONg88kQDXRPhH0ugV9by4nJtG+7VbtZgWMlYkJ4hoVm0T6c/vb
         NfXhoFZLACSeuS+xRfMbIiZNvk/w77pY3ZHDJGr4nI9X6gCm3je6JMcywvZNE7gDDMXA
         eNQQ==
X-Gm-Message-State: AOAM532KDfhpowykxgKnmOKpfGgRBWo/2ixyApEbIzOrpFtoPTn2jcxd
        3yXDjWjaFCsgSqz6kN1Motg=
X-Google-Smtp-Source: ABdhPJynhA0seghy2iemorEdB5BqNwm/BCYUfhCKm4Nq0gOgRaYKyRMEEsqwAQD7c02TgDJr4f08vA==
X-Received: by 2002:a17:906:5189:b0:712:1017:8ce7 with SMTP id y9-20020a170906518900b0071210178ce7mr18384106ejk.196.1655122452179;
        Mon, 13 Jun 2022 05:14:12 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id u26-20020a170906951a00b00709e786c7b2sm3751900ejx.213.2022.06.13.05.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:14:11 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/mips to MIPS
Date:   Mon, 13 Jun 2022 14:14:08 +0200
Message-Id: <20220613121408.8786-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintainers of the directory Documentation/devicetree/bindings/mips
are also the maintainers of the corresponding directory
include/dt-bindings/mips.

Add the file entry for include/dt-bindings/mips to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Thomas, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b30f6b69477..6bf0c0ff935f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13362,6 +13362,7 @@ F:	Documentation/devicetree/bindings/mips/
 F:	Documentation/mips/
 F:	arch/mips/
 F:	drivers/platform/mips/
+F:	include/dt-bindings/mips/
 
 MIPS BOSTON DEVELOPMENT BOARD
 M:	Paul Burton <paulburton@kernel.org>
-- 
2.17.1

