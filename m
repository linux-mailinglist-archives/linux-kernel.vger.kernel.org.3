Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9A85499AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiFMRUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbiFMRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:19:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCCA286FE;
        Mon, 13 Jun 2022 05:30:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g25so10838345ejh.9;
        Mon, 13 Jun 2022 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=B8BwMYVvC8BQc7LNFzLo5v93X9Yq8XucGXAjmnMlByk=;
        b=XQlPd903MYJVrjP4lIVH5ujucf95qpOh4AdpWxpDh4cwOKwMOOAIW4cC118V06hJ9a
         T3TMQMJmES8fKi/7UThbnCQFj5EKvQcr7HejKhf2wNul6gyvsT3+Ge7twVgdeKP1nWEv
         uwIbzMKWOKiP47tE0UgB6G5mhSHeYxLwODTM/RexPGqVmE39/30z5Pulr120htYUU8ux
         sEEy+KmLgmXNwTufYry6X3EUNE71bBAGSz0JdGZSEANDqW6cZQ88epfU4NjllmeEfRMM
         4jYOB1Hr46qvNWLdIZVKVJ/+NowzsCp3sqLzYk34mTl+HndThd4pmqkPV8v+i82aHkdp
         Imsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B8BwMYVvC8BQc7LNFzLo5v93X9Yq8XucGXAjmnMlByk=;
        b=rkePbMlV0ncON3ykhB3nZhrQ7NH/0OxsAm2i7/jark/m1kCH9DeP3fTcCIczEcs5++
         v6n/Rkdg/PWncpcb/qubTIeW4xWUCKUbfpkh3IlGz5BjU2clM7WFfri6kvW45Txa0FAN
         FUt8RMtKtDza+Qgut2UuWeYZRmhdM9lsX2J7z5bIq4M8WqaoR5ofVDdA6E+SjqBaHHeP
         YnP79TmO3+gDQQoTSvpUHOzota7iB2dPtDtsSZWIEolnTqNt9aZUPSJeH54Bk9JskxmU
         kWyuHVeAiEi9N6eYkxQYuJ8WbqKTXrY0YPrOWape7E1opQB2S4Qrw8jaiIO4OWdqMO3U
         2A8g==
X-Gm-Message-State: AOAM533yn+NhFR8SRRyBPhfMMXnvaCMunaeJ0jlWNagWDp/BD1Eo5B6s
        8PHUYv4ZIsZHml4b/gv6eCaAsvPDpcrLPA==
X-Google-Smtp-Source: ABdhPJw0skCSkAMQnGEqFEAS/7uy8MwoJr18K9YU6RpZOacew9XsDqMzZMDbn4MbVTU7h3be90VoWA==
X-Received: by 2002:a17:906:7254:b0:6fe:5637:cbe6 with SMTP id n20-20020a170906725400b006fe5637cbe6mr51977016ejk.612.1655123407428;
        Mon, 13 Jun 2022 05:30:07 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id f12-20020a056402068c00b0042a2d9af0f8sm4812513edy.79.2022.06.13.05.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:30:07 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/pinctrl to PIN CONTROL SUBSYSTEM
Date:   Mon, 13 Jun 2022 14:29:55 +0200
Message-Id: <20220613122955.20714-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory Documentation/devicetree/bindings/pinctrl
are also the maintainers of the corresponding directory
include/dt-bindings/pinctrl.

Add the file entry for include/dt-bindings/pinctrl to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Linus, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a4c3e811262..9c67cd163cbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15787,6 +15787,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 F:	Documentation/devicetree/bindings/pinctrl/
 F:	Documentation/driver-api/pin-control.rst
 F:	drivers/pinctrl/
+F:	include/dt-bindings/pinctrl/
 F:	include/linux/pinctrl/
 
 PIN CONTROLLER - AMD
-- 
2.17.1

