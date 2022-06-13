Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76397548404
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbiFMJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiFMJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:53:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308AD25EB;
        Mon, 13 Jun 2022 02:53:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 184so5057864pga.12;
        Mon, 13 Jun 2022 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=NgdLA0z7oCb9jXlN+2hfQR8rLO9SjNm0Q9JHfTfVmBA=;
        b=DRlFSfy8Hek0tYzWJZb9W42tzzbiYnNDjvIA0Uj2Rz4QytQisxbqHjMoXKdM1FlhJn
         zSK0WHntHZBLtGh3Z+VBv3PVUMjqDVhdT/bDwwRwfyWQO/iikcxAEL+OEx3LK6ZiUvby
         YkV2GfoCO+QDkdrqeJGWlgRVeJVhHBIrkfkaOE5Y3RoFpxrtF65Iq4lz0IBJTPXc8mm1
         qXSnWEH61FyK/p6kKp5oPH4fw8osFTZIydPNQWO98IcppabC66bUOiG93VknVRvcdSP1
         6VzWztFD+xI2guHXOVwnD11xF53WT4e3Bh5HXZMzJicb9bZPsRPUnHeIihjJ6IHr36Jk
         001Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NgdLA0z7oCb9jXlN+2hfQR8rLO9SjNm0Q9JHfTfVmBA=;
        b=SEjNh/eua88HoE6jbW+p5Vdgh+T4DJnCAsMnSzkIXRuX0rRuOOJSB/O90DrAbTF98b
         rUgzoNRZoxBEP0dS8jPI0XxCAcEy1abyFy9+1YRHakmBz/JD6JuXXrkRhc0ewvxrDt3L
         UzjSXpMq3Ws/iF1i2ET1slr/hBX4ST8iAL2KuYtuPa54rwuayjmmUm+BCi8ySgpsswOG
         f8dR5iBtKn2z4nbEPREG7m0I34TCm+usjRfhE8i9mJKbSl35GpuCfE57hpm2WcccK0Ro
         Ex/tOX2mlVYOhibds7oZrNdjWPN4Eq+KwupyGTsym6gEAt/BGQDsLzitjhetm8ODrnAa
         ASWw==
X-Gm-Message-State: AOAM532GvQFMVEJx3cVksnGXzmwCefb+38FKTCXHbz4sPkanKqAHyX/I
        ijVB14TLg8Nl6rqI02qajEo=
X-Google-Smtp-Source: ABdhPJyLBj9u1uHxRvsDhkVgV1jeG58opSfKPMejYeSBEVgr/Qwrlkk27SnwbAlfZOpteN0/l0f4JA==
X-Received: by 2002:a05:6a00:2390:b0:51c:21e1:782 with SMTP id f16-20020a056a00239000b0051c21e10782mr38717687pfc.21.1655114038654;
        Mon, 13 Jun 2022 02:53:58 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b001639f038250sm4639754plk.220.2022.06.13.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:53:58 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/4] Update Facebook Bletchley BMC DTS
Date:   Mon, 13 Jun 2022 17:51:46 +0800
Message-Id: <20220613095150.21917-1-potin.lai.pt@gmail.com>
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

Update below items for Facebook Bletchley BMC devicetree.

Potin Lai (4):
  ARM: dts: aspeed: bletchley: change LED sys_log_id to active low
  ARM: dts: aspeed: bletchley: disable GPIOV2 pull-down
  ARM: dts: aspeed: bletchley: bind presence-sledX pins via gpio-keys
  ARM: dts: aspeed: bletchley: update fusb302 nodes

 .../dts/aspeed-bmc-facebook-bletchley.dts     | 197 +++++++++++++-----
 1 file changed, 148 insertions(+), 49 deletions(-)

-- 
2.17.1

